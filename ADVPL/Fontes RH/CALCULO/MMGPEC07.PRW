#Include "RWMAKE.CH"
#Include "TBICONN.CH"
#Include "TOPCONN.CH"
#Include "PROTHEUS.CH"

/*/{Protheus.doc} MMGPEC07  - Fonte responsável pelo cálculo dos adicionais dos Médicos. (Insalubridade Periculosidade)
@return		Retorno
@author		André Longhini
@version	1.0
@since		19/01/2022
@obs	
*/
User Function MMGPEC07()

Local perPer	:= 0 								// Recebe o percentual de periculosidade para recalcular. 
Local nVlrTOT	:= 0 								// Recebe valor total das tarefas que tem de pagar periculosidade. 
Local nVlrVb	:= 0								// Recebe o valor da verba a deletar.
Local nVlrPeri	:= 0								// Recebe o valor do cálculo da periculosidade. 
Local qtVt		:= 0								// Recebe a quantidade de vale transporte a ser pago. 
Local qtAj		:= 0								// Recebe a quantidade de Ajuda de Custo a ser pago.
Local qtTrab	:= 0								// Recebe a quantidade de plantões feitos no mês.  			
Local cPd0037   := ""   							// Recebe código de verba com id 0037. 
Local cPd0038   := ""   							// Recebe código de verba com id 0038. 
Local cPd0039   := ""   							// Recebe código de verba com id 0039. 
Local cPd0672 	:= ""								// Recebe código de verba com id 0672. 
Local cPd0673 	:= ""								// Recebe código de verba com id 0673. 
Local cPd0054	:= ""								// Recebe código de verba com id 0054. 
Local cPd0203	:= ""								// Recebe código de verba com id 0203. 
Local cPd0242	:= ""								// Recebe código de verba com id 0242. 
Local nVlr0037  := 0    							// Recebe o vlr da verba com id 0037. 
Local nVlr0038  := 0    							// Recebe o vlr da verba com id 0038. 
Local nVlr0039  := 0    							// Recebe o vlr da verba com id 0039. 
Local nVlr0672  := 0    							// Recebe o vlr da verba com id 0672. 
Local nVlr0673 := 0    								// Recebe o vlr da verba com id 0673. 
Local nQtd0054	:= 0								// Recebe a Qtd da verba com id 0054.
Local nQtd0203	:= 0								// Recebe a Qtd da verba com id 0203.
Local nQtd0242	:= 0								// Recebe a Qtd da verba com id 0242.
Local cPd0036   := ""   							// Recebe código de verba com id 0036. 
Local nVlr0036  := 0    							// Recebe o vlr da verba com id 0036. 
Local qtTotal	:= 0								// Recebe a quantidade total a pagar.
Local cVbPl		:= ""								// Recebe o código de verba a ser deletado. 
Local cPgInsa	:= ""								// Recebe se o colaborador deve receber Insalubridade pela Tarefa executada. 1 = Sim; 2 = Não 
Local cPgPeri	:= ""								// Recebe se o colaborador deve receber Periculosidade pela Tarefa executada. 1 = Sim; 2 = Não 
Local cPgVt		:= SRA-> RA_XPGVT					// Recebe se o colaborador deve receber Vale Transporte por Plantão. 1 = Sim; 2 = Não. 
Local cPgAj		:= SRA-> RA_XPGAJ					// Recebe se o colaborador deve receber Ajuda de Custo por Plantão. 1 = Sim; 2 = Não. 
Local nVlrUni	:= SRA-> RA_XVLVT					// Recebe o valor unitário do vale transporte por plantão.  1 = Sim; 2 = Não. 
Local nVlrAjU	:= SRA-> RA_XVLAJ					// Recebe o valor unitário da ajuda de custo. 
Local nVlrAj	:= 0								// Recebe o valor do cálculo da Ajuda de custo a pagar. 
Local nVlrVt	:= 0								// Recebe o valor do cálculo do VT a pagar. 
Local cVbVt		:= GETMV("GPE_GPEC01")				// Recebe o código de verba para pagamento do vale transporte por plantão. 
Local cVbAj		:= GETMV("GPE_GPEC02")				// Recebe o código de verba para pagamento da ajuda de custo. 
Local cExVb		:= ""								// Exclui verba informada. 1 = Sim; 2 = Não 
Local cDtIni    := ""								// Grava a data inicial do período de cálculo
Local cDtFim	:= ""								// Grava a data fim do período de cálculo	
Local cPerFol	:= ""								// Grava período da folha
Local cPlMedic	:= SRA-> RA_XPGPL					// Recebe se o colaborador é plantonista. 1 = Sim; 2 = Não
Local _cAlias	:= GetNextAlias()					// Recebe o próximo _cAlias.
Local cQuery	:= ""								// Grava a consulta sql.	

	IF cPlMedic == '1'

			DbSelectArea("RCE")
			RCE->(dbsetorder(1))    //Cadastro de Sindicatos
			RCE->(DBSEEK(xFilial("RCE")+SRA->RA_SINDICA))

			perPer      := RCE-> RCE_PERPE      // Busca percentual da Periculosidade.


			DBCLOSEAREA()
			RCE->(DbCloseArea())


			// Consulta a RCH o período da folha
			cQuery	:= "SELECT RCH_PER, RCH_NUMPAG, RCH_PROCES, RCH_ROTEIR,RCH_PERSEL, RCH_DTINI, RCH_DTFIM "
				cQuery	+= "  FROM " + RetSqlName("RCH") + " RCH "
				cQuery	+= " WHERE RCH.RCH_FILIAL  = '" + xFilial("RCH") + "'"
				cQuery	+= "   AND RCH.RCH_PROCES  = '" + SRA->RA_PROCES + "'"			
				cQuery	+= "   AND RCH.RCH_ROTEIR  = 'FOL'"
				cQuery	+= "   AND RCH.RCH_PERSEL  = '1'"
				cQuery	+= "   AND RCH.D_E_L_E_T_ = ' '"
				cQuery	+= " GROUP BY RCH.RCH_PER, RCH.RCH_NUMPAG, RCH.RCH_PROCES, RCH.RCH_ROTEIR, RCH.RCH_PERSEL, RCH_DTINI, RCH_DTFIM "
				cQuery	+= " ORDER BY RCH_PER DESC"

			DBUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery), _cAlias , .T. , .F.)

				cDtIni 	:= (_cAlias)-> RCH_DTINI
				cDtFim 	:= (_cAlias)-> RCH_DTFIM
				cPerFol	:= (_cAlias)-> RCH_PER

			DBCLOSEAREA()


			// Consulta a RCF para buscar a quantidade de dias trabalhados;
			cQuery	:= "SELECT RCF_PER, RCF_PROCES, RCF_TNOTRA,RCF_DIATRA "
				cQuery	+= "  FROM " + RetSqlName("RCF") + " RCF "
				cQuery	+= " WHERE RCF.RCF_FILIAL  = '" + xFilial("RCF") + "'"
				cQuery	+= "   AND RCF.RCF_PROCES  = '" + SRA->RA_PROCES + "'"			
				cQuery	+= "   AND RCF.RCF_TNOTRA  = '" + SRA->RA_TNOTRAB + "'"
				cQuery	+= "   AND RCF.RCF_PER  = '" + cPerFol + "'"
				cQuery	+= "   AND RCF.D_E_L_E_T_ = ' '"
				cQuery	+= " GROUP BY RCF.RCF_PER, RCF_PROCES, RCF_TNOTRA,RCF_DIATRA "
				cQuery	+= " ORDER BY RCH_PER DESC"

			DBUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery), _cAlias , .T. , .F.)

				qtTrab	:= (_cAlias)-> RCF_PER

			DBCLOSEAREA()

			// Consulta a SRO para verificar se deverá excluir a verba
			cQuery	:= " SELECT RO_FILIAL, RO_MAT, RO_VERBA, RO_XDELV, RO_DATA, RO_DATAATE "
				cQuery	+= "  FROM " + RetSqlName("SRO") + " RO"
				cQuery	+= " WHERE RO.RO_FILIAL  = '" + SRA->RA_FILIAL + "'"
				cQuery	+= "   AND RO.RO_MAT     = '"+ SRA->RA_MAT +"'"	
				cQuery	+= "   AND RO.RO_XDELV = '1'"
				cQuery	+= "   AND RO.RO_DATA = '" + cDtIni + "'"
				cQuery	+= "   AND RO.RO_DATAATE = '" + cDtFim + "'"
				cQuery	+= "   AND RO.D_E_L_E_T_ = ' '"
				cQuery	+= " GROUP BY  RO_FILIAL, RO_MAT, RO_VERBA, RO_XDELV, RO_DATA, RO_DATAATE "

			DBUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery), _cAlias , .T. , .F.)

				cExVb := (_cAlias)-> RO_XDELV // Recebe o conteúdo do campo RO_XDELV
				cVbPl := (_cAlias)-> RO_VERBA // Recebe o conteúdo do campo RO_XDELV
				
			DbCloseArea()      



			// Consulta a SRO para verificar se deverá haver pagamento de Insalubridade
			cQuery	:= " SELECT RO_FILIAL, RO_MAT, RO_XINS, RO_DATA, RO_DATAATE "
				cQuery	+= "  FROM " + RetSqlName("SRO") + " RO"
				cQuery	+= " WHERE RO.RO_FILIAL  = '" + SRA->RA_FILIAL + "'"
				cQuery	+= "   AND RO.RO_MAT     = '"+ SRA->RA_MAT +"'"	
				cQuery	+= "   AND RO.RO_XINS = '1'"
				cQuery	+= "   AND RO.RO_DATA = '" + cDtIni + "'"
				cQuery	+= "   AND RO.RO_DATAATE = '" + cDtFim + "'"
				cQuery	+= "   AND RO.D_E_L_E_T_ = ' '"
				cQuery	+= " GROUP BY  RO_FILIAL, RO_MAT, RO_XINS, RO_DATA, RO_DATAATE "

			DBUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery), _cAlias , .T. , .F.)

				cPgInsa := (_cAlias)-> RO_XINS // Recebe o conteúdo do campo RO_XINS
				
			DbCloseArea()        

			// Consulta a SRO para verificar se deverá haver pagamento de Periculosidade
			cQuery	:= " SELECT RO_FILIAL, RO_MAT, RO_XPERI, RO_DATA, RO_DATAATE "
				cQuery	+= "  FROM " + RetSqlName("SRO") + " RO"
				cQuery	+= " WHERE RO.RO_FILIAL  = '" + SRA->RA_FILIAL + "'"
				cQuery	+= "   AND RO.RO_MAT     = '"+ SRA->RA_MAT +"'"	
				cQuery	+= "   AND RO.RO_XPERI = '1'"
				cQuery	+= "   AND RO.RO_DATA = '" + cDtIni + "'"
				cQuery	+= "   AND RO.RO_DATAATE = '" + cDtFim + "'"
				cQuery	+= "   AND RO.D_E_L_E_T_ = ' '"
				cQuery	+= " GROUP BY  RO_FILIAL, RO_MAT, RO_XPERI, RO_DATA, RO_DATAATE "

			DBUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery), _cAlias , .T. , .F.)

				cPgPeri := (_cAlias)-> RO_XPERI // Recebe o conteúdo do campo RO_XPERI
				
			DbCloseArea()      		


			// Consulta a SRO para verificar o valor para cálculo da periculosidade. 
			cQuery	:= " SELECT RO_FILIAL, RO_MAT, RO_XPERI, SUM(RO_VALTOT) AS RO_VALTOT, RO_DATA, RO_DATAATE "
				cQuery	+= "  FROM " + RetSqlName("SRO") + " RO"
				cQuery	+= " WHERE RO.RO_FILIAL  = '" + SRA->RA_FILIAL + "'"
				cQuery	+= "   AND RO.RO_MAT     = '"+ SRA->RA_MAT +"'"	
				cQuery	+= "   AND RO.RO_XPERI = '1'"
				cQuery	+= "   AND RO.RO_XDELV = '2'"
				cQuery	+= "   AND RO.RO_DATA = '" + cDtIni + "'"
				cQuery	+= "   AND RO.RO_DATAATE = '" + cDtFim + "'"
				cQuery	+= "   AND RO.D_E_L_E_T_ = ' '"
				cQuery	+= " GROUP BY  RO_FILIAL, RO_MAT, RO_XPERI, RO_DATA, RO_DATAATE "

			DBUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery), _cAlias , .T. , .F.)

				nVlrTOT := (_cAlias)-> RO_VALTOT // Recebe o conteúdo do campo RO_VALTOT
				
			DbCloseArea()      		


			// Cálculo do VT. 	

			If 	cPgVt == '1'
				// Consulta a SRO para verificar se deverá haver pagamento de vale Transporte
				cQuery	:= " SELECT RO_DATA, RO_DATAATE, SUM(RO_XQTVT) AS RO_XQTVT"
					cQuery	+= "  FROM " + RetSqlName("SRO") + " RO"
					cQuery	+= " WHERE RO.RO_FILIAL  = '" + SRA->RA_FILIAL + "'"
					cQuery	+= "   AND RO.RO_MAT     = '"+ SRA->RA_MAT +"'"	
					cQuery	+= "   AND RO.RO_DATA = '" + cDtIni + "'"
					cQuery	+= "   AND RO.RO_DATAATE = '" + cDtFim + "'"
					cQuery	+= "   AND RO.D_E_L_E_T_ = ' '"
					cQuery	+= " GROUP BY  RO_DATA, RO_DATAATE  "

				DBUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery), _cAlias , .T. , .F.)

					qtVt := (_cAlias)-> RO_XQTVT // Recebe o conteúdo do campo RO_XQTVT
					
				DbCloseArea()    

				//Obtem código de verbas
				cPd0054 := aCodFol[0054,1]  // Código de verba de id 0054 - Faltas
				cPd0203 := aCodFol[0203,1]  // Código de verba de id 0203 - Faltas
				cPd0242 := aCodFol[0242,1]  // Código de verba de id 0242 - Faltas

				//Obtem quantidade das verbas. 
				nQtd0054 := fBuscaPD(cPd0054,"H") 	// Obtem a quantidade da verba de id 0054 - Faltas
				nQtd0203 := fBuscaPD(cPd0203,"H") 	// Obtem a quantidade da verba de id 0203 - Faltas
				nQtd0242 := fBuscaPD(cPd0242,"H") 	// Obtem a quantidade da verba de id 0242 - Faltas


				//Calcula o total de desconto
				qtTotal	:= (qtVt - (nQtd0054 + nQtd0203 + nQtd0242))


				IF qtTotal > 0 

					// Calcula o valor a pagar do VT. 
					nVlrVt	:= ((nVlrUni) * qtTotal)
					
					FdelPD(cVbVt)                               		// Deleta a verba, caso seja encontrada no cálculo. 
					FGeraVerba(cVbVt,nVlrVt,qtTotal,,,"V","C",,,,)		// Gera a verba com valor correto.   

				endif


			ENDIF  			

			// Cálculo da ajuda de custo. 

			If 	cPgAj == '1'


				// Consulta a SRO para verificar se deverá haver pagamento de vale Transporte
				cQuery	:= " SELECT RO_DATA, RO_DATAATE, SUM(RO_XQTAJ) AS RO_XQTAJ"
					cQuery	+= "  FROM " + RetSqlName("SRO") + " RO"
					cQuery	+= " WHERE RO.RO_FILIAL  = '" + SRA->RA_FILIAL + "'"
					cQuery	+= "   AND RO.RO_MAT     = '"+ SRA->RA_MAT +"'"	
					cQuery	+= "   AND RO.RO_DATA = '" + cDtIni + "'"
					cQuery	+= "   AND RO.RO_DATAATE = '" + cDtFim + "'"
					cQuery	+= "   AND RO.D_E_L_E_T_ = ' '"
					cQuery	+= " GROUP BY  RO_DATA, RO_DATAATE  "

				DBUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery), _cAlias , .T. , .F.)

					qtAj := (_cAlias)-> RO_XQTAJ // Recebe o conteúdo do campo RO_XQTAJ
					
				DbCloseArea()    

				//Obtem código de verbas
				cPd0054 := aCodFol[0054,1]  // Código de verba de id 0054 - Faltas
				cPd0203 := aCodFol[0203,1]  // Código de verba de id 0203 - Faltas
				cPd0242 := aCodFol[0242,1]  // Código de verba de id 0242 - Faltas

				//Obtem quantidade das verbas. 
				nQtd0054 := fBuscaPD(cPd0054,"H") 	// Obtem a quantidade da verba de id 0054 - Faltas
				nQtd0203 := fBuscaPD(cPd0203,"H") 	// Obtem a quantidade da verba de id 0203 - Faltas
				nQtd0242 := fBuscaPD(cPd0242,"H") 	// Obtem a quantidade da verba de id 0242 - Faltas


				//Calcula o total de desconto
				qtTotal	:= 0
				qtTotal	:= (qtAj - (nQtd0054 + nQtd0203 + nQtd0242))

				// Calcula o valor a pagar da Ajuda de custo. 
				IF qtTotal > 0 

					nVlrAj	:= ((nVlrAjU) * qtTotal)
					
					FdelPD(cVbAj)                               		// Deleta a verba, caso seja encontrada no cálculo. 
					FGeraVerba(cVbAj,nVlrAj,qtTotal,,,"V","C",,,,)		// Gera a verba com valor correto.   

				endif

			ENDIF  


			// Obtem código das verbas
			cPd0037 := aCodFol[0037,1]  // Verba de insalubridade Min. 
			cPd0038 := aCodFol[0038,1] 	// Verba de insalubridade Méd. 
			cPd0039 := aCodFol[0039,1] 	// Verba de insalubridade Máx. 				
			cPd0036 := aCodFol[0036,1] 	// Código de Verba de Periculasidade. 
			cPd0672 := aCodFol[0672,1] 	// Código de Verba de Insalubridade Mês. 
			cPd0673 := aCodFol[0673,1] 	// Código de Verba de Periculasidade Mês. 
				

			// Obtem valor das verbas					
			nVlr0037 := fBuscaPD(cPd0037) 	// Vlr insalubridade Min. 
			nVlr0038 := fBuscaPD(cPd0038) 	// Vlr insalubridade Méd. 
			nVlr0039 := fBuscaPD(cPd0039) 	// Vlr insalubridade Máx.
			nVlr0036 := fBuscaPD(cPd0036) 	// Valor Periculasidade.
			nVlr0672 := fBuscaPD(cPd0672) 	// Valor Insalubridade Mês. 
			nVlr0673 := fBuscaPD(cPd0673) 	// Valor Periculasidade Mês. 
			nVlrVb   := fBuscaPD(cVbPl) 	// Vlr verba para deletar.

			// Obtem quantidade das verbas. 
			nQtd0036 := fBuscaPD(cPd0036,"H")	// Quantidade Periculosidade

			
			// Deleta verba principal do plantonista
			iF cExVb == '1' .and. nVlrVb > 0 
				FdelPD(cVbPl)                                      		// Deleta a verba de Periculosidade
			Endif

			// Grava verba de pagamento da periculosidade
			iF cPgPeri == '1'
				nVlrPeri := ((nVlrTOT*(perPer/100))+nVlr0036)
				FdelPD(cPd0036)                                     	// Deleta a verba de Periculosidade
				FGeraVerba(cPd0036,nVlrPeri,nQtd0036,,,"V","C",,,,)		// Gera a verba com valor correto.  
			endif

			if cPgPeri == '1'

				FdelPD(cPd0673)                                     // Deleta a verba de Periculosidade Mês
				FGeraVerba(cPd0673,nVlrPeri,nQtd0036,,,"V","C",,,,)	// Gera a verba com valor correto. 
			
			endif

			if cPgPeri <> '1' .and. nVlr0036 > 0 
				FdelPD(cPd0036)                                     	// Deleta a verba de Periculosidade
			Endif

			if nVlr0673 > 0 .and. cPgPeri <> '1'
				FdelPD(cPd0673)                                     	// Deleta a verba de Periculosidade Mês
			endif

			// Deleta verba de insalubridade de id 0037 caso não tenha que receber. 
			If  cPgInsa <> '1' .and. nVlr0037 > 0
				FdelPD(cPd0037)                                     	// Deleta a verba de insalubridade.
			Endif

			// Deleta verba de insalubridade de id 0038 caso não tenha que receber. 
			If  cPgInsa <> '1' .and. nVlr0038 > 0
				FdelPD(cPd0038)                                     	// Deleta a verba de insalubridade.		
			Endif	

			// Deleta verba de insalubridade de id 0039 caso não tenha que receber. 
			If  cPgInsa <> '1' .and. nVlr0039 > 0
				FdelPD(cPd0039)                                     	// Deleta a verba de insalubridade.				
			Endif					

			if nVlr0672 > 0 .and. cPgInsa <> '1'
					FdelPD(cPd0672)                                     // Deleta a verba de insalubridade Mês.
			endif				
    
	ENDIF

Return()
