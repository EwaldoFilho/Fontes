#Include "RWMAKE.CH"
#Include "TBICONN.CH"
#Include "TOPCONN.CH"
#Include "PROTHEUS.CH"

/*/{Protheus.doc} MMGPEC09  - Fonte responsável pelo cálculo do ISS para autônomos. 
@return		Retorno
@author		André Longhini
@version	1.0
@since		23/06/2022
@obs	
*/
User Function MMGPEC09()


Local cAnoAt	:= ''					// Recebe o período da folha
Local nVlrIss 	:= 0					//
Local cPd0218   := ""   				// Recebe código de verba com id 0218. 
Local nVlr0218  := 0    				// Recebe o vlr da verba com id 0218. 
Local _cAlias	:= GetNextAlias()		// Recebe o próximo _cAlias.
Local cQuery	:= ""					// Grava a consulta sql.	

	// Consulta a RCH o período da folha
	cQuery	:= "SELECT RCH_PER, RCH_NUMPAG, RCH_PROCES, RCH_ROTEIR,RCH_PERSEL "
			cQuery	+= "  FROM " + RetSqlName("RCH") + " RCH "
			cQuery	+= " WHERE RCH.RCH_FILIAL  = '" + xFilial("RCH") + "'"
			cQuery	+= "   AND RCH.RCH_PROCES  = '" + SRA->RA_PROCES + "'"			
			cQuery	+= "   AND RCH.RCH_ROTEIR  = 'AUT'"
			cQuery	+= "   AND RCH.RCH_PERSEL  = '1'"
			cQuery	+= "   AND RCH.D_E_L_E_T_ = ' '"
			cQuery	+= " GROUP BY RCH.RCH_PER, RCH.RCH_NUMPAG, RCH.RCH_PROCES, RCH.RCH_ROTEIR, RCH.RCH_PERSEL "
			cQuery	+= " ORDER BY RCH_PER DESC"

	DBUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery), _cAlias , .T. , .F.)

	cAnoAt 	:= (_cAlias)->(Substr(RCH_PER,1,6))

	DBCLOSEAREA()

	 // Consulta a RGB para localizar a verba e percentual. 
	cQuery	:= "SELECT RGB_PD, RGB_PERIOD, RGB_HORAS, SUM(RGB_VALOR) AS TOTAL, RGB_TIPO1 "
			cQuery	+= "  FROM " + RetSqlName("RGB") + " RGB"
			cQuery	+= " WHERE RGB.RGB_FILIAL  = '" + SRA->RA_FILIAL + "'"
			cQuery	+= "   AND RGB.RGB_MAT     = '" + SRA->RA_MAT + "'"
			cQuery	+= "   AND RGB.RGB_PD     = '515' "			
			cQuery	+= "   AND RGB.RGB_PERIOD  = '" + cAnoAt  + "'"
			cQuery	+= "   AND RGB.D_E_L_E_T_ = ' '"
			cQuery	+= " GROUP BY RGB.RGB_PERIOD, RGB.RGB_PD, RGB.RGB_HORAS, RGB.RGB_TIPO1 "
			cQuery	+= " ORDER BY RGB_PERIOD DESC"

	DBUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery), _cAlias , .T. , .F.)
    
	nPer	:= (_cAlias)->RGB_HORAS		// Grava a quantidade da verba localizada na consulta. 


	DBCLOSEAREA()
	


	If nPer != 0
		cPd0218 	:= aCodFol[0218,1]  		// Consulta código da verba de pagamento Autônomo
		nVlr0218 	:= fBuscaPD(cPd0218) 		// Recebe o valor da verba de pagamento do Autônomo.
		nVlrIss 	:= (nVlr0218*(nPer/100))	// Cálcula valor do ISS
		//Grava verba de ISS
		FdelPD("515")                                   // Deleta a verba, caso seja encontrada no cálculo. 
		FGeraVerba("515",nVlrIss,nPer,,,"V","C",,,,)		// Gera verba com valor.    														
	EndIF
	
Return()
