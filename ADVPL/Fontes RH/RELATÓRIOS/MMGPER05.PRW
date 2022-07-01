#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"

//Constantes
#Define STR_PULA    Chr(13)+Chr(10)

/*/{Protheus.doc} MMGPER05
Rotina que gera o relatório HeadCount
@param		Nenhum
@return		Nenhum
@author 	André Luis Maximiano Longhini	
@since 		02/12/2021
@version 	1.0
@Obs		02/12/2021 - MedMais - André Luis Maximiano Longhini - Construção inicial.

/*/

User Function MMGPER05()

	Local _aArea	:= GetArea()

	Private cPerg := "MMGPER05"

	//Cria as perguntas do relatório, caso não existam.
	MMGPER05B()

	// Ativa o grupo de perguntas
	If !Pergunte(cPerg,.T.)
		Return
	EndIf

	//Chama a função de geração do relatório em Excel.
	msAguarde( { || MMGPER05A() }, "Aguarde", "Gerando o relatório...")
	
	//Retorna o ambiente anterior.
	RestArea(_aArea)

Return()


/*/{Protheus.doc} MMGPER05A
Rotina responsável por gerar o relatório em Excel.
@param		Nenhum
@return		Nenhum
@author 	André Luis Maximiano Longhini
@since 		02/12/2021
@version 	1.0
@Obs		02/12/2021 - MedMais - André Luis Maximiano Longhini - Construção inicial.

/*/
Static Function MMGPER05A()

  	Local cQuery        := ""
    Local oFWMsExcel
    Local oExcel
	Local aArea			:= GetArea()
    Local dtHora        := FWTimeStamp(1,DATE(),TIME())
    Local cArquivo   	:= GetTempPath()+'HEADCOUNT'+''+dtHora+''+'.xml'
    Local cStatus       := ''
	Local cTpCont		:= ''
 
    //Busca os dados do ado colaborador
	cQuery := "SELECT RA_FILIAL, RA_MAT, RA_NOMECMP, RA_CIC, RA_PIS, RA_NUMCP,RJ_CODCBO, RA_CODUNIC, RA_RG, RA_ORGEMRG, RA_EMAIL, RA_DDDCELU, RA_NUMCELU, RA_DDDFONE, RA_TELEFON, RA_BCDEPSA,RA_CTDEPSA, RA_ADMISSA, RA_DEMISSA, RA_NASC, RA_CODFUNC, RJ_DESC, RA_CC, CTT_DESC01, CTT_CEI, RA_SALARIO, RA_SINDICA, RCE_DESCRI, RA_TNOTRAB, R6_DESC, RA_HRSMES, RA_HRSEMAN, RA_HRSDIA, RA_SITFOLH, RA_TPCONTR, RA_VCTOEXP, RA_VCTEXP2"       + STR_PULA
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
	cQuery += " AND RA.RA_CODFUNC BETWEEN '" + MV_PAR05 + "' AND '" + MV_PAR06 + "' "                                                                               + STR_PULA
	cQuery += " AND RA.RA_TNOTRAB BETWEEN '" + MV_PAR07 + "' AND '" + MV_PAR08 + "' "                                                                               + STR_PULA
    cQuery += " AND RA.RA_PROCES BETWEEN '" + MV_PAR09 + "' AND '" + MV_PAR10 + "' "                                                                                + STR_PULA
	cQuery += " AND RA.RA_SINDICA BETWEEN '" + MV_PAR11 + "' AND '" + MV_PAR12 + "' "                                                                               + STR_PULA
    cQuery += " AND RA.D_E_L_E_T_ = '' "                                                                                                                            + STR_PULA
	cQuery += " ORDER BY RA_FILIAL, RA_MAT"                                                                                                                         + STR_PULA
	TCQuery cQuery New Alias "QPRO"
     
    //Criando o objeto que irá gerar o conteúdo do Excel
    oFWMsExcel := FWMSExcel():New()
     
    //Aba 01 - Tabela do Cadastro
    oFWMsExcel:AddworkSheet("HEADCOUNT") //Não utilizar número junto com sinal de menos. Ex.: 1-
        //Criando a Tabela
        oFWMsExcel:AddTable("HEADCOUNT","HeadCount")
        //Criando Colunas
        oFWMsExcel:AddColumn("HEADCOUNT","HeadCount","Filial",1) 
        oFWMsExcel:AddColumn("HEADCOUNT","HeadCount","Matrícula",1)
		oFWMsExcel:AddColumn("HEADCOUNT","HeadCount","Matrícula eSocial",1)  
        oFWMsExcel:AddColumn("HEADCOUNT","HeadCount","Nome Completo",1) 
        oFWMsExcel:AddColumn("HEADCOUNT","HeadCount","CPF",1)
		oFWMsExcel:AddColumn("HEADCOUNT","HeadCount","PIS",1)
		oFWMsExcel:AddColumn("HEADCOUNT","HeadCount","CTPS",1)
		oFWMsExcel:AddColumn("HEADCOUNT","HeadCount","RG",1)
		oFWMsExcel:AddColumn("HEADCOUNT","HeadCount","ORG/UF RG",1)
		oFWMsExcel:AddColumn("HEADCOUNT","HeadCount","E-mail",1)
        oFWMsExcel:AddColumn("HEADCOUNT","HeadCount","Tel. Fixo",1)
        oFWMsExcel:AddColumn("HEADCOUNT","HeadCount","Tel. Celular",1)
        oFWMsExcel:AddColumn("HEADCOUNT","HeadCount","Banco",1)           
        oFWMsExcel:AddColumn("HEADCOUNT","HeadCount","Agência",1)
        oFWMsExcel:AddColumn("HEADCOUNT","HeadCount","Conta",1)
        oFWMsExcel:AddColumn("HEADCOUNT","HeadCount","Dt. Admissão",1)
		oFWMsExcel:AddColumn("HEADCOUNT","HeadCount","Dt. Ven. Exp",1)
		oFWMsExcel:AddColumn("HEADCOUNT","HeadCount","Dt. Ven. 2° Exp",1)
		oFWMsExcel:AddColumn("HEADCOUNT","HeadCount","Dt. Demissão",1)
		oFWMsExcel:AddColumn("HEADCOUNT","HeadCount","Tipo de Contrato",1)
        oFWMsExcel:AddColumn("HEADCOUNT","HeadCount","Dt. Nascimento",1)
        oFWMsExcel:AddColumn("HEADCOUNT","HeadCount","Cod. Função",1)
        oFWMsExcel:AddColumn("HEADCOUNT","HeadCount","Desc. Função",1)
		oFWMsExcel:AddColumn("HEADCOUNT","HeadCount","CBO",1)
        oFWMsExcel:AddColumn("HEADCOUNT","HeadCount","Cod. CCusto",1)
        oFWMsExcel:AddColumn("HEADCOUNT","HeadCount","Desc. CCusto",1)
		oFWMsExcel:AddColumn("HEADCOUNT","HeadCount","CNPJ Tomador",1)
        oFWMsExcel:AddColumn("HEADCOUNT","HeadCount","Salário",3,3)
        oFWMsExcel:AddColumn("HEADCOUNT","HeadCount","Cod. Sindicato",1)
        oFWMsExcel:AddColumn("HEADCOUNT","HeadCount","Desc. Sindicato",1)
        oFWMsExcel:AddColumn("HEADCOUNT","HeadCount","Cod. Turno",1)
        oFWMsExcel:AddColumn("HEADCOUNT","HeadCount","Desc. Turno",1)
        oFWMsExcel:AddColumn("HEADCOUNT","HeadCount","Horas Mensais",1)
        oFWMsExcel:AddColumn("HEADCOUNT","HeadCount","Horas Semanais",1)
        oFWMsExcel:AddColumn("HEADCOUNT","HeadCount","Horas Diárias",1)
        oFWMsExcel:AddColumn("HEADCOUNT","HeadCount","Sit. Folha",1)


        //Criando as Linhas
 		 While !(QPRO->(EoF()))
            
            cStatus := ''

            IF QPRO->RA_SITFOLH == ' '
                cStatus := "Ativo" 
            elseif QPRO->RA_SITFOLH == 'D'
                cStatus := "Desligado"
            elseif QPRO->RA_SITFOLH == 'F'
                cStatus := "Em Férias"
            elseif QPRO->RA_SITFOLH == 'A'
                 cStatus := "Afastado"
            endif    
			
			cTpCont := ''

			IF QPRO->RA_TPCONTR == '1'
                cTpCont := "Contrato Indeterminado" 
            elseif QPRO->RA_TPCONTR == '2'
                cTpCont := "Contrato Determinado"
            elseif QPRO->RA_TPCONTR == '3'
                cTpCont := "Contrato Intermitente"
            endif 



            oFWMsExcel:AddRow("HEADCOUNT","HeadCount",{;
																    QPRO->RA_FILIAL,;
                                                                    QPRO->RA_MAT,;
																	QPRO->RA_CODUNIC,;
                                                                    QPRO->RA_NOMECMP,;
                                                                    QPRO->RA_CIC,;
                                                                    QPRO->RA_PIS,;
                                                                    QPRO->RA_NUMCP,;
                                                                    QPRO->RA_RG,;
																	QPRO->RA_ORGEMRG,;
																	QPRO->RA_EMAIL,;
																	((QPRO->RA_DDDFONE)+ "-" + (QPRO->RA_TELEFON)),;
                                                                    ((QPRO->RA_DDDCELU)+ "-" + (QPRO->RA_NUMCELU)),;
                                                                    QPRO->(SUBSTR(RA_BCDEPSA,1,3)),;  
                                                                    QPRO->(SUBSTR(RA_BCDEPSA,4,4)),;   
                                                                    QPRO->RA_CTDEPSA,;  
                                                                    QPRO->(STOD(RA_ADMISSA)),;
																	QPRO->(STOD(RA_VCTOEXP)),; 
																	QPRO->(STOD(RA_VCTEXP2)),;  
																	QPRO->(STOD(RA_DEMISSA)),; 
																	cTpCont,;
                                                                    QPRO->(STOD(RA_NASC)),;
                                                                    QPRO->RA_CODFUNC,; 
																	QPRO->RJ_DESC,;  
																	QPRO->RJ_CODCBO,;
                                                                    QPRO->RA_CC,;
                                                                    QPRO->CTT_DESC01,;
																	QPRO->CTT_CEI,;
                                                                    QPRO->RA_SALARIO,;     
                                                                    QPRO->RA_SINDICA,;
                                                                    QPRO->RCE_DESCRI,;
                                                                    QPRO->RA_TNOTRAB,;
                                                                    QPRO->R6_DESC,;
                                                                    QPRO->RA_HRSMES,;
                                                                    QPRO->RA_HRSEMAN,;
                                                                    QPRO->(SUBSTR((CValToChar(RA_HRSDIA)),1,4)),;
                                                                    cStatus;                                              
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


/*/{Protheus.doc} MMGPER05B
Rotina responsável por criar as perguntas do relatório no SX1 caso não existam.
@param		Nenhum
@return		Nenhum
@author 	André Luis Maximiano Longhini
@since 		02/12/2021
@version 	1.0
@Obs		02/12/2021 - MedMais - André Luis Maximiano Longhini - Construção inicial.

/*/
Static Function MMGPER05B()

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
	AADD(aRegs,{cPerg,"05","Função de?    ","","","mv_ch5","C",TamSx3("RA_CODFUNC")[1],0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","","SRJ"})
	AADD(aRegs,{cPerg,"06","Função até?   ","","","mv_ch6","C",TamSx3("RA_CODFUNC")[1],0,0,"G","NaoVazio","mv_par06","","","","","","","","","","","","","","","","","","","","","","","","","SRJ"})
	AADD(aRegs,{cPerg,"07","Turno de?    ","","","mv_ch7","C",TamSx3("RA_TNOTRAB")[1],0,0,"G","","mv_par07","","","","","","","","","","","","","","","","","","","","","","","","","SR6"})
	AADD(aRegs,{cPerg,"08","Turno até?   ","","","mv_ch8","C",TamSx3("RA_TNOTRAB")[1],0,0,"G","NaoVazio","mv_par08","","","","","","","","","","","","","","","","","","","","","","","","","SR6"})
	AADD(aRegs,{cPerg,"09","Processo de?	  ","","","mv_ch9","C",TamSx3("RCF_PROCES")[1],0,0,"G","","mv_par09","","","","","","","","","","","","","","","","","","","","","","","","","RCJ"})
	AADD(aRegs,{cPerg,"10","Processo até?  ","","","mv_cha","C",TamSx3("RCF_PROCES")[1],0,0,"G","NaoVazio()","mv_par10","","","","","","","","","","","","","","","","","","","","","","","","","RCJ"})
	AADD(aRegs,{cPerg,"11","Sindicato de?  ","","","mv_chb","C",TamSx3("RA_SINDICA")[1],0,0,"G","","mv_par11","","","","","","","","","","","","","","","","","","","","","","","","","RCE"})
	AADD(aRegs,{cPerg,"12","Sindicato até?  ","","","mv_chc","C",TamSx3("RA_SINDICA")[1],0,0,"G","NaoVazio()","mv_par12","","","","","","","","","","","","","","","","","","","","","","","","","RCE"})
	
    
	//Adiciona o conteúdo dos helps no array.
	AADD(aHelpPor, "Informe a Filial inicial.")
	AADD(aHelpPor, "Informe a Filial final.")
	AADD(aHelpPor, "Informe o Centro de custo inicial.")
	AADD(aHelpPor, "Informe o Centro de custo final.")
	AADD(aHelpPor, "Informe a Função inicial")
	AADD(aHelpPor, "Informe a Função final.")
	AADD(aHelpPor, "Informe o Turno inicial.")
	AADD(aHelpPor, "Informe o Turno final.")
    AADD(aHelpPor, "Informe o Processo de Cálculo da Folha inicial.")
	AADD(aHelpPor, "Informe o Processo de Cálculo da Folha final.")
    AADD(aHelpPor, "Informe o Sindicato inicial.")
	AADD(aHelpPor, "Informe o Sindicato final.")
	

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
			MMGPER05C(cChaveHelp, aHelpPor[i], .T.)
		EndIf

	Next

Return


/*/{Protheus.doc} MMGPER05C
Rotina responsável por criar o HELP das perguntas do relatório no arquivo "SIGAHLP.HLP".
@param		Parâmetros: cKey : Chave da Pergunta
cHelp: Texto do Help
lUpdate: Indica se deve atualizar o help
@return		Nenhum
@author 	André Luis Maximiano Longhini
@since 		02/12/2021
@version 	1.0
@Obs		02/12/2021 - MedMais - André Luis Maximiano Longhini - Construção inicial.

/*/

Static Function MMGPER05C(cKey, cHelp, lUpdate)

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
