#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"

/*/{Protheus.doc} MMGPER09
Rotina que gera arquivo .csv para importação Alelo.
@param		Nenhum
@return		Nenhum
@author 	André Luis Maximiano Longhini	
@since 		31/05/2022
@version 	1.0
@Obs		31/05/2022 - MedMais - André Luis Maximiano Longhini - Construção inicial.

/*/

User Function MMGPER09()

	Local _aArea	:= GetArea()

	Private cPerg := "MMGPER09"

	//Cria as perguntas do arquivo, caso não existam.
	MMGPER09B()

	// Ativa o grupo de perguntas
	If !Pergunte(cPerg,.T.)
		Return
	EndIf

	//Chama a função de geração do arquivo em Excel.
	msAguarde( { || MMGPER09A() }, "Aguarde", "Gerando o Arquivo...")
	
	//Retorna o ambiente anterior.
	RestArea(_aArea)

Return()


/*/{Protheus.doc} MMGPER09A
Rotina responsável por gerar o arquivo em Excel.
@param		Nenhum
@return		Nenhum
@author 	André Luis Maximiano Longhini
@since 		31/05/2022
@version 	1.0
@Obs		31/05/2022 - MedMais - André Luis Maximiano Longhini - Construção inicial.

/*/
Static Function MMGPER09A()

	Local _cQry1	:= ""
	Local  funcion	:={{"","","","","","",""}}
	Local x := 0
	Local tipo := MV_PAR07
	Local tipoBen := ""
	Local vlBen	  := ""

	caminhoArq := alltrim(MV_PAR10)

	
	IF tipo == 1
		tipoBen := "VAL"
	elseif tipo == 2
		tipoBen := "VRF"
	endif

	//Query para buscar as informações dos benefícios de acordo com os parâmetros.
	_cQry1 := "SELECT R0_FILIAL, R0_MAT,RA_NASC, RA_NOMECMP,RA_CIC,R0_TPVALE,RA_SEXO,CTT_DESC01,SUM(R0_VALCAL) AS VLRBEN,R0_PERIOD,R0_ROTEIR " 
	_cQry1 += " FROM " + RetSqlName("SR0") + " R0 "
	_cQry1 += " INNER JOIN " + RetSqlName("SRA") + " RA"
	_cQry1 += " ON RA.RA_FILIAL = R0.R0_FILIAL "
	_cQry1 += " AND RA.RA_MAT = R0.R0_MAT "
	_cQry1 += " AND RA.D_E_L_E_T_ = '' "
	_cQry1 += " INNER JOIN " + RetSqlName("CTT") + " CTT "
	_cQry1 += " ON CTT.CTT_FILIAL = SUBSTRING(RA.RA_FILIAL,1,2) "
	_cQry1 += " AND CTT.CTT_CUSTO = RA.RA_CC "
	_cQry1 += " AND CTT.D_E_L_E_T_ = '' "
	_cQry1 += " WHERE R0.R0_FILIAL BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "' "
	_cQry1 += " AND RA.RA_CC BETWEEN '" + MV_PAR03 + "' AND '" + MV_PAR04 + "' "
	_cQry1 += " AND R0.R0_MAT BETWEEN '" + MV_PAR05 + "' AND '" + MV_PAR06 + "' "
	_cQry1 += " AND R0.R0_ROTEIR = '" + tipoBen + "'"
	_cQry1 += " AND R0.R0_PERIOD = '" + MV_PAR09 + "'"
	_cQry1 += " AND RA.RA_SITFOLH <> 'D' "
	_cQry1 += " AND R0.D_E_L_E_T_ = '' "
	_cQry1 += " GROUP BY  R0_FILIAL, R0_MAT,RA_NASC, RA_NOMECMP,RA_CIC,R0_TPVALE,RA_SEXO,CTT_DESC01,R0_PERIOD,R0_ROTEIR "
	_cQry1 += " ORDER BY R0_FILIAL, R0_MAT,RA_NOMECMP "

	TCQUERY _cQry1 NEW ALIAS "CONSQL"

	CONSQL->(DbGoTop())

	//Se não encontrar nenhum registro finaliza a rotina.
	If CONSQL->(EOF())

		MsgStop("Não foram encontrados registros com os parâmetros informados. Verifique!","MMGPER09A")

		//Fecha a query.
		CONSQL->(DbCloseArea())

		Return

	EndIf

	Dbselectarea("CONSQL")
	do While !CONSQL->(Eof())	

		dtNasc := STOD(CONSQL->RA_NASC)
		dtNasc := DTOC(dtNasc)
		vlBen  := StrTran(STR(CONSQL->VLRBEN,6,2),".",",")
	
				
		if funcion[1][1]==""
	 		funcion[1][1]:=ALLTRIM(CONSQL->RA_NOMECMP)
	 		funcion[1][2]:=ALLTRIM(CONSQL->RA_CIC)	 		
	 		funcion[1][3]:=ALLTRIM(dtNasc)	 		
	 		funcion[1][4]:=ALLTRIM(CONSQL->RA_SEXO) 	
			funcion[1][5]:=ALLTRIM(vlBen)
			funcion[1][6]:=ALLTRIM(CONSQL->CTT_DESC01) 
			funcion[1][7]:=ALLTRIM(CONSQL->R0_MAT) 

	    else
	    	aAdd(funcion,{ALLTRIM(CONSQL->RA_NOMECMP),ALLTRIM(CONSQL->RA_CIC),ALLTRIM(dtNasc),ALLTRIM(CONSQL->RA_SEXO),ALLTRIM(vlBen),ALLTRIM(CONSQL->CTT_DESC01),ALLTRIM(CONSQL->R0_MAT)})		              
	    endif
		CONSQL->(dbSkip())
	Enddo
	CONSQL->(DBCLOSEAREA())

// Gerar arquivo    
    csv := fCreate(caminhoArq)
                
 	cabec1:=";CONTRATO;;;;;;;;"  
	

    fWrite(csv,cabec1,len(cabec1))
	fWrite(csv,CHR(13)+CHR(10),2) 

	contrato:="%;" + MV_PAR08 + ";%;;;;;;;"

	fWrite(csv,contrato,len(contrato))
	fWrite(csv,CHR(13)+CHR(10),2)

	cabec2:=";NOME DO USUÁRIO;CPF;DATA DE NASCIMENTO;CÓDIGO DO SEXO;VALOR;TIPO DE LOCAL ENTREGA;LOCAL DE ENTREGA;MATRÍCULA;"                                                                     
    
	fWrite(csv,cabec2,len(cabec2))
	fWrite(csv,CHR(13)+CHR(10),2) 

	For x := 1 To Len(funcion)
		//alert(cvaltochar(funcion[x][8]))	
		linha:= "%;"+funcion[x][1]+";"+funcion[x][2]+";"+funcion[x][3]+";"+funcion[x][4]+";"+funcion[x][5]+";PT;"+funcion[x][6]+";"+funcion[x][7]+";%"
		fWrite(csv,linha,len(linha))
		fWrite(csv,CHR(13)+CHR(10),2) 	
	next x			
    


			   					
	fClose(csv)
	
	alert("Planilha de Custo de Pessoal Gerada em "+caminhoArq+"!")
	
Return


/*/{Protheus.doc} MMGPER09B
Rotina responsável por criar as perguntas do relatório no SX1 caso não existam.
@param		Nenhum
@return		Nenhum
@author 	André Luis Maximiano Longhini
@since 		31/05/2022
@version 	1.0
@Obs		31/05/2022 - MedMais - André Luis Maximiano Longhini - Construção inicial.

/*/
Static Function MMGPER09B()

	Local i := 0
	Local j := 0
	Local aHelpPor	 := {}
	Local cChaveHelp := ""

	_sAlias := Alias()
	DbSelectArea("SX1")
	DbSetOrder(1)
	cPerg := PADR(cPerg,10)
	aRegs:={}

	// Grupo/Ordem/PerguntaP/PerguntaE/PerguntaI/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/DefSpa1/DefEng1/Cnt01/Var02/Def02/DefSpa2/DefEng2/Cnt02/Var03/Def03/DefSpa3/DefEng3/Cnt03/Var04/Def04/DefSpa4/DefEng4/Cnt04/Var05/Def05/DefSpa5/DefEng5/Cnt05/F3/Pyme/GRPSXG/Help/Picture/IDFIL
	AADD(aRegs,{cPerg,"01","Filial de?     ","","","mv_ch1","C",TamSx3("RA_FILIAL")[1],0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","SM0"})
	AADD(aRegs,{cPerg,"02","Filial até?    ","","","mv_ch2","C",TamSx3("RA_FILIAL")[1],0,0,"G","NaoVazio","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","SM0"})
	AADD(aRegs,{cPerg,"03","C. Custo de?   ","","","mv_ch3","C",TamSx3("RA_CC")[1],0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","CTT"})
	AADD(aRegs,{cPerg,"04","C. Custo até?  ","","","mv_ch4","C",TamSx3("RA_CC")[1],0,0,"G","NaoVazio","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","CTT"})
	AADD(aRegs,{cPerg,"05","Matrícula de?   ","","","mv_ch5","C",TamSx3("RA_MAT")[1],0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","","SRA"})
	AADD(aRegs,{cPerg,"06","Matrícula até?  ","","","mv_ch6","C",TamSx3("RA_MAT")[1],0,0,"G","NaoVazio","mv_par06","","","","","","","","","","","","","","","","","","","","","","","","","SRA"})
	AADD(aRegs,{cPerg,"07","Tipo de Benefício? ","","","mv_ch7","C",1,0,0,"C","","mv_par07","VAL","","","","VRF","","","","","","","","","","","","","","","","","","","",""})
	AADD(aRegs,{cPerg,"08","Cód. Contrato?  ","","","mv_ch8","C",11,0,0,"G","NaoVazio","mv_par08","","","","","","","","","","","","","","","","","","","","","","","","",""})
	AADD(aRegs,{cPerg,"09","Período?  ","","","mv_ch9","C",TamSx3("R0_PERIOD")[1],0,0,"G","NaoVazio","mv_par09","","","","","","","","","","","","","","","","","","","","","","","","",""})
	aAdd(aRegs,{cPerg,"10","Caminho Arquivo     ?","            ?","            ?","mv_cha","C",50,0,0,"G","Naovazio","mv_par10","","","","","","","","","","","","","","","","","","","","","","","","","   "})
	
	//Adiciona o conteúdo dos helps no array.
	AADD(aHelpPor, "Informe a Filial inicial.")
	AADD(aHelpPor, "Informe a Filial final.")
	AADD(aHelpPor, "Informe o Centro de custo inicial.")
	AADD(aHelpPor, "Informe o Centro de custo final.")
	AADD(aHelpPor, "Informe a Matrícula inicial.")
	AADD(aHelpPor, "Informe a Matrícula final.")
	AADD(aHelpPor, "Informe o Tipo de Benefício")
	AADD(aHelpPor, "Informe o código do Contrato")
	AADD(aHelpPor, "Informe o Período.")
	AADD(aHelpPor, "Informe o caminho para salvar o arquivo.")

	//Cria as perguntas na SX1.
	For i:=1 to Len(aRegs)

		If !dbSeek(cPerg+aRegs[i,2])
			RecLock("SX1",.T.)
			For j:=1 to FCount()
				If j <= Len(aRegs[i])
					FieldPut(j,aRegs[i,j])
				Endif
			Next
			MsUnlock()
		Endif

		//Chave da Pergunta para criar o Help
		cChaveHelp := "P." + AllTrim(aRegs[i,1]) + AllTrim(aRegs[i,2]) + "."

		//Se tiver Help da pergunta cria
		If !Empty(aHelpPor[i])
			MMGPER09C(cChaveHelp, aHelpPor[i], .T.)
		EndIf

	Next

Return


/*/{Protheus.doc} MMGPER09C
Rotina responsável por criar o HELP das perguntas do relatório no arquivo "SIGAHLP.HLP".
@param		Parâmetros: cKey : Chave da Pergunta
cHelp: Texto do Help
lUpdate: Indica se deve atualizar o help
@return		Nenhum
@author 	André Luis Maximiano Longhini
@since 		31/05/2022
@version 	1.0
@Obs		31/05/2022 - MedMais - André Luis Maximiano Longhini - Construção inicial.

/*/

Static Function MMGPER09C(cKey, cHelp, lUpdate)

	Local cFilePor  := "SIGAHLP.HLP"
	Local nRet      := 0
	Default cKey    := ""
	Default cHelp   := ""
	Default lUpdate := .F.

	//Se a Chave ou o Help estiverem em branco
	If Empty(cKey) .Or. Empty(cHelp)
		Return
	EndIf

	//**************************** Português
	nRet := SPF_SEEK(cFilePor, cKey, 1)

	//Se não encontrar, será inclusão
	If nRet < 0
		SPF_INSERT(cFilePor, cKey, , , cHelp)

		//Senão, será atualização
	Else
		If lUpdate
			SPF_UPDATE(cFilePor, nRet, cKey, , , cHelp)
		EndIf
	EndIf

Return
