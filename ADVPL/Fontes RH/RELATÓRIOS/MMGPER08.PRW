#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"

//Constantes
#Define STR_PULA    Chr(13)+Chr(10)

/*/{Protheus.doc} MMGPER08
Rotina que gera o relatório de conferência da folha
@param		Nenhum
@return		Nenhum
@author 	André Luis Maximiano Longhini	
@since 		02/05/2022
@version 	1.0
@Obs		02/05/2022 - MedMais - André Luis Maximiano Longhini - Construção inicial.

/*/

User Function MMGPER08()

	Local _aArea	:= GetArea()

	Private cPerg := "MMGPER08"

	//Cria as perguntas do relatório, caso não existam.
	MMGPER08B()

	// Ativa o grupo de perguntas
	If !Pergunte(cPerg,.T.)
		Return
	EndIf

	//Chama a função de geração do relatório em Excel.
	msAguarde( { || MMGPER08A() }, "Aguarde", "Gerando o relatório...")
	
	//Retorna o ambiente anterior.
	RestArea(_aArea)

Return()


/*/{Protheus.doc} MMGPER08A
Rotina responsável por gerar o relatório em Excel.
@param		Nenhum
@return		Nenhum
@author 	André Luis Maximiano Longhini
@since 		02/05/2022
@version 	1.0
@Obs		02/05/2022 - MedMais - André Luis Maximiano Longhini - Construção inicial.

/*/
Static Function MMGPER08A()

  	Local cQuery        := ""
    Local oFWMsExcel
    Local oExcel
	Local aArea			:= GetArea()
    Local dtHora        := FWTimeStamp(1,DATE(),TIME())
    Local cArquivo   	:= GetTempPath()+'CONFERENCIA_FOLHA'+''+dtHora+''+'.xml'

    //Busca os dados para impressão Folha Corrente
	cQuery := " SELECT RCE_DESCRI,RA_SINDICA,RC_FILIAL, RC_MAT, RA_NOMECMP, RA_CIC, RA_CODFUNC, RJ_DESC, RC_CC, CTT_DESC01, RC_PD, RV_DESC, RC_TIPO1,CASE " 		+ STR_PULA
	cQuery += "	WHEN RC_TIPO1 = 'V' THEN 'VALOR'  WHEN RC_TIPO1 = 'H' THEN 'HORAS' WHEN RC_TIPO1 = 'D' THEN 'DIAS' END AS VB_REF, " 		  						+ STR_PULA
	cQuery += "	RV_TIPOCOD, CASE WHEN RV_TIPOCOD = '1' THEN 'PROVENTO' WHEN RV_TIPOCOD = '2' THEN 'DESCONTO' WHEN RV_TIPOCOD = '3' THEN 'BASE (PROVENTO)' " 		+ STR_PULA
	cQuery += "	WHEN RV_TIPOCOD = '4' THEN 'BASE (DESCONTO)' END AS VB_TP, RC_HORAS, RC_VALOR, RC_PERIODO,RA_SITFOLH,CASE WHEN RA_SITFOLH = '' THEN 'ATIVO' "    	+ STR_PULA
	cQuery += "	WHEN RA_SITFOLH = 'D' THEN 'DEMITIDO'  WHEN RA_SITFOLH = 'A' THEN 'AFASTADO' WHEN RA_SITFOLH = 'F' THEN 'FÉRIAS' END AS DESC_SITFOLH, "    		    + STR_PULA
	cQuery += "	RA_RESCRAI, CASE WHEN RA_RESCRAI = '10' THEN 'JUSTA CAUSA - INICIATIVA EMPREGADOR' WHEN RA_RESCRAI = '11' THEN 'SEM JUSTA CAUSA - INICIATIVA EMPREGADOR' WHEN RA_RESCRAI = '12' THEN 'EXTINÇAO DO CONTRATO DE TRABALHO - INICIATIVA EMPREGADOR' "   + STR_PULA
	cQuery += "	WHEN RA_RESCRAI = '20' THEN 'JUSTA CAUSA - INICIATIVA EMPREGADO' WHEN RA_RESCRAI = '21' THEN 'SEM JUSTA CAUSA - INICIATIVA EMPREGADO' WHEN RA_RESCRAI = '30' THEN 'TRANSF. COM ONUS PARA CEDENTE' "   + STR_PULA
	cQuery += "	WHEN RA_RESCRAI = '31' THEN 'TRANSF. SEM ONUS PARA CEDENTE' WHEN RA_RESCRAI = '40' THEN 'MUDANCA DE REGIME TRABALHISTA' WHEN RA_RESCRAI = '50' THEN 'REFORMA MILITAR PARA A RESERVA' WHEN RA_RESCRAI = '60' THEN 'FALECIMENTO' "   + STR_PULA
	cQuery += "	WHEN RA_RESCRAI = '62' THEN 'FALECIMENTO - ACIDENTE DE TRABALHO' WHEN RA_RESCRAI = '64' THEN 'FALECIMENTO - DOENÇA PROFISSIONAL' WHEN RA_RESCRAI = '70' THEN 'APOSENTADORIA - TEMP SERV COM RESC. CONTRATUAL' WHEN RA_RESCRAI = '71' THEN 'APOSENTADORIA - TEMP SERV SEM RESC. CONTRATUAL' "   + STR_PULA
    cQuery += "	WHEN RA_RESCRAI = '72' THEN 'APOSENTADORIA - POR IDADE' WHEN RA_RESCRAI = '73' THEN 'APOSENTADORIA - INVALIDEZ POR ACID. TRABAL' WHEN RA_RESCRAI = '74' THEN 'APOSENTADORIA - INVALIDEZ POR DOENÇA PROFISSIONAL' "   + STR_PULA
	cQuery += "	WHEN RA_RESCRAI = '75' THEN 'APOSENTADORIA - COMPULSORIA' WHEN RA_RESCRAI = '76' THEN 'APOSENTADORIA - INVALIDEZ, EXCETO DECORRENTE DOENCA' WHEN RA_RESCRAI = '78' THEN 'APOSENTADORIA - POR IDADE, SEM RESCISÃO CONTRATUAL' WHEN RA_RESCRAI = '79' THEN 'APOSENTADORIA - ESPECIAL' WHEN RA_RESCRAI = '80' THEN 'APOSENTADORIA - ESPECIAL, SEM RESCISÃO CONTRATUAL' WHEN RA_RESCRAI = '90' THEN 'DESLIGAMENTO POR ACORDO ENTRE EMPREGADO E EMPREGADOR' WHEN RA_RESCRAI = '' THEN '' "   + STR_PULA
	cQuery += "	 END AS TP_DESLIGAMENTO FROM "      																													+ STR_PULA
	cQuery += "	 "+RetSQLName('SRC')+" RC "      																													+ STR_PULA
	cQuery += "	INNER JOIN "+RetSQLName('SRV')+" RV " 																												+ STR_PULA
	cQuery += "	ON RV.RV_FILIAL = SUBSTRING(RC.RC_FILIAL,1,2) " 																									+ STR_PULA
	cQuery += "	AND RV.RV_COD = RC.RC_PD " 																															+ STR_PULA
	cQuery += "	AND RV.D_E_L_E_T_ = '' " 																															+ STR_PULA
	cQuery += "	INNER JOIN "+RetSQLName('CTT')+" CTT " 																												+ STR_PULA
	cQuery += "	ON CTT.CTT_FILIAL = SUBSTRING(RC.RC_FILIAL,1,2) " 																									+ STR_PULA
	cQuery += "	AND CTT.CTT_CUSTO = RC.RC_CC " 																														+ STR_PULA
	cQuery += "	AND CTT.D_E_L_E_T_ = '' " 																															+ STR_PULA
	cQuery += "	INNER JOIN "+RetSQLName('SRA')+" RA " 																												+ STR_PULA
	cQuery += "	ON RA.RA_FILIAL = RC.RC_FILIAL " 																													+ STR_PULA
	cQuery += "	AND RA.RA_MAT = RC.RC_MAT " 																														+ STR_PULA
	cQuery += "	AND RA.D_E_L_E_T_ = ''	" 																															+ STR_PULA
	cQuery += "	INNER JOIN "+RetSQLName('SRJ')+" RJ " 																												+ STR_PULA
	cQuery += "	ON RJ.RJ_FILIAL = SUBSTRING(RA.RA_FILIAL,1,2) " 																									+ STR_PULA
	cQuery += "	AND RJ.RJ_FUNCAO = RA.RA_CODFUNC	" 																												+ STR_PULA
	cQuery += "	AND RJ.D_E_L_E_T_ = ''	"																															+ STR_PULA
	cQuery += "	INNER JOIN "+RetSQLName('RCE')+" RCE " 																												+ STR_PULA
	cQuery += "	ON RCE.RCE_FILIAL = SUBSTRING(RA.RA_FILIAL,1,2) " 																									+ STR_PULA
	cQuery += "	AND RCE.RCE_CODIGO = RA.RA_SINDICA	" 																												+ STR_PULA
	cQuery += "	AND RCE.D_E_L_E_T_ = ''	"																															+ STR_PULA
	cQuery += "	WHERE RC.RC_PERIODO BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "' " 																			+ STR_PULA																										+ STR_PULA
	cQuery += "	AND RC.RC_FILIAL BETWEEN '" + MV_PAR03 + "' AND '" + MV_PAR04 + "' "  																				+ STR_PULA
	cQuery += "	AND RC.RC_MAT BETWEEN '" + MV_PAR05 + "' AND '" + MV_PAR06 + "' " 																					+ STR_PULA
	cQuery += "	AND RC.RC_CC BETWEEN '" + MV_PAR07 + "' AND '" + MV_PAR08 + "' " 																					+ STR_PULA
	cQuery += " ORDER BY RC_FILIAL, RC_MAT, RC_CC, RC_PD		" 																									+ STR_PULA                                                                                                         
	TCQuery cQuery New Alias "QPRO"
     
    //Criando o objeto que irá gerar o conteúdo do Excel
    oFWMsExcel := FWMSExcel():New()
     
    //Aba 01 - Tabela do Cadastro
    oFWMsExcel:AddworkSheet("FOLHA-ATIVA") //Não utilizar número junto com sinal de menos. Ex.: 1-
        //Criando a Tabela
        oFWMsExcel:AddTable("FOLHA-ATIVA","Folha Ativa")
        //Criando Colunas
        oFWMsExcel:AddColumn("FOLHA-ATIVA","Folha Ativa","Filial",1) 
        oFWMsExcel:AddColumn("FOLHA-ATIVA","Folha Ativa","Matrícula",1) 
        oFWMsExcel:AddColumn("FOLHA-ATIVA","Folha Ativa","Nome",1) 
        oFWMsExcel:AddColumn("FOLHA-ATIVA","Folha Ativa","CPF",1)
		oFWMsExcel:AddColumn("FOLHA-ATIVA","Folha Ativa","Cod. Função",1)
		oFWMsExcel:AddColumn("FOLHA-ATIVA","Folha Ativa","Des. Função",1)
		oFWMsExcel:AddColumn("FOLHA-ATIVA","Folha Ativa","Cod. C.Custo",1)
		oFWMsExcel:AddColumn("FOLHA-ATIVA","Folha Ativa","Des. C.Custo",1)
		oFWMsExcel:AddColumn("FOLHA-ATIVA","Folha Ativa","Cod. Sindicato",1)
		oFWMsExcel:AddColumn("FOLHA-ATIVA","Folha Ativa","Des. Sindicato",1)
        oFWMsExcel:AddColumn("FOLHA-ATIVA","Folha Ativa","Cod. Verba°",1)
        oFWMsExcel:AddColumn("FOLHA-ATIVA","Folha Ativa","Desc. Verba",1)
        oFWMsExcel:AddColumn("FOLHA-ATIVA","Folha Ativa","Tipo Lanc",1)           
        oFWMsExcel:AddColumn("FOLHA-ATIVA","Folha Ativa","Tipo Verba",1)
        oFWMsExcel:AddColumn("FOLHA-ATIVA","Folha Ativa","Referencia",1)
        oFWMsExcel:AddColumn("FOLHA-ATIVA","Folha Ativa","Valor",1)
		oFWMsExcel:AddColumn("FOLHA-ATIVA","Folha Ativa","Situação",1)
		oFWMsExcel:AddColumn("FOLHA-ATIVA","Folha Ativa","Tp. Rescisão",1)
        oFWMsExcel:AddColumn("FOLHA-ATIVA","Folha Ativa","Período",1)


        //Criando as Linhas
 		 While !(QPRO->(EoF()))
            
            oFWMsExcel:AddRow("FOLHA-ATIVA","Folha Ativa",{;
																    QPRO->RC_FILIAL,;
                                                                    QPRO->RC_MAT,;
                                                                    QPRO->RA_NOMECMP,;
                                                                    QPRO->RA_CIC,;
                                                                    QPRO->RA_CODFUNC,;
                                                                    QPRO->RJ_DESC,;
                                                                    QPRO->RC_CC,;
																	QPRO->CTT_DESC01,;
																	QPRO->RA_SINDICA,;
																	QPRO->RCE_DESCRI,;
                                                                    QPRO->RC_PD,;  
                                                                    QPRO->RV_DESC,;   
                                                                    QPRO->VB_REF,;  
                                                                    QPRO->VB_TP,; 
                                                                    QPRO->RC_HORAS,;
                                                                    QPRO->RC_VALOR,; 
																	QPRO->TP_DESLIGAMENTO,;
																	QPRO->RC_VALOR,;
                                                                    QPRO->RC_PERIODO;                                                                                
            })
            //Pulando Registro
            QPRO->(DbSkip())
		EndDo
	//Fecha Query
	QPRO->(DbCloseArea())

	//Busca os dados para impressão Folha Corrente
    //Busca os dados para impressão/
	cQuery := " SELECT RC_FILIAL, RC_CC, CTT_DESC01, RC_PD, RV_DESC, RC_TIPO1,CASE " 																				+ STR_PULA
	cQuery += "	WHEN RC_TIPO1 = 'V' THEN 'VALOR'  WHEN RC_TIPO1 = 'H' THEN 'HORAS' WHEN RC_TIPO1 = 'D' THEN 'DIAS' END AS VB_REF, " 		  						+ STR_PULA
	cQuery += "	RV_TIPOCOD, CASE WHEN RV_TIPOCOD = '1' THEN 'PROVENTO' WHEN RV_TIPOCOD = '2' THEN 'DESCONTO' WHEN RV_TIPOCOD = '3' THEN 'BASE (PROVENTO)' " 		+ STR_PULA
	cQuery += "	WHEN RV_TIPOCOD = '4' THEN 'BASE (DESCONTO)' END AS VB_TP, SUM(RC_VALOR) AS VALOR, RC_PERIODO  FROM "+RetSQLName('SRC')+" RC " 						+ STR_PULA
	cQuery += "	INNER JOIN "+RetSQLName('SRV')+" RV " 																												+ STR_PULA
	cQuery += "	ON RV.RV_FILIAL = SUBSTRING(RC.RC_FILIAL,1,2) " 																									+ STR_PULA
	cQuery += "	AND RV.RV_COD = RC.RC_PD " 																															+ STR_PULA
	cQuery += "	AND RV.D_E_L_E_T_ = '' " 																															+ STR_PULA
	cQuery += "	INNER JOIN "+RetSQLName('CTT')+" CTT " 																												+ STR_PULA
	cQuery += "	ON CTT.CTT_FILIAL = SUBSTRING(RC.RC_FILIAL,1,2) " 																									+ STR_PULA
	cQuery += "	AND CTT.CTT_CUSTO = RC.RC_CC " 																														+ STR_PULA
	cQuery += "	AND CTT.D_E_L_E_T_ = '' " 																															+ STR_PULA
	cQuery += "	INNER JOIN "+RetSQLName('SRA')+" RA " 																												+ STR_PULA
	cQuery += "	ON RA.RA_FILIAL = RC.RC_FILIAL " 																													+ STR_PULA
	cQuery += "	AND RA.RA_MAT = RC.RC_MAT " 																														+ STR_PULA
	cQuery += "	AND RA.D_E_L_E_T_ = ''	" 																															+ STR_PULA
	cQuery += "	INNER JOIN "+RetSQLName('SRJ')+" RJ " 																												+ STR_PULA
	cQuery += "	ON RJ.RJ_FILIAL = SUBSTRING(RA.RA_FILIAL,1,2) " 																									+ STR_PULA
	cQuery += "	AND RJ.RJ_FUNCAO = RA.RA_CODFUNC	" 																												+ STR_PULA
	cQuery += "	AND RJ.D_E_L_E_T_ = ''	"																															+ STR_PULA
	cQuery += "	WHERE RC.RC_PERIODO BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "' " 																			+ STR_PULA																										+ STR_PULA
	cQuery += "	AND RC.RC_FILIAL BETWEEN '" + MV_PAR03 + "' AND '" + MV_PAR04 + "' "  																				+ STR_PULA
	cQuery += "	AND RC.RC_MAT BETWEEN '" + MV_PAR05 + "' AND '" + MV_PAR06 + "' " 																					+ STR_PULA
	cQuery += "	AND RC.RC_CC BETWEEN '" + MV_PAR07 + "' AND '" + MV_PAR08 + "' " 																					+ STR_PULA
	cQuery += "	GROUP BY RC_FILIAL, RC_CC, CTT_DESC01, RC_PD, RV_DESC, RC_TIPO1, RV_TIPOCOD, RC_PERIODO" 															+ STR_PULA
	cQuery += " ORDER BY RC_FILIAL, RC_CC, RC_PD		" 																											+ STR_PULA                                                                                                         
	TCQuery cQuery New Alias "QPRO4"

    //Aba 01 - Tabela do Cadastro
    oFWMsExcel:AddworkSheet("FOLHA-ATIVA-RESUMO") //Não utilizar número junto com sinal de menos. Ex.: 1-
        //Criando a Tabela
        oFWMsExcel:AddTable("FOLHA-ATIVA-RESUMO","Resumo - Folha Ativa")
        //Criando Colunas
        oFWMsExcel:AddColumn("FOLHA-ATIVA-RESUMO","Resumo - Folha Ativa","Filial",1) 
		oFWMsExcel:AddColumn("FOLHA-ATIVA-RESUMO","Resumo - Folha Ativa","Cod. C.Custo",1)
		oFWMsExcel:AddColumn("FOLHA-ATIVA-RESUMO","Resumo - Folha Ativa","Des. C.Custo",1)
        oFWMsExcel:AddColumn("FOLHA-ATIVA-RESUMO","Resumo - Folha Ativa","Cod. Verba°",1)
        oFWMsExcel:AddColumn("FOLHA-ATIVA-RESUMO","Resumo - Folha Ativa","Desc. Verba",1)
        oFWMsExcel:AddColumn("FOLHA-ATIVA-RESUMO","Resumo - Folha Ativa","Tipo Lanc",1)  
		oFWMsExcel:AddColumn("FOLHA-ATIVA-RESUMO","Resumo - Folha Ativa","Tipo Verba",1)             
        oFWMsExcel:AddColumn("FOLHA-ATIVA-RESUMO","Resumo - Folha Ativa","Valor",1)
        oFWMsExcel:AddColumn("FOLHA-ATIVA-RESUMO","Resumo - Folha Ativa","Período",1)


        //Criando as Linhas
 		 While !(QPRO4->(EoF()))
            
            oFWMsExcel:AddRow("FOLHA-ATIVA-RESUMO","Resumo - Folha Ativa",{;
																    QPRO4->RC_FILIAL,;
                                                                    QPRO4->RC_CC,;
																	QPRO4->CTT_DESC01,;
                                                                    QPRO4->RC_PD,;  
                                                                    QPRO4->RV_DESC,;   
                                                                    QPRO4->VB_REF,;  
                                                                    QPRO4->VB_TP,; 
                                                                    QPRO4->VALOR,; 
                                                                    QPRO4->RC_PERIODO;                                                                                
            })
            //Pulando Registro
            QPRO4->(DbSkip())
		EndDo
	//Fecha Query
	QPRO4->(DbCloseArea())


    //Busca os dados para impressão - Folha anterior
	cQuery := " SELECT RCE_DESCRI,RA_SINDICA,RD_FILIAL, RD_MAT, RA_NOMECMP, RA_CIC, RA_CODFUNC, RJ_DESC, RD_CC, CTT_DESC01, RD_PD, RV_DESC, RD_TIPO1,CASE " 		+ STR_PULA
	cQuery += "	WHEN RD_TIPO1 = 'V' THEN 'VALOR'  WHEN RD_TIPO1 = 'H' THEN 'HORAS' WHEN RD_TIPO1 = 'D' THEN 'DIAS' END AS VB_REF, " 		  						+ STR_PULA
	cQuery += "	RV_TIPOCOD, CASE WHEN RV_TIPOCOD = '1' THEN 'PROVENTO' WHEN RV_TIPOCOD = '2' THEN 'DESCONTO' WHEN RV_TIPOCOD = '3' THEN 'BASE (PROVENTO)' " 		+ STR_PULA
	cQuery += "	WHEN RV_TIPOCOD = '3' THEN 'BASE (DESCONTO)' END AS VB_TP, RD_HORAS, RD_VALOR, RD_DATARQ,RA_SITFOLH,CASE WHEN RA_SITFOLH = '' THEN 'ATIVO' "    	+ STR_PULA
	cQuery += "	WHEN RA_SITFOLH = 'D' THEN 'DEMITIDO'  WHEN RA_SITFOLH = 'A' THEN 'AFASTADO' WHEN RA_SITFOLH = 'F' THEN 'FÉRIAS' END AS DESC_SITFOLH, "    		    + STR_PULA
	cQuery += "	RA_RESCRAI, CASE WHEN RA_RESCRAI = '10' THEN 'JUSTA CAUSA - INICIATIVA EMPREGADOR' WHEN RA_RESCRAI = '11' THEN 'SEM JUSTA CAUSA - INICIATIVA EMPREGADOR' WHEN RA_RESCRAI = '12' THEN 'EXTINÇAO DO CONTRATO DE TRABALHO - INICIATIVA EMPREGADOR' "   + STR_PULA
	cQuery += "	WHEN RA_RESCRAI = '20' THEN 'JUSTA CAUSA - INICIATIVA EMPREGADO' WHEN RA_RESCRAI = '21' THEN 'SEM JUSTA CAUSA - INICIATIVA EMPREGADO' WHEN RA_RESCRAI = '30' THEN 'TRANSF. COM ONUS PARA CEDENTE' "   + STR_PULA
	cQuery += "	WHEN RA_RESCRAI = '31' THEN 'TRANSF. SEM ONUS PARA CEDENTE' WHEN RA_RESCRAI = '40' THEN 'MUDANCA DE REGIME TRABALHISTA' WHEN RA_RESCRAI = '50' THEN 'REFORMA MILITAR PARA A RESERVA' WHEN RA_RESCRAI = '60' THEN 'FALECIMENTO' "   + STR_PULA
	cQuery += "	WHEN RA_RESCRAI = '62' THEN 'FALECIMENTO - ACIDENTE DE TRABALHO' WHEN RA_RESCRAI = '64' THEN 'FALECIMENTO - DOENÇA PROFISSIONAL' WHEN RA_RESCRAI = '70' THEN 'APOSENTADORIA - TEMP SERV COM RESC. CONTRATUAL' WHEN RA_RESCRAI = '71' THEN 'APOSENTADORIA - TEMP SERV SEM RESC. CONTRATUAL' "   + STR_PULA
    cQuery += "	WHEN RA_RESCRAI = '72' THEN 'APOSENTADORIA - POR IDADE' WHEN RA_RESCRAI = '73' THEN 'APOSENTADORIA - INVALIDEZ POR ACID. TRABAL' WHEN RA_RESCRAI = '74' THEN 'APOSENTADORIA - INVALIDEZ POR DOENÇA PROFISSIONAL' "   + STR_PULA
	cQuery += "	WHEN RA_RESCRAI = '75' THEN 'APOSENTADORIA - COMPULSORIA' WHEN RA_RESCRAI = '76' THEN 'APOSENTADORIA - INVALIDEZ, EXCETO DECORRENTE DOENCA' WHEN RA_RESCRAI = '78' THEN 'APOSENTADORIA - POR IDADE, SEM RESCISÃO CONTRATUAL' WHEN RA_RESCRAI = '79' THEN 'APOSENTADORIA - ESPECIAL' WHEN RA_RESCRAI = '80' THEN 'APOSENTADORIA - ESPECIAL, SEM RESCISÃO CONTRATUAL' WHEN RA_RESCRAI = '90' THEN 'DESLIGAMENTO POR ACORDO ENTRE EMPREGADO E EMPREGADOR' WHEN RA_RESCRAI = '' THEN '' "   + STR_PULA
	cQuery += "	 END AS TP_DESLIGAMENTO FROM "+RetSQLName('SRD')+" RD "      																													+ STR_PULA
	cQuery += "	INNER JOIN "+RetSQLName('SRV')+" RV " 																												+ STR_PULA
	cQuery += "	ON RV.RV_FILIAL = SUBSTRING(RD.RD_FILIAL,1,2) " 																									+ STR_PULA
	cQuery += "	AND RV.RV_COD = RD.RD_PD " 																															+ STR_PULA
	cQuery += "	AND RV.D_E_L_E_T_ = '' " 																															+ STR_PULA
	cQuery += "	INNER JOIN "+RetSQLName('CTT')+" CTT " 																												+ STR_PULA
	cQuery += "	ON CTT.CTT_FILIAL = SUBSTRING(RD.RD_FILIAL,1,2) " 																									+ STR_PULA
	cQuery += "	AND CTT.CTT_CUSTO = RD.RD_CC " 																														+ STR_PULA
	cQuery += "	AND CTT.D_E_L_E_T_ = '' " 																															+ STR_PULA
	cQuery += "	INNER JOIN "+RetSQLName('SRA')+" RA " 																												+ STR_PULA
	cQuery += "	ON RA.RA_FILIAL = RD.RD_FILIAL " 																													+ STR_PULA
	cQuery += "	AND RA.RA_MAT = RD.RD_MAT " 																														+ STR_PULA
	cQuery += "	AND RA.D_E_L_E_T_ = ''	" 																															+ STR_PULA
	cQuery += "	INNER JOIN "+RetSQLName('SRJ')+" RJ " 																												+ STR_PULA
	cQuery += "	ON RJ.RJ_FILIAL = SUBSTRING(RA.RA_FILIAL,1,2) " 																									+ STR_PULA
	cQuery += "	AND RJ.RJ_FUNCAO = RA.RA_CODFUNC	" 																												+ STR_PULA
	cQuery += "	AND RJ.D_E_L_E_T_ = ''	"																															+ STR_PULA
	cQuery += "	INNER JOIN "+RetSQLName('RCE')+" RCE " 																												+ STR_PULA
	cQuery += "	ON RCE.RCE_FILIAL = SUBSTRING(RA.RA_FILIAL,1,2) " 																									+ STR_PULA
	cQuery += "	AND RCE.RCE_CODIGO = RA.RA_SINDICA	" 																												+ STR_PULA
	cQuery += "	AND RCE.D_E_L_E_T_ = ''	"																															+ STR_PULA
	cQuery += "	WHERE RD.RD_DATARQ BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "' " 																				+ STR_PULA																										+ STR_PULA
	cQuery += "	AND RD.RD_FILIAL BETWEEN '" + MV_PAR03 + "' AND '" + MV_PAR04 + "' "  																				+ STR_PULA
	cQuery += "	AND RD.RD_MAT BETWEEN '" + MV_PAR05 + "' AND '" + MV_PAR06 + "' " 																					+ STR_PULA
	cQuery += "	AND RD.RD_CC BETWEEN '" + MV_PAR07 + "' AND '" + MV_PAR08 + "' " 																					+ STR_PULA
	cQuery += " ORDER BY RD_FILIAL, RD_MAT, RD_CC, RD_PD		" 																									+ STR_PULA                                                                                                         
	TCQuery cQuery New Alias "QPRO2"

     
    //Aba 01 - Tabela do Cadastro
    oFWMsExcel:AddworkSheet("FOLHA-ACUMULADA") //Não utilizar número junto com sinal de menos. Ex.: 1-
        //Criando a Tabela
        oFWMsExcel:AddTable("FOLHA-ACUMULADA","Folha(s) Acumulada(s)")
        //Criando Colunas
        oFWMsExcel:AddColumn("FOLHA-ACUMULADA","Folha(s) Acumulada(s)","Filial",1) 
        oFWMsExcel:AddColumn("FOLHA-ACUMULADA","Folha(s) Acumulada(s)","Matrícula",1) 
        oFWMsExcel:AddColumn("FOLHA-ACUMULADA","Folha(s) Acumulada(s)","Nome",1) 
        oFWMsExcel:AddColumn("FOLHA-ACUMULADA","Folha(s) Acumulada(s)","CPF",1)
		oFWMsExcel:AddColumn("FOLHA-ACUMULADA","Folha(s) Acumulada(s)","Cod. Função",1)
		oFWMsExcel:AddColumn("FOLHA-ACUMULADA","Folha(s) Acumulada(s)","Des. Função",1)
		oFWMsExcel:AddColumn("FOLHA-ACUMULADA","Folha(s) Acumulada(s)","Cod. C.Custo",1)
		oFWMsExcel:AddColumn("FOLHA-ACUMULADA","Folha(s) Acumulada(s)","Des. C.Custo",1)
		oFWMsExcel:AddColumn("FOLHA-ACUMULADA","Folha(s) Acumulada(s)","Cod. Sindicato",1)
		oFWMsExcel:AddColumn("FOLHA-ACUMULADA","Folha(s) Acumulada(s)","Des. Sindicato",1)
        oFWMsExcel:AddColumn("FOLHA-ACUMULADA","Folha(s) Acumulada(s)","Cod. Verba°",1)
        oFWMsExcel:AddColumn("FOLHA-ACUMULADA","Folha(s) Acumulada(s)","Desc. Verba",1)
        oFWMsExcel:AddColumn("FOLHA-ACUMULADA","Folha(s) Acumulada(s)","Tipo Lanc",1)           
        oFWMsExcel:AddColumn("FOLHA-ACUMULADA","Folha(s) Acumulada(s)","Tipo Verba",1)
        oFWMsExcel:AddColumn("FOLHA-ACUMULADA","Folha(s) Acumulada(s)","Referencia",1)
        oFWMsExcel:AddColumn("FOLHA-ACUMULADA","Folha(s) Acumulada(s)","Valor",1)
		oFWMsExcel:AddColumn("FOLHA-ACUMULADA","Folha(s) Acumulada(s)","Situação",1)
		oFWMsExcel:AddColumn("FOLHA-ACUMULADA","Folha(s) Acumulada(s)","Tp. Rescisão",1)
        oFWMsExcel:AddColumn("FOLHA-ACUMULADA","Folha(s) Acumulada(s)","Período",1)


        //Criando as Linhas
 		 While !(QPRO2->(EoF()))
            
            oFWMsExcel:AddRow("FOLHA-ACUMULADA","Folha(s) Acumulada(s)",{;
																    QPRO2->RD_FILIAL,;
                                                                    QPRO2->RD_MAT,;
                                                                    QPRO2->RA_NOMECMP,;
                                                                    QPRO2->RA_CIC,;
                                                                    QPRO2->RA_CODFUNC,;
                                                                    QPRO2->RJ_DESC,;
                                                                    QPRO2->RD_CC,;
																	QPRO2->CTT_DESC01,;
																	QPRO2->RA_SINDICA,;
																	QPRO2->RCE_DESCRI,;
                                                                    QPRO2->RD_PD,;  
                                                                    QPRO2->RV_DESC,;   
                                                                    QPRO2->VB_REF,;  
                                                                    QPRO2->VB_TP,; 
                                                                    QPRO2->RD_HORAS,;
                                                                    QPRO2->RD_VALOR,; 
																	QPRO2->DESC_SITFOLH,; 
																	QPRO2->TP_DESLIGAMENTO,; 
                                                                    QPRO2->RD_DATARQ;                                                                                
            })
            //Pulando Registro
            QPRO2->(DbSkip())
		EndDo
	//Fecha Query
	QPRO2->(DbCloseArea())
   


	//Busca os dados para impressão Folha Acumulada - Sintetica
	cQuery := " SELECT RD_FILIAL, RD_CC, CTT_DESC01, RD_PD, RV_DESC, RD_TIPO1,CASE " 																				+ STR_PULA
	cQuery += "	WHEN RD_TIPO1 = 'V' THEN 'VALOR'  WHEN RD_TIPO1 = 'H' THEN 'HORAS' WHEN RD_TIPO1 = 'D' THEN 'DIAS' END AS VB_REF, " 		  						+ STR_PULA
	cQuery += "	RV_TIPOCOD, CASE WHEN RV_TIPOCOD = '1' THEN 'PROVENTO' WHEN RV_TIPOCOD = '2' THEN 'DESCONTO' WHEN RV_TIPOCOD = '3' THEN 'BASE (PROVENTO)' " 		+ STR_PULA
	cQuery += "	WHEN RV_TIPOCOD = '4' THEN 'BASE (DESCONTO)' END AS VB_TP, SUM(RD_VALOR) AS VALOR, RD_DATARQ  FROM "+RetSQLName('SRD')+" RD " 						+ STR_PULA
	cQuery += "	INNER JOIN "+RetSQLName('SRV')+" RV " 																												+ STR_PULA
	cQuery += "	ON RV.RV_FILIAL = SUBSTRING(RD.RD_FILIAL,1,2) " 																									+ STR_PULA
	cQuery += "	AND RV.RV_COD = RD.RD_PD " 																															+ STR_PULA
	cQuery += "	AND RV.D_E_L_E_T_ = '' " 																															+ STR_PULA
	cQuery += "	INNER JOIN "+RetSQLName('CTT')+" CTT " 																												+ STR_PULA
	cQuery += "	ON CTT.CTT_FILIAL = SUBSTRING(RD.RD_FILIAL,1,2) " 																									+ STR_PULA
	cQuery += "	AND CTT.CTT_CUSTO = RD.RD_CC " 																														+ STR_PULA
	cQuery += "	AND CTT.D_E_L_E_T_ = '' " 																															+ STR_PULA
	cQuery += "	INNER JOIN "+RetSQLName('SRA')+" RA " 																												+ STR_PULA
	cQuery += "	ON RA.RA_FILIAL = RD.RD_FILIAL " 																													+ STR_PULA
	cQuery += "	AND RA.RA_MAT = RD.RD_MAT " 																														+ STR_PULA
	cQuery += "	AND RA.D_E_L_E_T_ = ''	" 																															+ STR_PULA
	cQuery += "	INNER JOIN "+RetSQLName('SRJ')+" RJ " 																												+ STR_PULA
	cQuery += "	ON RJ.RJ_FILIAL = SUBSTRING(RA.RA_FILIAL,1,2) " 																									+ STR_PULA
	cQuery += "	AND RJ.RJ_FUNCAO = RA.RA_CODFUNC	" 																												+ STR_PULA
	cQuery += "	AND RJ.D_E_L_E_T_ = ''	"																															+ STR_PULA
	cQuery += "	WHERE RD.RD_DATARQ BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "' " 																				+ STR_PULA																										+ STR_PULA
	cQuery += "	AND RD.RD_FILIAL BETWEEN '" + MV_PAR03 + "' AND '" + MV_PAR04 + "' "  																				+ STR_PULA
	cQuery += "	AND RD.RD_MAT BETWEEN '" + MV_PAR05 + "' AND '" + MV_PAR06 + "' " 																					+ STR_PULA
	cQuery += "	AND RD.RD_CC BETWEEN '" + MV_PAR07 + "' AND '" + MV_PAR08 + "' " 																					+ STR_PULA
	cQuery += "	GROUP BY RD_FILIAL, RD_CC, CTT_DESC01, RD_PD, RV_DESC, RD_TIPO1, RV_TIPOCOD, RD_DATARQ" 															+ STR_PULA
	cQuery += " ORDER BY RD_FILIAL, RD_CC, RD_PD		" 																									+ STR_PULA                                                                                                         
	TCQuery cQuery New Alias "QPRO3"
     

    //Aba 01 - Tabela do Cadastro
    oFWMsExcel:AddworkSheet("FOLHA-ACUMULADA-RESUMO") //Não utilizar número junto com sinal de menos. Ex.: 1-
        //Criando a Tabela
        oFWMsExcel:AddTable("FOLHA-ACUMULADA-RESUMO","Resumo - Folha Acumulada")
        //Criando Colunas
        oFWMsExcel:AddColumn("FOLHA-ACUMULADA-RESUMO","Resumo - Folha Acumulada","Filial",1) 
		oFWMsExcel:AddColumn("FOLHA-ACUMULADA-RESUMO","Resumo - Folha Acumulada","Cod. C.Custo",1)
		oFWMsExcel:AddColumn("FOLHA-ACUMULADA-RESUMO","Resumo - Folha Acumulada","Des. C.Custo",1)
        oFWMsExcel:AddColumn("FOLHA-ACUMULADA-RESUMO","Resumo - Folha Acumulada","Cod. Verba°",1)
        oFWMsExcel:AddColumn("FOLHA-ACUMULADA-RESUMO","Resumo - Folha Acumulada","Desc. Verba",1)
        oFWMsExcel:AddColumn("FOLHA-ACUMULADA-RESUMO","Resumo - Folha Acumulada","Tipo Lanc",1)  
		oFWMsExcel:AddColumn("FOLHA-ACUMULADA-RESUMO","Resumo - Folha Acumulada","Tipo Verba",1)             
        oFWMsExcel:AddColumn("FOLHA-ACUMULADA-RESUMO","Resumo - Folha Acumulada","Valor",1)
        oFWMsExcel:AddColumn("FOLHA-ACUMULADA-RESUMO","Resumo - Folha Acumulada","Período",1)

        //Criando as Linhas
 		 While !(QPRO3->(EoF()))
            
            oFWMsExcel:AddRow("FOLHA-ACUMULADA-RESUMO","Resumo - Folha Acumulada",{;
																    QPRO3->RD_FILIAL,;
                                                                    QPRO3->RD_CC,;
																	QPRO3->CTT_DESC01,;
                                                                    QPRO3->RD_PD,;  
                                                                    QPRO3->RV_DESC,;   
                                                                    QPRO3->VB_REF,;  
                                                                    QPRO3->VB_TP,; 
                                                                    QPRO3->VALOR,; 
                                                                    QPRO3->RD_DATARQ;                                                                           
            })
            //Pulando Registro
            QPRO3->(DbSkip())
		EndDo
	//Fecha Query
	QPRO3->(DbCloseArea())
   
    //Ativando o arquivo e gerando o xml
    oFWMsExcel:Activate()
    oFWMsExcel:GetXMLFile(cArquivo)
         
    //Abrindo o excel e abrindo o arquivo xml
    oExcel := MsExcel():New()            	//Abre uma nova conexão com Excel
    oExcel:WorkBooks:Open(cArquivo)     	//Abre uma planilha
    oExcel:SetVisible(.T.)                 	//Visualiza a planilha
    oExcel:Destroy()                        //Encerra o processo do gerenciador de tarefas
     
    //Fecha Query
    RestArea(aArea)

	
Return


/*/{Protheus.doc} MMGPER08B
Rotina responsável por criar as perguntas do relatório no SX1 caso não existam.
@param		Nenhum
@return		Nenhum
@author 	André Luis Maximiano Longhini
@since 		02/05/2022
@version 	1.0
@Obs		02/05/2022 - MedMais - André Luis Maximiano Longhini - Construção inicial.

/*/
Static Function MMGPER08B()

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
	AADD(aRegs,{cPerg,"01","Período de?     ","","","mv_ch1","C",TamSx3("RCF_PER")[1],0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","RCH"})
	AADD(aRegs,{cPerg,"02","Período até?    ","","","mv_ch2","C",TamSx3("RCF_PER")[1],0,0,"G","NaoVazio","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","RCH"})
	AADD(aRegs,{cPerg,"03","Filial de?     ","","","mv_ch3","C",4,0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","SM0"})
	AADD(aRegs,{cPerg,"04","Filial até?    ","","","mv_ch4","C",4,0,0,"G","NaoVazio","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","SM0"})
	AADD(aRegs,{cPerg,"05","Matrícula de?   ","","","mv_ch5","C",TamSx3("RA_MAT")[1],0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","","SRA"})
	AADD(aRegs,{cPerg,"06","Matrícula até?   ","","","mv_ch6","C",TamSx3("RA_MAT")[1],0,0,"G","NaoVazio","mv_par06","","","","","","","","","","","","","","","","","","","","","","","","","SRA"})
	AADD(aRegs,{cPerg,"07","Centro de Custo de?   ","","","mv_ch7","C",TamSx3("RA_CC")[1],0,0,"G","","mv_par07","","","","","","","","","","","","","","","","","","","","","","","","","CTT"})
	AADD(aRegs,{cPerg,"08","Centro de Custo até?   ","","","mv_ch8","C",TamSx3("RA_CC")[1],0,0,"G","NaoVazio","mv_par08","","","","","","","","","","","","","","","","","","","","","","","","","CTT"})

    
	//Adiciona o conteúdo dos helps no array.
	AADD(aHelpPor, "Informe o Período inicial - Ex.: 202201.")
	AADD(aHelpPor, "Informe o Período final - Ex.: 202202.")
	AADD(aHelpPor, "Informe a Filial inicial.")
	AADD(aHelpPor, "Informe a Filial final.")
	AADD(aHelpPor, "Informe a Matrícula inicial.")
	AADD(aHelpPor, "Informe a Matrícula final.")
	AADD(aHelpPor, "Informe o Centro de Custo inicial.")
	AADD(aHelpPor, "Informe o Centro de Custo final.")

	

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
			MMGPER08C(cChaveHelp, aHelpPor[i], .T.)
		EndIf

	Next

Return


/*/{Protheus.doc} MMGPER08C
Rotina responsável por criar o HELP das perguntas do relatório no arquivo "SIGAHLP.HLP".
@param		Parâmetros: cKey : Chave da Pergunta
cHelp: Texto do Help
lUpdate: Indica se deve atualizar o help
@return		Nenhum
@author 	André Luis Maximiano Longhini
@since 		02/05/2022
@version 	1.0
@Obs		02/05/2022 - MedMais - André Luis Maximiano Longhini - Construção inicial.

/*/

Static Function MMGPER08C(cKey, cHelp, lUpdate)

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
