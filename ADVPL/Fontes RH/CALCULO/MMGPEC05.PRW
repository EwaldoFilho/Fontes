#Include "RWMAKE.CH"
#Include "TBICONN.CH"
#Include "TOPCONN.CH"
#Include "PROTHEUS.CH"

/*/{Protheus.doc} MMGPEC05  - Fonte respons�vel pelo c�lculo do aux�lio creche.
@return		Retorno
@author		Andr� Longhini
@version	1.0
@since		18/01/2022
@obs	
*/
User Function MMGPEC05()

Local hrsMes    := 0    				// Recebe quantidade de horas mensal trabalhado pelo colaborador.
Local vlrSal    := 0    				// Recebe o valor do sal�rio do colaborador
Local salIncorp := 0                    // Recebe o valor do sal�rio incorporado. 
Local nVlrGrat  := 0    				// Recebe valor da Gratifica��o por Fun��o.
Local vlrPeri   := 0    				// Recebe valor da Periculosidade.
Local vlrInsmi  := 0    				// Recebe valor da Insalubridade min.
Local vlrInsme  := 0    				// Recebe valor da Insalubridade med.
Local vlrInsma  := 0    				// Recebe valor da Insalubridade max.
Local vlrSalCat	:= 0					// Recebe o valor do piso salarial.	
Local cBaseIns  := ""   				// Recebe tipo de base de Insalubridade. 
Local salMin    := 0    				// Recebe o valor do sal�rio m�nimo. 
Local codGrat   := ""   				// Aguarda c�digo de verba da Gratifica��o.
Local codVbGt1  := ""   				// Recebe c�digo de verba de Gratifica��o.
Local codVbGt2  := ""  					// Recebe c�digo de verba de Gratifica��o.
Local codVbGt3  := ""   				// Recebe c�digo de verba de Gratifica��o.
Local codVbGt4  := ""  					// Recebe c�digo de verba de Gratifica��o.
Local cPd0037   := ""   				// Recebe c�digo de verba com id 0037. 
Local cPd0038   := ""   				// Recebe c�digo de verba com id 0038. 
Local cPd0039   := ""   				// Recebe c�digo de verba com id 0039. 
Local cPd0036   := ""   				// Recebe c�digo de verba com id 0036. 
Local nVlr0037  := 0    				// Recebe o vlr da verba com id 0037. 
Local nVlr0038  := 0    				// Recebe o vlr da verba com id 0038. 
Local nVlr0039  := 0    				// Recebe o vlr da verba com id 0039. 
Local nVlr0036  := 0    				// Recebe o vlr da verba com id 0036. 
Local cPer      := ""   				// Recebe se o colaborador possu� Periculosidade. 
Local cIns      := ""   				// Recebe se o colaborador possu� Insalubridade.
Local nAnoDir	:= 0					// Grava a quantidade max em anos que o filho do colaborador deve ter para ter direito ao benef�cio. 
Local cPgAuxC	:= ''					// Grava a op��o de pagamento ou n�o de aux�lio creche - 1 = Sim, 2 = N�o.
Local cBase		:= ''					// Grava a op��o de base de c�lculo do benef�cio - 1 = Sal�rio Base, 2 = Sal�rio incorporado, 3 = Sal�rio Min, 4 = Piso da categoria.
Local cCodVerba	:= ''					// Recebe o c�digo de verba para pagamento do aux�lio creche. 
Local perCre	:= 0					// Recebe o percentual de referencia para c�lculo do benef�cio. 
Local perPer    := 0    				// Recebe percentual da Periculosidade. 
Local perInsmin := 0    				// Recebe percentual da Insalubridade min.
Local perInsmed := 0    				// Recebe percentual da Insalubridade med.
Local perInsmax := 0    				// Recebe percentual da Insalubridade max. 
Local cMesAt    := ''					// Grava o M�s Atual, se inferior ao m�s 10 acrescenta 0 a frente. 
Local cAnoAt	:= ''					// Grava o Ano Atual.		
Local nVlrAux	:= 0					// V�riavel que recebe o valor.
Local nCont		:= 0					// Recebe a quantidade de Filhos que podem receber o benef�cio
Local _cAlias	:= GetNextAlias()		// Recebe o pr�ximo _cAlias.
Local cQuery	:= ""					// Grava a consulta sql.	
Local filial    := ""
Local SitFol	:= SRA-> RA_SITFOLH
Local cAnoMax	:= ""					// Recebe ano m�ximo para consulta
Local PerMax	:= ""					// Recebe per�odo m�ximo para consulta

	DbSelectArea("RCE")
	RCE->(dbsetorder(1))    //Cadastro de Sindicatos
	RCE->(DBSEEK(xFilial("RCE")+SRA->RA_SINDICA))
		
        nAnoDir 	:= RCE-> RCE_XIDAD      // Busca o par�metro de idade m�xima para recebimento do benef�cio. 
		cPgAuxC		:= RCE-> RCE_XPGCRE		// Busca o par�metro se paga ou n�o aux�lio creche - 1 = Sim, 2 = N�o
		cBase		:= RCE-> RCE_XCREBA 	// Busca op��o de base de c�lculo - 1 = Sal�rio Base, 2 = Sal�rio incorporado, 3 = Sal�rio Min, 4 = Piso categoria.
		cCodVerba	:= RCE-> RCE_XVBCRE		// Busca c�digo de verba para pagamento do aux�lio creche. 
		vlrSalCat	:= RCE-> RCE_PISO		// Busca valor do piso da categoria
		perCre		:= RCE-> RCE_XPERCR		// Busca o percentual de referencia do benef�cio. 
        perInsmin   := RCE-> RCE_PINSMI     // Busca percentual da Insalubridade Min.
        perInsmed   := RCE-> RCE_PINSME     // Busca percentual da Insalubridade Med.
        perInsmax   := RCE-> RCE_PINSMA     // Busca percentual da Insalubridade Max.
        perPer      := RCE-> RCE_PERPE      // Busca percentual da Periculosidade.
        codVbGt1    := RCE-> RCE_XVBGT      // Busca C�digo de Verba de Gratifica��o Por Fun��o
        codVbGt2    := RCE-> RCE_XVBGT2     // Busca C�digo de Verba de Gratifica��o Por Fun��o
        codVbGt3    := RCE-> RCE_XVBGT3     // Busca C�digo de Verba de Gratifica��o Por Fun��o
        codVbGt4    := RCE-> RCE_XVBGT4     // Busca C�digo de Verba de Gratifica��o Por Fun��o		
		cBaseIns    := RCE-> RCE_BCALIN     // Busca a base de c�lculo da insalubridade: 1 - Sal�rio Min; 2 - Salario; 3 - Salario+verbas; 4 - Salario min+verbas; 5 - Salario min Estadual; 6 - Piso Categoria; 7 - Salario min Estadual+verbas; 8 - Piso categoria+verbas.
        filial      := SRA-> RA_FILIAL      // Busca filial do colaborador. 
        filial      := SubStr(filial, 3, 2)         		
	
	DBCLOSEAREA()

	If cPgAuxC == '1' .and. SitFol <> 'D'



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
				cAnoMax	:= cValToChar((VAL(cAnoAt) - nAnoDir))
				PerMax	:= (cAnoMax + cMesAt + '01')

			DBCLOSEAREA()

			// Consulta os depentens do Colaborador
			cQuery	:= "SELECT RB_FILIAL, RB_MAT, RB_NOME, RB_DTNASC, RB_GRAUPAR"
					cQuery	+= "  FROM " + RetSqlName("SRB") + " RB "
					cQuery	+= " WHERE RB.RB_FILIAL  = '" + SRA->RA_FILIAL + "'"
					cQuery	+= "   AND RB.RB_MAT  = '" + SRA->RA_MAT + "'"			
					cQuery	+= "   AND RB.RB_GRAUPAR IN ('F','E')"
					cQuery	+= "   AND RB.RB_DTNASC  >= '" + PerMax + "'"
					cQuery	+= "   AND RB.D_E_L_E_T_ = ' '"
					cQuery	+= " ORDER BY RB.RB_DTNASC DESC"
			DBUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery), _cAlias , .T. , .F.)

			
			nCont := 0
			DbSelectArea(_cAlias)
			(_cAlias)->(DbGoTop())
				While (_cAlias)->(!Eof())

    					nCont++ 

    				(_cAlias)->(DbSkip())
				EndDo

			DBCLOSEAREA()

			
			// Consulta a RCC para localizar o valor do sal�rio m�nimo. 
			cQuery	:= " SELECT RCC_FILIAL, RCC_CONTEU "
					cQuery	+= "  FROM " + RetSqlName("RCC") + " RCC"
					cQuery	+= " WHERE RCC.RCC_FILIAL  = '" + filial + "'"
					cQuery	+= "   AND RCC.RCC_CODIGO     = 'S004'"
					cQuery	+= "   AND RCC.RCC_CONTEU     LIKE '%"+ cAnoAt +"%'"	
					cQuery	+= "   AND RCC.D_E_L_E_T_ = ' '"
					cQuery	+= " GROUP BY RCC_FILIAL, RCC_CONTEU "
					cQuery	+= " ORDER BY  RCC_FILIAL, RCC_CONTEU DESC"

			DBUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery), _cAlias , .T. , .F.)

				salMin := (_cAlias)->RCC_CONTEU // Recebe o conte�do do campo RCC_CONTEU
				
				salMin := substr(salMin,18,7)   // Isola o valor referente ao sal�rio m�n. 

				salMin := GetdToVal(StrTran(salMin,".",","))    // Converte o dado caracter para n�mero. 

			DbCloseArea()

			If codVbGt1 <> ''
				codGrat := codVbGt1
			Elseif codVbGt2 <> ''
					codGrat := codVbGt2
			Elseif codVbGt3 <> ''
					codGrat := codVbGt3
			Elseif codVbGt4 <> ''
					codGrat := codVbGt4
			endif    

			// Consulta a SRV para verificar se a verba incorpora Sal�rio
			cQuery	:= " SELECT RV_FILIAL, RV_COD, RV_INCORP "
					cQuery	+= "  FROM " + RetSqlName("SRV") + " RV"
					cQuery	+= " WHERE RV.RV_FILIAL  = '" + SUBSTRING(filial,1,2) + "'"
					cQuery	+= "   AND RV.RV_COD     = '"+ codGrat +"'"	
					cQuery	+= "   AND RV.D_E_L_E_T_ = ' '"
					cQuery	+= " GROUP BY  RV_FILIAL, RV_COD, RV_INCORP "
					cQuery	+= " ORDER BY  RV_FILIAL, RV_COD DESC"

			DBUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery), _cAlias , .T. , .F.)

			cIncorp := (_cAlias)-> RV_INCORP // Recebe o conte�do do campo RV_INCORP
				
			DbCloseArea()        
				
			// Obtem c�digo de verbas
			cPd0037 := aCodFol[0037,1]  // Verba de insalubridade Min. 
			cPd0038 := aCodFol[0038,1] 	// Verba de insalubridade M�d. 
			cPd0039 := aCodFol[0039,1] 	// Verba de insalubridade M�x.     
			cPd0036 := aCodFol[0036,1] 	// Verba de Periculasidade. 

			// Obtem dados para o c�lculo 
			hrsMes   := SRA-> RA_HRSMES     //Busca a quantidade de horas mensal
			vlrSal   := SRA-> RA_SALARIO    //Busca o valor do sal�rio
			cPer     := SRA-> RA_ADCPERI    //Localiza se recebe periculosidade: 1 - N�o; 2 - Sim.
			cIns     := SRA-> RA_ADCINS     //Localiza se recebe insalubridade: 1 - N�o; 2 - Ins. M�n; 3 - Ins. M�d; 4 - Ins. M�x.

			
			If cIncorp == 'S'
				nVlrGrat := fBuscaPD(codGrat)
			ELSE 
				nVlrGrat := 0
			ENDIF


			nVlr0037 := fBuscaPD(cPd0037) 	// Vlr insalubridade Min. 
			nVlr0038 := fBuscaPD(cPd0038) 	// Vlr insalubridade M�d. 
			nVlr0039 := fBuscaPD(cPd0039) 	// Vlr insalubridade M�x. 
			nVlr0036 := fBuscaPD(cPd0036) 	// Vlr Periculasidade.

			//Calcula adicionais
			if cPer == '2'
				vlrPeri := vlrSal*(perPer/100)
			endif

			if cBaseIns == '1'

				if cIns == '2'
					vlrInsmi := salMin*(perInsmin/100)
				elseif cIns == '3'
					vlrInsme := salMin*(perInsmed/100)
				elseif cIns == '4'
					vlrInsma := salMin*(perInsmax/100)
				endif

			elseif cBaseIns == '2'
					
				if cIns == '2'
					vlrInsmi := vlrSal*(perInsmin/100)
				elseif cIns == '3'
					vlrInsme := vlrSal*(perInsmed/100)
				elseif cIns == '4'
					vlrInsma := vlrSal*(perInsmax/100)
				endif

			endif

			//Calcula o valor do sal�rio incorporado
			salIncorp := vlrSal + vlrInsmi + vlrInsme + vlrInsma + vlrPeri + nVlrGrat  // Soma valor das verbas encontradas com o valor do sal�rio. 

			//Calcula valor do Aux�lio Creche
			If nCont > 0
				If cBase == '1' // Sal�rio base
					nVlrAux := (vlrSal * (perCre/100)) * nCont
				ElseIf cBase == '2' 
					nVlrAux := (salIncorp * (perCre/100)) * nCont  
				ElseIf cBase == '3' 
					nVlrAux := (salIsalMin * (perCre/100)) * nCont    
				ElseIf cBase == '3' 
					nVlrAux := (vlrSalCat * (perCre/100))  * nCont						
				Endif
			Endif

			//Grava verba de pagamento do aux�lio creche
			iF nVlrAux > 0 
				FdelPD(cCodVerba)											        	// Deleta a verba, caso exista, antes de gera-la novamente.
				FGeraVerba(cCodVerba,nVlrAux,nCont,,,"V","C",,,,)                   	// Gera verba com valor correto.
			else
				FdelPD(cCodVerba)                                                       // Deleta a verba, caso n�o haja valor a pagar no pr�ximo m�s.
			Endif

	Endif
    
Return()
