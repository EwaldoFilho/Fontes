#Include "Protheus.ch"
/*
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±    	Programa RESULTADO ±±Autor Jefther Nobre ±± Data 22/11/2021	       ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±  	Desc. Relatório com a lista dos titulos a pagar por centro de 	   ±±
±± 		custos que foram baixados por periodo							   ±±
±± 																		   ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±		Uso ±± Financeiro contas a pagar								   ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*/

User Function RESULTADO()

Local oReport

	//Criando o grupo de pergunta
	CriaPerg()
	
	//Carregando os dados da pergunta
 	Pergunte("XRESULT",.T.)
 	
	//Chando a Função para criar a estrutura do relatorio	
	oReport := ReportDef()
  
 	//Imprimindo o Relatorio
	oReport:PrintDialog()
      

Return( Nil )


Static Function ReportDef()

Local oReport



// Criando a o Objeto

oReport := TReport():New("RESULTADO","Relatorio de Resultados","XRESULT",{|oReport| PrintReport(oReport)},"Relatorio de Resultados por Periodo")
// Criação dos campos que serão apresentados no relatório
oSection := TRSection():New(oReport,"centro de custos",{"SE2"} )

	TRCell():New(oSection,"E2_FILIAL"      , "SE2","Codigo Filial","",06)
	TRCell():New(oSection,"E2_FORNECE"      , "SE2","Codigo Fornecedor","",06)
	TRCell():New(oSection,"A2_NOME"         ," SA2","Nome Fornecedor","",40)
	TRCell():New(oSection,"E2_NUM"         , "SE2", "Numero Titulo","",06)
	TRCell():New(oSection,"E2_TIPO"      , "SE2", "Tipo")
	TRCell():New(oSection,"E2_NATUREZ"      , "SE2", "Natureza")
	TRCell():New(oSection,"ED_DESCRIC"      , "SED","Desc Natureza","",30)
	TRCell():New(oSection,"E2_CCUSTO"       , "SE2","Centro de custos")
	TRCell():New(oSection,"CTT_DESC01"      , "CTT", "Desc C. Custo")
    TRCell():New(oSection,"E2_HIST"         , "SE2", "Historico","",40)
    TRCell():New(oSection,"E2_VALOR"         , "SE2", "Valor")
	TRCell():New(oSection,"EMISSAO"       	, "SE2", "Dt. Emissão")
	TRCell():New(oSection,"VENCIMENTO"        , "SE2", "Dt. Vencimento")
	TRCell():New(oSection,"E5_BANCO"         , "SE5", "Cod. Banco Pg")
	TRCell():New(oSection,"E5_AGENCIA"       , "SE5", "Agencia Pg")
	TRCell():New(oSection,"E5_CONTA"         , "SE5", "Conta Pg")



TRFunction():New(oSection:Cell("E2_VALOR"),NIL,"SUM",,,,,.F.,.T.)
oReport:SetTotalInLine(.F.)
//oSection:= SetTotalInLine(.F.)     
//DEFINE FUNCTION FROM oSection:= TRCell("TOTAL") FUNCTION SUM NO END SECTION PICTURE '@E@Z 999.99'


Return ( oReport )


// Definido os parametros que serão usados para buscar
Static Function PrintReport(oReport)

Local oSection := oReport:Section(1)
Local cPart := ""

oSection:BeginQuery()

	cPart := "% AND E2_VENCTO >= '" + DTOS(MV_PAR01) + "' "
	cPart += "  AND E2_VENCTO <= '" + DTOS(MV_PAR02) + "' "
	cPart += "  AND E2_FILIAL BETWEEN '" + MV_PAR03 + "' AND '" + MV_PAR04 +"' %"
	
// Execução do SELECT para trazer as devidas informações 
BeginSql alias "QRYSA2"

	SELECT 
		SE2.E2_FILIAL, SE2.E2_FORNECE, SA2.A2_NOME, SE2.E2_NUM, SE2.E2_TIPO, SE2.E2_NATUREZ, SED.ED_DESCRIC, SE2.E2_CCUSTO, CTT.CTT_DESC01, SE2.E2_HIST, SE2.E2_VALOR, CONVERT(VARCHAR, CONVERT(DATE, SE2.E2_EMISSAO, 3), 3) AS EMISSAO, CONVERT(VARCHAR, CONVERT(DATE, SE2.E2_VENCTO, 3), 3) AS VENCIMENTO, SE5.E5_BANCO, SE5.E5_AGENCIA,SE5.E5_CONTA
	FROM 
		%table:SE2% SE2
		
		LEFT JOIN %table:CTT% CTT

		ON CTT.CTT_FILIAL = SUBSTRING(SE2.E2_FILIAL,1,2)

		AND CTT.CTT_CUSTO = SE2.E2_CCUSTO

		AND CTT.D_E_L_E_T_ = ''

		LEFT JOIN %table:SE5% SE5

		ON SE5.E5_FILIAL = SE2.E2_FILIAL

		AND SE5.E5_NUMERO = SE2.E2_NUM

		AND SE5.E5_CLIFOR = SE2.E2_FORNECE

		AND SE5.E5_LOJA = SE2.E2_LOJA

		AND SE5.D_E_L_E_T_ = ''

		INNER JOIN %table:SA2% SA2

		ON  SA2.A2_COD = SE2.E2_FORNECE

		AND SA2.A2_LOJA = SE2.E2_LOJA

		AND SA2.D_E_L_E_T_ = ''


		INNER JOIN %table:SED% SED

		ON  SED.ED_CODIGO = SE2.E2_NATUREZ

		AND SED.D_E_L_E_T_ = ''

	WHERE
		 SE2.D_E_L_E_T_ = ''
    	

		%exp:cPart%

	GROUP BY 
		SE2.E2_FILIAL,SE2.E2_FORNECE, SA2.A2_NOME, SE2.E2_NUM, SE2.E2_TIPO, SE2.E2_NATUREZ, SED.ED_DESCRIC, SE2.E2_CCUSTO, CTT.CTT_DESC01, SE2.E2_HIST, SE2.E2_VALOR, SE2.E2_FILIAL, SE2.E2_EMISSAO, SE2.E2_VENCTO, SE5.E5_BANCO, SE5.E5_AGENCIA,SE5.E5_CONTA
	
	ORDER BY 
		SE2.E2_CCUSTO
	
EndSql

aRetSql := GetLastQuery()
oSection:EndQuery()
oSection:Print()

Return( Nil )

// Criação das perguntas, sistema verifica se existe ou se precisa criar
Static Function CriaPerg()

Local _sAlias 	:= Alias()
Local aArea   	:= GetArea()
Local aRegs   	:= {}
Local nX		:= 0

Local cPerg		:= "XRESULT"

dbSelectArea("SX1")
dbSetOrder(1)

cPerg := PADR(cPerg,10) 

// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05
aCampos := {"GRUPO","ORDEM","PERGUNT","VARIAVL","TIPO","TAMANHO","DECIMAL","PRESEL","GSC","VALID","VAR01","DEF01","CNT01","VAR01","DEF01","CNT01","VAR02","DEF02","CNT02","VAR03","DEF03","CNT03","VAR04","DEF04","CNT04","VAR05","DEF05","CNT05","F3"}

aAdd(aRegs,{cPerg,"01","Vencimento de			","","","mv_ch1" ,"D",08,00,00,"G",""	,"MV_PAR01","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"02","Vencimento ate		  	","","","mv_ch2" ,"D",08,00,00,"G",""	,"MV_PAR02","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"03","Filial de			  	","","","mv_ch3" ,"C",04,00,00,"G",""	,"MV_PAR03","","","","","","","","","","","","","","","SM0"})
aAdd(aRegs,{cPerg,"04","Filial ate		  		","","","mv_ch4" ,"C",04,00,00,"G",""	,"MV_PAR03","","","","","","","","","","","","","","","SM0"})

dbSelectArea("SX1")
dbSetOrder(1)
For nX:=1 to Len(aRegs)
	If	DbSeek( cPerg + aRegs[nx][02] )   
    	If	RecLock('SX1',.F.)
			Replace SX1->X1_GRUPO  		With aRegs[nx][01]
			Replace SX1->X1_ORDEM   	With aRegs[nx][02]
			Replace SX1->X1_PERGUNTE	With aRegs[nx][03]
			Replace SX1->X1_PERSPA		With aRegs[nx][04]
			Replace SX1->X1_PERENG		With aRegs[nx][05]
			Replace SX1->X1_VARIAVL		With aRegs[nx][06]
			Replace SX1->X1_TIPO		With aRegs[nx][07]
			Replace SX1->X1_TAMANHO		With aRegs[nx][08]
			Replace SX1->X1_DECIMAL		With aRegs[nx][09]
			Replace SX1->X1_PRESEL		With aRegs[nx][10]
			Replace SX1->X1_GSC		  	With aRegs[nx][11]
			Replace SX1->X1_VALID		With aRegs[nx][12]
			Replace SX1->X1_VAR01		With aRegs[nx][13]
			Replace SX1->X1_DEF01	  	With aRegs[nx][14]
			Replace SX1->X1_DEF02		With aRegs[nx][17]
			Replace SX1->X1_DEF03		With aRegs[nx][20]
			Replace SX1->X1_DEF04		With aRegs[nx][23]
			Replace SX1->X1_DEF05		With aRegs[nx][26]
			Replace SX1->X1_F3   		With aRegs[nx][28]
			SX1->(MsUnlock())
		Else
			Help('',1,'REGNOIS')
		EndIf	
	Else
		If	RecLock('SX1',.T.)
			Replace SX1->X1_GRUPO  		With aRegs[nx][01]
			Replace SX1->X1_ORDEM   	With aRegs[nx][02]
			Replace SX1->X1_PERGUNTE	With aRegs[nx][03]
			Replace SX1->X1_PERSPA		With aRegs[nx][04]
			Replace SX1->X1_PERENG		With aRegs[nx][05]
			Replace SX1->X1_VARIAVL		With aRegs[nx][06]
			Replace SX1->X1_TIPO		With aRegs[nx][07]
			Replace SX1->X1_TAMANHO		With aRegs[nx][08]
			Replace SX1->X1_DECIMAL		With aRegs[nx][09]
			Replace SX1->X1_PRESEL		With aRegs[nx][10]
			Replace SX1->X1_GSC		  	With aRegs[nx][11]
			Replace SX1->X1_VALID		With aRegs[nx][12]
			Replace SX1->X1_VAR01		With aRegs[nx][13]
			Replace SX1->X1_DEF01	  	With aRegs[nx][14]
			Replace SX1->X1_DEF02		With aRegs[nx][17]
			Replace SX1->X1_DEF03		With aRegs[nx][20]
			Replace SX1->X1_DEF04		With aRegs[nx][23]
			Replace SX1->X1_DEF05		With aRegs[nx][26]
			Replace SX1->X1_F3   		With aRegs[nx][28]
			SX1->(MsUnlock())
		Else
			Help('',1,'REGNOIS')
		EndIf	
	Endif
Next nX


dbSelectArea(_sAlias)

RestArea(aArea)

Return NIL
