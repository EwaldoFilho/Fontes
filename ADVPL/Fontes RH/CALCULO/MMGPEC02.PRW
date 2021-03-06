#Include "RWMAKE.CH"
#Include "TBICONN.CH"
#Include "TOPCONN.CH"
#Include "PROTHEUS.CH"

/*/{Protheus.doc} MEDMGPEC02  - Fonte respons�vel pelo c�lculo do Adicional Noturno
@return		Retorno
@author		Andr� Longhini
@version	1.0
@since		13/10/2021
@obs	
*/
User Function MMGPEC02()


Local perAdNot  := 0    // Recebe percentual do adicional noturno, conforme informado no campo RCE_XPADN.
Local hrsMes    := 0    // Recebe quantidade de horas mensal trabalhado pelo colaborador.
Local vlrSal    := 0    // Recebe o valor do sal�rio do colaborador. 
Local nVlrAdNot := 0    // Recebe o valor do adicional noturno. 
Local salIncorp := 0    // Recebe o valor do sal�rio incorporado. 
Local codGrat   := ""   // Aguarda c�digo de verba da Gratifica��o.
Local codVbGt1  := ""   // Recebe c�digo de verba de Gratifica��o.
Local codVbGt2  := ""   // Recebe c�digo de verba de Gratifica��o.
Local codVbGt3  := ""   // Recebe c�digo de verba de Gratifica��o.
Local codVbGt4  := ""   // Recebe c�digo de verba de Gratifica��o.
Local cPd0037   := ""   // Recebe c�digo de verba com id 0037. 
Local cPd0038   := ""   // Recebe c�digo de verba com id 0038. 
Local cPd0039   := ""   // Recebe c�digo de verba com id 0039. 
Local cPd0036   := ""   // Recebe c�digo de verba com id 0036. 
Local nVlr0037  := 0    // Recebe o vlr da verba com id 0037. 
Local nVlr0038  := 0    // Recebe o vlr da verba com id 0038. 
Local nVlr0039  := 0    // Recebe o vlr da verba com id 0039. 
Local nVlr0036  := 0    // Recebe o vlr da verba com id 0036. 
Local nQtd65    := 0    // Recebe quantidade da verba de adicional noturno. 
Local perAdNot1 := 0    // Recebe % diferente do adicional noturno. 
Local perAdNot2 := 0    // Recebe % diferente do adicional noturno. 
Local perAdNot3 := 0    // Recebe % diferente do adicional noturno. 
Local codFunc1  := ""   // Recebe c�digo de fun��o.
Local codFunc2  := ""   // Recebe c�digo de fun��o.
Local codFunc3  := ""   // Recebe c�digo de fun��o.
Local cPer      := ""   // Recebe se o colaborador possu� Periculosidade. 
Local cIns      := ""   // Recebe se o colaborador possu� Insalubridade. 
Local perPer    := 0    // Recebe percentual da Periculosidade. 
Local perInsmin := 0    // Recebe percentual da Insalubridade min.
Local perInsmed := 0    // Recebe percentual da Insalubridade med.
Local perInsmax := 0    // Recebe percentual da Insalubridade max. 
Local nVlrGrat  := 0    // Recebe valor da Gratifica��o por Fun��o.
Local vlrPeri   := 0    // Recebe valor da Periculosidade.
Local vlrInsmi  := 0    // Recebe valor da Insalubridade min.
Local vlrInsme  := 0    // Recebe valor da Insalubridade med.
Local vlrInsma  := 0    // Recebe valor da Insalubridade max.
Local cBaseIns  := ""   // Recebe tipo de base de Insalubridade. 
Local salMin    := 0    // Recebe o valor do sal�rio m�nimo. 
Local _cAlias	:= GetNextAlias()	// Recebe o pr�ximo _cAlias.
Local cQuery	:= ""	
Local cAno      := cValtoChar(Year(dDataBase)) // Recebe o ano base. 
Local filial    := ""

		DbSelectArea("RCE")
		RCE->(dbsetorder(1))    //Cadastro de Sindicatos
		RCE->(DBSEEK(xFilial("RCE")+SRA->RA_SINDICA))

        codVbGt1    := RCE-> RCE_XVBGT              //Busca C�digo de Verba de Gratifica��o Por Fun��o
        codVbGt2    := RCE-> RCE_XVBGT2             //Busca C�digo de Verba de Gratifica��o Por Fun��o
        codVbGt3    := RCE-> RCE_XVBGT3             //Busca C�digo de Verba de Gratifica��o Por Fun��o
        codVbGt4    := RCE-> RCE_XVBGT4             //Busca C�digo de Verba de Gratifica��o Por Fun��o
        perInsmin   := RCE-> RCE_PINSMI             //Busca percentual da Insalubridade Min.
        perInsmed   := RCE-> RCE_PINSME             //Busca percentual da Insalubridade Med.
        perInsmax   := RCE-> RCE_PINSMA             //Busca percentual da Insalubridade Max.
        perPer      := RCE-> RCE_PERPE              //Busca percentual da Periculosidade.
        perAdNot    := RCE-> RCE_XPADN              //Busca percentual do Adcional Noturno no cadastro do Sindicato - Campo RCE_XPADN 
        perAdNot1   := RCE-> RCE_XPAD1              //Busca percentual do Adcional Noturno no cadastro do Sindicato - Campo RCE_XPAD1 
        perAdNot2   := RCE-> RCE_XPAD2              //Busca percentual do Adcional Noturno no cadastro do Sindicato - Campo RCE_XPAD2 
        perAdNot3   := RCE-> RCE_XPAD3              //Busca percentual do Adcional Noturno no cadastro do Sindicato - Campo RCE_XPAD3
        codFunc1    := RCE-> RCE_XCFU1              //Busca o c�digo de fun��o ao qual se refere o percentual do campo RCE_XPAD1
        codFunc2    := RCE-> RCE_XCFU2              //Busca o c�digo de fun��o ao qual se refere o percentual do campo RCE_XPAD2
        codFunc3    := RCE-> RCE_XCFU3              //Busca o c�digo de fun��o ao qual se refere o percentual do campo RCE_XPAD3
        cBaseIns    := RCE-> RCE_BCALIN             //Busca a base de c�lculo da insalubridade: 1 - Sal�rio Min; 2 - Salario; 3 - Salario+verbas; 4 - Salario min+verbas; 5 - Salario min Estadual; 6 - Piso Categoria; 7 - Salario min Estadual+verbas; 8 - Piso categoria+verbas.
        filial      := SRA-> RA_FILIAL              //Busca filial do colaborador. 
        filial      := SubStr(filial, 3, 2)         


        // Consulta a RCC para localizar o valor do sal�rio m�nimo. 
        cQuery	:= " SELECT RCC_FILIAL, RCC_CONTEU "
                cQuery	+= "  FROM " + RetSqlName("RCC") + " RCC"
                cQuery	+= " WHERE RCC.RCC_FILIAL  = '" + filial + "'"
                cQuery	+= "   AND RCC.RCC_CODIGO     = 'S004'"
                cQuery	+= "   AND RCC.RCC_CONTEU     LIKE '%"+ cAno +"%'"	
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

        // Obtem quantidade de horas
        nQtd65 := fBuscaPD("065","H") 

        // Obtem dados para o c�lculo 
        hrsMes   := SRA-> RA_HRSMES     //Busca a quantidade de horas mensal
        vlrSal   := SRA-> RA_SALARIO    //Busca o valor do sal�rio
        cPer     := SRA-> RA_ADCPERI    //Localiza se recebe periculosidade: 1 - N�o; 2 - Sim.
        cIns     := SRA-> RA_ADCINS     //Localiza se recebe insalubridade: 1 - N�o; 2 - Ins. M�n; 3 - Ins. M�d; 4 - Ins. M�x.

        // Obtem valor das verbas 

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

        
        IF ALLTRIM(SRA->RA_CODFUNC) $  AllTrim(codFunc1)

            //Calculo do valor do adicional noturno
            If salIncorp > vlrSal // Se o valor do sal�rio incorporador for maior que o valor do sal�rio c�lcula o Ad. Noturno com base no salario incorporado. 
                nVlrAdNot := ((salIncorp/hrsMes)*(perAdNot1/100))*nQtd65
            Else                  // Caso contr�rio utiliza valor do sal�rio. 
                nVlrAdNot := ((vlrSal/hrsMes)*(perAdNot1/100))*nQtd65
            EndIf

            // Gera verba Adicional Noturno
            If nQtd65 > 0    
                FdelPD("065")     
                FGeraVerba("065",nVlrAdNot,nQtd65,,,"H","C",,,,)        
            EndIf

        ELSEIF ALLTRIM(SRA->RA_CODFUNC) $  AllTrim(codFunc2)
            
            //Calculo do valor do adicional noturno
            If salIncorp > vlrSal // Se o valor do sal�rio incorporador for maior que o valor do sal�rio c�lcula o Ad. Noturno com base no salario incorporado. 
                nVlrAdNot := ((salIncorp/hrsMes)*(perAdNot2/100))*nQtd65
            Else                  // Caso contr�rio utiliza valor do sal�rio. 
                nVlrAdNot := ((vlrSal/hrsMes)*(perAdNot2/100))*nQtd65
            EndIf

            // Gera verba Adicional Noturno
            If nQtd65 > 0    
                FdelPD("065")     
                FGeraVerba("065",nVlrAdNot,nQtd65,,,"H","C",,,,)        
            EndIf            

        ELSEIF ALLTRIM(SRA->RA_CODFUNC) $  AllTrim(codFunc3)

            //Calculo do valor do adicional noturno
            If salIncorp > vlrSal // Se o valor do sal�rio incorporador for maior que o valor do sal�rio c�lcula o Ad. Noturno com base no salario incorporado. 
                nVlrAdNot := ((salIncorp/hrsMes)*(perAdNot3/100))*nQtd65
            Else                  // Caso contr�rio utiliza valor do sal�rio. 
                nVlrAdNot := ((vlrSal/hrsMes)*(perAdNot3/100))*nQtd65
            EndIf

            // Gera verba Adicional Noturno
            If nQtd65 > 0    
                FdelPD("065")     
                FGeraVerba("065",nVlrAdNot,nQtd65,,,"H","C",,,,)        
            EndIf                        

        Else 

             //Calculo do valor do adicional noturno
            If salIncorp > vlrSal // Se o valor do sal�rio incorporador for maior que o valor do sal�rio c�lcula o Ad. Noturno com base no salario incorporado. 
                nVlrAdNot := ((salIncorp/hrsMes)*(perAdNot/100))*nQtd65
            Else                  // Caso contr�rio utiliza valor do sal�rio. 
                nVlrAdNot := ((vlrSal/hrsMes)*(perAdNot/100))*nQtd65
            EndIf

            // Gera verba Adicional Noturno
            If nQtd65 > 0    
                FdelPD("065")     
                FGeraVerba("065",nVlrAdNot,nQtd65,,,"H","C",,,,)        
            EndIf
        EndIf


        RCE->(DbCloseArea())

Return()
