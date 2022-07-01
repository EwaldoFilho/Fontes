#Include 'RwMake.ch'
#Include 'FileIO.ch'
#Include 'Report.ch'
#Include 'TopConn.ch'
#Include 'Protheus.ch'
/*/{Protheus.doc} MMGPEC10
Rotina de separação do arquivo CNAB da Folha por Centro de Custo
@return		Nil
@author		MEDMAIS - André Longhini
@version	PROTHEUS 12.27
@since		20
@obs		30/06/2022 - Construção Inicial
/*/
User Function MMGPEC10()
Local lRet			:= .T.
Local cPerg			:= "U_MMGPEC10"
Private cAtencao	:= "A T E N Ç Ã O !!!"

	// Prepara a Pergunta ao usuário
	ValidPerg(cPerg)
	While .T.
		if ! Pergunte(cPerg,.T.)
			if MsgYesNo("Você cancelou a tela de parâmetros. Deseja sair da rotina ( Sim | Não )?",cAtencao)
				Return()
			endif
		else
			Exit
		endif
	End

	// Caso a pergunta seja respondida, inicia o processamento da rotina
	Processa( {|| lRet := MMGPEC10A() },"Processando...")

	if lRet
		MsgInfo("Rotina Finalizada com sucesso!!!",cAtencao)
	else
		MsgStop("Ocorreram erros durante a execução da rotina. Favor verificar!!!",cAtencao)
	endif

Return

Static Function MMGPEC10A()
Local nX		:= 0
Local nHandle	:= 0
Local nHdl		:= 0
Local nCont		:= 1
Local cLinha	:= ""
Local cLinA		:= ""
Local cLinB		:= ""
Local cLin		:= ""
Local cQry		:= ""
Local cCabec	:= ""
Local cCabec2	:= ""
Local cRoda1	:= ""
Local cRoda2	:= ""
Local cCcAnt	:= ""
Local cArqTxt	:= ""
Local cAlias1	:= GetNextAlias()
Local cEol		:= CHR(13)+CHR(10)
Local cPrefixo	:= AllTrim(MV_PAR03)
Private aLinhas	:= {}

	// Abre o arquivo Texto Informado
	nHandle := FT_FUSE(MV_PAR01)
	if nHandle = -1
		Alert("Não foi possivel abrir o arquivo " + MV_PAR01,cAtencao)
		Return(.F.)
	endif

	ProcRegua( FT_FLASTREC() * 2 )
	FT_FGOTOP()

	While !FT_FEOF()

		IncProc("Separando Registros... Aguarde!!!")
		cLinha := FT_FREADLN()   // Grava a linha na variavel cLinha

		if MV_PAR02 == 1 /*BRADESCO*/ .or. MV_PAR02 == 3 /*Santander*/

			if nCont >= 3 // Processa o Funcionario
				if SubStr(cLinha,14,01) == "A"
					cLinA := cLinha
				elseif SubStr(cLinha,14,01) == "B"
					cLinB := cLinha

					// Pesquisa o Centro de Custo do Funcionário
					cCCusto := MMGPEC10F( SubStr(cLinB,22,11) )
					if cCCusto[01] <> "000000"
						aAdd(aLinhas, { cCCusto[01], cLinA , nCont , "A", cCCusto[02] ,Val(SubStr(cLinA,120,15))/100 } )
						aAdd(aLinhas, { cCCusto[01], cLinB , nCont , "B", cCCusto[02] ,0 } )
					else
						aAdd(aLinhas, { "000000"   , cLinA , nCont , "A", cCCusto[02] ,Val(SubStr(cLinA,120,15))/100 } ) // Inclui sem Centro de Custo
						aAdd(aLinhas, { "000000"   , cLinB , nCont , "B", cCCusto[02] ,0 } ) // Inclui sem Centro de Custo
					Endif
				elseif SubStr(cLinha,01,08) == '23700015' .or. SubStr(cLinha,01,08) == '03300015'// Rodape 1
					cRoda1 := cLinha
				elseif SubStr(cLinha,01,08) == '23799999' .or. SubStr(cLinha,01,08) == '03399999' // Rodape 2
					cRoda2 := cLinha
				endif
			elseif nCont == 1 // Armazena a linha 1 do cabeçalho
				cCabec := cLinha
			elseif nCont == 2 // Armazena a linha 2 do cabeçalho
				cCabec2 := cLinha
			endif

		elseif MV_PAR02 == 2 // Banco Itaú

			if nCont >= 3 // Processa o Funcionario
				if SubStr(cLinha,14,01) == "A"
					cLinA := cLinha

					// Pesquisa o Centro de Custo do Funcionário
					cCCusto := MMGPEC10F( SubStr(cLinA,204,11) )
					if cCCusto[01] <> "000000"
						aAdd(aLinhas, { cCCusto[01], cLinA , nCont , "A", cCCusto[02] ,Val(SubStr(cLinA,120,15))/100 } )
					else
						aAdd(aLinhas, { "000000"   , cLinA , nCont , "A", cCCusto[02] ,Val(SubStr(cLinA,120,15))/100 } ) // Inclui sem Centro de Custo
					Endif
				elseif SubStr(cLinha,01,08) == '34100015' // Rodape 1
					cRoda1 := cLinha
				elseif SubStr(cLinha,01,08) == '34199999' // Rodape 2
					cRoda2 := cLinha
				endif
			elseif nCont == 1 // Armazena a linha 1 do cabeçalho
				cCabec := cLinha
			elseif nCont == 2 // Armazena a linha 2 do cabeçalho
				cCabec2 := cLinha
			endif

		endif

		nCont++
		FT_FSKIP()

	End

	// Fecha o Arquivo Texto Original
	FT_FUSE()

	// Ordena o Arquivo por Centro de Custo + Contador + Tipo da Linha
	aSort(aLinhas ,,, { |x,y| x[01] + StrZero(x[03],05) + x[04] < y[01] + StrZero(y[03],05) + y[04] } )

	// Escreve os arquivo de cada Centro de Custo
	nCont := 1
	For nX := 1 to Len(aLinhas)
		IncProc("Gerando novos Arquivos... Aguarde!!!")

		// Verifica se deve abrir / fechar um arquivo Texto
		if cCcAnt <> aLinhas[nX][01] // Abre um arquivo

			if !Empty(cRoda1) .and. nX > 1
				// Altera os valores do Rodape 1
				nTotal := 0
				aEval( aLinhas, { |x| nTotal += if(x[01]==cCcAnt , x[06] , 0) } )
				cRoda1 := SubStr( SubStr(cRoda1,01,18) + StrZero(nCont+1,05) + StrZero(nTotal*100,18) + if(MV_PAR02==2, Replicate("0",18), if(MV_PAR02==1,Replicate("0",24),if(MV_PAR02==3,Replicate("0",24),"")) ) + Replicate(" ",240)  ,01,240)

				// Escreve o Rodape 1
				cLin := cRoda1 + cEol
				if fWrite(nHdl,cLin,Len(cLin)) != Len(cLin)
					if !MsgAlert("Ocorreu um erro na gravacao do arquivo. Continua?",cAtencao)
						Exit
					endif
				endif
			endif

			if !Empty(cRoda2) .and. nX > 1
				// Altera os valores do Rodape 2
				cRoda2 := SubStr( SubStr(cRoda2,01,24) + StrZero(nCont+3,05) + if(MV_PAR02 <> 3,Replicate("0",06),"") + Replicate(" ",240)  ,01,240)

				// Escreve o Rodape 2
				cLin := cRoda2 + cEol
				if fWrite(nHdl,cLin,Len(cLin)) != Len(cLin)
					if !MsgAlert("Ocorreu um erro na gravacao do arquivo. Continua?",cAtencao)
						Exit
					endif
				endif
			endif

			cCcAnt := aLinhas[nX][01]
			if Empty(cCcAnt) .or. cCcAnt <> aLinhas[nX][01]
				//FT_FUSE()// Fecha o arquivo do Centro de Custo Anterior
				fClose(nHdl)
			endif
			cArqTxt := cPrefixo + aLinhas[nX][01] + ".TXT"
			nHdl	:= fCreate(cArqTxt,,,.F.) // Cria um Novo Arquivo para o novo Centro de Custo
			If nHdl == -1
			    MsgAlert("O arquivo de nome "+cArqTxt+" nao pode ser criado! Verifique as permissões da pasta.",cAtencao)
			    Return(.F.)
			Endif

			// Escreve a Linha do Cabeçalho 1
			cLin := cCabec + cEol
			if fWrite(nHdl,cLin,Len(cLin)) != Len(cLin)
				if !MsgAlert("Ocorreu um erro na gravacao do arquivo. Continua?",cAtencao)
					Exit
				endif
			endif

			// Escreve a Linha do Cabeçalho 2
			if !Empty(cCabec2)
				cLin := cCabec2 + cEol
				if fWrite(nHdl,cLin,Len(cLin)) != Len(cLin)
					if !MsgAlert("Ocorreu um erro na gravacao do arquivo. Continua?",cAtencao)
						Exit
					endif
				endif
			endif

			nCont := 1 // Reinicia a numeração para reenumerar as linhas quando for Banco do Brasil ou Itaú

		endif

		// Escreve as Linhas do Centro de Custo Atual
		cLin := aLinhas[nX][02] + cEol

		// Se for banco do Brasil ou Itaú, altera o sequencial de cada linha
		if MV_PAR02 == 1 .or. MV_PAR02 == 2
			cLin := SubStr(cLin,01,08) + StrZero(nCont,05) + SubStr(cLin,14,Len(cLin))
		endif
		
		nCont++

	    If fWrite(nHdl,cLin,Len(cLin)) != Len(cLin)
	        If !MsgAlert("Ocorreu um erro na gravacao do arquivo. Continua?",cAtencao)
	            Exit
	        Endif
	    Endif
	Next nX

	// Escreve as linhas do rodape do último arquivo
	if !Empty(cRoda1)
		// Altera os valores do Rodape 1
		nTotal := 0
		aEval( aLinhas, { |x| nTotal += if(x[01]==cCcAnt , x[06] , 0) } )
		cRoda1 := SubStr( SubStr(cRoda1,01,18) + StrZero(nCont+1,05) + StrZero(nTotal*100,18) + if(MV_PAR02==2, Replicate("0",18), if(MV_PAR02==1,Replicate("0",24),if(MV_PAR02==3,Replicate("0",24),"")) ) + Replicate(" ",240)  ,01,240)

		// Escreve o Rodape 1
		cLin := cRoda1 + cEol
		if fWrite(nHdl,cLin,Len(cLin)) != Len(cLin)
			MsgAlert("Ocorreu um erro na gravacao do arquivo. Continua?",cAtencao)
		endif
	endif

	if !Empty(cRoda2)
		// Altera os valores do Rodape 2
		cRoda2 := SubStr( SubStr(cRoda2,01,24) + StrZero(nCont+3,05) + if(MV_PAR02 <> 3,Replicate("0",06),"") + Replicate(" ",240)  ,01,240)

		// Escreve o Rodape 2
		cLin := cRoda2 + cEol
		if fWrite(nHdl,cLin,Len(cLin)) != Len(cLin)
			MsgAlert("Ocorreu um erro na gravacao do arquivo. Continua?",cAtencao)
		endif
	endif

	// Fecha o último arquivo antes do encerramento do programa
	//FT_FUSE()
	fClose(nHdl)

	// Imprime um relatório com o resultado dessa separação
	MMGPEC10C()

Return(.T.)


Static Function MMGPEC10B()
Local lFloppy := .T.
Local lHard   := .T.
Local lNetwork:= .F.

	if Empty(MV_PAR01) // Só pergunta o diretório se o campo estiver vazio, Assumindo o que foi digitado pelo usuario.
		cArqImp := cGetFile("Arquivos Texto|*.txt|Arquivos CSV|*.csv|Todos os Arquivos|*.*","Selecione o Arquivo",0,"SERVIDOR\",.T.,Iif(lFloppy,GETF_LOCALFLOPPY,0) + Iif(lHard,GETF_LOCALHARD,0) + Iif(lNetwork,GETF_NETWORKDRIVE,0))
		if Empty(cArqImp)
			MV_PAR01 := Space(60)
		else
			MV_PAR01 := Upper(SubStr(cArqImp + Space(60) ,1,60))
		endif
	endif

Return


Static Function MMGPEC10C()
Local oReport

	oReport := MMGPEC10D()
	oReport:PrintDialog()

Return(.T.)


Static Function MMGPEC10D()
Local oReport						// Objeto relatorio TReport (Release 4)
Local oSection1 	   				// Objeto secao 1 do relatorio
Local cAlias1	:= GetNextAlias()	// Pega o proximo Alias Disponivel
Local oBreak

	DEFINE REPORT oReport NAME "MMGPEC10" TITLE "Relação CNAB por Centro de Custo" /*PARAMETER "ABFATR06"*/ ACTION {|oReport| MMGPEC10E ( oReport, cAlias1 )} DESCRIPTION "Relação CNAB por Centro de Custo"

	oReport:SetPortrait()
	oReport:SetTotalInLine(.F.) //Define se os totalizadores serão impressos em linha ou coluna

	DEFINE SECTION oSection1 OF oReport TITLE "Centro de Custo" //TABLES "SRA"

	//DEFINE CELL NAME "CURSO" 		OF oSection1 TITLE OemToAnsi(STR0027)	SIZE 06 BLOCK{||cCurso}		//Curso

	DEFINE CELL NAME "CCUSTO"		OF oSection1 TITLE "C.Custo"				SIZE 15	ALIAS cAlias1									  	// Centro de Custo
	DEFINE CELL NAME "MATRICULA"	OF oSection1 TITLE "Matrícula"				SIZE 10	ALIAS cAlias1									 	// Matrícula
	DEFINE CELL NAME "NOME"			OF oSection1 TITLE "Nome do Funciontário"	SIZE 60	ALIAS cAlias1										// Nome
	DEFINE CELL NAME "CPF"			OF oSection1 TITLE "CPF"					SIZE 15	ALIAS cAlias1	PICTURE "@R 999.999.999-99" 		// CPF
	DEFINE CELL NAME "BANCO"		OF oSection1 TITLE "Banco/Agencia"			SIZE 15	ALIAS cAlias1										// Bco.Ag.D.Sal
	DEFINE CELL NAME "CONTA"		OF oSection1 TITLE "Conta"					SIZE 10	ALIAS cAlias1										// Cta.Dep.Sal.
	DEFINE CELL NAME "VALOR"		OF oSection1 TITLE "Valor"					SIZE 20	ALIAS cAlias1	PICTURE PesqPict("SRD","RD_VALOR")	// Valor

	oBreak := TRBreak():New(oSection1,oSection1:Cell("CCUSTO"),"Por C.Custo",.F.)

	// Totalizador por Centro de Custo
	TRFunction():New(oSection1:Cell("VALOR"),NIL,"SUM",oBreak,,,,.F.,.T.)

Return oReport


Static Function MMGPEC10E(oReport, cAlias1)
Local oSection1 := oReport:Section(1)
Local nX

	//Inicia a secao para impressao
	oSection1:Init()

	DbSelectArea("SRA")

	For nX := 1 to Len(aLinhas)
		// Cancela a impressao se o usuario pressionar o botão "Cancelar"
		If oReport:Cancel()
	   		Exit
		EndIf

		if aLinhas[nX][04] <> "A"
			Loop
		endif

		// Posiciono no Funcionário
		SRA->( DbGoTo( aLinhas[nX][05] ) )

	    oSection1:Cell("CCUSTO"):SetValue(SRA->RA_CC)
		oSection1:Cell("MATRICULA"):SetValue(SRA->RA_MAT )
		oSection1:Cell("NOME"):SetValue(SRA->RA_NOME)
		oSection1:Cell("CPF"):SetValue(SRA->RA_CIC)
		oSection1:Cell("BANCO"):SetValue(SRA->RA_BCDEPSA)
		oSection1:Cell("CONTA"):SetValue(SRA->RA_CTDEPSA)
		oSection1:Cell("VALOR"):SetValue(aLinhas[nX][06])

	    //Imprime a linha
		oSection1:PrintLine()
	Next nX

	oSection1:Finish()

Return(.T.)


Static Function ValidPerg(cPerg)
Local i,j
Local aRegs		:= {}

	DbSelectArea("SX1")
	SX1->(DbSetOrder(1))

//              Grupo Ordem Pergunta Portugues      Pergunta Espanhol         Pergunta Ingles          Variavel  Tipo  Tamanho Decimal Presel GSC  Valid                                Var01       Def01       DefSPA1  DefEng1    Cnt01  Var02  Def02         DefSpa2   DefEng2   Cnt02  Var03 Def03           DefSpa3  DefEng3  Cnt03 Var04  Def04 DefSpa4 DefEng4 Cnt04 Var05 Def05 DefSpa5 DefEng5 Cnt05 F3  GrgSxg cPyme aHelpPor aHelpEng aHelpSpa    cHelp    ³
	aAdd(aRegs,{cPerg,"01","Arquivo de Origem ?  " ,"Arquivo de Origem ?  "  ,"Arquivo de Origem ?  " ,"mv_ch1" ,"C"  ,80    ,00     ,0      ,"G" ,"StaticCall(MMGPEC10,MMGPEC10B)"    ,"mv_par01" ,""          ,""      ,""        ,""    ,""    ,""           ,""       ,""       ,""    ,""   ,""             ,""      ,""      ,""   ,""    ,""   ,""     ,""     ,""   ,""   ,""   ,""     ,""     ,""   ,"" ,""    ,""   ,""      ,""      ,""})
	aAdd(aRegs,{cPerg,"02","Banco ?  "             ,"Banco ?              "  ,"Banco ?              " ,"mv_ch2" ,"N"  ,01    ,00     ,0      ,"C" ,""                                  ,"mv_par02" ,"B.Bradesco"  ,""      ,""        ,""    ,""    ,"B.Itaú"     ,""       ,""       ,""    ,""   ,"B.Santander"  ,""      ,""      ,""   ,""    ,""   ,""     ,""     ,""   ,""   ,""   ,""     ,""     ,""   ,"" ,""    ,""   ,""      ,""      ,""})
	aAdd(aRegs,{cPerg,"03","Local de Destino ?  " ,"Local de Destino ?  "  ,"Local de Destino ?  " ,"mv_ch3" ,"C"  ,80    ,00     ,0      ,"G" ,""    ,"mv_par03" ,""          ,""      ,""        ,""    ,""    ,""           ,""       ,""       ,""    ,""   ,""             ,""      ,""      ,""   ,""    ,""   ,""     ,""     ,""   ,""   ,""   ,""     ,""     ,""   ,"" ,""    ,""   ,""      ,""      ,""})
	
	For i := 1 to Len(aRegs)
		If !MsSeek(PADR(cPerg,10)+aRegs[i,2])
			RecLock("SX1",.T.)
			For j := 1 to FCount()
				If j <= Len(aRegs[i])
					FieldPut(j,aRegs[i,j])
				Endif
			Next
			SX1->(MsUnLock())
		Endif
	Next

Return

Static Function MMGPEC10F(cCPF)
Local cCc		:= ""
Local cQry		:= ""
Local cRec		:= ""
Local cAlias1	:= GetNextAlias()

	// Busca o Centro de Custo do Funcionário pesquisando pelo CPF passado no parâmetro
	cQry := "SELECT CASE RA_SITFOLH
	cQry += "          WHEN ' ' THEN '1'"
	cQry += "          WHEN 'F' THEN '2'"
	cQry += "          WHEN 'A' THEN '3'"
	cQry += "          WHEN 'T' THEN '4'"
	cQry += "          WHEN 'D' THEN '5'
	cQry += "       END SITUACAO,"
	cQry += "       RA_CC,"
	cQry += "       R_E_C_N_O_ RECNUM"
	cQry += "  FROM " + RetSqlName("SRA")
	cQry += " WHERE RA_FILIAL  BETWEEN '    ' AND 'ZZZZ'"
	cQry += "   AND RA_CIC     = '" + cCPF + "'"
	cQry += "   AND D_E_L_E_T_ = ' '"
	cQry += " ORDER BY SITUACAO, R_E_C_N_O_"
	TcQuery ChangeQuery(cQry) New Alias (cAlias1)
	if ! (cAlias1)->(Eof())
		cCC		:= AllTrim((cAlias1)->RA_CC)
		cRec	:= (cAlias1)->RECNUM
	else
		cCC		:= "000000"
		cRec	:= 0
	Endif
	(cAlias1)->(DbCloseArea())

Return( { cCc , cRec } )

// Somente para não mostrar a advertência durante a compilação
if .F.
	MMGPEC10B()
endif
