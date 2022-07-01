#INCLUDE "PROTHEUS.CH"
#INCLUDE "RPTDEF.CH"
#INCLUDE "FWMVCDEF.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TOTVS.CH"
#INCLUDE "IMPFER.CH"
#INCLUDE "FWPrintSetup.ch"

/*/{Protheus.doc} MMGPER02 - Fonte responsável pela geração do recibo de férias. 
@return		Retorno
@author		André Longhini
@version	1.0
@since		20/10/2021
@obs	
*/

User Function MMGPER02()

	Private	cPerg := "MMGPER02"
	Private cPd13o := Space(3)
	Private aCodFol

	SetMnemonicos(xFilial("RCA"),NIL,.T.,"P_REGPARCI")
	P_REGPARCI	:= If( Type("P_REGPARCI") == "U", .F. , P_REGPARCI)

	// Mostra as perguntdas do relatório ao usuário
	if ! Pergunte(cPerg,.T.)
		Return()
	endif

	// Carrega tabela de Identificadores
	If !Fp_CodFol( @aCodFol, SRA->RA_FILIAL, .T. )
		Help( ,, OemToAnsi("Atenção"),, OemToAnsi("Falha na carga de verbas"), 1, 0 )
	   	Return( .F. )
	EndIf

	// Chama a impressão do relatório
	Processa( {|| GeraRel() },"Aguarde. Buscando as informações..." )

return()

/*/{Protheus.doc} GeraRel
Função que gera o relatório
@return		Retorno
@author		André Longhini
@version	1
@since		20/10/2021
@obs		
/*/
Static Function GeraRel()

	Local _cDiretLoc	:= "" //Variável que vai receber o diretório escolhido.
	Local aPeriodos		:= {}
	Local lTemCpoProg
	Local lUltSemana
	Local nImprVias
	Local nCnt
	Local i
	Local nPosSem
	Local nPosTbFer		:= 0
	Local nTempoParc	:= 0
	Local cRot 			:= ""
	Local cTipoRot 		:= ""
	Local cPeriodo		:= ""
	Local cSemana       := ""
	Local cAnoMes       := ""
	Local cFiliAtual	:= cFilAnt
	Local cAcessaSRA	:= &( " { || " + ChkRH( "GPER130" , "SRA" , "2" ) + " } " )

	Local cNomeArq		:= "Aviso_Ferias_"+DToS(dDataBase) + "_" + StrTran(time(),":")

	Private nSol13,nSolAb,nRecib,nRecAb,nDtRec,nRec13,cFilDe,cFilAte
	Private cMatDe,cMatAte,cCcDe,cCcAte,cNomDe,cNomAte,cDtSt13
	Private nFaltas	:= Val_Salmin:=0
	Private Salario	:= SalHora := SalDia := SalMes := nSalPg := 0.00
	Private lAchou		:= .F.
	Private aInfo		:= {}
	Private aTabFer		:= {}    			// Tabela para calculo dos dias de ferias
	Private aTabFer2	:= {}				// Tabela para calculo dos dias de ferias para regime de tempo parcial
	Private aCodBenef	:= {}
	Private nAviso,lImpAv,dDtfDe,dDtfAte,nImprDem

	Private DaAuxI		:= Ctod("//")
	Private DaAuxF		:= Ctod("//")
	Private cAboAnt		:= If(GetMv("MV_ABOPEC")=="S","1","2") //-- Abono antes ferias
	Private cAboPec		:= ""
	Private nDBanco
	Private lSomLiR		:= .F.
	Private aVerbsAbo	:= {}
	Private aVerbs13Abo	:= {}

	Private cReplic77:= REPLICATE("-",77)
	Private cReplic22:= REPLICATE("_",22)
	Private cReplic30:= REPLICATE("_",30)
	Private cReplic33:= REPLICATE("_",33)
	Private cReplic35:= REPLICATE("_",35)
	Private cReplic40:= REPLICATE("_",40)

	Private oPrn

	// Variaveis Utilizadas para Parametros
	nAviso	:= mv_par01		// 	Imprime aviso
	dDtfDe  := mv_par02     //  Periodo de Ferias De
	dDtfAte := mv_par03     //  Periodo de Ferias Ate
	cFilDe  := mv_par04     //  FiLial De
	cFilAte := mv_par05     //  FiLial Ate
	cMatDe  := mv_par06     //  Matricula De
	cMatAte := mv_par07     //  Matricula Ate
	cCcDe   := mv_par08     //  Centro De Custo De
	cCcAte  := mv_par09     //  Centro De Custo Ate
	cNomDe  := mv_par10     //  Nome De
	cNomAte := mv_par11     //  Nome Ate
	dDtSt13 := mv_par12     //  Data SoLic. 13o.
	nVias   := mv_par13     //  No. de Vias
	dDtPgDe := mv_par14	    //  Data de Pagamento De
	dDtPgAte:= mv_par15	    //  Data de Pagamento Ate
	nDtRec	:= mv_par16			
	// Verifica a base instalada, se for Brasil utiliza o param,
	// caso contrario, fixa o param como 2 (Nao Imprime Demitidos)
	nImprDem:= Iif( cPaisLoc == "BRA", mv_par17, 2 )
	nDAbnPec:= IiF(cPaisLoc == "BRA", mv_par18, 15)
	nDBanco := mv_par19		//  Imprime dados bancários
	If !Empty(MV_PAR20)		// Informa se deve somar os dias de licença remunerada ao período de gozo das férias.
		If MV_PAR20 == 1
			lSomLiR := .T.
		Else
			lSomLiR := .F.
		Endif
	EndIf
	nRecib	   := MV_PAR21
	nRecAb	   := MV_PAR22
	nRec13	   := MV_PAR23
	nSolAb     := MV_PAR24
	nSol13	   := MV_PAR25
	//Atribuir o conteúdo informado no parâmetro MV_PAR05 à variável _cDiretLoc.
	_cDiretLoc := Alltrim(MV_PAR26)
	

	//Validar se o caminho informado está com a barra no final. Caso não esteja, será adicionada.
	If Substr(_cDiretLoc,len(_cDiretLoc),1) <> "\"
		_cDiretLoc := Alltrim(_cDiretLoc) + "\"
	EndIf

	// Verifica a existencia dos campos de programacao ferias no SRF
	lTemCpoProg := fTCpoProg()

	// Pocisiona no Primeiro Registro Selecionado
	DbSelectArea("SRA")

	// Seta a Regua de Processamento
	ProcRegua(SRA->(LastRec()))

	dbSetOrder(1)
	dbSeek( cFilDe + cMatDe , .T. )
	cInicio  := "SRA->RA_FILIAL + SRA->RA_MAT"
	cFim     := cFilAte + cMatAte

	// Inicia a criação do arquivo
	oPrn := FWMsPrinter():New(cNomeArq, IMP_PDF, .F., , .T., , , , , , .F., )
	oPrn:SetResolution(80)
	oPrn:SetPortrait()
	oPrn:SetPaperSize(DMPAPER_A4)
	oPrn:lViewPDF := .T. //Visualizar o arquivo após ser gerado.
	oPrn:cPathPDF := _cDiretLoc // caminho onde será gerado o arquivo

	While !SRA->(Eof()) .and. &cInicio <= cFim

		IncProc()

		// Consiste Parametrizacao do Intervalo de Impressao
		If (SRA->RA_MAT < cMatDe) .Or. (SRA->RA_MAT > cMatAte) .Or. ;
			(SRA->RA_CC  < cCcDe ) .Or. (SRA->RA_CC  > cCcAte) .Or.;
			(SRA->RA_NOME < cNomDe) .Or. (SRA->RA_NOME > cNomAte)
			SRA->(dbSkip(1))
			Loop
		EndIf

		// Consiste Situacao do Funcionario
		// Inclusao do tratamento para Imprime Demitidos S/N no Brasil.
		// Se nao for Brasil considera-se o param como 2 (Nao imprime)
		If SRA->RA_SITFOLH $ "D" .AND. nImprDem <> 1	// 1 - Imprime Demitido = Sim
			SRA->(dbSkip(1))
			Loop
		Endif

		// Consiste Filiais e Acessos
	    If !( SRA->RA_FILIAL $ fValidFil() ) .Or. !Eval( cAcessaSRA )
			dbSelectArea("SRA")
			dbSkip()
			Loop
		EndIF
		cFilAnt := SRA->RA_FILIAL

		// Carrega tabela para apuracao dos dias de ferias - aTabFer
		// 1-Meses Periodo    2-Nro Periodos   3-Dias do Mes    4-Fator

		cProcesso 	:= SRA->RA_PROCES
		cTipoRot	:= "3"
		cRot 		:= fGetCalcRot(cTipoRot)

		// Carrega o periodo atual de calculo (aberto)
		fGetLastPer( @cPeriodo,@cSemana , cProcesso, cRot , .T., .F., @cAnoMes )

		aPeriodo    := {}
		aVerbsAbo   := {}
		aVerbs13Abo := {}

		// Carrega todos os dados do periodo
		fCarPeriodo( cPeriodo , cRot , @aPeriodo, @lUltSemana, @nPosSem)

		If Len(aPeriodo) == 0
			dbSelectArea("SRA")
			SRA->(dbSkip(1))
			Loop
		Else
			dDataDe := aPeriodo[nPosSem,3]
			dDataAte := aPeriodo[nPosSem,4]
		EndIf

		fTab_Fer(@aTabFer,,@aTabFer2)

		// Se as horas semanais forem inferiores a 26, e o Mnemonico P_REGPARCI estiver ativo,
		// utiliza os dias de férias da tabela S065 - Tabela de férias tempo parcial (Artigo 130A da CLT)
		If cPaisLoc == "BRA"
			nTempoParc := SRA->RA_HRSEMAN
			If SRA->RA_HOPARC == "1" .And. nTempoParc <= 25 .And. nTempoParc  > 0 .And. Len(aTabFer2) > 0	.And. P_REGPARCI
				nPosTbFer := Ascan(aTabFer2, { |X|  nTempoParc <= X[6] .And. nTempoParc > X[5] })
				If nPosTbFer > 0
					aTabFer := aClone(aTabFer2[nPosTbFer])
				Endif
			Endif
		EndIf

		lAchou := .F.
		lImpAv := .T.

		// Procura No Arquivo de Ferias o Periodo a Ser Listado
		dbSelectArea("SRH" )
		If dbSeek( SRA->RA_FILIAL + SRA->RA_MAT )
			aPeriodos := {}
			While !Eof() .And. SRA->RA_FILIAL + SRA->RA_MAT == SRH->RH_FILIAL + SRH->RH_MAT
				If ( !(cPaisLoc $ "ANG") .And. (SRH->RH_DATAINI >= dDtfDe .And. SRH->RH_DATAINI <= dDtfAte) .And.;
				(SRH->RH_DTRECIB >= dDtPgDe .And. SRH->RH_DTRECIB <= dDtPgAte) ) .OR. ;
				( (cPaisLoc $ "ANG") .And. (SRH->RH_DTRECIB >= dDtPgDe .And. SRH->RH_DTRECIB <= dDtPgAte) )
					AAdd(aPeriodos, Recno() )
				EndIf
				dbSkip()
			Enddo

			// Imprime Aviso de Ferias Caso nao tenha calculado
			If Len(aPeriodos) == 0
				dbSelectArea( "SRA" )
				If lImpAv
					FImprAvi(lTemCpoProg)
				Endif
				dbSelectArea( "SRA" )
				dbSkip()
				Loop
			Endif

			For nCnt := 1 To Len(aPeriodos)
				dbSelectArea( "SRH" )
				dbGoTo(aPeriodos[nCnt])

				// Carrega Matriz Com Dados da Empresa
				fInfo(@aInfo,SRA->RA_FILIAL)

				// Carrega Variaveis Codigos da Folha
				If !FP_CODFOL(@aCodFol,SRA->RA_FILIAL)
					Return
				Endif

				DaAuxI := SRH->RH_DATAINI
				DaAuxF := SRH->RH_DATAFIM

				If nRecAb == 1 .AND. Empty(aVerbsAbo)
					//Verbas encontradas no GPEXIDC.PRX com 'abono' na descricao
					aAdd(aVerbsAbo, aCodFol[74,1])
					aAdd(aVerbsAbo, aCodFol[205,1])
					aAdd(aVerbsAbo, aCodFol[617,1])
					aAdd(aVerbsAbo, aCodFol[622,1])
					aAdd(aVerbsAbo, aCodFol[623,1])

					For i := 632 To 635
						aAdd(aVerbsAbo, aCodFol[i,1])
					Next

					//Verbas encontradas no GPEXIDC1.PRX com 'abono' na descricao
					For i := 1312 To 1327
						aAdd(aVerbsAbo, aCodFol[i,1])
					Next

					aAdd(aVerbsAbo, aCodFol[1330,1])
					aAdd(aVerbsAbo, aCodFol[1331,1])

					aAdd(aVerbsAbo, aCodFol[1407,1])
					aAdd(aVerbsAbo, aCodFol[1408,1])
					aAdd(aVerbsAbo, aCodFol[1409,1])
					aAdd(aVerbsAbo, aCodFol[1410,1])

					aAdd(aVerbs13Abo, aCodFol[79,1])
					aAdd(aVerbs13Abo, aCodFol[206,1])
				Endif

				lAchou := .T.
				For nImprVias := 1 to nVias
					 MMGPER02A0()	// Imprime Página do Relatório
				Next nImprVias
				lImpAv := .F.
		    Next nCnt
	    EndIf

		// Imprime Aviso de Ferias Caso nao tenha calculado
		If lImpAv
			FImprAvi(lTemCpoProg)
		Endif

		dbSelectArea("SRA")
		dbSkip()
	Enddo
	cFilAnt := cFiliAtual

	// Termino do relatorio
	dbSelectArea("SRA")
	Set Filter to
	dbsetorder(1)

	oPrn:Preview() // Visualiza antes de imprimir
	FreeObj(oPrn)
	oPrn := Nil

Static nOrdSRR
// Imprime a Página do Aviso de Férias para cada funcionário selecionado, conforme número de Vias

Static Function MMGPER02A0()

	Local nLin		:= 0
	Local ni		:= 0 
	Local cImpAvFer	:= SuperGetMv('MV_IMPAVF',,"1")
	Local lImpBco	:= .F.
	Local oCourier
	Local aGozoFer	:= {}
	Local nAbono	:= 0
	Local n13Abono	:= 0
	Local dDtSolAb	:= Ctod("//")
	Local dDtBusFer	:= Ctod("//")
	Local i			:= 0
	Local nCntCd	:= 0
	Local nConta    := 0
	Private RootPath := GetSrvProfString("Startpath","")
	// As fontes disponíveis para utilização com a classe TFont na FwMsPrinter() são:
	// 1-Courier New
	// 2-Arial
	// 3-Arial Black
	// 4-Times New Roman
	// 5-Andale Mono

	// Define as Fontes do Relatório
	oCourier	:= TFont():New("Courier New",,15,,.T.,,,,,.F.,.F.)

	//Dados bancários
	If cPaisLoc == "BRA" .And. !Empty(nDBanco) .And. nDBanco == 1 .And. !Empty(SRA->RA_BCDEPSAL) .And. !Empty(SRA->RA_CTDEPSAL)
		cDtDisp  := If( lAchou .Or. M->RH_DFERIAS > 0 .and. SRA->RA_SITFOLH <> "D", PADR(DTOC(SRH->RH_DTRECIB),10), "" )
		cBcoDesc := AllTrim( DescBco(SRA->RA_BCDEPSAL,SRA->RA_FILIAL) )
		cBcoAg   := AllTrim( Substr(SRA->RA_BCDEPSAL,4,5) )
		cBcoCta  := AllTrim( SRA->RA_CTDEPSAL )
		lImpBco	 := .T.
	EndIf

	if lAchou

		dDtBusFer := SRH->RH_DATAINI
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Se Funcionario tem  dias de Licensa remunerada, entao deve-se³
		//³ imprimir somente o period de gozo das ferias (conf.vlr calcu-³
		//³ lado.)                                                       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If SRH->( RH_DIALRE1 + RH_DIALREM) > 0
			nDiaFeQueb := SRH->(RH_DFERIAS - Int(RH_DFERIAS) )
			If lSomLiR
				DaAuxF := SRH->RH_DATAFIM
			Else
				DaAuxF := SRH->RH_DATAFIM -( SRH->( RH_DIALRE1 + RH_DIALREM ) ) + If(nDiaFeQueb>0 , 1, 0 )
			EndIf
	    EndIf

	    IF cPaisLoc == "ANG"
		    aGozoFer := fBusGozo( SRH->RH_DATABAS , SRH->RH_DBASEAT )
		    IF len(aGozoFer) > 0
			    dDataRet := Dtoc(aGozoFer[len(aGozoFer)][2]+1)
			    DAAUXI   := aGozoFer[1][1]
			    DAAUXF   := aGozoFer[1][2]
			Else
				dDataRet := Dtoc(ctod('//'))
				DAAUXI   := ctod('//')
				DAAUXF   := ctod('//')
			Endif
		Endif

		IF nAviso == 1
				// Inicia a Página
				oPrn:StartPage()

				nLin := 0003
				oPrn:SayBitmap(nLin,0040, "\system\LGMID0101.PNG", 0150,0056)	
				oPrn:Say(nLin,0020,"*" + cReplic77 + "*",oCourier,100,CLR_BLACK)
				nLin += 0013
				oPrn:Say(nLin,0020,"|" + SPACE(30) + STR0025,oCourier,100,CLR_BLACK) //" AVISO DE FERIAS "
				oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
				nLin += 0013
				oPrn:Say(nLin,0020,"|" + SPACE(30) + Replicate("=",Len(STR0025)),oCourier,100,CLR_BLACK)
				oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
				nLin += 0013
				oPrn:Say(nLin,0020, "|",oCourier,100,CLR_BLACK)
				oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
				nLin += 0013
				IF cPaisLoc == "ANG"
					oPrn:Say(nLin,0020, "|" + SPACE(28+(20-LEN(ALLTRIM(aInfo[5]))))+ALLTRIM(aInfo[5])+", "+SUBSTR(DTOC(SRH->RH_DTRECIB),1,2)+STR0002+MesExtenso(MONTH(SRH->RH_DTRECIB))+STR0002+STR(YEAR(SRH->RH_DTRECIB),4) ,oCourier,100,CLR_BLACK)	//" de "###" de "
				ELSE
					oPrn:Say(nLin,0020, "|" + SPACE(28+(20-LEN(ALLTRIM(aInfo[5]))))+ALLTRIM(aInfo[5])+", "+SUBSTR(DTOC(SRH->RH_DTAVISO),1,2)+STR0002+MesExtenso(MONTH(SRH->RH_DTAVISO))+STR0002+STR(YEAR(SRH->RH_DTAVISO),4) ,oCourier,100,CLR_BLACK)	//" de "###" de "
				ENDIF
				oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
				nLin += 0013
				oPrn:Say(nLin,0020, "|",oCourier,100,CLR_BLACK)
				oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
				nLin += 0013
				If cPaisLoc <> "ARG"
					oPrn:Say(nLin,0020, "|" + SPACE(07) + STR0026 ,oCourier,100,CLR_BLACK)	//"A(O) SR(A)"
				Else
					oPrn:Say(nLin,0020, "|" + SPACE(07) + STR0115 ,oCourier,100,CLR_BLACK)	//"SR(A)"
				EndIf
				oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
				nLin += 0013
				oPrn:Say(nLin,0020, "|",oCourier,100,CLR_BLACK)
				oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
				nLin += 0013
				oPrn:Say(nLin,0020, "|" + SPACE(07) + SRA->RA_MAT + " - " + Left(SRA->RA_NOME,30),oCourier,100,CLR_BLACK)
				oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
				nLin += 0013

				// Se for Brasil e imprime funcionarios demitidos SIM, utilizar CC
				// da tabela SRR para buscar CC da epoca das ferias do funcionario
				DbSelectArea( "SRR" )
				SRR->(dbSetOrder(1))

				If cPaisLoc == "BRA" .and. SRA->RA_SITFOLH $ "D" .and. nImprDem == 1 .and.;
					dbSeek( SRA->RA_FILIAL + SRA->RA_MAT + "F" + Dtos(dDtBusFer) )
					cDesc := DescCc( SRR->RR_CC, SRR->RR_FILIAL )
				Else
					cDesc := DescCc( SRA->RA_CC, SRA->RA_FILIAL )
				EndIf

				If cPaisLoc == "BRA" .and. SRA->RA_SITFOLH $ "D" .and. nImprDem == 1 .and.;
					dbSeek( SRA->RA_FILIAL + SRA->RA_MAT + "F" + Dtos(dDtBusFer) )
					cDesc := DescCc( SRR->RR_CC, SRR->RR_FILIAL )
				Else
					cDesc := DescCc( SRA->RA_CC, SRA->RA_FILIAL )
				EndIf

				If cPaisLoc == "BRA"
					cLinha:= "|" + SPACE(07) + STR0027 + SRA->RA_NUMCP+" - "+SRA->RA_SERCP+SPACE(8)+"C.CUSTO: " //"CTPS = "
				ElseIf !( cPaisLoc $ "ARG|ANG" )
					cLinha:= "|" + SPACE(07) + STR0027 + SRA->RA_NUMCP+" - "+SRA->RA_SERCP+SPACE(8)+STR0028	//"CTPS = "###"DEPTO: "
				ElseIF cPaisLoc == "ANG"
					cLinha:= "|" + SPACE(07) + STR0028	//"###"DEPTO: "
				else
					cLinha:= "|" + SPACE(07) + STR0116 + SRA->RA_NUMCP+" - "+SRA->RA_SERCP+SPACE(8)+STR0028	//"CTPS = "###"DEPTO: "
				EndIf

				cLInha:= cLinha+AllTrim(cDesc)
				oPrn:Say(nLin,0020, cLinha,oCourier,100,CLR_BLACK)
				oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
				nLin += 0013

				lDepto	:= CpoUsado("RA_DEPTO") .And. !EMPTY(SRA->RA_DEPTO)
				oPrn:Say(nLin,0020, "|" + SPACE(07) + "C.CUSTO: " + SRA->RA_CC ,oCourier,100,CLR_BLACK)
				IF lDepto
					oPrn:Say(nLin,0317, STR0028 + ( fDesc('SQB',SRA->RA_DEPTO,'QB_DESCRIC') ) ,oCourier,100,CLR_BLACK) //"###"DEPTO: "
				Else
					oPrn:Say(nLin,0020, "|" ,oCourier,100,CLR_BLACK)
				EndIF
				oPrn:Say(nLin,0628,"|" ,oCourier,100,CLR_BLACK)
				nLin += 0013
				oPrn:Say(nLin,0020, "|" ,oCourier,100,CLR_BLACK)
				oPrn:Say(nLin,0628, "|" ,oCourier,100,CLR_BLACK)
				nLin += 0013
				oPrn:Say(nLin,0020, "|" + SPACE(16) + STR0029 ,oCourier,100,CLR_BLACK)	//"Nos  termos da legislacao  vigente,  suas  ferias   serao"
				oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
				nLin += 0013
				oPrn:Say(nLin,0020, "|" + SPACE(07) + STR0030 ,oCourier,100,CLR_BLACK)	//"concedidas conforme o demonstrativo abaixo:"
				oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
				nLin += 0013
				oPrn:Say(nLin,0020, "|",oCourier,100,CLR_BLACK)
				oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
				nLin += 0013

				If (SRH->RH_DIALRE1 + SRH->RH_DIALREM) > 0
					oPrn:Say(nLin,0020, "|" + SPACE(64) + STR0033,oCourier,100,CLR_BLACK)
					oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
					nLin += 0013
					oPrn:Say(nLin,0020, "| " + STR0031+SPACE(04)+Iif(lSomLiR,STR0148,STR0032)+Iif(lSomLiR,SPACE(04),SPACE(07))+STR0122+SPACE(03)+STR0123,oCourier,100,CLR_BLACK) //"Periodo Aquisitivo:"###"Periodo de Gozo:"###"Retorno ao Trabalho:"
					oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
					nLin += 0013
					oPrn:Say(nLin,0020, "|" + PADR(DTOC(SRH->RH_DATABAS),10)+STR0034+PADR(DTOC(SRH->RH_DBASEAT),10)+SPACE(01)+If(SRH->RH_DIALREM == 30,STR0125,PADR(DTOC(DAAUXI),10)+STR0034+PADR(DTOC(DAAUXF),10))+SPACE(6)+(CVALTOCHAR(SRH->RH_DIALRE1 + SRH->RH_DIALREM))+SPACE(9)+PADR(DTOC(SRH->RH_DATAFIM+1),10),oCourier,100,CLR_BLACK)	//" A "###" A "
					oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
					nLin += 0013
				else
					oPrn:Say(nLin,0020, "|",oCourier,100,CLR_BLACK)
					oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
					nLin += 0013
					oPrn:Say(nLin,0020, "|    " + STR0031+SPACE(08)+STR0032+SPACE(06)+STR0124,oCourier,100,CLR_BLACK) //"Periodo Aquisitivo:"###"Periodo de Gozo:"###"Retorno ao Trabalho:"
					oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
					nLin += 0013
					IF cPaisLoc == "ANG"
						oPrn:Say(nLin,0020, "|  " + DTOC(SRH->RH_DATABAS)+STR0034+DTOC(SRH->RH_DBASEAT)+SPACE(08)+Dtoc(DAAUXI)+STR0034+Dtoc(DAAUXF)+SPACE(9)+dDataRet ,oCourier,100,CLR_BLACK)//" A "###" A "
						oPrn:Say(nLin,0628, "|"	,oCourier,100,CLR_BLACK)

						IF len(aGozoFer) > 1
							For ni=2 to len(aGozoFer)
								nLin += 0013
								DAAUXI   := aGozoFer[ni][1]
								DAAUXF   := aGozoFer[ni][2]
								oPrn:Say(nLin,0020, "|",oCourier,100,CLR_BLACK)
								oPrn:Say(nLin,0120, Dtoc(DAAUXI)+STR0034+Dtoc(DAAUXF),oCourier,100,CLR_BLACK)
								oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
							Next i
						Endif
					Else
						oPrn:Say(nLin,0020, "|  " + PADR(DTOC(SRH->RH_DATABAS),10)+STR0034+PADR(DTOC(SRH->RH_DBASEAT),10)+SPACE(02)+PADR(DTOC(DAAUXI),10)+STR0034+PADR(DTOC(DAAUXF),10)+SPACE(8)+PADR(DTOC(DAAUXF+1),10),oCourier,100,CLR_BLACK)	//" A "###" A "
						oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
					Endif
				EndIf
				nLin += 0013
				oPrn:Say(nLin,0020, "|",oCourier,100,CLR_BLACK)
				oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
				nLin += 0013

				If cPaisLoc <> "ARG"
					If cImpAvFer == "1"
						oPrn:Say(nLin,0020, "|" + SPACE(16) + STR0035 ,oCourier,100,CLR_BLACK) 	 //"A remuneracao correspondente as ferias e, se for o  caso,"
						oPrn:Say(nLin,0628, "|" ,oCourier,100,CLR_BLACK)
						nLin += 0013
						oPrn:Say(nLin,0020, "|" + SPACE(07) + STR0036 ,oCourier,100,CLR_BLACK)   //"ao abono pecuniario e ao adiantamento do 13° salário,    |"
						oPrn:Say(nLin,0628, "|" ,oCourier,100,CLR_BLACK)
						nLin += 0013
						oPrn:Say(nLin,0020, "|" + SPACE(07) + STR0037 +PADR(DTOC(SRH->RH_DTRECIB),10)+".",oCourier,100,CLR_BLACK) //"encontra-se no  caixa  e  podera ser recebida  no  dia "
						oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
						If lImpBco
							nLin += 0013
							oPrn:Say(nLin,0020, "|" + SPACE(07) + STR0144 + cBcoDesc,oCourier,100,CLR_BLACK) // "Banco: "
							oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
							nLin += 0013
							oPrn:Say(nLin,0020, "|" + SPACE(07) + STR0145 + cBcoAg + "/" + cBcoCta ,oCourier,100,CLR_BLACK)//"Agencia/Conta: "
							oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
						EndIf
						If cPaisLoc != "BRA"
							nLin += 0013
							oPrn:Say(nLin,0020, "|" + SPACE(16) + STR0038 ,oCourier,100,CLR_BLACK)  //"Solicitamos  apresentar  a  sua  carteira  de trabalho  e"
							oPrn:Say(nLin,0628, "|"  ,oCourier,100,CLR_BLACK)
							nLin += 0013
							oPrn:Say(nLin,0020, "|" + SPACE(07) + STR0039 ,oCourier,100,CLR_BLACK)  //"previdencia social ao depto pessoal para as anotacoes necessarias.
							oPrn:Say(nLin,0628, "|"  ,oCourier,100,CLR_BLACK)
						EndIf
					Else
						oPrn:Say(nLin,0020, "|",oCourier,100,CLR_BLACK)
						oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
						nLin += 0013
						oPrn:Say(nLin,0020, "|",oCourier,100,CLR_BLACK)
						oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
						nLin += 0013
						oPrn:Say(nLin,0020, "|",oCourier,100,CLR_BLACK)
						oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
						nLin += 0013
						If cPaisLoc != "BRA"
							oPrn:Say(nLin,0020, "|" + SPACE(16) + STR0038 ,oCourier,100,CLR_BLACK)  //"Solicitamos  apresentar  a  sua  carteira  de trabalho  e"
							oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
							nLin += 0013
							oPrn:Say(nLin,0020, "|" + SPACE(07) + STR0039 ,oCourier,100,CLR_BLACK)  //"previdencia social ao depto pessoal para as anotacoes necessarias.
							oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
						EndIf
					EndIF
				Else
					oPrn:Say(nLin,0020, "|" + SPACE(16) + STR0117,oCourier,100,CLR_BLACK)
					oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
					oPrn:Say(nLin,0020, "|" + SPACE(07) + STR0118,oCourier,100,CLR_BLACK)
					oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
					oPrn:Say(nLin,0020, "|" + SPACE(07) + STR0119 +PADR(DTOC(SRH->RH_DTRECIB),10)+".",oCourier,100,CLR_BLACK)
					oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
					oPrn:Say(nLin,0020, "|" + SPACE(16) + STR0120,oCourier,100,CLR_BLACK)
					oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
					oPrn:Say(nLin,0020, "|" + SPACE(07) + STR0121,oCourier,100,CLR_BLACK)
					oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
				EndIf
				nLinBkp := nLin
				oPrn:Say(nLin,0020, "|",oCourier,100,CLR_BLACK)
				oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
				nLin += 0013
				oPrn:Say(nLin,0020, "|",oCourier,100,CLR_BLACK)
				oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
				nLin += 0013
				oPrn:Say(nLin,0020, "|",oCourier,100,CLR_BLACK)
				oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
				nLin += 0013
				oPrn:Say(nLin,0020, "|",oCourier,100,CLR_BLACK)
				oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
				nLin += 0013
				oPrn:Say(nLin,0020, "|" + SPACE(02) + cReplic40+SPACE(01)+cReplic33+SPACE(01),oCourier,100,CLR_BLACK)
				oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
				nLin += 0013
				oPrn:Say(nLin,0020, "|" + SPACE(02) + SubStr(aInfo[3]+Space(40),1,40)+SPACE(05)+Left(SRA->RA_NOME,30),oCourier,100,CLR_BLACK)
				oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
				nLin += 0013
				oPrn:Say(nLin,0020, "|",oCourier,100,CLR_BLACK)
				oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
				nLin += 0013
				oPrn:Say(nLin,0020, "*" + cReplic77 + "*",oCourier,100,CLR_BLACK)

				// Imprimie a assinatura do responsavel
			//	oPrn:SayBitmap(nLinBkp+0005,0100,"\system\LGMID0101.PNG",0048,0046)

				oPrn:EndPage()

			else

				If M->RH_DFERIAS > 0 .and. SRA->RA_SITFOLH <> "D"
					// Inicia a Página
					oPrn:StartPage()
					nLin := 0003
							
					oPrn:SayBitmap(nLin,0040, "\system\LGMID0101.PNG", 0150,0056)
					oPrn:Say(nLin,0020,"*" + cReplic77 + "*",oCourier,100,CLR_BLACK)
					nLin += 0013
					oPrn:Say(nLin,0020,"|" + SPACE(30) + STR0025,oCourier,100,CLR_BLACK) //" AVISO DE FERIAS "
					oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
					nLin += 0013
					oPrn:Say(nLin,0020,"|" + SPACE(30) + Replicate("=",Len(STR0025)),oCourier,100,CLR_BLACK)
					oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
					nLin += 0013
					oPrn:Say(nLin,0020, "|",oCourier,100,CLR_BLACK)
					oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
					nLin += 0013
				//	oPrn:Say(nLin,0020, "|" + SPACE(28+(20-LEN(ALLTRIM(aInfo[5]))))+ALLTRIM(aInfo[5])+", "+SUBSTR(DTOC(SRH->RH_DTAVISO),1,2)+STR0002+MesExtenso(MONTH(SRH->RH_DTAVISO))+STR0002+STR(YEAR(SRH->RH_DTAVISO),4) ,oCourier,100,CLR_BLACK)	//" de "###" de "
					oPrn:Say(nLin,0020, "|" + SPACE(28+(20-LEN(ALLTRIM(aInfo[5]))))+ALLTRIM(aInfo[5])+", "+SUBSTR(DTOC(dRH_DTAVIS),1,2)+STR0002+MesExtenso(MONTH(dRH_DTAVIS))+STR0002+STR(YEAR(dRH_DTAVIS),4) ,oCourier,100,CLR_BLACK)	//" de "###" de "
					oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
					nLin += 0013
					oPrn:Say(nLin,0020, "|",oCourier,100,CLR_BLACK)
					oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
					nLin += 0013
					If cPaisLoc <> "ARG"
						oPrn:Say(nLin,0020, "|" + SPACE(07) + STR0026 ,oCourier,100,CLR_BLACK)	//"A(O) SR(A)"
					Else
						oPrn:Say(nLin,0020, "|" + SPACE(07) + STR0115 ,oCourier,100,CLR_BLACK)	//"SR(A)"
					EndIf
					oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
					nLin += 0013
					oPrn:Say(nLin,0020, "|",oCourier,100,CLR_BLACK)
					oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
					nLin += 0013
					oPrn:Say(nLin,0020, "|" + SPACE(07) + SRA->RA_MAT + " - " + Left(SRA->RA_NOME,30),oCourier,100,CLR_BLACK)
					oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
					nLin += 0013

					// Se for Brasil e imprime funcionarios demitidos SIM, utilizar CC
					// da tabela SRR para buscar CC da epoca das ferias do funcionario
					DbSelectArea( "SRR" )
					SRR->(dbSetOrder(1))

					If cPaisLoc == "BRA" .and. SRA->RA_SITFOLH $ "D" .and. nImprDem == 1 .and.;
						dbSeek( SRA->RA_FILIAL + SRA->RA_MAT + "F" + Dtos(dDtBusFer) )
						cDesc := DescCc( SRR->RR_CC, SRR->RR_FILIAL )
					Else
						cDesc := DescCc( SRA->RA_CC, SRA->RA_FILIAL )
					EndIf

					If cPaisLoc == "BRA" .and. SRA->RA_SITFOLH $ "D" .and. nImprDem == 1 .and.;
						dbSeek( SRA->RA_FILIAL + SRA->RA_MAT + "F" + Dtos(dDtBusFer) )
						cDesc := DescCc( SRR->RR_CC, SRR->RR_FILIAL )
					Else
						cDesc := DescCc( SRA->RA_CC, SRA->RA_FILIAL )
					EndIf

					If cPaisLoc == "BRA"
						cLinha:= "|" + SPACE(07) + STR0027 + SRA->RA_NUMCP+" - "+SRA->RA_SERCP+SPACE(8)+"C.CUSTO: " //"CTPS = "
					ElseIf !( cPaisLoc $ "ARG|ANG" )
						cLinha:= "|" + SPACE(07) + STR0027 + SRA->RA_NUMCP+" - "+SRA->RA_SERCP+SPACE(8)+STR0028	//"CTPS = "###"DEPTO: "
					ElseIF cPaisLoc == "ANG"
						cLinha:= "|" + SPACE(07) + STR0028	//"###"DEPTO: "
					else
						cLinha:= "|" + SPACE(07) + STR0116 + SRA->RA_NUMCP+" - "+SRA->RA_SERCP+SPACE(8)+STR0028	//"CTPS = "###"DEPTO: "
					EndIf

					cLInha:= cLinha+AllTrim(cDesc)
					oPrn:Say(nLin,0020, cLinha,oCourier,100,CLR_BLACK)
					oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
					nLin += 0013

					lDepto	:= CpoUsado("RA_DEPTO") .And. !EMPTY(SRA->RA_DEPTO)
					oPrn:Say(nLin,0020, "|" + SPACE(07) + "C.CUSTO: " + SRA->RA_CC ,oCourier,100,CLR_BLACK)
					IF lDepto
						oPrn:Say(nLin,0317, STR0028 + ( fDesc('SQB',SRA->RA_DEPTO,'QB_DESCRIC') ) ,oCourier,100,CLR_BLACK) //"###"DEPTO: "
					Else
						oPrn:Say(nLin,0020, "|" ,oCourier,100,CLR_BLACK)
					EndIF
					oPrn:Say(nLin,0628,"|" ,oCourier,100,CLR_BLACK)
					nLin += 0013
					oPrn:Say(nLin,0020, "|" ,oCourier,100,CLR_BLACK)
					oPrn:Say(nLin,0628, "|" ,oCourier,100,CLR_BLACK)
					nLin += 0013
					oPrn:Say(nLin,0020, "|" + SPACE(16) + STR0029 ,oCourier,100,CLR_BLACK)	//"Nos  termos da legislacao  vigente,  suas  ferias   serao"
					oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
					nLin += 0013
					oPrn:Say(nLin,0020, "|" + SPACE(07) + STR0030 ,oCourier,100,CLR_BLACK)	//"concedidas conforme o demonstrativo abaixo:"
					oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
					nLin += 0013
					oPrn:Say(nLin,0020, "|",oCourier,100,CLR_BLACK)
					oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
					nLin += 0013

					If (SRH->RH_DIALRE1 + SRH->RH_DIALREM) > 0
						oPrn:Say(nLin,0020, "|" + SPACE(64) + STR0033,oCourier,100,CLR_BLACK)
						oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
						nLin += 0013
						oPrn:Say(nLin,0020, "| " + STR0031+SPACE(04)+Iif(lSomLiR,STR0148,STR0032)+Iif(lSomLiR,SPACE(04),SPACE(07))+STR0122+SPACE(03)+STR0123,oCourier,100,CLR_BLACK) //"Periodo Aquisitivo:"###"Periodo de Gozo:"###"Retorno ao Trabalho:"
						oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
						nLin += 0013
						oPrn:Say(nLin,0020, "|" + PADR(DTOC(SRH->RH_DATABAS),10)+STR0034+PADR(DTOC(SRH->RH_DBASEAT),10)+SPACE(01)+If(SRH->RH_DIALREM == 30,STR0125,PADR(DTOC(DAAUXI),10)+STR0034+PADR(DTOC(DAAUXF),10))+SPACE(6)+(CVALTOCHAR(SRH->RH_DIALRE1 + SRH->RH_DIALREM))+SPACE(9)+PADR(DTOC(SRH->RH_DATAFIM+1),10),oCourier,100,CLR_BLACK)	//" A "###" A "
						oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
						nLin += 0013
					else
						oPrn:Say(nLin,0020, "|",oCourier,100,CLR_BLACK)
						oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
						nLin += 0013
						oPrn:Say(nLin,0020, "|    " + STR0031+SPACE(08)+STR0032+SPACE(06)+STR0124,oCourier,100,CLR_BLACK) //"Periodo Aquisitivo:"###"Periodo de Gozo:"###"Retorno ao Trabalho:"
						oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
						nLin += 0013
						oPrn:Say(nLin,0020, "|" + SPACE(04) + PADR(DTOC(M->RH_DATABAS),10)+STR0108+PADR(DTOC(M->RH_DBASEAT),10)+SPACE(02)+PADR(DTOC(DAAUXI),10)+STR0108+PADR(DTOC(DAAUXF),10)+SPACE(6)+PADR(DTOC(DAAUXF+1),10)+SPACE(09) ,oCourier,100,CLR_BLACK)	//" A "###" A "
						oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
					EndIf
					nLin += 0013
					oPrn:Say(nLin,0020, "|",oCourier,100,CLR_BLACK)
					oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
					nLin += 0013

					If cImpAvFer == "1"
						oPrn:Say(nLin,0020, "|" + SPACE(16) + STR0035 ,oCourier,100,CLR_BLACK) 	 //"A remuneracao correspondente as ferias e, se for o  caso,"
						oPrn:Say(nLin,0628, "|" ,oCourier,100,CLR_BLACK)
						nLin += 0013
						oPrn:Say(nLin,0020, "|" + SPACE(07) + STR0036 ,oCourier,100,CLR_BLACK)   //"ao abono pecuniario e ao adiantamento do 13° salário,    |"
						oPrn:Say(nLin,0628, "|" ,oCourier,100,CLR_BLACK)
						nLin += 0013
						oPrn:Say(nLin,0020, "|" + SPACE(07) + STR0037 +PADR(DTOC(dRH_DTRECI),10)+".",oCourier,100,CLR_BLACK) //"encontra-se no  caixa  e  podera ser recebida  no  dia "
						oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
						If lImpBco
							nLin += 0013
							oPrn:Say(nLin,0020, "|" + SPACE(07) + STR0144 + cBcoDesc,oCourier,100,CLR_BLACK) // "Banco: "
							oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
							nLin += 0013
							oPrn:Say(nLin,0020, "|" + SPACE(07) + STR0145 + cBcoAg + "/" + cBcoCta ,oCourier,100,CLR_BLACK)//"Agencia/Conta: "
							oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
						EndIf
						If cPaisLoc != "BRA"
							nLin += 0013
							oPrn:Say(nLin,0020, "|" + SPACE(16) + STR0038 ,oCourier,100,CLR_BLACK)  //"Solicitamos  apresentar  a  sua  carteira  de trabalho  e"
							oPrn:Say(nLin,0628, "|"  ,oCourier,100,CLR_BLACK)
							nLin += 0013
							oPrn:Say(nLin,0020, "|" + SPACE(07) + STR0039 ,oCourier,100,CLR_BLACK)  //"previdencia social ao depto pessoal para as anotacoes necessarias.
							oPrn:Say(nLin,0628, "|"  ,oCourier,100,CLR_BLACK)
						EndIf
					Else
						nLin += 0013
						oPrn:Say(nLin,0020, "|",oCourier,100,CLR_BLACK)
						oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
						nLin += 0013
						oPrn:Say(nLin,0020, "|",oCourier,100,CLR_BLACK)
						oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
						nLin += 0013
						oPrn:Say(nLin,0020, "|",oCourier,100,CLR_BLACK)
						oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
						nLin += 0013
						If cPaisLoc != "BRA"
							oPrn:Say(nLin,0020, "|" + SPACE(16) + STR0112 + SPACE(4) ,oCourier,100,CLR_BLACK)  //"Solicitamos  apresentar  a  sua  carteira  de trabalho  e"
							oPrn:Say(nLin,0628, "|"  ,oCourier,100,CLR_BLACK)
							nLin += 0013
							oPrn:Say(nLin,0020, "|" + SPACE(07) + STR0113 ,oCourier,100,CLR_BLACK)  //"previdencia social ao depto pessoal para as anotacoes necessarias.
							oPrn:Say(nLin,0628, "|"  ,oCourier,100,CLR_BLACK)
						EndIf
						oPrn:Say(nLin,0020, "|" + SPACE(16) + STR0117,oCourier,100,CLR_BLACK)
						oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
						oPrn:Say(nLin,0020, "|" + SPACE(07) + STR0118,oCourier,100,CLR_BLACK)
						oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
						oPrn:Say(nLin,0020, "|" + SPACE(07) + STR0119 +PADR(DTOC(SRH->RH_DTRECIB),10)+".",oCourier,100,CLR_BLACK)
						oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
						oPrn:Say(nLin,0020, "|" + SPACE(16) + STR0120,oCourier,100,CLR_BLACK)
						oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
						oPrn:Say(nLin,0020, "|" + SPACE(07) + STR0121,oCourier,100,CLR_BLACK)
						oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
					EndIf
					nLinBkp := nLin
					oPrn:Say(nLin,0020, "|",oCourier,100,CLR_BLACK)
					oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
					nLin += 0013
					oPrn:Say(nLin,0020, "|",oCourier,100,CLR_BLACK)
					oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
					nLin += 0013
					oPrn:Say(nLin,0020, "|",oCourier,100,CLR_BLACK)
					oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
					nLin += 0013
					oPrn:Say(nLin,0020, "|",oCourier,100,CLR_BLACK)
					oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
					nLin += 0013
					oPrn:Say(nLin,0020, "|" + SPACE(02) + cReplic40+SPACE(01)+cReplic33+SPACE(01),oCourier,100,CLR_BLACK)
					oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
					nLin += 0013
					oPrn:Say(nLin,0020, "|" + SPACE(02) + SubStr(aInfo[3]+Space(40),1,40)+SPACE(05)+Left(SRA->RA_NOME,30),oCourier,100,CLR_BLACK)
					oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
					nLin += 0013
					oPrn:Say(nLin,0020, "|",oCourier,100,CLR_BLACK)
					oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
					nLin += 0013
					oPrn:Say(nLin,0020, "*" + cReplic77 + "*",oCourier,100,CLR_BLACK)

					// Imprimie a assinatura do responsavel
					//oPrn:SayBitmap(nLinBkp+0005,0100,"\system\Flauzeliton.jpg",0048,0046)

					oPrn:EndPage()
			Endif
		endif
	endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Solicitacao Abono Pecuniario                                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nSolAb == 1
		nAbono   := 0
		n13Abono := 0
		
		dbSelectArea( "SRR" )	
		SRR->(dbSetOrder(1))	
		
		If dbSeek(SRA->RA_FILIAL + SRA->RA_MAT + "F" + Dtos(dDtBusFer) + aCodFol[074,1] )
			
			nAbono := 1
			
		// -> Ajuste para considerar a posição de "Abono M/S "
		ElseIf dbSeek(SRA->RA_FILIAL + SRA->RA_MAT + "F" + Dtos(dDtBusFer) + aCodFol[205,1] )
			
			nAbono := 1
		
		Endif
		
		If dbSeek(SRA->RA_FILIAL + SRA->RA_MAT + "F" + Dtos(dDtBusFer) + aCodFol[079,1] )
		
			n13Abono := 1
			
		// -> Ajuste para considerar a posição de "Abono M/S "
		ElseIf dbSeek(SRA->RA_FILIAL + SRA->RA_MAT + "F" + Dtos(dDtBusFer) + aCodFol[206,1] )
			
			n13Abono := 1
		
		Endif
		
		If ( nAbono + n13Abono ) > 0

			oPrn:StartPage()

			nLin := 0003
			oPrn:SayBitmap(nLin,0040, "\system\LGMID0101.PNG", 0150,0056)
			oPrn:Say(nLin,0020, "*" + cReplic77 + "*",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020, "|" + SPACE(18) +STR0013+SPACE(17),oCourier,100,CLR_BLACK)	//"     SOLICITACAO DO ABONO DE FERIAS       "
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020, "|" + SPACE(18) +"     ==============================       "+SPACE(17),oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)	
			nLin += 0013					
			oPrn:Say(nLin,0020, "|" + SPACE(77),oCourier,100,CLR_BLACK)  
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)	
			nLin += 0013
			dDtSolAb:= DaySub(SRH->RH_DBASEAT,nDAbnPec)
			oPrn:Say(nLin,0020, "|" + SPACE(28+(20-LEN(ALLTRIM(aInfo[5]))))+ALLTRIM(aInfo[5])+", " +SUBSTR(DTOC(dDtSolAb),1,2)+STR0002+MesExtenso(MONTH(dDtSolAb))+STR0002+STR(YEAR(dDtSolAb),4),oCourier,100,CLR_BLACK)	//" de "###" de "
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)	
			nLin += 0013
			oPrn:Say(nLin,0020, "|" + SPACE(77),oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013						
			oPrn:Say(nLin,0020, "|" + SPACE(07) + STR0003 +SPACE(69),oCourier,100,CLR_BLACK)//"A"
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013					
			oPrn:Say(nLin,0020, "|" + SPACE(07) + SubStr(aInfo[3] + Space(40), 1, 40) + SPACE(30),oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013		
			oPrn:Say(nLin,0020, "|" + SPACE(77),oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013		
			oPrn:Say(nLin,0020, "|" + SPACE(77),oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020, "|" + SPACE(07) + STR0014 + SPACE(53),oCourier,100,CLR_BLACK)	//"Prezados Senhores"
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020, "|" + SPACE(77),oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020, "|" + SPACE(77),oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020, "|" + SPACE(16) + STR0015 + SPACE(3),oCourier,100,CLR_BLACK)	//"Nos  termos da legislacao vigente, solicito  a  conversao "
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020, "|" + SPACE(07) + STR0016,oCourier,100,CLR_BLACK)							//"de  1/3  (Hum Terco)  de  minhas  ferias   relativas  ao   periodo    |"
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020, "|" + SPACE(07) + STR0017 + PADR(DTOC(SRH->RH_DATABAS),10)+STR0018+PADR(DTOC(SRH->RH_DBASEAT),10)+STR0019+SPACE(12),oCourier,100,CLR_BLACK)	//"aquisitivo de "###" a "###" em abono pecuniario."
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020, "|" + SPACE(16) + STR0020+SPACE(19),oCourier,100,CLR_BLACK)	//"Solicito apor o seu ciente na copia desta."
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020, "|" + SPACE(77),oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020, "|" + SPACE(77),oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			
			If !Empty(SRA->RA_NSOCIAL)
				oPrn:Say(nLin,0020, "|" + SPACE(07) + SRA->RA_NSOCIAL,oCourier,100,CLR_BLACK)
				oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
				nLin += 0013
				oPrn:Say(nLin,0020, "|" + SPACE(07) + STR0021 + SRA->RA_FILIAL + " " + SRA->RA_MAT,oCourier,100,CLR_BLACK) // "Registro No: "
				oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
			Else
				oPrn:Say(nLin,0020, "|" + SPACE(07) + SRA->RA_NOME+SPACE(02)+STR0021+SRA->RA_FILIAL+" "+SRA->RA_MAT,oCourier,100,CLR_BLACK)//+SPACE(16)+"|"	//"Registro No: "
				oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
			EndIf
			
			// Se for Brasil e imprime funcionarios demitidos SIM, utilizar CC
			// da tabela SRR para buscar CC da epoca das ferias do funcionario
			If cPaisLoc == "BRA" .and. SRA->RA_SITFOLH $ "D" .and. nImprDem == 1
				cDesc := DescCc( SRR->RR_CC, SRR->RR_FILIAL )
			Else
				cDesc := DescCc( SRA->RA_CC, SRA->RA_FILIAL )
			EndIf

			nLin += 0013
			cLinha:="|" + SPACE(07) + STR0022 + SRA->RA_NUMCP+" - "+SRA->RA_SERCP+SPACE(10)+"C.CUSTO: "+ AllTrim(cDesc)
			oPrn:Say(nLin,0020, cLinha,oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
			nLin += 0013

			lDepto	:= CpoUsado("RA_DEPTO") .And. !EMPTY(SRA->RA_DEPTO)

			IF lDepto 
				oPrn:Say(nLin,0020, "|" + SPACE(39) + STR0028 + ( fDesc('SQB',SRA->RA_DEPTO,'QB_DESCRIC') ),oCourier,100,CLR_BLACK)
				oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
			Else
				oPrn:Say(nLin,0020, "|",oCourier,100,CLR_BLACK)
				oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
			EndIF

			nLin += 0013

			oPrn:Say(nLin,0020, "|" + SPACE(77),oCourier,100,CLR_BLACK) 
			oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020, "|" + SPACE(77),oCourier,100,CLR_BLACK) 
			oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020, "|" + SPACE(07) + STR0023+SPACE(18)+STR0024+SPACE(17),oCourier,100,CLR_BLACK)	//"Atenciosamente"###"Ciente em ___/___/___"
			oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020, "|" + SPACE(77),oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020, "|" + SPACE(77),oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020, "|" + SPACE(02) + cReplic40 + SPACE(3) + cReplic30 + SPACE(02),oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
			nLin += 0013

			If !Empty(SRA->RA_NSOCIAL)
				oPrn:Say(nLin,0020, "|" + SPACE(02) + SubStr(aInfo[3] + Space(40), 1, 40) + SPACE(03) + Left(SRA->RA_NSOCIAL, 30) + SPACE(02),oCourier,100,CLR_BLACK)
				oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
			Else
				oPrn:Say(nLin,0020, "|" + SPACE(02) + SubStr(aInfo[3] + Space(40), 1, 40) + SPACE(03) + Left(SRA->RA_NOME, 30) + SPACE(02),oCourier,100,CLR_BLACK)
				oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
			EndIf
			
			nLin += 0013

			oPrn:Say(nLin,0020, "|" + SPACE(77),oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020, "*" + cReplic77 + "*",oCourier,100,CLR_BLACK)

			oPrn:EndPage()

		Endif
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Recibo De Abono                                              ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nRecAb == 1
		nValAb		:= 0.00
		nValab13 	:= 0.00		
		nValnLiq	:= 0.00
		cRet1		:= ''
		cRet2		:= ''
		

		
		dbSelectArea( "SRR" )
		SRR->(dbSetOrder(1))
		dbGoTop()
				
		For i := 1 To Len(aVerbsAbo)
		
			If dbSeek(SRA->RA_FILIAL + SRA->RA_MAT + "F" + Dtos(dDtBusFer) + aVerbsAbo[i] )
				While SRR->RR_FILIAL + SRR->RR_MAT + SRR->RR_TIPO3 + DToS(SRR->RR_DATA) + SRR->RR_PD == SRA->RA_FILIAL + SRA->RA_MAT + "F" + DToS(dDtBusFer) + aVerbsAbo[i]
					nValAb += SRR->RR_VALOR
					SRR->(DbSkip())
				EndDo
			Endif
			
		Next
			
		For i := 1 To Len(aVerbs13Abo)
		
			If dbSeek(SRA->RA_FILIAL + SRA->RA_MAT + "F" + Dtos(dDtBusFer) + aVerbs13Abo[i] )
				While SRR->RR_FILIAL + SRR->RR_MAT + SRR->RR_TIPO3 + DToS(SRR->RR_DATA) + SRR->RR_PD == SRA->RA_FILIAL + SRA->RA_MAT + "F" + DToS(dDtBusFer) + aVerbs13Abo[i]
					nValAb13 += SRR->RR_VALOR
					SRR->(DbSkip())
				EndDo
			Endif
			
		Next i 
		
		If ( nValAb + nValAb13 ) > 0

			oPrn:StartPage()

			nLin := 0003
			oPrn:SayBitmap(nLin,0040, "\system\LGMID0101.PNG", 0150,0056)		
			oPrn:Say(nLin,0020,"*" + cReplic77 + "*",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,"|" + SPACE(25) +STR0040+SPACE(24),oCourier,100,CLR_BLACK)			//" RECIBO DE ABONO DE FERIAS  "
			oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,"|" + SPACE(25) +" =========================  "+SPACE(24),oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,"|" + SPACE(77),oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,"|" + SPACE(77),oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,"|" + SPACE(77),oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,"|" + SPACE(77),oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
			nLin += 0013

			If !Empty(SRA->RA_NSOCIAL)
				oPrn:Say(nLin,0020,"|" + SPACE(07) + SRA->RA_NSOCIAL,oCourier,100,CLR_BLACK)
				oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
			Else
				oPrn:Say(nLin,0020,"|" + SPACE(07) + Sra->RA_NOME+SPACE(40),oCourier,100,CLR_BLACK)
				oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
			EndIf
			
			// Se for Brasil e imprime funcionarios demitidos SIM, utilizar CC
			// da tabela SRR para buscar CC da epoca das ferias do funcionario
			If cPaisLoc == "BRA" .and. SRA->RA_SITFOLH $ "D" .and. nImprDem == 1
				cDesc := DescCc( SRR->RR_CC, SRR->RR_FILIAL )
			Else
				cDesc := DescCc( SRA->RA_CC, SRA->RA_FILIAL )
			EndIf

			cLinha:="|" + SPACE(07) + STR0041 + SRA->RA_NUMCP+" - "+SRA->RA_SERCP+SPACE(8) //"CTPS = "
			cLInha := cLinha + "C.CUSTO: " + Alltrim(cDesc)
			nLin += 0013
			oPrn:Say(nLin,0020,cLinha,oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628, "|",oCourier,100,CLR_BLACK)
			nLin += 0013
			lDepto	:= CpoUsado("RA_DEPTO") .And. !EMPTY(SRA->RA_DEPTO)
			IF lDepto 
				oPrn:Say(nLin,0020,"|" + SPACE(37) + STR0028 + ( fDesc('SQB',SRA->RA_DEPTO,'QB_DESCRIC') ),oCourier,100,CLR_BLACK)
				oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			Else
				oPrn:Say(nLin,0020,"|",oCourier,100,CLR_BLACK)
				oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			EndIF

			nLin += 0013
			oPrn:Say(nLin,0020,"|" + SPACE(77),oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,"|" + SPACE(27) + STR0043 + SPACE(25),oCourier,100,CLR_BLACK)	//"D E M O N S T R A T I V O"
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,"|" + SPACE(77),oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,STR0044,oCourier,100,CLR_BLACK)	//"|  Periodo de ferias em Abono Pecuniario      Periodo de gozo de ferias       |"
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013

			If !empty(SRH->RH_ABOPEC)
				cAbono 	:= SRH->RH_ABOPEC
			Else
				cAbono	:= GetMv("MV_ABOPEC")                  //-- Define se o periodo do abono pecuniario será considerado antes ou depois do gozo de ferias 
				cAbono 	:= if(cAbono=="S","1","2")    		   //-- Abono antes
			EndIF
			
			If cAbono == "1"
				oPrn:Say(nLin,0020,"|"+Space(7)+PADR(DtoC(SRH->RH_DATAINI-SRH->RH_DABONPE),10)+STR0045+Dtoc(SRH->RH_DATAINI-1)                        +Space(15)+PADR(Dtoc(SRH->RH_DATAINI),10)+STR0045+PADR(DtoC(DaAuxF),10)+Space(5),oCourier,100,CLR_BLACK)	//"  a  "###"  a  "
				oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			Else
				oPrn:Say(nLin,0020,"|"+Space(7)+PADR(DtoC( DaAuxF + 1            ),10)+STR0045+PADR(Dtoc(DaAuxF+SRH->RH_DABONPE),10)+Space(15)+PADR(Dtoc(SRH->RH_DATAINI),10)+STR0045+PADR(DtoC(DaAuxF),10)+Space(5),oCourier,100,CLR_BLACK)	//"  a  "###"  a  "
				oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			Endif

			nLin += 0013
			oPrn:Say(nLin,0020,"|" + SPACE(77),oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,"|" + SPACE(07) + STR0046+STR(SRH->RH_DABONPE,3)+STR0047+TRANSFORM(nValAb,"@E 999,999,999.99")+SPACE(28),oCourier,100,CLR_BLACK)	//"Abono ("###") Dias :          "
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,"|" + SPACE(07) + STR0048+TRANSFORM(nValAb13,"@E 999,999,999.99")+SPACE(28),oCourier,100,CLR_BLACK)										//"Acrescimo 1/3 :             "
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,"|" + SPACE(07) + STR0049+TRANSFORM(nValAb13+nValab ,"@E 999,999,999.99")+SPACE(28),oCourier,100,CLR_BLACK)							//"Liquido :                   "
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			nValnLiq := nValAb13+nValab
			oPrn:Say(nLin,0020,"|" + SPACE(77),oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,"|" + SPACE(77),oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			cExt := Extenso(nValnLiq,.F.,1)
			SepExt(cExt,13,70,@cRet1,@cRet2)
			oPrn:Say(nLin,0020,"|" + SPACE(17) + STR0050 + SubStr(aInfo[3], 1, 50),oCourier,100,CLR_BLACK)		//"Recebi de "
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,"|" +Space(07)+ STR0051+TRANSFORM(nValnLiq,"@E 999,999,999.99") + "  ("+cRet1+SPACE(9),oCourier,100,CLR_BLACK)	//" a importancia Liquida de  R$ "
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013

			nLenCRet2 := len(cRet2)
			If nLenCRet2 > 63
				oPrn:Say(nLin,0020,"|" +SPACE(08)+subStr(cRet2,1, 69),oCourier,100,CLR_BLACK)
				oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
				nLin += 0013
				oPrn:Say(nLin,0020,"|" +SPACE(08)+subStr(cRet2,70)+".****)",oCourier,100,CLR_BLACK)
				oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
				nLin += 0013
				oPrn:Say(nLin,0020,"|" + SPACE(07) + STR0052,oCourier,100,CLR_BLACK)		//" conforme demonstrativo acima, referente ao abono pecuniario."
				oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
				nLin += 0013
				oPrn:Say(nLin,0020,"|" + SPACE(77),oCourier,100,CLR_BLACK)
				oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
				nLin += 0013
				oPrn:Say(nLin,0020,"|" + SPACE(77),oCourier,100,CLR_BLACK)
				oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
				nLin += 0013
				oPrn:Say(nLin,0020,"| " + ALLTRIM(aInfo[5])+", "+STRZERO(DAY(SRH->RH_DTRECIB),2)+STR0053+MesExtenso(MONTH(SRH->RH_DTRECIB))+STR0053+STR(YEAR(SRH->RH_DTRECIB),4),oCourier,100,CLR_BLACK)	//" de "###" de "
				oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
				nLin += 0013
				oPrn:Say(nLin,0020,"|" + SPACE(46)+cReplic30,oCourier,100,CLR_BLACK)
				oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
				nLin += 0013

				If !Empty(SRA->RA_NSOCIAL)
					oPrn:Say(nLin,0020,"|" + SPACE(46) + Left(SRA->RA_NSOCIAL, 30),oCourier,100,CLR_BLACK)
					oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
				Else
					oPrn:Say(nLin,0020,"|" + SPACE(46) + SRA->RA_NOME     ,oCourier,100,CLR_BLACK)
					oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
				EndIf
				nLin += 0013
				oPrn:Say(nLin,0020,"|" + SPACE(77),oCourier,100,CLR_BLACK)
				oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
				nLin += 0013
				oPrn:Say(nLin,0020,"*" + cReplic77 + "*",oCourier,100,CLR_BLACK)
			Else
				oPrn:Say(nLin,0020,"|" +SPACE(08)+cRet2+".****)",oCourier,100,CLR_BLACK)
				oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
				nLin += 0013
				oPrn:Say(nLin,0020,"|" + SPACE(07) + STR0052,oCourier,100,CLR_BLACK)		//" conforme demonstrativo acima, referente ao abono pecuniario."
				oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
				nLin += 0013
				oPrn:Say(nLin,0020,"|" + SPACE(77),oCourier,100,CLR_BLACK)
				oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
				nLin += 0013
				oPrn:Say(nLin,0020,"|" + SPACE(77),oCourier,100,CLR_BLACK)
				oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
				nLin += 0013
				oPrn:Say(nLin,0020,"| " + ALLTRIM(aInfo[5])+", "+STRZERO(DAY(SRH->RH_DTRECIB),2)+STR0053+MesExtenso(MONTH(SRH->RH_DTRECIB))+STR0053+STR(YEAR(SRH->RH_DTRECIB),4),oCourier,100,CLR_BLACK)	//" de "###" de "
				oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
				nLin += 0013
				oPrn:Say(nLin,0020,"|" + SPACE(46)+cReplic30,oCourier,100,CLR_BLACK)
				oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
				nLin += 0013

				If !Empty(SRA->RA_NSOCIAL)
					oPrn:Say(nLin,0020,"|" + SPACE(46) + Left(SRA->RA_NSOCIAL, 30),oCourier,100,CLR_BLACK)
					oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
				Else
					oPrn:Say(nLin,0020,"|" + SPACE(46) + SRA->RA_NOME     ,oCourier,100,CLR_BLACK)
					oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)	
				EndIf

				nLin += 0013
				oPrn:Say(nLin,0020,"|" + SPACE(77),oCourier,100,CLR_BLACK)
				oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)	
				nLin += 0013
				oPrn:Say(nLin,0020,"*" + cReplic77 + "*",oCourier,100,CLR_BLACK)
				
			EndIf

			oPrn:EndPage()
		Endif
		
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Solicitacao 1a Parcela 13o Salario                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nSol13 == 1
		n1Parc   := 0
		
		dbSelectArea( "SRR" )
		SRR->(dbSetOrder(1))	
		
		If dbSeek(SRA->RA_FILIAL + SRA->RA_MAT + "F" + Dtos(dDtBusFer) + aCodFol[022,1] )
			n1Parc := 1
		Endif
		
		If n1Parc > 0

			oPrn:StartPage()

			nLin := 0003
			oPrn:SayBitmap(nLin,0040, "\system\LGMID0101.PNG", 0150,0056)	
			oPrn:Say(nLin,0020,"*" + cReplic77 + "*",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,"|" + SPACE(18) + STR0001	+SPACE(17),oCourier,100,CLR_BLACK)	//" SOLICITACAO DA 1a PARCELA DO 13o SALARIO "
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,"|" + SPACE(18) +" ======================================== "+SPACE(17),oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,"|" + SPACE(77),oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,"|" + SPACE(77),oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,"|" + SPACE(77),oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,"|" + SPACE(77),oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,"|" + SPACE(77),oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013					
			oPrn:Say(nLin,0020,"|" + SPACE(77),oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013		
			oPrn:Say(nLin,0020,"|" + SPACE(77),oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,"|" + SPACE(77),oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013											
			If dDtSt13 > SRA->RA_ADMISSA
				oPrn:Say(nLin,0020,"|" + SPACE(28+(20-LEN(ALLTRIM(aInfo[5]))))+ALLTRIM(aInfo[5])+", "+SUBSTR(DTOC(dDTSt13),1,2)+STR0002+MesExtenso(MONTH(dDTSt13))+STR0002+STR(YEAR(dDTSt13),4),oCourier,100,CLR_BLACK)	//" de "###" de "
			Else
				oPrn:Say(nLin,0020,"|" + SPACE(28+(20-LEN(ALLTRIM(aInfo[5]))))+ALLTRIM(aInfo[5])+", "+SUBSTR(DTOC(SRA->RA_ADMISSA),1,2)+STR0002+MesExtenso(MONTH(SRA->RA_ADMISSA))+STR0002+STR(YEAR(SRA->RA_ADMISSA),4),oCourier,100,CLR_BLACK)	//" de "###" de "
			Endif
		
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,"|" + SPACE(77),oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,"|" + SPACE(07) + STR0003 +SPACE(69),oCourier,100,CLR_BLACK)	//"A"
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,"|" + SPACE(07) + aInfo[3],oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,"|" + SPACE(77),oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,"|" + SPACE(77),oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,"|" + SPACE(07) + STR0004 + SPACE(53),oCourier,100,CLR_BLACK)	//"Prezados Senhores"
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,"|" + SPACE(77),oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,"|" + SPACE(77),oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,"|" + SPACE(16) + STR0005 + SPACE(4),oCourier,100,CLR_BLACK)	//"Nos  termos da legislacao vigente, solicito  o  pagamento"
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,"|" + SPACE(07) + STR0006,oCourier,100,CLR_BLACK)										//"da  1a  Parcela  do 13o Salario por  ocasiao  do  gozo  de  minhas    |"
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,"|" + SPACE(07) + STR0007 + SPACE(63),oCourier,100,CLR_BLACK)	//"ferias."
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,"|" + SPACE(16) + STR0008+SPACE(19),oCourier,100,CLR_BLACK)//"Solicito apor o seu ciente na copia desta."
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,"|" + SPACE(77),oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,"|" + SPACE(77),oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			
			If !Empty(SRA->RA_NSOCIAL)
				oPrn:Say(nLin,0020,"|" + SPACE(07) + SRA->RA_NSOCIAL,oCourier,100,CLR_BLACK)
				oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
				nLin += 0013
				oPrn:Say(nLin,0020,"|" + SPACE(07) + STR0009 + SRA->RA_FILIAL + " " + SRA->RA_MAT,oCourier,100,CLR_BLACK) // "Registro No: "
			Else
				oPrn:Say(nLin,0020,"|" + SPACE(07) + SRA->RA_NOME+SPACE(02)+STR0009+SRA->RA_FILIAL+" "+SRA->RA_MAT,oCourier,100,CLR_BLACK)//+SPACE(16)+"|"	//"Registro No: "
			EndIf
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			
			// Se for Brasil e imprime funcionarios demitidos SIM, utilizar CC
			// da tabela SRR para buscar CC da epoca das ferias do funcionario
			If cPaisLoc == "BRA" .and. SRA->RA_SITFOLH $ "D" .and. nImprDem == 1
				cDesc := DescCc( SRR->RR_CC, SRR->RR_FILIAL )
			Else
				cDesc := DescCc( SRA->RA_CC, SRA->RA_FILIAL )
			EndIf
			
			cLinha:= "|" + SPACE(07) + STR0010 + SRA->RA_NUMCP+" - "+SRA->RA_SERCP+SPACE(10)	//"CTPS = "		
			cLInha:= cLinha + "C.CUSTO: " + Alltrim(cDesc)
			oPrn:Say(nLin,0020,cLinha,oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013

			lDepto	:= CpoUsado("RA_DEPTO") .And. !EMPTY(SRA->RA_DEPTO)
			IF lDepto 
				oPrn:Say(nLin,0020,"|" + SPACE(39) + STR0028 + ( fDesc('SQB',SRA->RA_DEPTO,'QB_DESCRIC') ),oCourier,100,CLR_BLACK)
				oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			Else
				oPrn:Say(nLin,0020,"|",oCourier,100,CLR_BLACK)
				oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			EndIF
			nLin += 0013
			oPrn:Say(nLin,0020,"|" + SPACE(77),oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,"|" + SPACE(77),oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,"|" + SPACE(07) + STR0011+SPACE(18)+STR0012+SPACE(17),oCourier,100,CLR_BLACK)	//"Atenciosamente"###"Ciente em ___/___/___"
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,"|" + SPACE(77),oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,"|" + SPACE(77),oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,"|" + SPACE(07) + cReplic22+SPACE(10)+cReplic35+space(03),oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,"|" + SPACE(77),oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,"*" + cReplic77 + "*",oCourier,100,CLR_BLACK)

			oPrn:EndPage()
			
		Endif
	Endif	


	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Recibo De 13o Salario                                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nRec13 == 1
		nVal13o  := 0.00
		nPen13o  := 0.00
		nVal13a  := 0.00
		nValnLiq := 0.00
		cRet1    := ''
		cRet2    := ''
		
				
		dbSelectArea( "SRR" )
		SRR->(dbSetOrder(1))
		If dbSeek(SRA->RA_FILIAL + SRA->RA_MAT + "F" + Dtos(dDtBusFer) + cPd13o )
			nVal13o := SRR->RR_VALOR
		Endif
		
		For nCntCd := 1 To Len(aCodBenef)
			If dbSeek(SRA->RA_FILIAL + SRA->RA_MAT + "F" + Dtos(dDtBusFer) + aCodBenef[nCntCd,1] )
				nPen13o += SRR->RR_VALOR
			EndIf
		Next nCntCd
		
		If nVal13o > 0
			
			oPrn:StartPage()

			nLin := 0003
			oPrn:SayBitmap(nLin,0040, "\system\LGMID0101.PNG", 0150,0056)
			oPrn:Say(nLin,0020,"*" + cReplic77 + "*",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,"|" + SPACE(20) + STR0054+SPACE(19),oCourier,100,CLR_BLACK)//" RECIBO DA 1a. PARCELA DO 13o SALARIO "
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,"|" + SPACE(20) +" ==================================== "+SPACE(19),oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,"|" + SPACE(77),oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,"|" + SPACE(77),oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,"|" + SPACE(77),oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,"|" + SPACE(77),oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,"|" + SPACE(77),oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,"|" + SPACE(77),oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,"|" + SPACE(77),oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,"|" + SPACE(77),oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			
			If !Empty(SRA->RA_NSOCIAL)
				oPrn:Say(nLin,0020,"|" + SPACE(07) + SRA->RA_NSOCIAL,oCourier,100,CLR_BLACK)
				oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			Else
				oPrn:Say(nLin,0020,"|" + SPACE(07) + Sra->RA_NOME+SPACE(40),oCourier,100,CLR_BLACK)
				oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			EndIf
			
			// Se for Brasil e imprime funcionarios demitidos SIM, utilizar CC
			// da tabela SRR para buscar CC da epoca das ferias do funcionario
			If cPaisLoc == "BRA" .and. SRA->RA_SITFOLH $ "D" .and. nImprDem == 1
				cDesc := DescCc( SRR->RR_CC, SRR->RR_FILIAL )
			Else
				cDesc := DescCc( SRA->RA_CC, SRA->RA_FILIAL )
			EndIf
			
			nTamSpaco := 77-(7 + 7 + len(SRA->RA_NUMCP) + 3 + len(SRA->RA_SERCP) + 8 + 7 + len(cDesc))
			
			cLinha:="|" + SPACE(07) + STR0056 + SRA->RA_NUMCP+" - "+SRA->RA_SERCP+SPACE(8) 	//"CTPS = "
			cLInha := cLinha + "C.CUSTO: " + Alltrim(cDesc)
			nLin += 0013

			oPrn:Say(nLin,0020,cLinha,oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013

			lDepto	:= CpoUsado("RA_DEPTO") .And. !EMPTY(SRA->RA_DEPTO)
			IF lDepto 
				oPrn:Say(nLin,0020,"|" + SPACE(37) + STR0028 + ( fDesc('SQB',SRA->RA_DEPTO,'QB_DESCRIC') ),oCourier,100,CLR_BLACK)
				oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			Else
				oPrn:Say(nLin,0020,"|" + SPACE(77),oCourier,100,CLR_BLACK)
				oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			EndIF	

			nLin += 0013

			oPrn:Say(nLin,0020,"|" + SPACE(77),oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,"|" + SPACE(27) + STR0058 + SPACE(25),oCourier,100,CLR_BLACK)	//"D E M O N S T R A T I V O"
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,"|" + SPACE(77),oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,"|" + SPACE(07) + STR0059+TRANSFORM(nVal13o,"@E 999,999,999.99")+SPACE(28),oCourier,100,CLR_BLACK)	//"1a Parcela do 13o Salario : "
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,"|" + SPACE(07) + STR0060+TRANSFORM(nVal13a,"@E 999,999,999.99")+SPACE(28),oCourier,100,CLR_BLACK)	//"Adiantamento :              "
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013

			If nPen13o > 0
				oPrn:Say(nLin,0020,"|" + SPACE(07) + STR0114+TRANSFORM(nPen13o,"@E 999,999,999.99")+SPACE(28),oCourier,100,CLR_BLACK)	//"Pensao :"
				oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			EndIf

			nLin += 0013
			oPrn:Say(nLin,If(nPen13o>0,14,13),0020,"|" + SPACE(07) + STR0061+TRANSFORM(nVal13o-nVal13a-nPen13o,"@E 999,999,999.99")+SPACE(28),oCourier,100,CLR_BLACK)//"Liquido :                   "
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			
			nValnLiq := nVal13o-nVal13a-nPen13o
			If nPen13o == 0
				oPrn:Say(nLin,0020,"|" + SPACE(77),oCourier,100,CLR_BLACK)
				oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			EndIf
			
			nLin += 0013
			oPrn:Say(nLin,0020,"|" + SPACE(77),oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013

			cExt := Extenso(nValnLiq,.F.,1)
			SepExt(cExt,13,70,@cRet1,@cRet2)

			oPrn:Say(nLin,0020,"|" + SPACE(16) + STR0062 + subStr(aInfo[3], 1, 50),oCourier,100,CLR_BLACK)	//"Recebi de "
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,"|" +Space(07)+ STR0063+TRANSFORM(nValnLiq,"@E 999,999,999.99") + "  ("+cRet1+SPACE(9),oCourier,100,CLR_BLACK)	//" a importancia Liquida de  R$ "
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013

			nLenCRet2 := len(cRet2)
			If nLenCRet2 > 63
				oPrn:Say(nLin,0020,"|" +SPACE(08)+subStr(cRet2,1, 69),oCourier,100,CLR_BLACK)
				oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
				nLin += 0013
				oPrn:Say(nLin,0020,"|" +SPACE(08)+subStr(cRet2,70)+".****)",oCourier,100,CLR_BLACK)
				oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
				nLin += 0013
				oPrn:Say(nLin,0020,"|" + SPACE(07) + STR0064,oCourier,100,CLR_BLACK)	//" conforme demonstrativo acima, referente a 1a parcela do 13o salario."
				oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
				nLin += 0013
				oPrn:Say(nLin,0020,"|" + SPACE(77),oCourier,100,CLR_BLACK)	
				oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
				nLin += 0013
				oPrn:Say(nLin,0020,"|" + SPACE(77),oCourier,100,CLR_BLACK)	
				oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
				nLin += 0013
				oPrn:Say(nLin,0020,"| " + ALLTRIM(aInfo[5])+", "+STRZERO(DAY(SRH->RH_DTRECIB),2)+STR0065+MesExtenso(MONTH(SRH->RH_DTRECIB))+STR0066+STR(YEAR(SRH->RH_DTRECIB),4),oCourier,100,CLR_BLACK)	//" de "###" de "
				oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
				nLin += 0013
				oPrn:Say(nLin,0020,"|" + SPACE(46)+cReplic30,oCourier,100,CLR_BLACK)
				oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
				nLin += 0013
				If !Empty(SRA->RA_NSOCIAL)
					oPrn:Say(nLin,0020,"|" + SPACE(46) + Left(SRA->RA_NSOCIAL, 30),oCourier,100,CLR_BLACK)
					oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
				Else
					oPrn:Say(nLin,0020,"|" + SPACE(46) + SRA->RA_NOME     ,oCourier,100,CLR_BLACK)
					oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
				EndIf
				nLin += 0013
				oPrn:Say(nLin,0020,"|" + SPACE(77),oCourier,100,CLR_BLACK)
				oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
				nLin += 0013
				oPrn:Say(nLin,0020,"*" + cReplic77 + "*",oCourier,100,CLR_BLACK)
				
			Else
				oPrn:Say(nLin,0020,"|" +SPACE(08)+cRet2+".****)",oCourier,100,CLR_BLACK) 
				oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
				nLin += 0013
				oPrn:Say(nLin,0020,"|" + SPACE(07) + STR0064,oCourier,100,CLR_BLACK) 	//" conforme demonstrativo acima, referente a 1a parcela do 13o salario."
				oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
				nLin += 0013
				oPrn:Say(nLin,0020,"|" + SPACE(77),oCourier,100,CLR_BLACK)
				oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
				nLin += 0013
				oPrn:Say(nLin,0020,"|" + SPACE(77),oCourier,100,CLR_BLACK)
				oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
				nLin += 0013
				oPrn:Say(nLin,0020,"| " + ALLTRIM(aInfo[5])+", "+STRZERO(DAY(SRH->RH_DTRECIB),2)+STR0065+MesExtenso(MONTH(SRH->RH_DTRECIB))+STR0066+STR(YEAR(SRH->RH_DTRECIB),4),oCourier,100,CLR_BLACK)	//" de "###" de "
				oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
				nLin += 0013
				oPrn:Say(nLin,0020,"|" + SPACE(46)+cReplic30,oCourier,100,CLR_BLACK)
				oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
				nLin += 0013
				If !Empty(SRA->RA_NSOCIAL)
					oPrn:Say(nLin,0020,"|" + SPACE(46) + Left(SRA->RA_NSOCIAL, 30),oCourier,100,CLR_BLACK)
					oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
				Else
					oPrn:Say(nLin,0020,"|" + SPACE(46) + SRA->RA_NOME     ,oCourier,100,CLR_BLACK)
					oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)

				EndIf
				nLin += 0013
				oPrn:Say(nLin,0020,"|" + SPACE(77),oCourier,100,CLR_BLACK)
				oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
				nLin += 0013
				oPrn:Say(nLin,0020,"*" + cReplic77 + "*",oCourier,100,CLR_BLACK)
				
			EndIf

			oPrn:EndPage()
		Endif
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Recibo De Ferias                                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nRecib == 1
		
		aPdv  := {}
		aPdd  := {}
		cRet1 := ""
		cRet2 := ""
		nLi   := 1
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Posiciona Arq. SRR Para Guardar na Matriz as Verbas De Ferias³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If Empty( nOrdSRR )
			nOrdSRR := RetOrder( "SRR", "RR_FILIAL+RR_MAT+RR_TIPO3+DTOS(RR_DATA)+RR_PD+RR_CC" )
		EndiF
		
		dbSelectArea("SRR")
		dbSetOrder(nOrdSRR)
		If dbSeek( SRA->RA_FILIAL + SRA->RA_MAT + "F" )
			While ! Eof() .And. SRA->RA_FIlIAL + SRA->RA_MAT + "F" == SRR->RR_FILIAL + SRR->RR_MAT + SRR->RR_TIPO3
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Verifica Verba For Abono Ou 13o Esta $ Na Variavel Nao Lista ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If AScan(aVerbsAbo, SRR->RR_PD ) == 0 .And.;
					AScan(aVerbs13Abo, SRR->RR_PD ) == 0 .And.;
					SRR->RR_PD # cPd13o .And. SRR->RR_PD # aCodFol[102,1] .And.; 					
					AScan(aCodBenef, { |x| x[1] == SRR->RR_PD }) == 0
					
					If SRR->RR_DATA == dDtBusFer
						If PosSrv( SRR->RR_PD , SRA->RA_FILIAL , "RV_TIPOCOD" ) == "1"
							AAdd(aPdv , { SRR->RR_PD , SRR->RR_VALOR, SRR->RR_PERIODO, SRR->RR_ROTEIR, SRR->RR_SEMANA, SRR->RR_CC, SRR->RR_SEQ })
						ElseIf PosSrv( SRR->RR_PD , SRA->RA_FILIAL , "RV_TIPOCOD" ) == "2"
							AAdd(aPdd , { SRR->RR_PD , SRR->RR_VALOR, SRR->RR_PERIODO, SRR->RR_ROTEIR, SRR->RR_SEMANA, SRR->RR_CC, SRR->RR_SEQ })
						Endif
					Endif
					
				Endif
				dbSkip()
			Enddo
			
			PER_AQ_I := STRZERO(DAY(SRH->RH_DATABAS),2)+STR0067+MesExtenso(MONTH(SRH->RH_DATABAS))+STR0067+STR(YEAR(SRH->RH_DATABAS),4)	//" De "###" De "
			PER_AQ_F := STRZERO(DAY(SRH->RH_DBASEAT),2)+STR0067+MesExtenso(MONTH(SRH->RH_DBASEAT))+STR0067+STR(YEAR(SRH->RH_DBASEAT),4)	//" De "###" De "
			PER_GO_I := STRZERO(DAY(DAAUXI),2)+STR0067+MesExtenso(MONTH(DAAUXI))+STR0067+STR(YEAR(DAAUXI),4)		//" De "###" De "
			PER_GO_F := STRZERO(DAY(DAAUXF),2)+STR0067+MesExtenso(MONTH(DAAUXF))+STR0067+STR(YEAR(DAAUXF),4)		//" De "###" De "
			
			oPrn:StartPage()

			nLin := 0003
			oPrn:SayBitmap(nLin,0040, "\system\LGMID0101.PNG", 0150,0056)
			oPrn:Say(nLin,0020,"*" + cReplic77 + "*",oCourier,100,CLR_BLACK) 
			nLin += 0013
			oPrn:Say(nLin,0020,"|",oCourier,100,CLR_BLACK) 
			oPrn:Say(nLin,0250,STR0068,oCourier,100,CLR_BLACK) 		//" RECIBO DE FERIAS "
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,"|",oCourier,100,CLR_BLACK) 
			oPrn:Say(nLin,0250," ================ ",oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,"|" + SPACE(77),oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,"|" + SPACE(77),oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,"|" + SPACE(77),oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,"|" + SPACE(77),oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,"|" + SPACE(77),oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			If !Empty(SRA->RA_NSOCIAL)
				oPrn:Say(nLin,0020,STR0150+Left(SRA->RA_NSOCIAL, 60)+SPACE(3),oCourier,100,CLR_BLACK)			//"| Nome Social: "
				oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			Else
				oPrn:Say(nLin,0020,STR0069+Left(SRA->RA_NOME,30)+SPACE(020),oCourier,100,CLR_BLACK)			//"| Nome do Empregado.......: "
				oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			EndIf
			nLin += 0013   
			
			If ! (cPaisLoc $ "ARG|ANG")
				oPrn:Say(nLin,0020,STR0070 + If(Empty(SRA->RA_NUMCP),Space(7),AllTrim(SRA->RA_NUMCP))+" - "+SRA->RA_SERCP+SPACE(01)+STR0071+SRA->RA_FILIAL+" "+SRA->RA_MAT,oCourier,100,CLR_BLACK)			//"| Carteira Trabalho.......: " //"Registro: "
				oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)			
			Else
				cLinAtu := "| " + STR0071+SRA->RA_FILIAL+" "+SRA->RA_MAT
				oPrn:Say(nLin,0020,cLinAtu + Space( 78-Len(cLinAtu) ),oCourier,100,CLR_BLACK)	//"Registro: "
				oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			EndIf
			
			nLin += 0013 
			oPrn:Say(nLin,0020,STR0072+PER_AQ_I+STR0073+PER_AQ_F,oCourier,100,CLR_BLACK)	//"| Periodo Aquisitivo......: "###" A "
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013      
			
			IF cPaisLoc <> "ANG"
				oPrn:Say(nLin,0020,Iif(lSomLiR,STR0149,STR0074)+PER_GO_I+STR0073+PER_GO_F,oCourier,100,CLR_BLACK)	//"| Periodo Gozo das Ferias.: "###" A " 
			ELSE

			    For i=1 to Len(aGozoFer)
			    	
					PER_GO_I := STR(DAY(aGozoFer[i][1]),2)+STR0067+MesExtenso(MONTH(aGozoFer[i][1]))+STR0067+STR(YEAR(aGozoFer[i][1]),4)		//" De "###" De "
					PER_GO_F := STR(DAY(aGozoFer[i][2]),2)+STR0067+MesExtenso(MONTH(aGozoFer[i][2]))+STR0067+STR(YEAR(aGozoFer[i][2]),4)		//" De "###" De "
			    	
			    	oPrn:Say(nLin,0020,STR0074+PER_GO_I+STR0073+PER_GO_F,oCourier,100,CLR_BLACK) 
			       
			    	IF i <> Len(aGozoFer)
    					oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
						nLin += 0013
			    	ENDIF
			    	
			    Next i
			    
			Endif

			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,STR0137 + cValToChar(SRH->RH_DIALRE1 + SRH->RH_DIALREM),oCourier,100,CLR_BLACK)			//"| Qtde. Dias Lic. Remun...: "
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,"*" + cReplic77 + "*",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,"|",oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0200,"DADOS PARA CALCULO DE PAGAMENTO FERIAS",oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013			
			oPrn:Say(nLin,0020,"*" + cReplic77 + "*",oCourier,100,CLR_BLACK)
			nLin += 0013								
			oPrn:Say(nLin,0020,STR0075 + Transform(SRH->RH_SALMES,"@E 999,999.99")+Space(05)+STR0077 + Transform(SRH->RH_SALHRS,"@E 999,999.99"),oCourier,100,CLR_BLACK)		//"| Salario Mes ............: "
			//Space(05)+STR0077 + Transform(SRH->RH_SALHRS,"@E 999,999.99")				//"Salario Hora ...........: "
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,STR0076 + Transform(SRH->RH_SALDIA,"@E 999,999.99")+Space(05)+STR0127 + Transform(SRH->RH_SALDIA1,"@E 999,999.99"),oCourier,100,CLR_BLACK)			//"Valor Dia Mes...: "
			//Space(05)+STR0127 + Transform(SRH->RH_SALDIA1,"@E 999,999.99")				//"Valor Dia Mes Seg: "
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			
			cDiasFMes := If(SRR->(dbSeek(SRA->RA_FILIAL + SRA->RA_MAT + "F" +; 
									Dtos(dDtBusFer) + aCodFol[072,1])), Transform(SRR->RR_HORAS, "@E 999,999.99"), Space(11))
									
			cDiasFMesSeg := If(SRR->(dbSeek(SRA->RA_FILIAL + SRA->RA_MAT + "F" +; 
										Dtos(dDtBusFer) + aCodFol[073,1])), Transform(SRR->RR_HORAS, "@E 999,999.99"), Space(11))									
			
			If SRA->RA_CATFUNC = 'C'
			 	cCodPgMed := ACODFOL[343,1]
			 	cCodMedMs := ACODFOL[344,1]
				If Empty(cDiasFMes)  
					cDiasFMes := If(SRR->(dbSeek(SRA->RA_FILIAL + SRA->RA_MAT + "F" +; 
									Dtos(dDtBusFer) + If(!Empty(cCodPgMed),cCodPgMed,aCodFol[075,1] ))), Transform(SRR->RR_HORAS, "@E 999,999.99"), Space(11))
					cDiasFMesSeg := If(SRR->(dbSeek(SRA->RA_FILIAL + SRA->RA_MAT + "F" +; 
									Dtos(dDtBusFer) + If(!Empty(cCodMedMs),cCodMedMs,aCodFol[076,1]) )), Transform(SRR->RR_HORAS, "@E 999,999.99"), Space(11))	
				ENDIF					
			Endif 								
			
			oPrn:Say(nLin,0020,STR0128 + cDiasFMes +Space(05)+STR0129 + cDiasFMesSeg,oCourier,100,CLR_BLACK)					//"Dias Ferias Mes: "
			//Space(05)+STR0129 + cDiasFMesSeg						//"Dias Ferias Mes Seg: "
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013					
			
			cDiasAbMes := If(SRR->(dbSeek(SRA->RA_FILIAL + SRA->RA_MAT + "F" +; 
										Dtos(dDtBusFer) + aCodFol[074,1])), Transform(SRR->RR_HORAS, "@E 999,999.99"), Space(11))
									
			cDiasAbMSeg := If(SRR->(dbSeek(SRA->RA_FILIAL + SRA->RA_MAT + "F" +; 
										Dtos(dDtBusFer) + aCodFol[205,1])), Transform(SRR->RR_HORAS, "@E 999,999.99"), Space(11))												
			If SRA->RA_CATFUNC = 'C'
				If Empty(cDiasAbMes) 
					cDiasAbMes := If(SRR->(dbSeek(SRA->RA_FILIAL + SRA->RA_MAT + "F" +; 
										Dtos(dDtBusFer) + aCodFol[623,1])), Transform(SRR->RR_HORAS, "@E 999,999.99"), Space(11))
									
					cDiasAbMSeg := If(SRR->(dbSeek(SRA->RA_FILIAL + SRA->RA_MAT + "F" +; 
										Dtos(dDtBusFer) + aCodFol[634,1])), Transform(SRR->RR_HORAS, "@E 999,999.99"), Space(11))
				Endif						
			Endif																		
			
					
			
			oPrn:Say(nLin,0020,STR0130 + cDiasAbMes +Space(05) + STR0131 + cDiasAbMSeg,oCourier,100,CLR_BLACK)	//"Dias Abono Mes: "
			//Space(05) + STR0131 + cDiasAbMSeg		//"Dias Abono Mes Seg: "
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013														
			oPrn:Say(nLin,0020,"*" + cReplic77 + "*",oCourier,100,CLR_BLACK)
			nLin += 0013
			oPrn:Say(nLin,0020,STR0079,oCourier,100,CLR_BLACK)	//"|          P R O V E N T O S           |           D E S C O N T O S          |"
			nLin += 0013
			oPrn:Say(nLin,0020,"|-----------------------------------------------------------------------------|",oCourier,100,CLR_BLACK)
			nLin += 0013
			//Cod##Verba##Q/H##Valor
			oPrn:Say(nLin,0020,"| " + STR0133 + " " + STR0134 + Space(12) + STR0135 + Space(7) + STR0136 + " | " +STR0133 + " " + STR0134 + Space(12) + STR0135 + Space(7) + STR0136,oCourier,100,CLR_BLACK)
							
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)					
			nLin += 0013
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Impressao das Verbas                                         ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			nMaximo := MAX(Len(aPDV),Len(aPdd))
			SRR->(DbSetOrder(1))

			For nConta :=1 TO nMaximo
			
				If nConta > Len(aPdv)
					DET := Space(37) + "| "
				ElseIf !Empty(aPdv[nConta,7]) // Verifico se existe sequencia, pois pode haver verbas repetidas e será necessário utilizar o indice 4 para busca correta
					SRR->(DbSetOrder(4))//RR_FILIAL+RR_MAT+RR_PERIODO+RR_ROTEIR+RR_SEMANA+RR_PD+RR_CC+RR_SEQ+RR_DATA
					SRR->(DbSeek(SRA->RA_FILIAL + SRA->RA_MAT + aPdv[nConta,3] + aPdv[nConta,4] + aPdv[nConta,5] + aPdv[nConta,1] + aPdv[nConta,6] + aPdv[nConta,7] + DToS(dDtBusFer)) )
					nQtdHoras := SRR->RR_HORAS
					cDesc := Left(DescPd(aPdv[nConta,1],SRA->RA_FILIAL),15)
					DET := aPdv[nConta,1] + " " + cDesc + " " + Transform(nQtdHoras, '@E 99.99') + " " + Transform(aPdv[nConta,2],'@E 999,999.99')+"| "
					SRR->(DbSetOrder(1))
				Else
					SRR->(DbSeek(SRA->RA_FILIAL + SRA->RA_MAT + "F" + DToS(dDtBusFer) + aPdv[nConta,1]) )
					nQtdHoras := SRR->RR_HORAS
					cDesc := Left(DescPd(aPdv[nConta,1],SRA->RA_FILIAL),15)
					DET := aPdv[nConta,1] + " " + cDesc + " " + Transform(nQtdHoras, '@E 99.99') + " " + Transform(aPdv[nConta,2],'@E 999,999.99')+"| "
				EndIf
			
				If nConta > Len(aPdd)
					DET += Space(37) + "|"
				Else
					SRR->(DbSeek(SRA->RA_FILIAL + SRA->RA_MAT + "F" + DToS(dDtBusFer) + aPdd[nConta,1]) )
					nQtdHoras := SRR->RR_HORAS
					cDesc := Left(DescPd(aPdd[nConta,1],SRA->RA_FILIAL),15)
					DET += aPdd[nConta,1] + " " + cDesc + " " + Transform(nQtdHoras, '@E 99.99') + " " + Transform(aPdd[nConta,2],'@E 999,999.99')+" |"
				EndIf
			
				oPrn:Say(nLin,0020,"|" + Space(2) +DET,oCourier,100,CLR_BLACK)
				nLin += 0013
				fVerQuebra(nLin)
			Next
			
			nTvp := 0.00
			nTvd := 0.00
			AeVal(aPdv,{ |X| nTVP:= nTVP + X[2]})    // Acumula Valores
			AeVal(aPdd,{ |X| nTVD:= nTVD + X[2]})
			
			oPrn:Say(nLin,0020,"|                                      |                                      |",oCourier,100,CLR_BLACK)
			nLin += 0013
			fVerQuebra(nLin)
			oPrn:Say(nLin,0020,STR0080+Trans(nTvp,"@E 999,999,999.99")+" "+STR0081+Trans(nTvd,"@E 999,999,999.99"),oCourier,100,CLR_BLACK)	//"| Total Proventos......:"
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)						//"| Total Descontos......:"
			nLin += 0013
			fVerQuebra(nLin)
			oPrn:Say(nLin,0020,"*" + cReplic77 + "*",oCourier,100,CLR_BLACK)
			nLin += 0013
			fVerQuebra(nLin)
			cLiqReceber := Trans(nTvp-nTvd,"@E 999,999,999.99") 														
									
			oPrn:Say(nLin,0020,STR0132 + cLiqReceber,oCourier,100,CLR_BLACK)//"| Liquido a receber.." +Trans(nTvp-nTvd,"@E 999,999,999.99")
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)		 
			nLin += 0013			
			fVerQuebra(nLin)
			oPrn:Say(nLin,0020,"*" + cReplic77 + "*",oCourier,100,CLR_BLACK)
			nLin += 0013
			fVerQuebra(nLin)
			oPrn:Say(nLin,0020,"|" + SPACE(02) + STR0082 + SubStr(aInfo[3]+Space(40),1,40) + Space(23) ,oCourier,100,CLR_BLACK)	//"Recebi da: "
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			fVerQuebra(nLin)
			oPrn:Say(nLin,0020,"|" + SPACE(02) + STR0083 + SubStr(AllTrim(aInfo[4]) + ", " + AllTrim(aInfo[14]) + Space(40),1,40)+STR0084+SubStr(aInfo[7]+Space(8),1,8),oCourier,100,CLR_BLACK)		//"Estabelecida a "###"   -  Cep: "
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			fVerQuebra(nLin)
			oPrn:Say(nLin,0020,"|" + SPACE(02) + STR0085 + SubStr(aInfo[5]+Space(25),1,25)+STR0086+aInfo[6] + Space(27),oCourier,100,CLR_BLACK)	//"Cidade: "###"   -     UF: "
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			cExt   := EXTENSO(nTvp-nTvd,.F.,1)
			
			SepExt(cExt,52,77,@cRet1,@cRet2)
			
			
			fVerQuebra(nLin)
			oPrn:Say(nLin,0020, STR0087 + SubStr(aInfo[5]+Space(20),1,20)+", "+StrZero(Day(SRH->RH_DTRECIB),2)+STR0088+SubStr(MesExtenso(Month(SRH->RH_DTRECIB))+Space(9),1,9)+STR0089+STR(YEAR(SRH->RH_DTRECIB),4)+STR0090,oCourier,100,CLR_BLACK)	//"|  em "###"  de  "###"  de  "###" a importancia de      |"
			nLin += 0013
			fVerQuebra(nLin)
			oPrn:Say(nLin,0020,STR0091 + TRANSFORM(nTvp-nTvd,"@E 999,999,999.99")+" ("+cRet1,oCourier,100,CLR_BLACK)	//"|  R$ "
			If Len(cRet2) > 0
				oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			Else
				oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			Endif
			
			If Len(cRet2) > 0
				nLin += 0013
				fVerQuebra(nLin)
				oPrn:Say(nLin,0020,"|  "+cRet2+".****)",oCourier,100,CLR_BLACK)
				oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			Endif
			
			nLin += 0013
			fVerQuebra(nLin)
			oPrn:Say(nLin,0020,STR0092,oCourier,100,CLR_BLACK)		//"|  que me paga adiantadamente por motivo das minhas ferias regulamentares ,   |"
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			fVerQuebra(nLin)
			oPrn:Say(nLin,0020,STR0093,oCourier,100,CLR_BLACK)		//"|  ora  concedidas  que  vou  gozar de  acordo com a  descricao acima,        |"
			
			IF cPaisLoc <> "ANG"
				nLin += 0013     
				fVerQuebra(nLin)
				oPrn:Say(nLin,0020,STR0094,oCourier,100,CLR_BLACK)		//"|  tudo conforme o aviso que recebi em tempo, ao qual dei meu ciente.     |"
			ENDIF
			
			nLin += 0013 
			fVerQuebra(nLin)
			oPrn:Say(nLin,0020,STR0095,oCourier,100,CLR_BLACK)		//"|  Para clareza e documento, firmo o presente recibo, dando a firma plena e   |"
			nLin += 0013 
			fVerQuebra(nLin)
			oPrn:Say(nLin,0020,STR0096,oCourier,100,CLR_BLACK)		//"|  geral quitacao.                                                            |"
			nLin += 0013
			fVerQuebra(nLin)
			oPrn:Say(nLin,0020,"|" + SPACE(77),oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			fVerQuebra(nLin)

			//Impressao dos dados bancarios
			If lImpBco
				oPrn:Say(nLin,0020,"|" + Space(2) + STR0146 + cDtDisp,oCourier,100,CLR_BLACK)					//"A importância será disponibilizada em: "
				oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
				nLin += 0013
				fVerQuebra(nLin)
				oPrn:Say(nLin,0020,"|" + Space(2) + STR0144 + cBcoDesc,oCourier,100,CLR_BLACK)					//"Banco: " STR0144
				oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
				nLin += 0013
				fVerQuebra(nLin)
				oPrn:Say(nLin,0020,"|" + Space(2) + STR0145 + cBcoAg + "/" + cBcoCta,oCourier,100,CLR_BLACK)	//"Agência/Conta: "
				oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
				nLin += 0013
				fVerQuebra(nLin)
				oPrn:Say(nLin,0020,"|" + SPACE(77),oCourier,100,CLR_BLACK)
				oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
				nLin += 0013
				fVerQuebra(nLin)
			EndIf

			If nDtRec == 1
				oPrn:Say(nLin,0020,"|  "+ALLTRIM(aInfo[5])+", "+StrZero(Day(SRH->RH_DTRECIB),2)+STR0097+MesExtenso(MONTH(SRH->RH_DTRECIB))+STR0097+STRZERO(YEAR(SRH->RH_DTRECIB),4),oCourier,100,CLR_BLACK)	//" de "###" de "
				oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			Else
				oPrn:Say(nLin,0020,"|  ",oCourier,100,CLR_BLACK)
				oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			Endif
			nLin += 0013
			fVerQuebra(nLin)
			oPrn:Say(nLin,0020,"|" + SPACE(77),oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			fVerQuebra(nLin)
			oPrn:Say(nLin,0020,STR0098,oCourier,100,CLR_BLACK)	//"|                         Assinatura do Empregado:__________________________  |"
			nLin += 0013
			fVerQuebra(nLin)
			oPrn:Say(nLin,0020,"|" + SPACE(077),oCourier,100,CLR_BLACK)
			oPrn:Say(nLin,0628,"|",oCourier,100,CLR_BLACK)
			nLin += 0013
			fVerQuebra(nLin)
			oPrn:Say(nLin,0020,"*" + cReplic77 + "*",oCourier,100,CLR_BLACK)
			nLin += 0013
			fVerQuebra(nLin)
			
			IF cPaisLoc == "ANG"
				nLin += 0013
				fVerQuebra(nLin)
				oPrn:Say(nLin,0020,"* Artigo 161 LGT, desconto na duração de férias , na proporção de um dia de ",oCourier,100,CLR_BLACK)
				nLin += 0013       
				fVerQuebra(nLin)
				oPrn:Say(nLin,0020,"férias por cada dia de falta injustificada, e de um dia de férias por cada",oCourier,100,CLR_BLACK)
				nLin += 0013 
				fVerQuebra(nLin)
				oPrn:Say(nLin,0020,"três dias de falta justificada.",oCourier,100,CLR_BLACK)
				nLin += 0013 
				fVerQuebra(nLin)
			ENDIF
			
		oPrn:EndPage()	
		
		Endif
	Endif


Return()

Static Function FImprAvi(lTemCpoProg)

	Local dDtIniProg,nDiasAbono,nDiasFePro,nDiasDedFer
	Local nImprVias
	Local cQry		:= ""
	Local cData		:= dtos(dDtfDe)
	Local cData1	:= dTos(dDtfAte)
	Local nX		:= 1

	Private dRH_DTAVIS
	Private	dRH_DFERIA
	Private	dRH_DTRECI

	lMetadeFal := If( Type("lMetadeFal") == "U", .F. , lMetadeFal)
	lTempoParc := If( Type("lTempoParc") == "U", .F. , lTempoParc)

	If nAviso==1 // Imprimi Aviso

		aStruSRF  := If(Empty(aStruSRF),SRF->(dbStruct()),aStruSRF)

		cQry := GetNextAlias()
		BEGINSQL ALIAS cQry
				SELECT *
				FROM %table:SRF% SRF
				WHERE SRF.%notDel%
				AND RF_FILIAL= %exp:SRA->RA_FILIAL%
				AND RF_MAT=%exp:SRA->RA_MAT%
				AND RF_STATUS=%exp:'1'%
				AND ( (RF_DATAINI BETWEEN %exp:cData% AND %exp:cData1%) OR (RF_DATINI2 BETWEEN %exp:cData% AND %exp:cData1%)  OR (RF_DATINI3 BETWEEN %exp:cData% AND %exp:cData1%))
				ORDER BY RF_DATABAS
		ENDSQL
		For nX := 1 To Len(aStruSRF)
			If ( aStruSRF[nX][2] <> "C" )
				TcSetField(cQry,aStruSRF[nX][1],aStruSRF[nX][2],aStruSRF[nX][3],aStruSRF[nX][4])
			EndIf
		Next nX

		//-- Verifica se no Arquivo SRF Existe Periodo de Ferias
		If !(cQry)->(Eof())
			dDtIniProg := CTOD("")
			nDiasFePro := 0
			nDiasAbono := 0
			If (cQry)->RF_DATAINI >= dDtfDe .And. (cQry)->RF_DATAINI <= dDtfAte
				dDtIniProg := (cQry)->RF_DATAINI
				nDiasFePro := If(lTemCpoProg, (cQry)->RF_DFEPRO1, 0)
				nDiasAbono := If(lTemCpoProg, (cQry)->RF_DABPRO1, 0)
			ElseIf lTemCpoProg
				If (cQry)->RF_DATINI2 >= dDtfDe .And. (cQry)->RF_DATINI2 <= dDtfAte
					dDtIniProg := (cQry)->RF_DATINI2
					nDiasFePro := (cQry)->RF_DFEPRO2
					nDiasAbono := (cQry)->RF_DABPRO2
				ElseIf (cQry)->RF_DATINI3 >= dDtfDe .And. (cQry)->RF_DATINI3 <= dDtfAte
					dDtIniProg := (cQry)->RF_DATINI3
					nDiasFePro := (cQry)->RF_DFEPRO3
					nDiasAbono := (cQry)->RF_DABPRO3
				EndIf
			EndIf
			If !Empty(dDtIniProg)
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Carrega Matriz Com Dados da Empresa                          ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				fInfo(@aInfo,SRA->RA_FILIAL)
				nDferven := nDferave := 0
				If (cQry)->RF_DVENPEN > 0 .And. !Empty((cQry)->RF_IVENPEN)
			 		M->RH_DATABAS := (cQry)->RF_IVENPEN
					M->RH_DBASEAT := (cQry)->RF_FVENPEN
					nDferven       := (cQry)->RF_DVENPEN
				Else
			  		M->RH_DATABAS := (cQry)->RF_DATABAS
					M->RH_DBASEAT := fCalcFimAq((cQry)->RF_DATABAS)
					If nDiasFePro > 0
						nDferven := nDiasFePro
					Else
						//Calc_Fer(SRF->RF_DATABAS,dDatabase,@nDferven,@nDferave)
						nDferven := (cQry)->RF_DFERVAT
						nDferven := If (nDferVen <= 0,nDferave,nDferven)
					EndIf
				EndIf

				nDiasAviso 		:= GetNewPar("MV_AVISFER",aTabFer[3])  // Dias Aviso Ferias

				If !empty((cQry)->RF_ABOPEC)
					cAboPec := (cQry)->RF_ABOPEC
				Else
					cAboPec := cAboAnt		//-- cAboPec = 1 -> considera abono antes do periodo de gozo de ferias
				EndIf

				M->RH_DTAVISO  := fVerData(dDtIniProg - (If (nDiasAviso > 0, nDiasAviso,aTabFer[3])))
				M->RH_DFERIAS  := If( nDFerven > aTabFer[3] , aTabFer[3] , nDFerven )
				M->RH_DTRECIB  := If(cAboPec=="1" .and. nDiasAbono > 0,DataValida(DataValida((dDtIniProg-nDiasAbono)-1,.F.)-1,.F.), DataValida(DataValida(dDtIniProg-1,.F.)-1,.F.))
				M->RF_TEMABPE  := (cQry)->RF_TEMABPE

				If (cQry)->RF_TEMABPE == "S" .And. !lTemCpoProg
					M->RH_DFERIAS -= If(nDiasAbono > 0, nDiasAbono, 10)
				Endif

				//--Abater dias de ferias Antecipadas
				If (cQry)->RF_DFERANT > 0
					M->RH_DFERIAS := Min(M->RH_DFERIAS, aTabFer[3]-(cQry)->RF_DFERANT)
				Endif

				// Abate Faltas  do cad. Provisoes
				If ( (cQry)->RF_DFALVAT + (cQry)->RF_DFALAAT ) > 5
					nDFaltaV := (cQry)->RF_DFALVAT + (cQry)->RF_DFALAAT
					TabFaltas(@nDFaltaV)

					If (nDFaltaV > 0 .and. nDiasAbono > 0 )

						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³  Se tiver faltas e abono, calcular os dias de ferias\abono proporcional as faltas.|
						//³	 Exemplo: 20 dias ferias                                                          |
				   	    //³	          10 dias de abono e                                                      |
						//³ 		  10 Faltas = deduzir 6 dias das ferias. 		 					      |
						//³           Regra do abono: 1/3 dos dias de ferias.                                 |
						//³			  Como funcionario teve 10 faltas, ele tem direito a apenas 24 dias de    |
						//³           ferias, e nao 30. Os dias de feria e abono devem ser proporcionais aos  |
						//³           dias de direito de ferias.                                              |
						//³           Dias de Direito = 24													  |
		   		        //³           Dias de Abono   =  8 (24 / 3 = 1/3 dos dias de direito )                |
		   	    	    //³           Dias de Ferias  = 16 (24 - 8 dias de abono) 							  |
		   	    	    //³           Total de Ferias + Abono  = 24 Dias 									  |
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

						nDiasDedFer   := ( nDiasFePro - ( If(!lMetadeFal, If(!lTempoParc, nDFaltaV, 0), nDiasFePro / 2) - nDiasAbono ) )

						If nDiasDedFer > 0
							M->RH_DFERIAS := nDiasDedFer - NoRound( ( ( nDiasFePro + nDiasAbono ) - If(!lMetadeFal, If(!lTempoParc, nDFaltaV, 0), nDiasFePro / 2) ) / 3 )
						Else
							M->RH_DFERIAS -= (If(!lMetadeFal, If(!lTempoParc, nDFaltaV, 0), nDiasFePro / 2))
						EndIf

					Else
						M->RH_DFERIAS -= (If(!lMetadeFal, If(!lTempoParc, nDFaltaV, 0), nDiasFePro / 2))
					EndIf
				Endif

				M->RH_PERC13S := (cQry)->RF_PERC13S

				DaAuxI := dDtIniProg
				DaAuxF := dDtIniProg + M->RH_DFERIAS - 1

				If M->RH_DFERIAS > 0
					dRH_DTAVIS	:= M->RH_DTAVISO
					dRH_DFERIA	:= M->RH_DFERIAS
					dRH_DTRECI	:= M->RH_DTRECIB
					For nImprVias := 1 to nVias
						MMGPER02A0()
					Next
				Endif
			EndIf
		Endif
		(cQry)->(dbCloseArea())
	Endif

Return

Static Function fVerQuebra(nLinha)

If nLinha > 60
	nLinha := nLinha + 1
EndIf

Return
