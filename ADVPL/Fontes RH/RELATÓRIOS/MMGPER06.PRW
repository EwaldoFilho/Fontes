#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"

//Constantes
#Define STR_PULA    Chr(13)+Chr(10)

/*/{Protheus.doc} MMGPER06
Rotina que gera o relatório de conferência de incidências de verbas
@param		Nenhum
@return		Nenhum
@author 	André Luis Maximiano Longhini	
@since 		21/12/2021
@version 	1.0
@Obs		21/12/2021 - MedMais - André Luis Maximiano Longhini - Construção inicial.

/*/

User Function MMGPER06()

	Local _aArea	:= GetArea()

	Private cPerg := "MMGPER06"

	//Cria as perguntas do relatório, caso não existam.
	MMGPER06B()

	// Ativa o grupo de perguntas
	If !Pergunte(cPerg,.T.)
		Return
	EndIf

	//Chama a função de geração do relatório em Excel.
	msAguarde( { || MMGPER06A() }, "Aguarde", "Gerando o relatório...")
	
	//Retorna o ambiente anterior.
	RestArea(_aArea)

Return()


/*/{Protheus.doc} MMGPER06A
Rotina responsável por gerar o relatório em Excel.
@param		Nenhum
@return		Nenhum
@author 	André Luis Maximiano Longhini
@since 		21/12/2021
@version 	1.0
@Obs		21/12/2021 - MedMais - André Luis Maximiano Longhini - Construção inicial.

/*/
Static Function MMGPER06A()

  	Local cQuery        := ""
    Local oFWMsExcel
    Local oExcel
	Local aArea			:= GetArea()
    Local dtHora        := FWTimeStamp(1,DATE(),TIME())
    Local cArquivo   	:= GetTempPath()+'CADASTRODEVERBAS'+''+dtHora+''+'.xml'

    //Busca os dados para impressão
	cQuery := " SELECT RV_FILIAL AS FILIAL, RV_COD AS COD_VERBA, RV_DESC AS DESCRICAO, CASE " 																						+ STR_PULA
	cQuery += "	WHEN RV.RV_DESCDET <> '' THEN RV.RV_DESCDET " 																														+ STR_PULA
	cQuery += "	ELSE RV.RV_DESC " 																																					+ STR_PULA
	cQuery += "	END AS DESC_COMPLETA " 																																				+ STR_PULA
	cQuery += "	, CASE " 																																							+ STR_PULA
	cQuery += "	WHEN RV.RV_TIPOCOD = '1' THEN 'PROVENTO' " 																															+ STR_PULA
	cQuery += "	WHEN RV.RV_TIPOCOD = '2' THEN 'DESCONTO' " 																															+ STR_PULA
	cQuery += "	WHEN RV.RV_TIPOCOD = '3' THEN 'BASE(PROVENTO)' " 																													+ STR_PULA
	cQuery += "	WHEN RV.RV_TIPOCOD = '4' THEN 'BASE(DESCONTO)' " 																													+ STR_PULA
	cQuery += "	ELSE RV.RV_TIPOCOD " 																																				+ STR_PULA
	cQuery += "	END AS TIPO, RV_INSS AS INC_INSS_FOL, RV_IR AS INC_IR_FOL, RV_FGTS AS INC_FGTS_FOL, RV_REF13 AS REF_13, RV_REFFER AS REF_FER, "										+ STR_PULA
	cQuery += "	RV_NATUREZ AS NATUREZA_ESOCIAL, C89_DESCRI AS DESC_NATUREZA, RV_INCIRF AS INC_IR_ESOCIAL,  C8U_DESCRI AS DESC_INC_IR, RV_INCFGTS AS INC_FGTS_ESOCIAL, CASE "		+ STR_PULA
	cQuery += "	WHEN RV.RV_INCFGTS = '00' THEN 'Não é Base de Cálculo do FGTS' "																									+ STR_PULA
	cQuery += "	WHEN RV.RV_INCFGTS = '11' THEN 'Base de Cálculo do FGTS MENSAL' "																									+ STR_PULA
	cQuery += "	WHEN RV.RV_INCFGTS = '12' THEN 'Base de Cálculo do FGTS 13°' "																										+ STR_PULA
	cQuery += "	WHEN RV.RV_INCFGTS = '21' THEN 'Base de Cálculo do FGTS RESCISÓRIO' "																								+ STR_PULA
	cQuery += "	WHEN RV.RV_INCFGTS = '91' THEN 'Incidência suspensa em decerrência de decisão Judicial' "																			+ STR_PULA
	cQuery += "	ELSE RV.RV_INCFGTS "																																				+ STR_PULA
	cQuery += "	END AS DESC_INC_FGTS "																																				+ STR_PULA
	cQuery += "	, RV_INCCP AS INC_INSS_ESOCIAL, C8T_DESCRI AS DESC_INC_INSS "																										+ STR_PULA
	cQuery += "	FROM SRV010 RV "   																																					+ STR_PULA
	cQuery += "	LEFT JOIN C89010 C89 "																																				+ STR_PULA
	cQuery += "	ON C89.C89_CODIGO = RV.RV_NATUREZ "																																	+ STR_PULA
	cQuery += "	AND C89.C89_VALIDA = '' "																																			+ STR_PULA
	cQuery += "	AND C89.D_E_L_E_T_ = '' "																																			+ STR_PULA
	cQuery += "	LEFT JOIN C8T010 C8T "																																				+ STR_PULA
	cQuery += "	ON C8T.C8T_CODIGO = RV.RV_INCCP "																																	+ STR_PULA
	cQuery += "	AND C8T.C8T_VALIDA = '' " 																																			+ STR_PULA
	cQuery += "	AND C8T.D_E_L_E_T_ = '' "																																			+ STR_PULA
	cQuery += "	LEFT JOIN C8U010 C8U "																																				+ STR_PULA
	cQuery += "	ON C8U.C8U_CODIGO = RV.RV_INCIRF "																																	+ STR_PULA
	cQuery += "	AND C8U.C8U_VALIDA = '' "																																			+ STR_PULA
	cQuery += "	AND C8U.D_E_L_E_T_ = '' "																																			+ STR_PULA
	cQuery += "	WHERE RV.D_E_L_E_T_ = '' "																																			+ STR_PULA
	cQuery += " AND RV.RV_FILIAL  BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "' " 
	cQuery += " AND RV.RV_COD  BETWEEN '" + MV_PAR03 + "' AND '" + MV_PAR04 + "' "
	cQuery += " AND RV.RV_TIPOCOD  BETWEEN '" + MV_PAR05 + "' AND '" + MV_PAR06 + "' "
	cQuery += "	ORDER BY RV.RV_FILIAL, RV.RV_COD "    																																+ STR_PULA                                                                                                           
	TCQuery cQuery New Alias "QPRO"
     
    //Criando o objeto que irá gerar o conteúdo do Excel
    oFWMsExcel := FWMSExcel():New()
     
    //Aba 01 - Tabela do Cadastro
    oFWMsExcel:AddworkSheet("CADVB") //Não utilizar número junto com sinal de menos. Ex.: 1-
        //Criando a Tabela
        oFWMsExcel:AddTable("CADVB","Cadastro de Verbas")
        //Criando Colunas
        oFWMsExcel:AddColumn("CADVB","Cadastro de Verbas","Filial",1) 
        oFWMsExcel:AddColumn("CADVB","Cadastro de Verbas","Cód. Verba",1) 
        oFWMsExcel:AddColumn("CADVB","Cadastro de Verbas","Descrição",1) 
        oFWMsExcel:AddColumn("CADVB","Cadastro de Verbas","Desc. Comp",1)
		oFWMsExcel:AddColumn("CADVB","Cadastro de Verbas","Tipo",1)
		oFWMsExcel:AddColumn("CADVB","Cadastro de Verbas","INC INSS FOL",1)
		oFWMsExcel:AddColumn("CADVB","Cadastro de Verbas","INC IR FOL",1)
		oFWMsExcel:AddColumn("CADVB","Cadastro de Verbas","INC FGTS FOL",1)
        oFWMsExcel:AddColumn("CADVB","Cadastro de Verbas","Ref. 13°",1)
        oFWMsExcel:AddColumn("CADVB","Cadastro de Verbas","Ref. Férias",1)
        oFWMsExcel:AddColumn("CADVB","Cadastro de Verbas","Natureza eSocial",1)           
        oFWMsExcel:AddColumn("CADVB","Cadastro de Verbas","Descrição Nat.",1)
        oFWMsExcel:AddColumn("CADVB","Cadastro de Verbas","INC IR ESOCIAL",1)
        oFWMsExcel:AddColumn("CADVB","Cadastro de Verbas","Desc. Inc. IR eSocial",1)
        oFWMsExcel:AddColumn("CADVB","Cadastro de Verbas","INC FGTS ESOCIAL",1)
        oFWMsExcel:AddColumn("CADVB","Cadastro de Verbas","Desc. Inc. FGTS eSocial",1)
        oFWMsExcel:AddColumn("CADVB","Cadastro de Verbas","INC INSS ESOCIAL",1)
        oFWMsExcel:AddColumn("CADVB","Cadastro de Verbas","Desc. Inc. INSS eSocial",1)


        //Criando as Linhas
 		 While !(QPRO->(EoF()))
            
            oFWMsExcel:AddRow("CADVB","Cadastro de Verbas",{;
																    QPRO->FILIAL,;
                                                                    QPRO->COD_VERBA,;
                                                                    QPRO->DESCRICAO,;
                                                                    QPRO->DESC_COMPLETA,;
                                                                    QPRO->TIPO,;
                                                                    QPRO->INC_INSS_FOL,;
                                                                    QPRO->INC_IR_FOL,;
																	QPRO->INC_FGTS_FOL,;
                                                                    QPRO->REF_13,;  
                                                                    QPRO->REF_FER,;   
                                                                    QPRO->NATUREZA_ESOCIAL,;  
                                                                    QPRO->DESC_NATUREZA,; 
                                                                    QPRO->INC_IR_ESOCIAL,;
                                                                    QPRO->DESC_INC_IR,; 
                                                                    QPRO->INC_FGTS_ESOCIAL,;  
                                                                    QPRO->DESC_INC_FGTS,;
                                                                    QPRO->INC_INSS_ESOCIAL,;
                                                                    QPRO->DESC_INC_INSS;                                                                                
            })
            //Pulando Registro
            QPRO->(DbSkip())
		EndDo

	

   
    //Ativando o arquivo e gerando o xml
    oFWMsExcel:Activate()
    oFWMsExcel:GetXMLFile(cArquivo)
         
    //Abrindo o excel e abrindo o arquivo xml
    oExcel := MsExcel():New()            	//Abre uma nova conexão com Excel
    oExcel:WorkBooks:Open(cArquivo)     	//Abre uma planilha
    oExcel:SetVisible(.T.)                 	//Visualiza a planilha
    oExcel:Destroy()                        //Encerra o processo do gerenciador de tarefas
     
    //Fecha Query
    QPRO->(DbCloseArea())
    RestArea(aArea)

	
Return


/*/{Protheus.doc} MMGPER06B
Rotina responsável por criar as perguntas do relatório no SX1 caso não existam.
@param		Nenhum
@return		Nenhum
@author 	André Luis Maximiano Longhini
@since 		21/12/2021
@version 	1.0
@Obs		21/12/2021 - MedMais - André Luis Maximiano Longhini - Construção inicial.

/*/
Static Function MMGPER06B()

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
	AADD(aRegs,{cPerg,"01","Filial de?     ","","","mv_ch1","C",TamSx3("RV_FILIAL")[1],0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","SM0"})
	AADD(aRegs,{cPerg,"02","Filial até?    ","","","mv_ch2","C",TamSx3("RV_FILIAL")[1],0,0,"G","NaoVazio","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","SM0"})
	AADD(aRegs,{cPerg,"03","Código de Verba de?   ","","","mv_ch3","C",TamSx3("RV_COD")[1],0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","SRV"})
	AADD(aRegs,{cPerg,"04","Código de Verba até?  ","","","mv_ch4","C",TamSx3("RV_COD")[1],0,0,"G","NaoVazio","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","SRV"})
	AADD(aRegs,{cPerg,"05","Típo de Verba de?   ","","","mv_ch5","C",TamSx3("RV_TIPOCOD")[1],0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","",""})
	AADD(aRegs,{cPerg,"06","Típo de verba até?   ","","","mv_ch6","C",TamSx3("RV_TIPOCOD")[1],0,0,"G","NaoVazio","mv_par06","","","","","","","","","","","","","","","","","","","","","","","","",""})

    
	//Adiciona o conteúdo dos helps no array.
	AADD(aHelpPor, "Informe a Filial inicial.")
	AADD(aHelpPor, "Informe a Filial final.")
	AADD(aHelpPor, "Informe o Código de verba inicial.")
	AADD(aHelpPor, "Informe o Código de verba final.")
	AADD(aHelpPor, "Informe o Tipo de verba inicial - 1 Provento, 2 Desconto, 3 Base(Provento) e 4 Base(Desconto).")
	AADD(aHelpPor, "Informe o Tipo de verba final - 1 Provento, 2 Desconto, 3 Base(Provento) e 4 Base(Desconto).")

	

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
			MMGPER06C(cChaveHelp, aHelpPor[i], .T.)
		EndIf

	Next

Return


/*/{Protheus.doc} MMGPER06C
Rotina responsável por criar o HELP das perguntas do relatório no arquivo "SIGAHLP.HLP".
@param		Parâmetros: cKey : Chave da Pergunta
cHelp: Texto do Help
lUpdate: Indica se deve atualizar o help
@return		Nenhum
@author 	André Luis Maximiano Longhini
@since 		21/12/2021
@version 	1.0
@Obs		21/12/2021 - MedMais - André Luis Maximiano Longhini - Construção inicial.

/*/

Static Function MMGPER06C(cKey, cHelp, lUpdate)

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
