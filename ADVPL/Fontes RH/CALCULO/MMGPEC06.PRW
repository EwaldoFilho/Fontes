#Include "RWMAKE.CH"
#Include "TBICONN.CH"
#Include "TOPCONN.CH"
#Include "PROTHEUS.CH"

/*/{Protheus.doc} MMGPEC06  - Fonte responsável pelo cálculo de Hora Extra Noturna
@return		Retorno
@author		André Longhini
@version	1.0
@since		18/01/2022
@obs	
*/
User Function MMGPEC06()

Local hrsMes    := 0    				// Recebe quantidade de horas mensal trabalhado pelo colaborador.
Local vlrSal    := 0    				// Recebe o valor do salário do colaborador
Local salIncorp := 0                    // Recebe o valor do salário incorporado. 
Local nVlrGrat1 := 0    				// Recebe valor da Gratificação por Função.
Local nVlrGrat2 := 0    				// Recebe valor da Gratificação por Função.
Local nVlrGrat3 := 0    				// Recebe valor da Gratificação por Função.
Local nVlrGrat4 := 0    				// Recebe valor da Gratificação por Função.
Local vlrPeri   := 0    				// Recebe valor da Periculosidade.
Local vlrInsmi  := 0    				// Recebe valor da Insalubridade min.
Local vlrInsme  := 0    				// Recebe valor da Insalubridade med.
Local vlrInsma  := 0    				// Recebe valor da Insalubridade max.
Local nVlrHr	:= 0					// Recebe o valor calculado da Hora Extra Noturna
Local nVlr065	:= 0					// Recebe o valor da verba 065 - Adicional Noturno
Local nQtd065	:= 0 					// Recebe a quantidade da verba 065 - Adicinal Noturno	
Local perHr		:= 0 					// Recebe o Percentual de referência para pagamento da hora extra noturna. 																		
Local pgHrNot	:= ''					// Recebe a opção de pagamento ou não da hora extra noturna - 1 = Sim; 2 = Não.
Local cCCust	:= ''   				// Recebe os Centros de custo que deverão haver a incidência da ocorrência.
Local codVbGt1  := ""   				// Recebe código de verba de Gratificação.
Local codVbGt2  := ""  					// Recebe código de verba de Gratificação.
Local codVbGt3  := ""   				// Recebe código de verba de Gratificação.
Local codVbGt4  := ""  					// Recebe código de verba de Gratificação.
Local cPd0037   := ""   				// Recebe código de verba com id 0037. 
Local cPd0038   := ""   				// Recebe código de verba com id 0038. 
Local cPd0039   := ""   				// Recebe código de verba com id 0039. 
Local cPd0036   := ""   				// Recebe código de verba com id 0036. 
Local nVlr0037  := 0    				// Recebe o vlr da verba com id 0037. 
Local nVlr0038  := 0    				// Recebe o vlr da verba com id 0038. 
Local nVlr0039  := 0    				// Recebe o vlr da verba com id 0039. 
Local nVlr0036  := 0    				// Recebe o vlr da verba com id 0036. 
Local cPer      := ""   				// Recebe se o colaborador possuí Periculosidade. 
Local cIns      := ""   				// Recebe se o colaborador possuí Insalubridade.
Local cBaseIns  := ""   				// Recebe tipo de base de Insalubridade.  
Local perPer    := 0    				// Recebe percentual da Periculosidade. 
Local perInsmin := 0    				// Recebe percentual da Insalubridade min.
Local perInsmed := 0    				// Recebe percentual da Insalubridade med.
Local perInsmax := 0    				// Recebe percentual da Insalubridade max. 
Local perAdNot	:= 0					// Recebe % do adicional noturno.
Local perAdNot1 := 0    				// Recebe % diferente do adicional noturno. 
Local perAdNot2 := 0    				// Recebe % diferente do adicional noturno. 
Local perAdNot3 := 0    				// Recebe % diferente do adicional noturno. 
Local codFunc1  := ""   				// Recebe código de função.
Local codFunc2  := ""   				// Recebe código de função.
Local codFunc3  := ""   				// Recebe código de função.

	DbSelectArea("RCE")
	RCE->(dbsetorder(1))    //Cadastro de Sindicatos
	RCE->(DBSEEK(xFilial("RCE")+SRA->RA_SINDICA))

	pgHrNot 	:= RCE-> RCE_XPGHR		// Busca a opção de pagamento ou não da hora extra noturna - 1 = Sim; 2 = Não.
	cCCust 		:= RCE-> RCE_XCCHR  	// Busca os Centros de custo que deverão haver a incidência da ocorrência. 
	cCodVb 		:= RCE-> RCE_XVBHR		// Busca verba para pagamento da hora extra noturna. 
	perHr		:= RCE-> RCE_XPERH		// Busca o percentual de referência para pagamento da hora extra noturna. 
	perInsmin   := RCE-> RCE_PINSMI     // Busca percentual da Insalubridade Min.
    perInsmed   := RCE-> RCE_PINSME     // Busca percentual da Insalubridade Med.
    perInsmax   := RCE-> RCE_PINSMA     // Busca percentual da Insalubridade Max.
    perPer      := RCE-> RCE_PERPE      // Busca percentual da Periculosidade.
    codVbGt1    := RCE-> RCE_XVBGT      // Busca Código de Verba de Gratificação Por Função
    codVbGt2    := RCE-> RCE_XVBGT2     // Busca Código de Verba de Gratificação Por Função
    codVbGt3    := RCE-> RCE_XVBGT3     // Busca Código de Verba de Gratificação Por Função
    codVbGt4    := RCE-> RCE_XVBGT4     // Busca Código de Verba de Gratificação Por Função		
	cBaseIns    := RCE-> RCE_BCALIN     // Busca a base de cálculo da insalubridade: 1 - Salário Min; 2 - Salario; 3 - Salario+verbas; 4 - Salario min+verbas; 5 - Salario min Estadual; 6 - Piso Categoria; 7 - Salario min Estadual+verbas; 8 - Piso categoria+verbas.
	perAdNot    := RCE-> RCE_XPADN      //Busca percentual do Adcional Noturno no cadastro do Sindicato - Campo RCE_XPADN 
    perAdNot1   := RCE-> RCE_XPAD1      //Busca percentual do Adcional Noturno no cadastro do Sindicato - Campo RCE_XPAD1 
    perAdNot2   := RCE-> RCE_XPAD2      //Busca percentual do Adcional Noturno no cadastro do Sindicato - Campo RCE_XPAD2 
    perAdNot3   := RCE-> RCE_XPAD3      //Busca percentual do Adcional Noturno no cadastro do Sindicato - Campo RCE_XPAD3
    codFunc1    := RCE-> RCE_XCFU1      //Busca o código de função ao qual se refere o percentual do campo RCE_XPAD1
    codFunc2    := RCE-> RCE_XCFU2      //Busca o código de função ao qual se refere o percentual do campo RCE_XPAD2
    codFunc3    := RCE-> RCE_XCFU3      //Busca o código de função ao qual se refere o percentual do campo RCE_XPAD3      


	If pgHrNot == '1' .and. ALLTRIM(SRA->RA_CC) $  ALLTRIM(cCCust) .and. SRA->RA_SITFOLH <> 'D'



		// Obtem quantidade do Adicional Noturno
		nQtd065 := fBuscaPD("065","H") 	// Obtem a quantidade da verba de Adicional Noturno

		// Obtem valor das verbas
		nVlr065		:= fBuscaPD("065") 			// Obtem o valor da verba de Adicional Noturno
		nVlrGrat1 	:= fBuscaPD(codVbGt1) 		// Vlr Gratificação por Função
		nVlrGrat2 	:= fBuscaPD(codVbGt2) 		// Vlr Gratificação por Função
		nVlrGrat3 	:= fBuscaPD(codVbGt3) 		// Vlr Gratificação por Função
		nVlrGrat4 	:= fBuscaPD(codVbGt4) 		// Vlr Gratificação por Função
		nVlr0037 	:= fBuscaPD(cPd0037) 		// Vlr insalubridade Min. 
		nVlr0038 	:= fBuscaPD(cPd0038) 		// Vlr insalubridade Méd. 
		nVlr0039 	:= fBuscaPD(cPd0039) 		// Vlr insalubridade Máx. 
		nVlr0036 	:= fBuscaPD(cPd0036) 		// Vlr Periculasidade.


		// Obtem dados para o cálculo 
        hrsMes   := SRA-> RA_HRSMES     	//Busca a quantidade de horas mensal
        vlrSal   := SRA-> RA_SALARIO    	//Busca o valor do salário
        cPer     := SRA-> RA_ADCPERI    	//Localiza se recebe periculosidade: 1 - Não; 2 - Sim.
        cIns     := SRA-> RA_ADCINS     	//Localiza se recebe insalubridade: 1 - Não; 2 - Ins. Mín; 3 - Ins. Méd; 4 - Ins. Máx.

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

		//Calcula o valor do salário incorporado
		salIncorp := vlrSal + vlrInsmi + vlrInsme + vlrInsma + vlrPeri + nVlrGrat1 + nVlrGrat2 + nVlrGrat3 + nVlrGrat4   // Soma valor das verbas encontradas com o valor do salário. 


		//Grava verba de Hora Extra Noturna
		iF nVlr065 > 0 
			nVlrHr := (((salIncorp)/hrsMes*((perAdnot/100)+(100/100))*((perHr/100)+(100/100))))*(nQtd065/7)		// Cálcula valor da Hora Extra Noturna
			FdelPD(cCodVb)                                                    								 	// Deleta a verba, caso seja encontrada no cálculo. 
			FGeraVerba(cCodVb,nVlrHr,nQtd065,,,"V","C",,,,)   
		Endif

	ENDIF

	DBCLOSEAREA()
	RCE->(DbCloseArea())
	
Return()
