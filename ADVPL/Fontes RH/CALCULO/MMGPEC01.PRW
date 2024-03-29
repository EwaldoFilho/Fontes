#Include "RWMAKE.CH"
#Include "TBICONN.CH"
#Include "TOPCONN.CH"
#Include "PROTHEUS.CH"

/*/{Protheus.doc} MEDMGPEC01  - Fonte respons�vel pelo c�lculo do vale transporte em pecunia. 
@return		Retorno
@author		Andr� Longhini
@version	1.0
@since		28/09/2021
@obs	
*/
User Function MMGPEC01()

Local cMesAt    := ''																												// Grava o M�s Atual, se inferior ao m�s 10 acrescenta 0 a frente. 
Local cAnoAt	:= ''																												// Grava o Ano Atual.
Local cMesSeg	:= ''																												// Grava o M�s seguinte.
Local cDtFim	:= ''																												// Grava o Ano+M�s seguinte. 			
Local nVlrAtt	:= 0																												// V�riavel que recebe o valor.
Local nQtdHr	:= 0																												// Recebe a quantidade de dias da verba.
Local _cAlias	:= GetNextAlias()																									// Recebe o pr�ximo _cAlias.
Local cQuery	:= ""																												// Grava a consulta sql.	





    // Obtem verbas
	cPd0052		:= aCodFol[0052,1]        // Verba Pg Vale Transporte em Pecunia. 
						
	// Obtem quantidade de dias
	nQtd0052	:= fBuscaPD(cPd0052,"H") // Verba Pg Vale Transporte em Pecunia. 
			
	// Obtem Valor
    nValExt		:= fBuscaPD(cpd0052)      // Verba Pg Vale Transporte em Pecunia. 

		// Consulta a RCH o per�odo da folha
	cQuery	:= "SELECT RCH_PER, RCH_NUMPAG, RCH_PROCES, RCH_ROTEIR,RCH_PERSEL "
			cQuery	+= "  FROM " + RetSqlName("RCH") + " RCH "
			cQuery	+= " WHERE RCH.RCH_FILIAL  = '" + xFilial("RCH") + "'"
			cQuery	+= "   AND RCH.RCH_PROCES  = '" + SRA->RA_PROCES + "'"			
			cQuery	+= "   AND RCH.RCH_ROTEIR  = 'FOL'"
			cQuery	+= "   AND RCH.RCH_PERSEL  = '1'"
			cQuery	+= "   AND RCH.D_E_L_E_T_ = ' '"
			cQuery	+= " GROUP BY RCH.RCH_PER, RCH.RCH_NUMPAG, RCH.RCH_PROCES, RCH.RCH_ROTEIR, RCH.RCH_PERSEL "
			cQuery	+= " ORDER BY RCH_PER DESC"

	DBUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery), _cAlias , .T. , .F.)

	cAnoAt 	:= (_cAlias)->(Substr(RCH_PER,1,4))
	cMesAt 	:= (_cAlias)->(Substr(RCH_PER,5,2))
	cMesSeg	:= CValToChar(val(cMesAt)+1)
	cMesSeg := CValToChar(STRZERO(VAL(cMesSeg),2))

    
	iF cMesAt == '12'							// Valida se o M�s atual � dezembro.
		cAnoSeg  := CValToChar(Val(cAnoAt)+1)   // Caso a valida��o for positiva, adiciona um ano ao ano atual. 
		cMesSeg	 := '01'                        // Caso a valida��o for positiva, o m�s seguinte ser� 01. 
		cDtFim   := cAnoSeg+""+cMesSeg			// Concatena o Ano+Mes fim.
	Else 
		cDtFim   := cAnoAt+""+cMesSeg           // Caso a valida��o for negativa, concatena o Ano+M�s fim. 
	endif
    

	DBClosearea()


    // Consulta a RGB para localizar se h� a verba de pecunia do Vale Transporte. 
	cQuery	:= "SELECT RGB_PD, RGB_PERIOD, RGB_HORAS, SUM(RGB_VALOR) AS TOTAL, RGB_TIPO1 "
			cQuery	+= "  FROM " + RetSqlName("RGB") + " RGB"
			cQuery	+= " WHERE RGB.RGB_FILIAL  = '" + SRA->RA_FILIAL + "'"
			cQuery	+= "   AND RGB.RGB_MAT     = '" + SRA->RA_MAT + "'"
			cQuery	+= "   AND RGB.RGB_PD     = '" + cPd0052 + "'"			
			cQuery	+= "   AND RGB.RGB_PERIOD  = '" + Alltrim(cDtFim)  + "'"
			cQuery	+= "   AND RGB.D_E_L_E_T_ = ' '"
			cQuery	+= " GROUP BY RGB.RGB_PERIOD, RGB.RGB_PD, RGB.RGB_HORAS, RGB.RGB_TIPO1 "
			cQuery	+= " ORDER BY RGB_PERIOD DESC"

	DBUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery), _cAlias , .T. , .F.)
    
	nVlrAtt := (_cAlias)->TOTAL			// Grava o valor da verba localizada na consulta.
	nQtdHr	:= (_cAlias)->RGB_HORAS		// Grava a quantidade da verba localizada na consulta. 
    

	DBClosearea()


	

    //Regrava pagamento do VT com valor correto
	iF nVlrAtt > 0 
		FdelPD("034")											        	// Deleta a verba, caso exista, antes de gera-la novamente.
    	FGeraVerba("034",nVlrAtt,nQtdHr,,,"V","C",,,,)                   	// Gera verba com valor correto.
	else
		FdelPD("034")                                                       // Deleta a verba, caso n�o haja valor a pagar no pr�ximo m�s.
	Endif

    
Return()
