#Include "RWMAKE.CH"
#Include "TBICONN.CH"
#Include "TOPCONN.CH"
#Include "PROTHEUS.CH"

/*/{Protheus.doc} MMGPEC06  - Fonte respons�vel pelo c�lculo de Hora Extra Noturna
@return		Retorno
@author		Andr� Longhini
@version	1.0
@since		18/01/2022
@obs	
*/
User Function MMGPEC06()

Local hrsMes    := 0    				// Recebe quantidade de horas mensal trabalhado pelo colaborador.
Local vlrSal    := 0    				// Recebe o valor do sal�rio do colaborador
Local salIncorp := 0                    // Recebe o valor do sal�rio incorporado. 
Local nVlrGrat1 := 0    				// Recebe valor da Gratifica��o por Fun��o.
Local nVlrGrat2 := 0    				// Recebe valor da Gratifica��o por Fun��o.
Local nVlrGrat3 := 0    				// Recebe valor da Gratifica��o por Fun��o.
Local nVlrGrat4 := 0    				// Recebe valor da Gratifica��o por Fun��o.
Local vlrPeri   := 0    				// Recebe valor da Periculosidade.
Local vlrInsmi  := 0    				// Recebe valor da Insalubridade min.
Local vlrInsme  := 0    				// Recebe valor da Insalubridade med.
Local vlrInsma  := 0    				// Recebe valor da Insalubridade max.
Local nVlrHr	:= 0					// Recebe o valor calculado da Hora Extra Noturna
Local nVlr065	:= 0					// Recebe o valor da verba 065 - Adicional Noturno
Local nQtd065	:= 0 					// Recebe a quantidade da verba 065 - Adicinal Noturno	
Local perHr		:= 0 					// Recebe o Percentual de refer�ncia para pagamento da hora extra noturna. 																		
Local pgHrNot	:= ''					// Recebe a op��o de pagamento ou n�o da hora extra noturna - 1 = Sim; 2 = N�o.
Local cCCust	:= ''   				// Recebe os Centros de custo que dever�o haver a incid�ncia da ocorr�ncia.
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
Local cBaseIns  := ""   				// Recebe tipo de base de Insalubridade.  
Local perPer    := 0    				// Recebe percentual da Periculosidade. 
Local perInsmin := 0    				// Recebe percentual da Insalubridade min.
Local perInsmed := 0    				// Recebe percentual da Insalubridade med.
Local perInsmax := 0    				// Recebe percentual da Insalubridade max. 
Local perAdNot	:= 0					// Recebe % do adicional noturno.
Local perAdNot1 := 0    				// Recebe % diferente do adicional noturno. 
Local perAdNot2 := 0    				// Recebe % diferente do adicional noturno. 
Local perAdNot3 := 0    				// Recebe % diferente do adicional noturno. 
Local codFunc1  := ""   				// Recebe c�digo de fun��o.
Local codFunc2  := ""   				// Recebe c�digo de fun��o.
Local codFunc3  := ""   				// Recebe c�digo de fun��o.

	DbSelectArea("RCE")
	RCE->(dbsetorder(1))    //Cadastro de Sindicatos
	RCE->(DBSEEK(xFilial("RCE")+SRA->RA_SINDICA))

	pgHrNot 	:= RCE-> RCE_XPGHR		// Busca a op��o de pagamento ou n�o da hora extra noturna - 1 = Sim; 2 = N�o.
	cCCust 		:= RCE-> RCE_XCCHR  	// Busca os Centros de custo que dever�o haver a incid�ncia da ocorr�ncia. 
	cCodVb 		:= RCE-> RCE_XVBHR		// Busca verba para pagamento da hora extra noturna. 
	perHr		:= RCE-> RCE_XPERH		// Busca o percentual de refer�ncia para pagamento da hora extra noturna. 
	perInsmin   := RCE-> RCE_PINSMI     // Busca percentual da Insalubridade Min.
    perInsmed   := RCE-> RCE_PINSME     // Busca percentual da Insalubridade Med.
    perInsmax   := RCE-> RCE_PINSMA     // Busca percentual da Insalubridade Max.
    perPer      := RCE-> RCE_PERPE      // Busca percentual da Periculosidade.
    codVbGt1    := RCE-> RCE_XVBGT      // Busca C�digo de Verba de Gratifica��o Por Fun��o
    codVbGt2    := RCE-> RCE_XVBGT2     // Busca C�digo de Verba de Gratifica��o Por Fun��o
    codVbGt3    := RCE-> RCE_XVBGT3     // Busca C�digo de Verba de Gratifica��o Por Fun��o
    codVbGt4    := RCE-> RCE_XVBGT4     // Busca C�digo de Verba de Gratifica��o Por Fun��o		
	cBaseIns    := RCE-> RCE_BCALIN     // Busca a base de c�lculo da insalubridade: 1 - Sal�rio Min; 2 - Salario; 3 - Salario+verbas; 4 - Salario min+verbas; 5 - Salario min Estadual; 6 - Piso Categoria; 7 - Salario min Estadual+verbas; 8 - Piso categoria+verbas.
	perAdNot    := RCE-> RCE_XPADN      //Busca percentual do Adcional Noturno no cadastro do Sindicato - Campo RCE_XPADN 
    perAdNot1   := RCE-> RCE_XPAD1      //Busca percentual do Adcional Noturno no cadastro do Sindicato - Campo RCE_XPAD1 
    perAdNot2   := RCE-> RCE_XPAD2      //Busca percentual do Adcional Noturno no cadastro do Sindicato - Campo RCE_XPAD2 
    perAdNot3   := RCE-> RCE_XPAD3      //Busca percentual do Adcional Noturno no cadastro do Sindicato - Campo RCE_XPAD3
    codFunc1    := RCE-> RCE_XCFU1      //Busca o c�digo de fun��o ao qual se refere o percentual do campo RCE_XPAD1
    codFunc2    := RCE-> RCE_XCFU2      //Busca o c�digo de fun��o ao qual se refere o percentual do campo RCE_XPAD2
    codFunc3    := RCE-> RCE_XCFU3      //Busca o c�digo de fun��o ao qual se refere o percentual do campo RCE_XPAD3      


	If pgHrNot == '1' .and. ALLTRIM(SRA->RA_CC) $  ALLTRIM(cCCust) .and. SRA->RA_SITFOLH <> 'D'



		// Obtem quantidade do Adicional Noturno
		nQtd065 := fBuscaPD("065","H") 	// Obtem a quantidade da verba de Adicional Noturno

		// Obtem valor das verbas
		nVlr065		:= fBuscaPD("065") 			// Obtem o valor da verba de Adicional Noturno
		nVlrGrat1 	:= fBuscaPD(codVbGt1) 		// Vlr Gratifica��o por Fun��o
		nVlrGrat2 	:= fBuscaPD(codVbGt2) 		// Vlr Gratifica��o por Fun��o
		nVlrGrat3 	:= fBuscaPD(codVbGt3) 		// Vlr Gratifica��o por Fun��o
		nVlrGrat4 	:= fBuscaPD(codVbGt4) 		// Vlr Gratifica��o por Fun��o
		nVlr0037 	:= fBuscaPD(cPd0037) 		// Vlr insalubridade Min. 
		nVlr0038 	:= fBuscaPD(cPd0038) 		// Vlr insalubridade M�d. 
		nVlr0039 	:= fBuscaPD(cPd0039) 		// Vlr insalubridade M�x. 
		nVlr0036 	:= fBuscaPD(cPd0036) 		// Vlr Periculasidade.


		// Obtem dados para o c�lculo 
        hrsMes   := SRA-> RA_HRSMES     	//Busca a quantidade de horas mensal
        vlrSal   := SRA-> RA_SALARIO    	//Busca o valor do sal�rio
        cPer     := SRA-> RA_ADCPERI    	//Localiza se recebe periculosidade: 1 - N�o; 2 - Sim.
        cIns     := SRA-> RA_ADCINS     	//Localiza se recebe insalubridade: 1 - N�o; 2 - Ins. M�n; 3 - Ins. M�d; 4 - Ins. M�x.

		//Identifica o Percentual do Adicional Noturno
		If ALLTRIM(SRA->RA_CODFUNC) $  AllTrim(codFunc1)
			perAdnot := perAdNot1
		ELSEIF ALLTRIM(SRA->RA_CODFUNC) $  AllTrim(codFunc2)
			perAdnot := perAdNot2
		ELSEIF ALLTRIM(SRA->RA_CODFUNC) $  AllTrim(codFunc3)
			perAdnot := perAdNot3
		ELSE
			perAdnot := perAdNot
		ENDIF


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
		salIncorp := vlrSal + vlrInsmi + vlrInsme + vlrInsma + vlrPeri + nVlrGrat1 + nVlrGrat2 + nVlrGrat3 + nVlrGrat4   // Soma valor das verbas encontradas com o valor do sal�rio. 


		//Grava verba de Hora Extra Noturna
		iF nVlr065 > 0 
			nVlrHr := (((salIncorp)/hrsMes*((perAdnot/100)+(100/100))*((perHr/100)+(100/100))))*(nQtd065/7)		// C�lcula valor da Hora Extra Noturna
			FdelPD(cCodVb)                                                    								 	// Deleta a verba, caso seja encontrada no c�lculo. 
			FGeraVerba(cCodVb,nVlrHr,nQtd065,,,"V","C",,,,)   
		Endif

	ENDIF

	DBCLOSEAREA()
	RCE->(DbCloseArea())
	
Return()
