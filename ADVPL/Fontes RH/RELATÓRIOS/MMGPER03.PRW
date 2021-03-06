#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"

/*/{Protheus.doc} MMGPER03
Rotina que gera o relat�rio de fun��es vs centro de custo vs turnos
@param		Nenhum
@return		Nenhum
@author 	Andr� Luis Maximiano Longhini	
@since 		25/10/2021
@version 	1.0
@Obs		25/10/2021 - MedMais - Andr� Luis Maximiano Longhini - Constru��o inicial.

/*/

User Function MMGPER03()

	Local _aArea	:= GetArea()

	Private cPerg := "MMGPER03"

	//Cria as perguntas do relat�rio, caso n�o existam.
	MMGPER03B()

	// Ativa o grupo de perguntas
	If !Pergunte(cPerg,.T.)
		Return
	EndIf

	//Chama a fun��o de gera��o do relat�rio em Excel.
	msAguarde( { || MMGPER03A() }, "Aguarde", "Gerando o relat�rio...")
	
	//Retorna o ambiente anterior.
	RestArea(_aArea)

Return()


/*/{Protheus.doc} MMGPER03A
Rotina respons�vel por gerar o relat�rio em Excel.
@param		Nenhum
@return		Nenhum
@author 	Andr� Luis Maximiano Longhini
@since 		25/10/2021
@version 	1.0
@Obs		25/10/2021 - MedMais - Andr� Luis Maximiano Longhini - Constru��o inicial.

/*/
Static Function MMGPER03A()

	Local _cQry1	:= ""
	Local  funcion	:={{"","","","","","",""}}
	Local x := 0

	caminhoArq := alltrim(mv_par09)



	//Query para buscar as informa��es dos benef�cios de acordo com os par�metros.
	_cQry1 := "SELECT RA_FILIAL AS FILIAL,RA_TNOTRAB AS TURNO,R6_DESC AS DESCTUR,RA_CODFUNC AS FUNCAO,RJ_DESC AS DESCFUNC,RA_CC AS CCUSTO,CTT_DESC01 AS CCDESC " 
	_cQry1 += " FROM " + RetSqlName("SRA") + " RA "
	_cQry1 += " LEFT JOIN " + RetSqlName("SR6") + " R6"
	_cQry1 += " ON R6.R6_FILIAL  = '" + xFilial("SR6") + "'"
	_cQry1 += " AND R6.R6_TURNO  = RA.RA_TNOTRAB "
	_cQry1 += " AND R6.D_E_L_E_T_ = ' '"
	_cQry1 += " LEFT JOIN " + RetSqlName("SRJ") + " RJ"
	_cQry1 += " ON RJ.RJ_FILIAL  = '" + xFilial("SRJ") + "'"
	_cQry1 += " AND RJ.RJ_FUNCAO = RA.RA_CODFUNC "
	_cQry1 += " AND RJ.D_E_L_E_T_ = ' '"
	_cQry1 += " LEFT JOIN " + RetSqlName("CTT") + " CTT"
	_cQry1 += " ON CTT.CTT_FILIAL = '" + xFilial("CTT") + "'"
	_cQry1 += " AND CTT.CTT_CUSTO = RA.RA_CC "
	_cQry1 += " AND CTT.D_E_L_E_T_ = ' '"
	_cQry1 += " WHERE RA.RA_FILIAL BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "' "
	_cQry1 += " AND RA.RA_CC BETWEEN '" + MV_PAR03 + "' AND '" + MV_PAR04 + "' "
	_cQry1 += " AND RA.RA_CODFUNC BETWEEN '" + MV_PAR05 + "' AND '" + MV_PAR06 + "' "
	_cQry1 += " AND RA.RA_TNOTRAB BETWEEN '" + MV_PAR07 + "' AND '" + MV_PAR08 + "' "
	_cQry1 += " AND RA.RA_SITFOLH <> 'D' "
	_cQry1 += " AND RA.D_E_L_E_T_ = '' "
	_cQry1 += " GROUP BY RA_FILIAL,RA_TNOTRAB,R6_DESC,RA_CODFUNC,RJ_DESC,RA_CC,CTT_DESC01 "
	_cQry1 += " ORDER BY RA_FILIAL,RA_TNOTRAB,R6_DESC,RA_CODFUNC,RJ_DESC,RA_CC,CTT_DESC01 "

	TCQUERY _cQry1 NEW ALIAS "CONSQL"

	CONSQL->(DbGoTop())

	//Se n�o encontrar nenhum registro finaliza a rotina.
	If CONSQL->(EOF())

		MsgStop("N�o foram encontrados registros com os par�metros informados. Verifique!","MMGPER03A")

		//Fecha a query.
		CONSQL->(DbCloseArea())

		Return

	EndIf

	Dbselectarea("CONSQL")
	do While !CONSQL->(Eof())		
				
		if funcion[1][1]==""
	 		funcion[1][1]:=TRIM(CONSQL->FILIAL)
	 		funcion[1][2]:=TRIM(CONSQL->TURNO)	 		
	 		funcion[1][3]:=TRIM(CONSQL->DESCTUR) 	 		
	 		funcion[1][4]:=TRIM(CONSQL->FUNCAO) 	
			funcion[1][5]:=TRIM(CONSQL->DESCFUNC) 
			funcion[1][6]:=TRIM(CONSQL->CCUSTO) 
			funcion[1][7]:=TRIM(CONSQL->CCDESC) 

	    else
	    	aAdd(funcion,{TRIM(CONSQL->FILIAL),TRIM(CONSQL->TURNO),TRIM(CONSQL->DESCTUR),TRIM(CONSQL->FUNCAO),TRIM(CONSQL->DESCFUNC),TRIM(CONSQL->CCUSTO),TRIM(CONSQL->CCDESC)})		              
	    endif
		CONSQL->(dbSkip())
	Enddo
	CONSQL->(DBCLOSEAREA())

// Gerar arquivo    
    csv := fCreate(caminhoArq)
                
 	cabec1:="Turnos por Fun��o e Centro de Custo"                                                                  
    fWrite(csv,cabec1,len(cabec1))
	fWrite(csv,CHR(13)+CHR(10),2) 
	fWrite(csv,CHR(13)+CHR(10),2)

	cabec2:="FILIAL;TURNO;DESC TURNO;FUN��O;DESC FUN��O;C.CUSTO;DESC C.CUSTO"                                                                     
    
	fWrite(csv,cabec2,len(cabec2))
	fWrite(csv,CHR(13)+CHR(10),2) 

	For x := 1 To Len(funcion)
		//alert(cvaltochar(funcion[x][8]))	
		linha:= "_"+funcion[x][1]+";_"+funcion[x][2]+";"+funcion[x][3]+";_"+funcion[x][4]+";"+funcion[x][5]+";"+funcion[x][6]+";"+funcion[x][7]
		fWrite(csv,linha,len(linha))
		fWrite(csv,CHR(13)+CHR(10),2) 	
	next x			
    


			   					
	fClose(csv)
	
	alert("Planilha de Custo de Pessoal Gerada em "+caminhoArq+"!")
	
Return


/*/{Protheus.doc} MMGPER03B
Rotina respons�vel por criar as perguntas do relat�rio no SX1 caso n�o existam.
@param		Nenhum
@return		Nenhum
@author 	Andr� Luis Maximiano Longhini
@since 		25/10/2021
@version 	1.0
@Obs		25/10/2021 - MedMais - Andr� Luis Maximiano Longhini - Constru��o inicial.

/*/
Static Function MMGPER03B()

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
	AADD(aRegs,{cPerg,"02","Filial at�?    ","","","mv_ch2","C",TamSx3("RA_FILIAL")[1],0,0,"G","NaoVazio","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","SM0"})
	AADD(aRegs,{cPerg,"03","C. Custo de?   ","","","mv_ch3","C",TamSx3("RA_CC")[1],0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","CTT"})
	AADD(aRegs,{cPerg,"04","C. Custo at�?  ","","","mv_ch4","C",TamSx3("RA_CC")[1],0,0,"G","NaoVazio","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","CTT"})
	AADD(aRegs,{cPerg,"05","Fun��o de?    ","","","mv_ch5","C",TamSx3("RA_CODFUNC")[1],0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","","SRJ"})
	AADD(aRegs,{cPerg,"06","Fun��o at�?   ","","","mv_ch6","C",TamSx3("RA_CODFUNC")[1],0,0,"G","NaoVazio","mv_par06","","","","","","","","","","","","","","","","","","","","","","","","","SRJ"})
	AADD(aRegs,{cPerg,"07","Turno de?    ","","","mv_ch7","C",TamSx3("RA_TNOTRAB")[1],0,0,"G","","mv_par07","","","","","","","","","","","","","","","","","","","","","","","","","SR6"})
	AADD(aRegs,{cPerg,"08","Turno at�?   ","","","mv_ch8","C",TamSx3("RA_TNOTRAB")[1],0,0,"G","NaoVazio","mv_par08","","","","","","","","","","","","","","","","","","","","","","","","","SR6"})
	aAdd(aRegs,{cPerg,"09","Caminho Arquivo     ?","            ?","            ?","mv_ch9","C",50,0,0,"G","Naovazio","mv_par09","","","","","","","","","","","","","","","","","","","","","","","","","   "})
	
	//Adiciona o conte�do dos helps no array.
	AADD(aHelpPor, "Informe a Filial inicial.")
	AADD(aHelpPor, "Informe a Filial final.")
	AADD(aHelpPor, "Informe o Centro de custo inicial.")
	AADD(aHelpPor, "Informe o Centro de custo final.")
	AADD(aHelpPor, "Informe a Fun��o inicial")
	AADD(aHelpPor, "Informe a Fun��o final.")
	AADD(aHelpPor, "Informe o Turno inicial.")
	AADD(aHelpPor, "Informe o Turno final.")
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
			MMGPER03C(cChaveHelp, aHelpPor[i], .T.)
		EndIf

	Next

Return


/*/{Protheus.doc} MMGPER03C
Rotina respons�vel por criar o HELP das perguntas do relat�rio no arquivo "SIGAHLP.HLP".
@param		Par�metros: cKey : Chave da Pergunta
cHelp: Texto do Help
lUpdate: Indica se deve atualizar o help
@return		Nenhum
@author 	Andr� Luis Maximiano Longhini
@since 		25/10/2021
@version 	1.0
@Obs		25/10/2021 - MedMais - Andr� Luis Maximiano Longhini - Constru��o inicial.

/*/

Static Function MMGPER03C(cKey, cHelp, lUpdate)

	Local cFilePor  := "SIGAHLP.HLP"
	Local nRet      := 0
	Default cKey    := ""
	Default cHelp   := ""
	Default lUpdate := .F.

	//Se a Chave ou o Help estiverem em branco
	If Empty(cKey) .Or. Empty(cHelp)
		Return
	EndIf

	//**************************** Portugu�s
	nRet := SPF_SEEK(cFilePor, cKey, 1)

	//Se n�o encontrar, ser� inclus�o
	If nRet < 0
		SPF_INSERT(cFilePor, cKey, , , cHelp)

		//Sen�o, ser� atualiza��o
	Else
		If lUpdate
			SPF_UPDATE(cFilePor, nRet, cKey, , , cHelp)
		EndIf
	EndIf

Return
