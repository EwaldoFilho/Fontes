#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"

//Constantes
#Define STR_PULA    Chr(13)+Chr(10)

/*/{Protheus.doc} MMCOMR01
Rotina que gera o relat�rio de confer�ncia da calibra��o
@param		Nenhum
@return		Nenhum
@author 	Andr� Luis Maximiano Longhini	
@since 		24/06/2022
@version 	1.0
@Obs		24/06/2022 - MedMais - Andr� Luis Maximiano Longhini - Constru��o inicial.

/*/

User Function MMCOMR01()

	Local _aArea	:= GetArea()

	Private cPerg := "MMCOMR01"

	//Cria as perguntas do relat�rio, caso n�o existam.
	MMCOMR01B()

	// Ativa o grupo de perguntas
	If !Pergunte(cPerg,.T.)
		Return
	EndIf

	//Chama a fun��o de gera��o do relat�rio em Excel.
	msAguarde( { || MMCOMR01A() }, "Aguarde", "Gerando o relat�rio...")
	
	//Retorna o ambiente anterior.
	RestArea(_aArea)

Return()


/*/{Protheus.doc} MMCOMR01A
Rotina respons�vel por gerar o relat�rio em Excel.
@param		Nenhum
@return		Nenhum
@author 	Andr� Luis Maximiano Longhini
@since 		24/06/2022
@version 	1.0
@Obs		24/06/2022 - MedMais - Andr� Luis Maximiano Longhini - Constru��o inicial.

/*/
Static Function MMCOMR01A()

  	Local cQuery        := ""
    Local oFWMsExcel
    Local oExcel
	Local aArea			:= GetArea()
    Local dtHora        := FWTimeStamp(1,DATE(),TIME())
    Local cArquivo   	:= GetTempPath()+'EQUIPAMENTOS'+''+dtHora+''+'.xml'

    //Busca os dados para impress�o
	cQuery := " SELECT ZZD_CODCC AS COD_CC, ZZD_DESCCC AS DESC_CC, " 																										+ STR_PULA
	cQuery += " CASE " 																																						+ STR_PULA
	cQuery += " WHEN ZZD_TPPROD = 'N' THEN 'N�O' " 																															+ STR_PULA
	cQuery += " WHEN ZZD_TPPROD = 'S' THEN 'SIM' " 																															+ STR_PULA
	cQuery += " END AS EQUIP_MEDMAIS, " 																																	+ STR_PULA
	cQuery += " CASE " 																																						+ STR_PULA
	cQuery += " WHEN ZZD_ATIVO = 'N' THEN 'N�O' " 																															+ STR_PULA
	cQuery += " WHEN ZZD_ATIVO = 'S' THEN 'SIM' " 																															+ STR_PULA
	cQuery += " WHEN ZZD_ATIVO = '' THEN 'N�O' " 																															+ STR_PULA
	cQuery += " END AS EQUIP_ATIVO, " 																																		+ STR_PULA
	cQuery += " ZZD_CODPR AS COD_PROD, ZZD_DESCPD AS DESC_PROD, ZZD_CODATI AS COD_BEM, ZZD_DESCAT AS DESC_BEM, ZZD_ESPEC AS ESPECIFICACAO_MARCA, ZZD_IDENT AS PLAQUETA, " 	+ STR_PULA
	cQuery += " ZZD_NSERIE AS N_SERIE, " 																																	+ STR_PULA
	cQuery += " CASE " 																																						+ STR_PULA
	cQuery += " WHEN ZZD_VALIDA = '1' THEN 'ANUAL' " 																														+ STR_PULA
	cQuery += " WHEN ZZD_VALIDA = '2' THEN 'SEMESTRAL' " 																													+ STR_PULA
	cQuery += " WHEN ZZD_VALIDA = '3' THEN 'TRIMESTRAL' " 																													+ STR_PULA
	cQuery += " WHEN ZZD_VALIDA = '4' THEN 'BIMESTRAL' " 																													+ STR_PULA
	cQuery += " WHEN ZZD_VALIDA = '5' THEN 'MENSAL' " 																														+ STR_PULA
	cQuery += " END AS PERIODICIDADE,CONVERT (VARCHAR, CONVERT(DATE, ZZD_DTCAL, 103), 103) AS DT_ULT_CALIBRACAO,CONVERT (VARCHAR, CONVERT(DATE, ZZD_DTCAL2, 103), 103) AS DT_PROX_CALIBRACAO, ZZD_NCERT AS N_CERTIFICADO, " 	+ STR_PULA
	cQuery += " CASE  " 																																					+ STR_PULA
	cQuery += " WHEN ZZD_TOLADM = 'N' THEN 'N�O' " 																															+ STR_PULA
	cQuery += " WHEN ZZD_TOLADM = 'S' THEN 'SIM' " 																															+ STR_PULA
	cQuery += " WHEN ZZD_TOLADM = '' THEN '' " 																																+ STR_PULA
	cQuery += " END AS RES_LIM_ADM, " 																																		+ STR_PULA
	cQuery += " CASE " 																																						+ STR_PULA
	cQuery += " WHEN ZZD_CERTAP = 'N' THEN 'N�O' " 																															+ STR_PULA
	cQuery += " WHEN ZZD_CERTAP = 'S' THEN 'SIM' " 																															+ STR_PULA
	cQuery += " WHEN ZZD_CERTAP = '' THEN '' " 																																+ STR_PULA
	cQuery += " END AS CERT_APROVADO, "																																		+ STR_PULA
	cQuery += " CASE " 																																						+ STR_PULA
	cQuery += " WHEN ZZD_LIBERA = 'N' THEN 'N�O' " 																															+ STR_PULA
	cQuery += " WHEN ZZD_LIBERA = 'S' THEN 'SIM' " 																															+ STR_PULA
	cQuery += " WHEN ZZD_LIBERA = '' THEN '' " 																																+ STR_PULA
	cQuery += " END AS EQUIP_LIBERADO, CONVERT (VARCHAR, CONVERT(DATE, ZZD_DTVAL, 103), 103) AS DT_AVALIACAO, ZZD_NOME AS RESP_AVALIACAO, " 								+ STR_PULA
	cQuery += " CASE " 																																						+ STR_PULA
	cQuery += " WHEN ZZD_STATUS = '1' THEN 'VALIDO' " 																														+ STR_PULA
	cQuery += " WHEN ZZD_STATUS = '2' THEN 'AGENDAR CALIBRACAO' " 																											+ STR_PULA
	cQuery += " WHEN ZZD_STATUS = '3' THEN 'VENCIDO' " 																														+ STR_PULA
	cQuery += " WHEN ZZD_STATUS = '4' THEN 'BAIXADO'  " 																													+ STR_PULA
	cQuery += " END AS STATUS_EQUIP, ZZD_OBS " 																																+ STR_PULA
	cQuery += " FROM " + RetSqlName("ZZD") + " " 																															+ STR_PULA
	cQuery += " WHERE D_E_L_E_T_ = '' " 																																	+ STR_PULA                                                                                                           
	cQuery += " AND ZZD_FILIAL BETWEEN '" + mv_par01 + "' AND '" + mv_par02 + "' " 																							+ STR_PULA 
	cQuery += " AND ZZD_CODCC BETWEEN '" + mv_par03 + "' AND '" + mv_par04 + "' " 																							+ STR_PULA 
	cQuery += " AND ZZD_STATUS BETWEEN '" + STR(mv_par05,1,0) + "' AND '" + STR(mv_par06,1,0) + "' " 																		+ STR_PULA 
	TCQuery cQuery New Alias "QPRO"
     
    //Criando o objeto que ir� gerar o conte�do do Excel
    oFWMsExcel := FWMSExcel():New()
     
    //Aba 01 - Tabela do Cadastro
    oFWMsExcel:AddworkSheet("EQUIP") //N�o utilizar n�mero junto com sinal de menos. Ex.: 1-
        //Criando a Tabela
        oFWMsExcel:AddTable("EQUIP","Cadastro de Calibra��o")
        //Criando Colunas
        oFWMsExcel:AddColumn("EQUIP","Cadastro de Calibra��o","Cod. CCusto",1) 
        oFWMsExcel:AddColumn("EQUIP","Cadastro de Calibra��o","Desc. Centro de Custo",1) 
        oFWMsExcel:AddColumn("EQUIP","Cadastro de Calibra��o","Patrim�nio Med+",1) 
        oFWMsExcel:AddColumn("EQUIP","Cadastro de Calibra��o","Equip. Cadast. Ativo",1)
		oFWMsExcel:AddColumn("EQUIP","Cadastro de Calibra��o","Cod. Produto",1)
		oFWMsExcel:AddColumn("EQUIP","Cadastro de Calibra��o","Desc. Produto",1)
		oFWMsExcel:AddColumn("EQUIP","Cadastro de Calibra��o","Cod. Ativo",1)
		oFWMsExcel:AddColumn("EQUIP","Cadastro de Calibra��o","Desc. Ativo",1)
        oFWMsExcel:AddColumn("EQUIP","Cadastro de Calibra��o","Especifica��o/Marca",1)
        oFWMsExcel:AddColumn("EQUIP","Cadastro de Calibra��o","Plaqueta",1)
        oFWMsExcel:AddColumn("EQUIP","Cadastro de Calibra��o","N� S�rie",1)           
        oFWMsExcel:AddColumn("EQUIP","Cadastro de Calibra��o","Periodicidade Calib.",1)
        oFWMsExcel:AddColumn("EQUIP","Cadastro de Calibra��o","Dt. �ltima Calib.",1)
        oFWMsExcel:AddColumn("EQUIP","Cadastro de Calibra��o","Dt. Pr�x. Calib.",1)
        oFWMsExcel:AddColumn("EQUIP","Cadastro de Calibra��o","N.Certificado",1)
        oFWMsExcel:AddColumn("EQUIP","Cadastro de Calibra��o","Tol. Administrativa",1)
        oFWMsExcel:AddColumn("EQUIP","Cadastro de Calibra��o","Cert. Aprov.",1)
        oFWMsExcel:AddColumn("EQUIP","Cadastro de Calibra��o","Equip. Liberado",1)
		oFWMsExcel:AddColumn("EQUIP","Cadastro de Calibra��o","Dt. Avalia��o",1)
		oFWMsExcel:AddColumn("EQUIP","Cadastro de Calibra��o","Resp. Avalia��o",1)
		oFWMsExcel:AddColumn("EQUIP","Cadastro de Calibra��o","Status Equipamento",1)


        //Criando as Linhas
 		 While !(QPRO->(EoF()))
            
            oFWMsExcel:AddRow("EQUIP","Cadastro de Calibra��o",{;
																    QPRO->COD_CC,;
                                                                    QPRO->DESC_CC,;
                                                                    QPRO->EQUIP_MEDMAIS,;
                                                                    QPRO->EQUIP_ATIVO,;
                                                                    QPRO->COD_PROD,;
                                                                    QPRO->DESC_PROD,;
                                                                    QPRO->COD_BEM,;
																	QPRO->DESC_BEM,;
                                                                    QPRO->ESPECIFICACAO_MARCA,;  
                                                                    QPRO->PLAQUETA,;   
                                                                    QPRO->N_SERIE,;  
                                                                    QPRO->PERIODICIDADE,; 
                                                                    QPRO->DT_ULT_CALIBRACAO,;
                                                                    QPRO->DT_PROX_CALIBRACAO,; 
                                                                    QPRO->N_CERTIFICADO,;  
                                                                    QPRO->RES_LIM_ADM,;
                                                                    QPRO->CERT_APROVADO,;
                                                                    QPRO->EQUIP_LIBERADO,; 
                                                                    QPRO->DT_AVALIACAO,;
																	QPRO->RESP_AVALIACAO,;	
																	QPRO->STATUS_EQUIP;																                                                                               
            })
            //Pulando Registro
            QPRO->(DbSkip())
		EndDo

	

   
    //Ativando o arquivo e gerando o xml
    oFWMsExcel:Activate()
    oFWMsExcel:GetXMLFile(cArquivo)
         
    //Abrindo o excel e abrindo o arquivo xml
    oExcel := MsExcel():New()            	//Abre uma nova conex�o com Excel
    oExcel:WorkBooks:Open(cArquivo)     	//Abre uma planilha
    oExcel:SetVisible(.T.)                 	//Visualiza a planilha
    oExcel:Destroy()                        //Encerra o processo do gerenciador de tarefas
     
    //Fecha Query
    QPRO->(DbCloseArea())
    RestArea(aArea)

	
Return


/*/{Protheus.doc} MMCOMR01B
Rotina respons�vel por criar as perguntas do relat�rio no SX1 caso n�o existam.
@param		Nenhum
@return		Nenhum
@author 	Andr� Luis Maximiano Longhini
@since 		24/06/2022
@version 	1.0
@Obs		24/06/2022 - MedMais - Andr� Luis Maximiano Longhini - Constru��o inicial.

/*/
Static Function MMCOMR01B()

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
	AADD(aRegs,{cPerg,"01","Filial de?     ","","","mv_ch1","C",2,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","SM0"})
	AADD(aRegs,{cPerg,"02","Filial at�?    ","","","mv_ch2","C",2,0,0,"G","NaoVazio","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","SM0"})
	AADD(aRegs,{cPerg,"03","Centro de Custo de?   ","","","mv_ch3","C",TamSx3("CTT_CUSTO")[1],0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","CTT"})
	AADD(aRegs,{cPerg,"04","Centro de Custo at�?  ","","","mv_ch4","C",TamSx3("CTT_CUSTO")[1],0,0,"G","NaoVazio","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","CTT"})
	AADD(aRegs,{cPerg,"05","Status de?  ","","","mv_ch5","C",1,0,0,"C","","mv_par05","1 - VALIDO","","","","2 - AGENDAR CALIBRACAO","","","","3 - VENCIDO","","","","4 - BAIXADO","","","","","","","","","","","",""})
	AADD(aRegs,{cPerg,"06","Status at�?  ","","","mv_ch6","C",1,0,0,"C","","mv_par06","1 - VALIDO","","","","2 - AGENDAR CALIBRACAO","","","","3 - VENCIDO","","","","4 - BAIXADO","","","","","","","","","","","",""})
	
    
	//Adiciona o conte�do dos helps no array.
	AADD(aHelpPor, "Informe a Filial inicial.")
	AADD(aHelpPor, "Informe a Filial final.")
	AADD(aHelpPor, "Informe o Centro de Custo inicial.")
	AADD(aHelpPor, "Informe o Centro de Custo final.")
	AADD(aHelpPor, "Informe o Status inicial.")
	AADD(aHelpPor, "Informe o Status final.")

	

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
			MMCOMR01C(cChaveHelp, aHelpPor[i], .T.)
		EndIf

	Next

Return


/*/{Protheus.doc} MMCOMR01C
Rotina respons�vel por criar o HELP das perguntas do relat�rio no arquivo "SIGAHLP.HLP".
@param		Par�metros: cKey : Chave da Pergunta
cHelp: Texto do Help
lUpdate: Indica se deve atualizar o help
@return		Nenhum
@author 	Andr� Luis Maximiano Longhini
@since 		24/06/2022
@version 	1.0
@Obs		24/06/2022 - MedMais - Andr� Luis Maximiano Longhini - Constru��o inicial.

/*/

Static Function MMCOMR01C(cKey, cHelp, lUpdate)

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
