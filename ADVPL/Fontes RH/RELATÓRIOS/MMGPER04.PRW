#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"

//Constantes
#Define STR_PULA    Chr(13)+Chr(10)

/*/{Protheus.doc} MMGPER04
Rotina que gera o relatório de conferência do benefício
@param		Nenhum
@return		Nenhum
@author 	André Luis Maximiano Longhini	
@since 		24/11/2021
@version 	1.0
@Obs		24/11/2021 - MedMais - André Luis Maximiano Longhini - Construção inicial.

/*/

User Function MMGPER04()

	Local _aArea	:= GetArea()

	Private cPerg := "MMGPER04"

	//Cria as perguntas do relatório, caso não existam.
	MMGPER04B()

	// Ativa o grupo de perguntas
	If !Pergunte(cPerg,.T.)
		Return
	EndIf

	//Chama a função de geração do relatório em Excel.
	msAguarde( { || MMGPER04A() }, "Aguarde", "Gerando o relatório...")
	
	//Retorna o ambiente anterior.
	RestArea(_aArea)

Return()


/*/{Protheus.doc} MMGPER04A
Rotina responsável por gerar o relatório em Excel.
@param		Nenhum
@return		Nenhum
@author 	André Luis Maximiano Longhini
@since 		24/11/2021
@version 	1.0
@Obs		24/11/2021 - MedMais - André Luis Maximiano Longhini - Construção inicial.

/*/
Static Function MMGPER04A()

  	Local cQuery        := ""
    Local oFWMsExcel
    Local oExcel
	Local aArea			:= GetArea()
    Local dtHora        := FWTimeStamp(1,DATE(),TIME())
    Local cArquivo   	:= GetTempPath()+'CONFBEN'+''+dtHora+''+'.xml'
    
 
    //Busca os dados do calendário
    cQuery := " SELECT "                                                    						+ STR_PULA
    cQuery += "     RCF.RCF_FILIAL, "                                       						+ STR_PULA
    cQuery += "     RCF.RCF_PER, "                                        							+ STR_PULA
    cQuery += "     RCF.RCF_PROCES, "                                      							+ STR_PULA
    cQuery += "     RCF.RCF_TNOTRA, "                                      							+ STR_PULA
    cQuery += "     SR6.R6_DESC, "                                      							+ STR_PULA	
    cQuery += "     RCF.RCF_DUTILT, "                                      							+ STR_PULA
	cQuery += "     RCF.RCF_DALIM, "                                      							+ STR_PULA
    cQuery += "     RCF.RCF_DREFEI "                                      							+ STR_PULA
    cQuery += " FROM "                                                    							+ STR_PULA
    cQuery += "     "+RetSQLName('RCF')+" RCF "                            							+ STR_PULA
	cQuery += "     LEFT JOIN "+RetSQLName('SR6')+" SR6 ON ( "        								+ STR_PULA
    cQuery += "         RCF.RCF_FILIAL = SR6.R6_FILIAL  " 			       					        + STR_PULA
    cQuery += "         AND RCF.RCF_TNOTRA = SR6.R6_TURNO "                    						+ STR_PULA
    cQuery += "         AND SR6.D_E_L_E_T_='' "                            							+ STR_PULA
    cQuery += "     ) "                                                        						+ STR_PULA
    cQuery += " WHERE "                                                    							+ STR_PULA
    cQuery += "     RCF.RCF_FILIAL BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "' "            	+ STR_PULA
    cQuery += " 	AND RCF.RCF_PROCES =	 '" + MV_PAR03 + "' "            						+ STR_PULA	
	cQuery += " 	AND RCF.RCF_PER BETWEEN '" + MV_PAR04 + "' AND '" + MV_PAR05 + "' "  			+ STR_PULA
	cQuery += " 	AND RCF.RCF_TNOTRA BETWEEN '" + MV_PAR06 + "' AND '" + MV_PAR07 + "' "  		+ STR_PULA
    cQuery += "     AND RCF.D_E_L_E_T_ = '' "                            							+ STR_PULA
    cQuery += " ORDER BY "                                                							+ STR_PULA
    cQuery += "     RCF.RCF_FILIAL, RCF.RCF_PER,RCF.RCF_PROCES,RCF.RCF_TNOTRA "						+ STR_PULA
    TCQuery cQuery New Alias "CALEND"
     
    //Criando o objeto que irá gerar o conteúdo do Excel
    oFWMsExcel := FWMSExcel():New()
     
    //Aba 01 - Tabela do Calendário
    oFWMsExcel:AddworkSheet("Calendario") //Não utilizar número junto com sinal de menos. Ex.: 1-
        //Criando a Tabela
        oFWMsExcel:AddTable("Calendario","Conferéncia Benefício - Calendário")
        //Criando Colunas
        oFWMsExcel:AddColumn("Calendario","Conferéncia Benefício - Calendário","Filial",1) 
        oFWMsExcel:AddColumn("Calendario","Conferéncia Benefício - Calendário","Período",1) 
        oFWMsExcel:AddColumn("Calendario","Conferéncia Benefício - Calendário","Processo",1) 
        oFWMsExcel:AddColumn("Calendario","Conferéncia Benefício - Calendário","Cód. Turno",1)
		oFWMsExcel:AddColumn("Calendario","Conferéncia Benefício - Calendário","Descrição do Turno",1)
		oFWMsExcel:AddColumn("Calendario","Conferéncia Benefício - Calendário","Quantidade VTR Previsto",1)
		oFWMsExcel:AddColumn("Calendario","Conferéncia Benefício - Calendário","Quantidade VAL Previsto",1)
		oFWMsExcel:AddColumn("Calendario","Conferéncia Benefício - Calendário","Quantidade VRF Previsto",1)
        //Criando as Linhas
 		 While !(CALEND->(EoF()))
            oFWMsExcel:AddRow("Calendario","Conferéncia Benefício - Calendário",{;
																    CALEND->RCF_FILIAL,;
                                                                    CALEND->RCF_PER,;
                                                                    CALEND->RCF_PROCES,;
                                                                    CALEND->RCF_TNOTRA,;
                                                                    Iif(CALEND->RCF_TNOTRA == '@@@','Calendário Padrão do Sistema',CALEND->R6_DESC),;
                                                                    CALEND->RCF_DUTILT,;
																	CALEND->RCF_DALIM,;
																	CALEND->RCF_DREFEI;
			})
         
            //Pulando Registro
            CALEND->(DbSkip())
		EndDo

	//Fecha Query
    CALEND->(DbCloseArea())

    if MV_PAR01 == '01'
        MV_PAR01 := MV_PAR01 + '' + '01'
    ELSEIF MV_PAR01 == '02'
        MV_PAR01 := MV_PAR01 + '' + '01'
    ELSEIF MV_PAR01 == '04'
        MV_PAR01 := MV_PAR01 + '' + '01'
    endif

    if MV_PAR02 == '01'
        MV_PAR02 := MV_PAR02 + '' + '01'
    ELSEIF MV_PAR02 == '02'
        MV_PAR02 := MV_PAR02 + '' + '01'
    ELSEIF MV_PAR02 == '04'
        MV_PAR02 := MV_PAR02 + '' + '01'
    ELSEIF MV_PAR02 == '99'
        MV_PAR02 := MV_PAR02 + '' + '99'
    ENDIF


    //Busca os dados do VTR
    cQuery := " SELECT "                                                    						+ STR_PULA
    cQuery += "     SR0.R0_FILIAL, " 	                                      						+ STR_PULA
    cQuery += "     SR0.R0_MAT, "         	                               							+ STR_PULA
    cQuery += "     SRA.RA_NOMECMP, "         	                               						+ STR_PULA
    cQuery += "     SRA.RA_HRSMES, "         	                               						+ STR_PULA 
    cQuery += "     SRA.RA_TNOTRAB, "         	                               						+ STR_PULA
    cQuery += "     SR6.R6_DESC, "         	                               						    + STR_PULA
    cQuery += "     CASE "         	                               						            + STR_PULA   
    cQuery += "     wHEN RA_SITFOLH = '' THEN 'ATIVO' "         	                                + STR_PULA 
    cQuery += "     wHEN RA_SITFOLH = 'A' THEN 'AFASTADO' "      	                                + STR_PULA 
    cQuery += "     wHEN RA_SITFOLH = 'D' THEN 'DEMITIDO' "         	                            + STR_PULA 
    cQuery += "     wHEN RA_SITFOLH = 'F' THEN 'FERIAS' "         	                                + STR_PULA  
    cQuery += "     END AS SITUACAO, "         	                                                    + STR_PULA  
    cQuery += "     CASE "         	                               						            + STR_PULA   
    cQuery += "     wHEN RA_CATFUNC = 'H' THEN 'HORISTA' "         	                                + STR_PULA 
    cQuery += "     wHEN RA_CATFUNC = 'A' THEN 'AUTONOMO' "         	                            + STR_PULA
    cQuery += "     wHEN RA_CATFUNC = 'M' THEN 'MENSALISTA' "         	                            + STR_PULA
    cQuery += "     wHEN RA_CATFUNC = 'P' THEN 'PRO-LABORE' "      	                                + STR_PULA 
    cQuery += "     wHEN RA_CATFUNC = 'S' THEN 'SEMANALISTA' "         	                            + STR_PULA 
    cQuery += "     wHEN RA_CATFUNC = 'T' THEN 'TAREFEIRO' "         	                            + STR_PULA  
    cQuery += "     END AS CATEGORIA, "         	                                                + STR_PULA 
    cQuery += "     SRA.RA_CC, "         	                               							+ STR_PULA
    cQuery += "     CTT.CTT_DESC01, "         	                               						+ STR_PULA 
    cQuery += "     SR0.R0_TPVALE, "                                      							+ STR_PULA
    cQuery += "     SR0.R0_CODIGO, "                                      							+ STR_PULA
	cQuery += "     SRN.RN_DESC, "                                      							+ STR_PULA
	cQuery += "     SR0.R0_PERIOD, "                                      							+ STR_PULA	
    cQuery += "     SR0.R0_QDIACAL, "                                      							+ STR_PULA	
    cQuery += "     SR0.R0_VALCAL, "                                      							+ STR_PULA
	cQuery += "     SR0.R0_VLRVALE, "                                      							+ STR_PULA
    cQuery += "     SR0.R0_VLRFUNC, "                                      							+ STR_PULA
	cQuery += "     SR0.R0_VLREMP "                                      							+ STR_PULA
    cQuery += " FROM "                                                    							+ STR_PULA
    cQuery += "     "+RetSQLName('SR0')+" SR0 "                            							+ STR_PULA
	cQuery += "     INNER JOIN "+RetSQLName('SRN')+" SRN ON ( "        								+ STR_PULA
    cQuery += "         SRN.RN_FILIAL = SUBSTRING(SR0.R0_FILIAL,1,2)  " 	      					+ STR_PULA
    cQuery += "         AND SRN.RN_COD = SR0.R0_CODIGO "                    						+ STR_PULA
    cQuery += "         AND SRN.D_E_L_E_T_='' "                            							+ STR_PULA
    cQuery += "     ) "                                                        						+ STR_PULA
    cQuery += "     INNER JOIN "+RetSQLName('SRA')+" SRA ON ( "        							    + STR_PULA
    cQuery += "         SRA.RA_FILIAL = SR0.R0_FILIAL  " 	      					                + STR_PULA
    cQuery += "         AND SRA.RA_MAT = SR0.R0_MAT "                    				    		+ STR_PULA
    cQuery += "         AND SRA.D_E_L_E_T_='' "                            							+ STR_PULA
    cQuery += "     ) "                                                        						+ STR_PULA
    cQuery += "     INNER JOIN "+RetSQLName('SR6')+" SR6 ON ( "        							    + STR_PULA
    cQuery += "         SR6.R6_FILIAL = SUBSTRING(SRA.RA_FILIAL,1,2)  "     		                + STR_PULA
    cQuery += "         AND SR6.R6_TURNO = SRA.RA_TNOTRAB "                    			    		+ STR_PULA
    cQuery += "         AND SR6.D_E_L_E_T_='' "                            							+ STR_PULA
    cQuery += "     ) "                                                        						+ STR_PULA
    cQuery += "     INNER JOIN "+RetSQLName('CTT')+" CTT ON ( "        							    + STR_PULA
    cQuery += "         CTT.CTT_FILIAL = SUBSTRING(SRA.RA_FILIAL,1,2)  "     		                + STR_PULA
    cQuery += "         AND CTT.CTT_CUSTO = SRA.RA_CC "                    			    	    	+ STR_PULA
    cQuery += "         AND CTT.D_E_L_E_T_='' "                            							+ STR_PULA
    cQuery += "     ) "                                                        						+ STR_PULA
    cQuery += " WHERE "                                                    							+ STR_PULA
    cQuery += "     SR0.R0_FILIAL BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "' "            	+ STR_PULA
    cQuery += " 	AND SR0.R0_TPVALE =	 '0' "            											+ STR_PULA	
	cQuery += "     AND SR0.R0_PERIOD BETWEEN '" + MV_PAR04 + "' AND '" + MV_PAR05 + "' "   	    + STR_PULA
	cQuery += " 	AND SR0.R0_CC BETWEEN '" + MV_PAR08 + "' AND '" + MV_PAR09 + "' "  				+ STR_PULA
    cQuery += "     AND SR0.D_E_L_E_T_ = '' "                            							+ STR_PULA
    cQuery += " ORDER BY "                                                							+ STR_PULA
    cQuery += "     SR0.R0_FILIAL, SR0.R0_MAT, SR0.R0_PERIOD, SR0.R0_CODIGO "						+ STR_PULA
    TCQuery cQuery New Alias "CALCVT"

    //Aba 02 - Dados do Cálculo VTR
    oFWMsExcel:AddworkSheet("VTR")
        //Criando a Tabela
        oFWMsExcel:AddTable("VTR","Cálculo - Vale Transporte")
        oFWMsExcel:AddColumn("VTR","Cálculo - Vale Transporte","Filial",1)
        oFWMsExcel:AddColumn("VTR","Cálculo - Vale Transporte","Matrícula",1)
        oFWMsExcel:AddColumn("VTR","Cálculo - Vale Transporte","Colaborador",1)
        oFWMsExcel:AddColumn("VTR","Cálculo - Vale Transporte","Horas Mensais",1)
        oFWMsExcel:AddColumn("VTR","Cálculo - Vale Transporte","Categoria",1)
        oFWMsExcel:AddColumn("VTR","Cálculo - Vale Transporte","Situação",1)
        oFWMsExcel:AddColumn("VTR","Cálculo - Vale Transporte","Cód. Turno",1)
        oFWMsExcel:AddColumn("VTR","Cálculo - Vale Transporte","Descrição Turno",1)
        oFWMsExcel:AddColumn("VTR","Cálculo - Vale Transporte","Centro de Custo",1)
        oFWMsExcel:AddColumn("VTR","Cálculo - Vale Transporte","Descrição C.Custo",1)
        oFWMsExcel:AddColumn("VTR","Cálculo - Vale Transporte","Codigo do Benefício",1)
        oFWMsExcel:AddColumn("VTR","Cálculo - Vale Transporte","Descrição do Benefício",1)
        oFWMsExcel:AddColumn("VTR","Cálculo - Vale Transporte","Período de Cálculo",1)
        oFWMsExcel:AddColumn("VTR","Cálculo - Vale Transporte","Qt. Dias Calculado",1)
        oFWMsExcel:AddColumn("VTR","Cálculo - Vale Transporte","Valor Cálculado",1)
        oFWMsExcel:AddColumn("VTR","Cálculo - Vale Transporte","Valor Unitário",1)
        oFWMsExcel:AddColumn("VTR","Cálculo - Vale Transporte","Valor Desconto Funcionário",1)
        oFWMsExcel:AddColumn("VTR","Cálculo - Vale Transporte","Valor Parte Empresa",1)


        //Criando as Linhas... Enquanto não for fim da query
        While !(CALCVT->(EoF()))
            oFWMsExcel:AddRow("VTR","Cálculo - Vale Transporte",{;
                                                                    CALCVT->R0_FILIAL,;
                                                                    CALCVT->R0_MAT,;
                                                                    CALCVT->RA_NOMECMP,;
                                                                    CALCVT->RA_HRSMES,;
                                                                    CALCVT->CATEGORIA,;
                                                                    CALCVT->SITUACAO,;
                                                                    CALCVT->RA_TNOTRAB,;
                                                                    CALCVT->R6_DESC,;
                                                                    CALCVT->RA_CC,;
                                                                    CALCVT->CTT_DESC01,;
                                                                    CALCVT->R0_CODIGO,;
                                                                    CALCVT->RN_DESC,;
                                                                    CALCVT->R0_PERIOD,;
                                                                    CALCVT->R0_QDIACAL,;																
                                                                    CALCVT->R0_VALCAL,;
                                                                    CALCVT->R0_VLRVALE,;
                                                                    CALCVT->R0_VLRFUNC,;
                                                                    CALCVT->R0_VLREMP;
            })
         
            //Pulando Registro
            CALCVT->(DbSkip())
        EndDo

    //Fecha Query
	CALCVT->(DbCloseArea())	


    //Busca os dados do VAL
    cQuery := " SELECT "                                                    						+ STR_PULA
    cQuery += "     SR0.R0_FILIAL, " 	                                      						+ STR_PULA
    cQuery += "     SR0.R0_MAT, "         	                               							+ STR_PULA
    cQuery += "     SRA.RA_NOMECMP, "         	                               						+ STR_PULA
    cQuery += "     SRA.RA_HRSMES, "         	                               						+ STR_PULA 
    cQuery += "     SRA.RA_TNOTRAB, "         	                               						+ STR_PULA
    cQuery += "     SR6.R6_DESC, "         	                               						    + STR_PULA
    cQuery += "     CASE "         	                               						            + STR_PULA   
    cQuery += "     wHEN RA_SITFOLH = '' THEN 'ATIVO' "         	                                + STR_PULA 
    cQuery += "     wHEN RA_SITFOLH = 'A' THEN 'AFASTADO' "      	                                + STR_PULA 
    cQuery += "     wHEN RA_SITFOLH = 'D' THEN 'DEMITIDO' "         	                            + STR_PULA 
    cQuery += "     wHEN RA_SITFOLH = 'F' THEN 'FERIAS' "         	                                + STR_PULA  
    cQuery += "     END AS SITUACAO, "         	                                                    + STR_PULA  
    cQuery += "     CASE "         	                               						            + STR_PULA   
    cQuery += "     wHEN RA_CATFUNC = 'H' THEN 'HORISTA' "         	                                + STR_PULA 
    cQuery += "     wHEN RA_CATFUNC = 'A' THEN 'AUTONOMO' "         	                            + STR_PULA
    cQuery += "     wHEN RA_CATFUNC = 'M' THEN 'MENSALISTA' "         	                            + STR_PULA
    cQuery += "     wHEN RA_CATFUNC = 'P' THEN 'PRO-LABORE' "      	                                + STR_PULA 
    cQuery += "     wHEN RA_CATFUNC = 'S' THEN 'SEMANALISTA' "         	                            + STR_PULA 
    cQuery += "     wHEN RA_CATFUNC = 'T' THEN 'TAREFEIRO' "         	                            + STR_PULA  
    cQuery += "     END AS CATEGORIA, "         	                                                + STR_PULA 
    cQuery += "     SRA.RA_CC, "         	                               							+ STR_PULA
    cQuery += "     CTT.CTT_DESC01, "         	                               						+ STR_PULA 
    cQuery += "     SR0.R0_TPVALE, "                                      							+ STR_PULA
    cQuery += "     SR0.R0_CODIGO, "                                      							+ STR_PULA
	cQuery += "     RFO.RFO_DESCR, "                                      							+ STR_PULA
	cQuery += "     SR0.R0_PERIOD, "                                      							+ STR_PULA	
    cQuery += "     SR0.R0_QDIACAL, "                                      							+ STR_PULA	
    cQuery += "     SR0.R0_VALCAL, "                                      							+ STR_PULA
	cQuery += "     SR0.R0_VLRVALE, "                                      							+ STR_PULA
    cQuery += "     SR0.R0_VLRFUNC, "                                      							+ STR_PULA
	cQuery += "     SR0.R0_VLREMP "                                      							+ STR_PULA
    cQuery += " FROM "                                                    							+ STR_PULA
    cQuery += "     "+RetSQLName('SR0')+" SR0 "                            							+ STR_PULA
	cQuery += "     INNER JOIN "+RetSQLName('RFO')+" RFO ON ( "        								+ STR_PULA
    cQuery += "         RFO.RFO_FILIAL = SUBSTRING(SR0.R0_FILIAL,1,2) "	       		   				+ STR_PULA
    cQuery += "         AND RFO.RFO_CODIGO = SR0.R0_CODIGO "                    					+ STR_PULA
	cQuery += "         AND RFO.RFO_TPVALE = '2' "                    								+ STR_PULA
    cQuery += "         AND RFO.D_E_L_E_T_='' "                            							+ STR_PULA
    cQuery += "     ) "                                                        						+ STR_PULA
    cQuery += "     INNER JOIN "+RetSQLName('SRA')+" SRA ON ( "        							    + STR_PULA
    cQuery += "         SRA.RA_FILIAL = SR0.R0_FILIAL  " 	      					                + STR_PULA
    cQuery += "         AND SRA.RA_MAT = SR0.R0_MAT "                    				    		+ STR_PULA
    cQuery += "         AND SRA.D_E_L_E_T_='' "                            							+ STR_PULA
    cQuery += "     ) "                                                        						+ STR_PULA
    cQuery += "     INNER JOIN "+RetSQLName('SR6')+" SR6 ON ( "        							    + STR_PULA
    cQuery += "         SR6.R6_FILIAL = SUBSTRING(SRA.RA_FILIAL,1,2)  "     		                + STR_PULA
    cQuery += "         AND SR6.R6_TURNO = SRA.RA_TNOTRAB "                    			    		+ STR_PULA
    cQuery += "         AND SR6.D_E_L_E_T_='' "                            							+ STR_PULA
    cQuery += "     ) "                                                        						+ STR_PULA
    cQuery += "     INNER JOIN "+RetSQLName('CTT')+" CTT ON ( "        							    + STR_PULA
    cQuery += "         CTT.CTT_FILIAL = SUBSTRING(SRA.RA_FILIAL,1,2)  "     		                + STR_PULA
    cQuery += "         AND CTT.CTT_CUSTO = SRA.RA_CC "                    			    	    	+ STR_PULA
    cQuery += "         AND CTT.D_E_L_E_T_='' "                            							+ STR_PULA
    cQuery += "     ) "                                                        						+ STR_PULA
    cQuery += " WHERE "                                                    							+ STR_PULA
    cQuery += "     SR0.R0_FILIAL BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "' "            	+ STR_PULA
    cQuery += " 	AND SR0.R0_TPVALE =	 '2' "            											+ STR_PULA	
	cQuery += "     AND SR0.R0_PERIOD BETWEEN '" + MV_PAR04 + "' AND '" + MV_PAR05 + "' "   	    + STR_PULA
	cQuery += " 	AND SR0.R0_CC BETWEEN '" + MV_PAR08 + "' AND '" + MV_PAR09 + "' "  				+ STR_PULA
    cQuery += "     AND SR0.D_E_L_E_T_ = '' "                            							+ STR_PULA
    cQuery += " ORDER BY "                                                							+ STR_PULA
    cQuery += "     SR0.R0_FILIAL, SR0.R0_MAT, SR0.R0_PERIOD, SR0.R0_CODIGO "						+ STR_PULA
    TCQuery cQuery New Alias "CALCVA"

    //Aba 03 - Dados do Cálculo VAL
    oFWMsExcel:AddworkSheet("VAL")
        //Criando a Tabela
        oFWMsExcel:AddTable("VAL","Cálculo - Vale Alimentação")
        oFWMsExcel:AddColumn("VAL","Cálculo - Vale Alimentação","Filial",1)
        oFWMsExcel:AddColumn("VAL","Cálculo - Vale Alimentação","Matrícula",1)
        oFWMsExcel:AddColumn("VAL","Cálculo - Vale Alimentação","Colaborador",1)
        oFWMsExcel:AddColumn("VAL","Cálculo - Vale Alimentação","Horas Mensais",1)
        oFWMsExcel:AddColumn("VAL","Cálculo - Vale Alimentação","Categoria",1)
        oFWMsExcel:AddColumn("VAL","Cálculo - Vale Alimentação","Situação",1)
        oFWMsExcel:AddColumn("VAL","Cálculo - Vale Alimentação","Cód. Turno",1)
        oFWMsExcel:AddColumn("VAL","Cálculo - Vale Alimentação","Descrição Turno",1)
        oFWMsExcel:AddColumn("VAL","Cálculo - Vale Alimentação","Centro de Custo",1)
        oFWMsExcel:AddColumn("VAL","Cálculo - Vale Alimentação","Descrição C.Custo",1)
        oFWMsExcel:AddColumn("VAL","Cálculo - Vale Alimentação","Codigo do Benefício",1)
        oFWMsExcel:AddColumn("VAL","Cálculo - Vale Alimentação","Descrição do Benefício",1)
        oFWMsExcel:AddColumn("VAL","Cálculo - Vale Alimentação","Período de Cálculo",1)
        oFWMsExcel:AddColumn("VAL","Cálculo - Vale Alimentação","Qt. Dias Calculado",1)
        oFWMsExcel:AddColumn("VAL","Cálculo - Vale Alimentação","Valor Cálculado",1)
        oFWMsExcel:AddColumn("VAL","Cálculo - Vale Alimentação","Valor Unitário",1)
        oFWMsExcel:AddColumn("VAL","Cálculo - Vale Alimentação","Valor Desconto Funcionário",1)
        oFWMsExcel:AddColumn("VAL","Cálculo - Vale Alimentação","Valor Parte Empresa",1)


        //Criando as Linhas... Enquanto não for fim da query
        While !(CALCVA->(EoF()))
            oFWMsExcel:AddRow("VAL","Cálculo - Vale Alimentação",{;
                                                                    CALCVA->R0_FILIAL,;
                                                                    CALCVA->R0_MAT,;
                                                                    CALCVA->RA_NOMECMP,;
                                                                    CALCVA->RA_HRSMES,;
                                                                    CALCVA->CATEGORIA,;
                                                                    CALCVA->SITUACAO,;
                                                                    CALCVA->RA_TNOTRAB,;
                                                                    CALCVA->R6_DESC,;
                                                                    CALCVA->RA_CC,;
                                                                    CALCVA->CTT_DESC01,;
                                                                    CALCVA->R0_CODIGO,;
                                                                    CALCVA->RFO_DESCR,;
                                                                    CALCVA->R0_PERIOD,;
                                                                    CALCVA->R0_QDIACAL,;																
                                                                    CALCVA->R0_VALCAL,;
                                                                    CALCVA->R0_VLRVALE,;
                                                                    CALCVA->R0_VLRFUNC,;
                                                                    CALCVA->R0_VLREMP;
            })
         
            //Pulando Registro
            CALCVA->(DbSkip())
        EndDo
		
    //Fecha Query
	CALCVA->(DbCloseArea())	

 
    //Busca os dados do VRF
    cQuery := " SELECT "                                                    						+ STR_PULA
    cQuery += "     SR0.R0_FILIAL, " 	                                      						+ STR_PULA
    cQuery += "     SR0.R0_MAT, "         	                               							+ STR_PULA
    cQuery += "     SRA.RA_NOMECMP, "         	                               						+ STR_PULA
    cQuery += "     SRA.RA_HRSMES, "         	                               						+ STR_PULA 
    cQuery += "     SRA.RA_TNOTRAB, "         	                               						+ STR_PULA
    cQuery += "     SR6.R6_DESC, "         	                               						    + STR_PULA
    cQuery += "     CASE "         	                               						            + STR_PULA   
    cQuery += "     wHEN RA_SITFOLH = '' THEN 'ATIVO' "         	                                + STR_PULA 
    cQuery += "     wHEN RA_SITFOLH = 'A' THEN 'AFASTADO' "      	                                + STR_PULA 
    cQuery += "     wHEN RA_SITFOLH = 'D' THEN 'DEMITIDO' "         	                            + STR_PULA 
    cQuery += "     wHEN RA_SITFOLH = 'F' THEN 'FERIAS' "         	                                + STR_PULA  
    cQuery += "     END AS SITUACAO, "         	                                                    + STR_PULA  
    cQuery += "     CASE "         	                               						            + STR_PULA   
    cQuery += "     wHEN RA_CATFUNC = 'H' THEN 'HORISTA' "         	                                + STR_PULA 
    cQuery += "     wHEN RA_CATFUNC = 'A' THEN 'AUTONOMO' "         	                            + STR_PULA
    cQuery += "     wHEN RA_CATFUNC = 'M' THEN 'MENSALISTA' "         	                            + STR_PULA
    cQuery += "     wHEN RA_CATFUNC = 'P' THEN 'PRO-LABORE' "      	                                + STR_PULA 
    cQuery += "     wHEN RA_CATFUNC = 'S' THEN 'SEMANALISTA' "         	                            + STR_PULA 
    cQuery += "     wHEN RA_CATFUNC = 'T' THEN 'TAREFEIRO' "         	                            + STR_PULA  
    cQuery += "     END AS CATEGORIA, "         	                                                + STR_PULA     
    cQuery += "     SRA.RA_CC, "         	                               							+ STR_PULA
    cQuery += "     CTT.CTT_DESC01, "         	                               						+ STR_PULA 
    cQuery += "     SR0.R0_TPVALE, "                                      							+ STR_PULA
    cQuery += "     SR0.R0_CODIGO, "                                      							+ STR_PULA
	cQuery += "     RFO.RFO_DESCR, "                                      							+ STR_PULA
	cQuery += "     SR0.R0_PERIOD, "                                      							+ STR_PULA	
    cQuery += "     SR0.R0_QDIACAL, "                                      							+ STR_PULA	
    cQuery += "     SR0.R0_VALCAL, "                                      							+ STR_PULA
	cQuery += "     SR0.R0_VLRVALE, "                                      							+ STR_PULA
    cQuery += "     SR0.R0_VLRFUNC, "                                      							+ STR_PULA
	cQuery += "     SR0.R0_VLREMP "                                      							+ STR_PULA
    cQuery += " FROM "                                                    							+ STR_PULA
    cQuery += "     "+RetSQLName('SR0')+" SR0 "                            							+ STR_PULA
	cQuery += "     INNER JOIN "+RetSQLName('RFO')+" RFO ON ( "        								+ STR_PULA
    cQuery += "         RFO.RFO_FILIAL = SUBSTRING(SR0.R0_FILIAL,1,2)"	     	    				+ STR_PULA
    cQuery += "         AND RFO.RFO_CODIGO = SR0.R0_CODIGO "                    					+ STR_PULA
	cQuery += "         AND RFO.RFO_TPVALE = '1' "                    								+ STR_PULA
    cQuery += "         AND RFO.D_E_L_E_T_='' "                            							+ STR_PULA
    cQuery += "     ) "                                                        						+ STR_PULA
    cQuery += "     INNER JOIN "+RetSQLName('SRA')+" SRA ON ( "        							    + STR_PULA
    cQuery += "         SRA.RA_FILIAL = SR0.R0_FILIAL  " 	      					                + STR_PULA
    cQuery += "         AND SRA.RA_MAT = SR0.R0_MAT "                    				    		+ STR_PULA
    cQuery += "         AND SRA.D_E_L_E_T_='' "                            							+ STR_PULA
    cQuery += "     ) "                                                        						+ STR_PULA
    cQuery += "     INNER JOIN "+RetSQLName('SR6')+" SR6 ON ( "        							    + STR_PULA
    cQuery += "         SR6.R6_FILIAL = SUBSTRING(SRA.RA_FILIAL,1,2)  "     		                + STR_PULA
    cQuery += "         AND SR6.R6_TURNO = SRA.RA_TNOTRAB "                    			    		+ STR_PULA
    cQuery += "         AND SR6.D_E_L_E_T_='' "                            							+ STR_PULA
    cQuery += "     ) "                                                        						+ STR_PULA
    cQuery += "     INNER JOIN "+RetSQLName('CTT')+" CTT ON ( "        							    + STR_PULA
    cQuery += "         CTT.CTT_FILIAL = SUBSTRING(SRA.RA_FILIAL,1,2)  "     		                + STR_PULA
    cQuery += "         AND CTT.CTT_CUSTO = SRA.RA_CC "                    			    	    	+ STR_PULA
    cQuery += "         AND CTT.D_E_L_E_T_='' "                            							+ STR_PULA
    cQuery += "     ) "                                                        						+ STR_PULA
    cQuery += " WHERE "                                                    							+ STR_PULA
    cQuery += "     SR0.R0_FILIAL BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "' "            	+ STR_PULA
    cQuery += " 	AND SR0.R0_TPVALE =	 '1' "            											+ STR_PULA	
	cQuery += "     AND SR0.R0_PERIOD BETWEEN '" + MV_PAR04 + "' AND '" + MV_PAR05 + "' "   	    + STR_PULA
	cQuery += " 	AND SR0.R0_CC BETWEEN '" + MV_PAR08 + "' AND '" + MV_PAR09 + "' "  				+ STR_PULA
    cQuery += "     AND SR0.D_E_L_E_T_ = '' "                            							+ STR_PULA
    cQuery += " ORDER BY "                                                							+ STR_PULA
    cQuery += "     SR0.R0_FILIAL, SR0.R0_MAT, SR0.R0_PERIOD, SR0.R0_CODIGO "						+ STR_PULA
    TCQuery cQuery New Alias "CALCVR"

    //Aba 04 - Dados do Cálculo VRF
    oFWMsExcel:AddworkSheet("VRF")
        //Criando a Tabela
        oFWMsExcel:AddTable("VRF","Cálculo - Vale Refeição")
        oFWMsExcel:AddColumn("VRF","Cálculo - Vale Refeição","Filial",1)
        oFWMsExcel:AddColumn("VRF","Cálculo - Vale Refeição","Matrícula",1)
        oFWMsExcel:AddColumn("VRF","Cálculo - Vale Refeição","Colaborador",1)
        oFWMsExcel:AddColumn("VRF","Cálculo - Vale Refeição","Horas Mensais",1)
        oFWMsExcel:AddColumn("VRF","Cálculo - Vale Refeição","Categoria",1)
        oFWMsExcel:AddColumn("VRF","Cálculo - Vale Refeição","Situação",1)
        oFWMsExcel:AddColumn("VRF","Cálculo - Vale Refeição","Cód. Turno",1)
        oFWMsExcel:AddColumn("VRF","Cálculo - Vale Refeição","Descrição Turno",1)
        oFWMsExcel:AddColumn("VRF","Cálculo - Vale Refeição","Centro de Custo",1)
        oFWMsExcel:AddColumn("VRF","Cálculo - Vale Refeição","Descrição C.Custo",1)
        oFWMsExcel:AddColumn("VRF","Cálculo - Vale Refeição","Codigo do Benefício",1)
        oFWMsExcel:AddColumn("VRF","Cálculo - Vale Refeição","Descrição do Benefício",1)
        oFWMsExcel:AddColumn("VRF","Cálculo - Vale Refeição","Período de Cálculo",1)
        oFWMsExcel:AddColumn("VRF","Cálculo - Vale Refeição","Qt. Dias Calculado",1)
        oFWMsExcel:AddColumn("VRF","Cálculo - Vale Refeição","Valor Cálculado",1)
        oFWMsExcel:AddColumn("VRF","Cálculo - Vale Refeição","Valor Unitário",1)
        oFWMsExcel:AddColumn("VRF","Cálculo - Vale Refeição","Valor Desconto Funcionário",1)
        oFWMsExcel:AddColumn("VRF","Cálculo - Vale Refeição","Valor Parte Empresa",1)


        //Criando as Linhas... Enquanto não for fim da query
        While !(CALCVR->(EoF()))
            oFWMsExcel:AddRow("VRF","Cálculo - Vale Refeição",{;
                                                                    CALCVR->R0_FILIAL,;
                                                                    CALCVR->R0_MAT,;
                                                                    CALCVR->RA_NOMECMP,;
                                                                    CALCVR->RA_HRSMES,;
                                                                    CALCVR->CATEGORIA,;
                                                                    CALCVR->SITUACAO,;
                                                                    CALCVR->RA_TNOTRAB,;
                                                                    CALCVR->R6_DESC,;
                                                                    CALCVR->RA_CC,;
                                                                    CALCVR->CTT_DESC01,;
                                                                    CALCVR->R0_CODIGO,;
                                                                    CALCVR->RFO_DESCR,;
                                                                    CALCVR->R0_PERIOD,;
                                                                    CALCVR->R0_QDIACAL,;																
                                                                    CALCVR->R0_VALCAL,;
                                                                    CALCVR->R0_VLRVALE,;
                                                                    CALCVR->R0_VLRFUNC,;
                                                                    CALCVR->R0_VLREMP;
            })
         
            //Pulando Registro
            CALCVR->(DbSkip())
        EndDo
		
    //Fecha Query
	CALCVR->(DbCloseArea())	

    //Ativando o arquivo e gerando o xml
    oFWMsExcel:Activate()
    oFWMsExcel:GetXMLFile(cArquivo)
         
    //Abrindo o excel e abrindo o arquivo xml
    oExcel := MsExcel():New()            	//Abre uma nova conexão com Excel
    oExcel:WorkBooks:Open(cArquivo)     	//Abre uma planilha
    oExcel:SetVisible(.T.)                 	//Visualiza a planilha
    oExcel:Destroy()                        //Encerra o processo do gerenciador de tarefas
     
   
    RestArea(aArea)

	
Return


/*/{Protheus.doc} MMGPER04B
Rotina responsável por criar as perguntas do relatório no SX1 caso não existam.
@param		Nenhum
@return		Nenhum
@author 	André Luis Maximiano Longhini
@since 		24/11/2021
@version 	1.0
@Obs		24/11/2021 - MedMais - André Luis Maximiano Longhini - Construção inicial.

/*/
Static Function MMGPER04B()

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
	AADD(aRegs,{cPerg,"02","Filial até?    ","","","mv_ch2","C",2,0,0,"G","NaoVazio","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","SM0"})
	AADD(aRegs,{cPerg,"03","Processo	  ","","","mv_ch3","C",TamSx3("RCF_PROCES")[1],0,0,"G","NaoVazio()","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","RCJ"})
	AADD(aRegs,{cPerg,"04","Período de?  ","","","mv_ch4","C",TamSx3("RCF_PER")[1],0,0,"G","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","RCH"})
	AADD(aRegs,{cPerg,"05","Período até?   ","","","mv_ch5","C",TamSx3("RCF_PER")[1],0,0,"G","NaoVazio()","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","","RCH"})
	AADD(aRegs,{cPerg,"06","Turno de?    ","","","mv_ch7","C",TamSx3("RCF_TNOTRAB")[1],0,0,"G","","mv_par06","","","","","","","","","","","","","","","","","","","","","","","","","SR6"})
	AADD(aRegs,{cPerg,"07","Turno até?   ","","","mv_ch8","C",TamSx3("RCF_TNOTRAB")[1],0,0,"G","NaoVazio","mv_par07","","","","","","","","","","","","","","","","","","","","","","","","","SR6"})
	AADD(aRegs,{cPerg,"08","C. Custo de?   ","","","mv_ch3","C",TamSx3("RA_CC")[1],0,0,"G","","mv_par08","","","","","","","","","","","","","","","","","","","","","","","","","CTT"})
	AADD(aRegs,{cPerg,"09","C. Custo até?  ","","","mv_ch4","C",TamSx3("RA_CC")[1],0,0,"G","NaoVazio","mv_par09","","","","","","","","","","","","","","","","","","","","","","","","","CTT"})

	//Adiciona o conteúdo dos helps no array.
	AADD(aHelpPor, "Informe a Filial inicial - Ex: 01.")
	AADD(aHelpPor, "Informe a Filial final - Ex: 99.")
	AADD(aHelpPor, "Informe o Processo de pagamento - Ex: 00001.")
	AADD(aHelpPor, "Informe o Período de cálculo inicial - Ex: 202101.")
	AADD(aHelpPor, "Informe a Período de cálculo final - Ex: 202112.")
	AADD(aHelpPor, "Informe o Turno inicial.")
	AADD(aHelpPor, "Informe o Turno final.")
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
			MMGPER04C(cChaveHelp, aHelpPor[i], .T.)
		EndIf

	Next

Return


/*/{Protheus.doc} MMGPER04C
Rotina responsável por criar o HELP das perguntas do relatório no arquivo "SIGAHLP.HLP".
@param		Parâmetros: cKey : Chave da Pergunta
cHelp: Texto do Help
lUpdate: Indica se deve atualizar o help
@return		Nenhum
@author 	André Luis Maximiano Longhini
@since 		24/11/2021
@version 	1.0
@Obs		24/11/2021 - MedMais - André Luis Maximiano Longhini - Construção inicial.

/*/

Static Function MMGPER04C(cKey, cHelp, lUpdate)

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
