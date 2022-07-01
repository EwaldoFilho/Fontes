#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"

//Constantes
#Define STR_PULA    Chr(13)+Chr(10)

/*/{Protheus.doc} MMGPER07
Rotina que gera o relatório abertura de dados bancários
@param		Nenhum
@return		Nenhum
@author 	André Luis Maximiano Longhini	
@since 		21/03/2022
@version 	1.0
@Obs		21/03/2022 - MedMais - André Luis Maximiano Longhini - Construção inicial.

/*/

User Function MMGPER07()

	Local _aArea	:= GetArea()

	Private cPerg := "MMGPER07"

	//Cria as perguntas do relatório, caso não existam.
	MMGPER07B()

	// Ativa o grupo de perguntas
	If !Pergunte(cPerg,.T.)
		Return
	EndIf

	//Chama a função de geração do relatório em Excel.
	msAguarde( { || MMGPER07A() }, "Aguarde", "Gerando o relatório...")
	
	//Retorna o ambiente anterior.
	RestArea(_aArea)

Return()


/*/{Protheus.doc} MMGPER07A
Rotina responsável por gerar o relatório em Excel.
@param		Nenhum
@return		Nenhum
@author 	André Luis Maximiano Longhini
@since 		21/03/2022
@version 	1.0
@Obs		21/03/2022 - MedMais - André Luis Maximiano Longhini - Construção inicial.

/*/
Static Function MMGPER07A()

  	Local cQuery        := ""
    Local oFWMsExcel
    Local oExcel
	Local aArea			:= GetArea()
    Local dtHora        := FWTimeStamp(1,DATE(),TIME())
    Local cArquivo   	:= GetTempPath()+'AB_CONTA'+''+dtHora+''+'.xml'
    Local cEcivil       := ''
	Local cSalario		:= ''

    //Busca os dados do ado colaborador
	cQuery := "SELECT RA_FILIAL, RA_MAT, RA_NOMECMP, RA_CIC, RA_PIS, RA_NUMCP, RA_RG, RA_EMAIL, RA_DDDCELU, RA_NUMCELU, RA_DDDFONE, RA_TELEFON, RA_BCDEPSA,RA_CTDEPSA, RA_ADMISSA, RA_DEMISSA, RA_NASC, RA_CODFUNC, RJ_DESC, RA_CC, CTT_DESC01, RA_SALARIO, RA_SINDICA, RCE_DESCRI, RA_TNOTRAB, R6_DESC, RA_HRSMES, RA_HRSEMAN, RA_HRSDIA, RA_SITFOLH, RA_TPCONTR"       + STR_PULA
    cQuery += " RA_NACIONA, RA_RGORG, RA_RGUF, RA_DTRGEXP, RA_ESTCIVI, RA_SEXO, RA_CEP, RA_PAI, RA_MAE, RA_MUNNASC, RA_NATURAL, RA_ENDEREC, RA_NUMENDE, RA_COMPLEM, RA_BAIRRO, RA_MUNICIP, RA_ESTADO, CASE 
	cQuery += " WHEN RA_CODFUNC = '99998' THEN '1090' "  																											+ STR_PULA
	cQuery += " WHEN RA_CODFUNC in ('00004','00033','00031','00032','00066','00048','00061','00062','00060','00089','00091') THEN '1110' "   						+ STR_PULA	
	cQuery += " WHEN RA_CODFUNC = '00051' THEN '1131' "   																											+ STR_PULA	
	cQuery += " WHEN RA_CODFUNC = '00046' THEN '1140' "   																											+ STR_PULA	
	cQuery += " WHEN RA_CODFUNC in ('00068','00023') THEN '1150' "   																								+ STR_PULA	
	cQuery += " WHEN RA_CODFUNC = '00027' THEN '1170' "             																								+ STR_PULA				
	cQuery += " WHEN RA_CODFUNC in ('00005','00041','00043','00009','00042','00025','00024','00003','00065','00026','00103','00028','00047') THEN '1190' "			+ STR_PULA	
	cQuery += " WHEN RA_CODFUNC in ('00029','00069','00080','99999','00030') THEN '1250' "																			+ STR_PULA	
	cQuery += " WHEN RA_CODFUNC in ('00078','00084','00074') THEN '1260' "																							+ STR_PULA	
	cQuery += " WHEN RA_CODFUNC = '00053' THEN '1320' "             																								+ STR_PULA
	cQuery += " WHEN RA_CODFUNC in ('00040','00011') THEN '1340' "																						        	+ STR_PULA	
	cQuery += " WHEN RA_CODFUNC = '00088' THEN '1431' "             																								+ STR_PULA	
	cQuery += " WHEN RA_CODFUNC = '00045' THEN '1450' "             																								+ STR_PULA
	cQuery += " WHEN RA_CODFUNC in ('00059','00056','00055','00057') THEN '1541' "																					+ STR_PULA	
	cQuery += " WHEN RA_CODFUNC = '00006' THEN '1572' "             																								+ STR_PULA	
	cQuery += " WHEN RA_CODFUNC = '00037' THEN '1790' "             																								+ STR_PULA
	cQuery += " WHEN RA_CODFUNC in ('00052','00058') THEN '1990' "																						        	+ STR_PULA
	cQuery += " WHEN RA_CODFUNC in ('00013','00015','00019','00020','00018','00063','00017','00016','00064','00014','00112','00110','00007','00012') THEN '2952' "	+ STR_PULA	
	cQuery += " WHEN RA_CODFUNC in ('00085','00086') THEN '3800' "																						        	+ STR_PULA	
	cQuery += " WHEN RA_CODFUNC in ('00102','00077','00083') THEN '3810' "																				        	+ STR_PULA
	cQuery += " WHEN RA_CODFUNC in ('00035','00036','00070','00111','00071') THEN '3820' "																        	+ STR_PULA	
	cQuery += " WHEN RA_CODFUNC in ('00054','00082') THEN '3933' "																						        	+ STR_PULA
	cQuery += " WHEN RA_CODFUNC in ('00034','00039','00076','00038','00008','00072','00107','00010','00044') THEN '3940' "				  			        		+ STR_PULA
	cQuery += " WHEN RA_CODFUNC in ('00021','00081','00087','00073','00109') THEN '3990' "																        	+ STR_PULA	
	cQuery += " WHEN RA_CODFUNC = '00075' THEN '4012' "             																								+ STR_PULA	
	cQuery += " WHEN RA_CODFUNC = '00079' THEN '4900' "             																								+ STR_PULA
	cQuery += " WHEN RA_CODFUNC in ('00108','00100','00105','00050','00090','00049') THEN '5310' "															       	+ STR_PULA
	cQuery += " WHEN RA_CODFUNC in ('00106','00104') THEN '5320' "																						        	+ STR_PULA
	cQuery += " WHEN RA_CODFUNC = '00022' THEN '5990' "             																								+ STR_PULA
	cQuery += " WHEN RA_CODFUNC = '00067' THEN '9311' "             																								+ STR_PULA		
	cQuery += " END AS DEPARA_FUNC "             																													+ STR_PULA										
	cQuery += " FROM " + RetSqlName("SRA") + " RA "                                                                                                                 + STR_PULA
	cQuery += " LEFT JOIN " + RetSqlName("SR6") + " R6"                                                                                                             + STR_PULA
	cQuery += " ON R6.R6_FILIAL  = '" + xFilial("SR6") + "'"                                                                                                        + STR_PULA
	cQuery += " AND R6.R6_TURNO  = RA.RA_TNOTRAB "                                                                                                                  + STR_PULA
	cQuery += " AND R6.D_E_L_E_T_ = ' '"                                                                                                                            + STR_PULA
    cQuery += " LEFT JOIN " + RetSqlName("RCE") + " RCE"                                                                                                            + STR_PULA
	cQuery += " ON RCE.RCE_FILIAL  = '" + xFilial("RCE") + "'"                                                                                                      + STR_PULA
	cQuery += " AND RCE.RCE_CODIGO  = RA.RA_SINDICA "                                                                                                               + STR_PULA
	cQuery += " AND RCE.D_E_L_E_T_ = ' '"                                                                                                                           + STR_PULA
	cQuery += " LEFT JOIN " + RetSqlName("SRJ") + " RJ"                                                                                                             + STR_PULA
	cQuery += " ON RJ.RJ_FILIAL  = '" + xFilial("SRJ") + "'"                                                                                                        + STR_PULA
	cQuery += " AND RJ.RJ_FUNCAO = RA.RA_CODFUNC "                                                                                                                  + STR_PULA
	cQuery += " AND RJ.D_E_L_E_T_ = ' '"                                                                                                                            + STR_PULA
	cQuery += " LEFT JOIN " + RetSqlName("CTT") + " CTT"                                                                                                            + STR_PULA
	cQuery += " ON CTT.CTT_FILIAL = '" + xFilial("CTT") + "'"                                                                                                       + STR_PULA
	cQuery += " AND CTT.CTT_CUSTO = RA.RA_CC "                                                                                                                      + STR_PULA
	cQuery += " AND CTT.D_E_L_E_T_ = ' '"                                                                                                                           + STR_PULA
	cQuery += " WHERE RA.RA_FILIAL BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "' "                                                                              + STR_PULA
	cQuery += " AND RA.RA_CC BETWEEN '" + MV_PAR03 + "' AND '" + MV_PAR04 + "' "                                                                                    + STR_PULA
	cQuery += " AND RA.RA_MAT BETWEEN '" + MV_PAR05 + "' AND '" + MV_PAR06 + "' "                                                                              		+ STR_PULA
	cQuery += " AND RA.RA_PROCES BETWEEN '" + MV_PAR07 + "' AND '" + MV_PAR08 + "' "                                                                                + STR_PULA    
	cQuery += " AND RA.RA_SITFOLH <> 'D' "                                                                                                                          + STR_PULA
    cQuery += " AND RA.D_E_L_E_T_ = '' "                                                                                                                            + STR_PULA
	cQuery += " ORDER BY RA_FILIAL, RA_MAT"                                                                                                                         + STR_PULA
	TCQuery cQuery New Alias "QPRO"
     
    //Criando o objeto que irá gerar o conteúdo do Excel
    oFWMsExcel := FWMSExcel():New()
     
    //Aba 01 - Tabela do Cadastro
    oFWMsExcel:AddworkSheet("AB_CONTA") //Não utilizar número junto com sinal de menos. Ex.: 1-
        //Criando a Tabela
        oFWMsExcel:AddTable("AB_CONTA","AAB_CONTA")
        //Criando Colunas
        oFWMsExcel:AddColumn("AB_CONTA","AAB_CONTA","CPF",1) 
        oFWMsExcel:AddColumn("AB_CONTA","AAB_CONTA","Nome Titular",1) 
        oFWMsExcel:AddColumn("AB_CONTA","AAB_CONTA","Data de Nascimento",1) 
        oFWMsExcel:AddColumn("AB_CONTA","AAB_CONTA","Sexo",1)
		oFWMsExcel:AddColumn("AB_CONTA","AAB_CONTA","Estado Civil",1)
		oFWMsExcel:AddColumn("AB_CONTA","AAB_CONTA","Tipo Documento",1)
		oFWMsExcel:AddColumn("AB_CONTA","AAB_CONTA","Número Documento",1)
		oFWMsExcel:AddColumn("AB_CONTA","AAB_CONTA","Data Emissão do Documento",1)
        oFWMsExcel:AddColumn("AB_CONTA","AAB_CONTA","Órgão Emissor do Documento",1)
        oFWMsExcel:AddColumn("AB_CONTA","AAB_CONTA","UF - Documento",1)
        oFWMsExcel:AddColumn("AB_CONTA","AAB_CONTA","CEP",1)           
        oFWMsExcel:AddColumn("AB_CONTA","AAB_CONTA","DDD",1)
        oFWMsExcel:AddColumn("AB_CONTA","AAB_CONTA","Telefone",1)
        oFWMsExcel:AddColumn("AB_CONTA","AAB_CONTA","Código da Profissão",1)
		oFWMsExcel:AddColumn("AB_CONTA","AAB_CONTA","Valor da Renda",1)
		oFWMsExcel:AddColumn("AB_CONTA","AAB_CONTA","Tipo da renda",1)
        oFWMsExcel:AddColumn("AB_CONTA","AAB_CONTA","Data de Admissão",1)
        oFWMsExcel:AddColumn("AB_CONTA","AAB_CONTA","Nome do Pai",1)
        oFWMsExcel:AddColumn("AB_CONTA","AAB_CONTA","Nome da Mãe",1)
        oFWMsExcel:AddColumn("AB_CONTA","AAB_CONTA","Nacionalidade",1)
        oFWMsExcel:AddColumn("AB_CONTA","AAB_CONTA","Naturalidade",1)
        oFWMsExcel:AddColumn("AB_CONTA","AAB_CONTA","UF",1)
        oFWMsExcel:AddColumn("AB_CONTA","AAB_CONTA","Nome do Cônjuge",1)
        oFWMsExcel:AddColumn("AB_CONTA","AAB_CONTA","Endereço",1)
        oFWMsExcel:AddColumn("AB_CONTA","AAB_CONTA","Número",1)
        oFWMsExcel:AddColumn("AB_CONTA","AAB_CONTA","Complemento",1)
        oFWMsExcel:AddColumn("AB_CONTA","AAB_CONTA","Bairro",1)
        oFWMsExcel:AddColumn("AB_CONTA","AAB_CONTA","Cidade",1)
        oFWMsExcel:AddColumn("AB_CONTA","AAB_CONTA","UF",1)
		oFWMsExcel:AddColumn("AB_CONTA","AAB_CONTA","COD.CC",1)
		oFWMsExcel:AddColumn("AB_CONTA","AAB_CONTA","C.Custo",1)
        oFWMsExcel:AddColumn("AB_CONTA","AAB_CONTA","Cód. da Agência",1)
        oFWMsExcel:AddColumn("AB_CONTA","AAB_CONTA","PAB",1)
		oFWMsExcel:AddColumn("AB_CONTA","AAB_CONTA","Cod. PAB",1)	
		oFWMsExcel:AddColumn("AB_CONTA","AAB_CONTA","Banco Agencia",1)
		oFWMsExcel:AddColumn("AB_CONTA","AAB_CONTA","Conta",1)	


        //Criando as Linhas
 		 While !(QPRO->(EoF()))
            
			cEcivil = ''
			
			IF QPRO->RA_ESTCIVI == 'S'
                cEcivil := "1" 
            elseif QPRO->RA_ESTCIVI == 'V'
                cEcivil := "3"
            elseif QPRO->RA_ESTCIVI == 'D'
                cEcivil := "4"
			elseif QPRO->RA_ESTCIVI == 'Q'
                cEcivil := "5"
            elseif QPRO->RA_ESTCIVI == 'M'
                cEcivil := "6"
			elseif QPRO->RA_ESTCIVI == 'C'
                cEcivil := "7"
			elseif QPRO->RA_ESTCIVI == ''
                cEcivil := ''
            endif    
			
			cSalario = ''

			if cSalario = ''
				cSalario = (cValToChar(RA_SALARIO) + "00")
			endif

            oFWMsExcel:AddRow("AB_CONTA","AAB_CONTA",{;
																    QPRO->RA_CIC,;
                                                                    QPRO->RA_NOMECMP,;
                                                                    QPRO->(STOD(RA_NASC)),;
                                                                    QPRO->RA_SEXO,;
                                                                    cEcivil,;
                                                                    "1",;
                                                                    QPRO->RA_RG,;
																	QPRO->(STOD(RA_DTRGEXP)),;
																	QPRO->RA_RGORG,;
																	QPRO->RA_RGUF,;																	
																	QPRO->RA_CEP,;
                                                                    QPRO->RA_DDDCELU,;
                                                                    QPRO->RA_NUMCELU,;	
																	QPRO->DEPARA_FUNC,;																
                                                                    cSalario,;  
                                                                    "1",;  
																	QPRO->(STOD(RA_ADMISSA)),; 																  
                                                                    QPRO->RA_PAI,; 
                                                                    QPRO->RA_MAE,; 
																	"1",;
                                                                    QPRO->RA_MUNNASC,;
                                                                    QPRO->RA_NATURAL,; 
																	"",;  
                                                                    QPRO->RA_ENDEREC,;
                                                                    QPRO->RA_NUMENDE,;
                                                                    QPRO->RA_COMPLEM,;     
                                                                    QPRO->RA_BAIRRO,;
                                                                    QPRO->RA_MUNICIP,;
                                                                    QPRO->RA_ESTADO,;
																	QPRO->RA_CC,;
																	QPRO->CTT_DESC01,;
                                                                    "",;																	
                                                                    "",;
																	"",;
                                                                    QPRO->RA_BCDEPSA,; 
																	QPRO->RA_CTDEPSA;                                             
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


/*/{Protheus.doc} MMGPER07B
Rotina responsável por criar as perguntas do relatório no SX1 caso não existam.
@param		Nenhum
@return		Nenhum
@author 	André Luis Maximiano Longhini
@since 		21/03/2022
@version 	1.0
@Obs		21/03/2022 - MedMais - André Luis Maximiano Longhini - Construção inicial.

/*/
Static Function MMGPER07B()

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
	AADD(aRegs,{cPerg,"07","Processo de?	  ","","","mv_ch7","C",TamSx3("RCF_PROCES")[1],0,0,"G","","mv_par07","","","","","","","","","","","","","","","","","","","","","","","","","RCJ"})
	AADD(aRegs,{cPerg,"08","Processo até?  ","","","mv_ch8","C",TamSx3("RCF_PROCES")[1],0,0,"G","NaoVazio()","mv_par08","","","","","","","","","","","","","","","","","","","","","","","","","RCJ"})
	
    
	//Adiciona o conteúdo dos helps no array.
	AADD(aHelpPor, "Informe a Filial inicial.")
	AADD(aHelpPor, "Informe a Filial final.")
	AADD(aHelpPor, "Informe o Centro de custo inicial.")
	AADD(aHelpPor, "Informe o Centro de custo final.")
	AADD(aHelpPor, "Informe a Matrícula inicial")
	AADD(aHelpPor, "Informe a Matrícula final.")
    AADD(aHelpPor, "Informe o Processo de Cálculo da Folha inicial.")
	AADD(aHelpPor, "Informe o Processo de Cálculo da Folha final.")

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
			MMGPER07C(cChaveHelp, aHelpPor[i], .T.)
		EndIf

	Next

Return


/*/{Protheus.doc} MMGPER07C
Rotina responsável por criar o HELP das perguntas do relatório no arquivo "SIGAHLP.HLP".
@param		Parâmetros: cKey : Chave da Pergunta
cHelp: Texto do Help
lUpdate: Indica se deve atualizar o help
@return		Nenhum
@author 	André Luis Maximiano Longhini
@since 		21/03/2022
@version 	1.0
@Obs		21/03/2022 - MedMais - André Luis Maximiano Longhini - Construção inicial.

/*/

Static Function MMGPER07C(cKey, cHelp, lUpdate)

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
