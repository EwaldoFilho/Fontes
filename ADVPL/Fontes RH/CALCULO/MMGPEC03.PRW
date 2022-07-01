#Include "RWMAKE.CH"
#Include "TBICONN.CH"
#Include "TOPCONN.CH"
#Include "PROTHEUS.CH"

/*/{Protheus.doc} MMGPEC03  - Fonte responsável pelo cáculo de gratificação por função
@return		Retorno
@author		André Longhini
@version	1.0
@since		18/10/2021
@obs	
*/
User Function MMGPEC03()


Local perGrat       := 0    // Recebe percentual da gratificação, conforme informado no campo RCE_XPGRT.
Local perGrat2      := 0    // Recebe percentual da gratificação, conforme informado no campo RCE_XPGR2.
Local perGrat3      := 0    // Recebe percentual da gratificação, conforme informado no campo RCE_XPGR3.
Local perGrat4      := 0    // Recebe percentual da gratificação, conforme informado no campo RCE_XPGR4.
Local bsCalc        := ""   // Recebe o tipo de base de cálculo, conforme campo RCE_XBSGT - 1 - Salário base, 2 - Salário incorporado, 3 - Salário mínimo, 4 - Piso do sindicato
Local bsCalc2       := ""   // Recebe o tipo de base de cálculo, conforme campo RCE_XBSGT2 - 1 - Salário base, 2 - Salário incorporado, 3 - Salário mínimo, 4 - Piso do sindicato
Local bsCalc3       := ""   // Recebe o tipo de base de cálculo, conforme campo RCE_XBSGT3 - 1 - Salário base, 2 - Salário incorporado, 3 - Salário mínimo, 4 - Piso do sindicato
Local bsCalc4       := ""   // Recebe o tipo de base de cálculo, conforme campo RCE_XBSGT4 - 1 - Salário base, 2 - Salário incorporado, 3 - Salário mínimo, 4 - Piso do sindicato
Local cPd0037       := ""   // Recebe código de verba com id 0037. 
Local cPd0038       := ""   // Recebe código de verba com id 0038. 
Local cPd0039       := ""   // Recebe código de verba com id 0039. 
Local cPd0036       := ""   // Recebe código de verba com id 0036. 
Local cPd0031       := ""   // Recebe código de verba com id 0031.    
Local nVlr0037      := 0    // Recebe o vlr da verba com id 0037. 
Local nVlr0038      := 0    // Recebe o vlr da verba com id 0038. 
Local nVlr0039      := 0    // Recebe o vlr da verba com id 0039. 
Local nVlr0036      := 0    // Recebe o vlr da verba com id 0036. 
Local nVlr0031      := 0    // Recebe o vlr da verba com id 0031.
Local codFunc       := ""   // Recebe o código das funções, conforme informado no campo RCE_XCFUG.
Local codFunc2      := ""   // Recebe o código das funções, conforme informado no campo RCE_XFG2.
Local codFunc3      := ""   // Recebe o código das funções, conforme informado no campo RCE_XCFG3.
Local codFunc4      := ""   // Recebe o código das funções, conforme informado no campo RCE_XCFG4.
Local salIncorp     := 0    // Recebe o valor do salário incorporado. 
Local nVlrGrat      := 0    // Recebe o valor da gratificação.
Local nQtd0031      := 0    // Recebe a quantidade da verba com id 0031. 
Local salMin        := 0    // Recebe o valor do salário mínimo. 
Local _cAlias	    := GetNextAlias()	// Recebe o próximo _cAlias.
Local cQuery	    := ""	
Local cAno      	:= cValtoChar(Year(dDataBase)) // Recebe o ano base. 
Local filial        := ""
Local vbGrat1       := ""   // Recebe o código da verba referente o percentual de gratificação 1
Local vbGrat2       := ""   // Recebe o código da verba referente o percentual de gratificação 2
Local vbGrat3       := ""   // Recebe o código da verba referente o percentual de gratificação 3
Local vbGrat4       := ""   // Recebe o código da verba referente o percentual de gratificação 4

		DbSelectArea("RCE")
		RCE->(dbsetorder(1))    //Cadastro de Sindicatos
		RCE->(DBSEEK(xFilial("RCE")+SRA->RA_SINDICA))
        
        filial     := SRA->RA_FILIAL
        filial     := SubStr(filial, 3, 2)
        perGrat     := RCE-> RCE_XPGRT      //Busca percentual da Gratificação de função - Campo RCE_XPGRT 
        perGrat2    := RCE-> RCE_XPGR2      //Busca percentual da Gratificação de função - Campo RCE_XPGR2 
        perGrat3    := RCE-> RCE_XPGR3      //Busca percentual da Gratificação de função - Campo RCE_XPGR3 
        perGrat4    := RCE-> RCE_XPGR4      //Busca percentual da Gratificação de função - Campo RCE_XPGR4 
        bsCalc      := RCE-> RCE_XBSGT      //Busca o tipo de base de cálculo, conforme campo RCE_XBSGT
        bsCalc2     := RCE-> RCE_XBSGT2     //Busca o tipo de base de cálculo, conforme campo RCE_XBSGT2
        bsCalc3     := RCE-> RCE_XBSGT3     //Busca o tipo de base de cálculo, conforme campo RCE_XBSGT3
        bsCalc4     := RCE-> RCE_XBSGT4     //Busca o tipo de base de cálculo, conforme campo RCE_XBSGT4
        codFunc     := RCE-> RCE_XCFUG      //Busca o código da função, conforme campo RCE_XCFUG
        codFunc2    := RCE-> RCE_XFG2       //Busca o código da função, conforme campo RCE_XFU2
        codFunc3    := RCE-> RCE_XCFG3      //Busca o código da função, conforme campo RCE_XCFG3
        codFunc4    := RCE-> RCE_XCFG4      //Busca o código da função, conforme campo RCE_XCFG4
        vlrPiso     := RCE-> RCE_PISO       //Busca o valor do piso salarial da categoria
        vbGrat1     := RCE-> RCE_XVBGT      //Busca a verba referente a gratificação RCE_XPGRT
        vbGrat2     := RCE-> RCE_XVBGT2     //Busca a verba referente a gratificação RCE_XPGR2
        vbGrat3     := RCE-> RCE_XVBGT3     //Busca a verba referente a gratificação RCE_XPGR3
        vbGrat4     := RCE-> RCE_XVBGT4     //Busca a verba referente a gratificação RCE_XPGR4

        // Consulta a RCC para localizar o valor do salário mínimo. 
        cQuery	:= " SELECT RCC_FILIAL, RCC_CONTEU "
                cQuery	+= "  FROM " + RetSqlName("RCC") + " RCC"
                cQuery	+= " WHERE RCC.RCC_FILIAL  = '" + filial + "'"
                cQuery	+= "   AND RCC.RCC_CODIGO     = 'S004'"
                cQuery	+= "   AND RCC.RCC_CONTEU     LIKE '%"+ cAno +"%'"	
                cQuery	+= "   AND RCC.D_E_L_E_T_ = ' '"
                cQuery	+= " GROUP BY RCC_FILIAL, RCC_CONTEU "
                cQuery	+= " ORDER BY  RCC_FILIAL, RCC_CONTEU DESC"

        DBUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery), _cAlias , .T. , .F.)

        salMin := (_cAlias)->RCC_CONTEU // Recebe o conteúdo do campo RCC_CONTEU
        
        salMin := substr(salMin,18,7)   // Isola o valor referente ao salário mín. 

        salMin := GetdToVal(StrTran(salMin,".",","))    // Converte o dado caracter para número. 

        

        IF bsCalc == '1'

            IF ALLTRIM(SRA->RA_CODFUNC) $  ALLTRIM(codFunc)
                // Obtem código de verbas
                cPd0031 := aCodFol[0031,1] 	// Verba de Salário. 

                // Obtem valor das verbas 
                nVlr0031 := fBuscaPD(cPd0031) 	// Vlr Salário.

                // Obtem quantidade das verbas
                nQtd0031 := fBuscaPD(cPd0031,"H")     
                    
                //Calculo do valor da Gratificação
                If nVlr0031 > 0 // Se o valor do salário incorporador for maior que o valor do salário cálcula o Ad. Noturno com base no salario incorporado. 
                    nVlrGrat := (nVlr0031*(perGrat/100))
                EndIf

                // Gera verba Gratificação
                If nVlrGrat > 0    
                    FGeraVerba(vbGrat1,nVlrGrat,nQtd0031,,,"V","C",,,,)        
                EndIf

            EndIf


        ELSEIF bsCalc == '2'

            IF ALLTRIM(SRA->RA_CODFUNC) $  ALLTRIM(codFunc)

                // Obtem código de verbas
                cPd0037 := aCodFol[0037,1]  // Verba de insalubridade Min. 
                cPd0038 := aCodFol[0038,1] 	// Verba de insalubridade Méd. 
                cPd0039 := aCodFol[0039,1] 	// Verba de insalubridade Máx.     
                cPd0036 := aCodFol[0036,1] 	// Verba de Periculasidade. 
                cPd0031 := aCodFol[0031,1] 	// Verba de Salário. 

                // Obtem valor das verbas 
                nVlr0037 := fBuscaPD(cPd0037) 	// Vlr insalubridade Min. 
                nVlr0038 := fBuscaPD(cPd0038) 	// Vlr insalubridade Méd. 
                nVlr0039 := fBuscaPD(cPd0039) 	// Vlr insalubridade Máx. 
                nVlr0036 := fBuscaPD(cPd0036) 	// Vlr Periculasidade.
                nVlr0031 := fBuscaPD(cPd0031) 	// Vlr Salário.

                // Obtem quantidade das verbas
                nQtd0031 := fBuscaPD(cPd0031,"H")     
                    
                //Calcula o valor do salário incorporado
                salIncorp := nVlr0031 + nVlr0037 + nVlr0038 + nVlr0039 + nVlr0036 // Soma valor das verbas encontradas com o valor do salário. 

                //Calculo do valor da Gratificação
                If salIncorp > 0 // Se o valor do salário incorporador for maior que o valor do salário cálcula o Ad. Noturno com base no salario incorporado. 
                    nVlrGrat := (salIncorp*(perGrat/100))
                EndIf

                // Gera verba Gratificação
                If nVlrGrat > 0    
                    FGeraVerba(vbGrat1,nVlrGrat,nQtd0031,,,"V","C",,,,)        
                EndIf

            EndIf


        ELSEIF bsCalc == '3'

            IF ALLTRIM(SRA->RA_CODFUNC) $  ALLTRIM(codFunc)

                // Obtem quantidade das verbas
                nQtd0031 := fBuscaPD(cPd0031,"H")     
                    
                //Calculo do valor da Gratificação
                If salMin > 0 // Se o valor do salário incorporador for maior que o valor do salário cálcula o Ad. Noturno com base no salario incorporado. 
                    nVlrGrat := (salMin*(perGrat/100))
                EndIf

                // Gera verba Gratificação
                If nVlrGrat > 0    
                    FGeraVerba(vbGrat1,nVlrGrat,nQtd0031,,,"V","C",,,,)        
                EndIf

            EndIf

                    
        ELSEIF bsCalc == '4'


            IF ALLTRIM(SRA->RA_CODFUNC) $  ALLTRIM(codFunc)

                nVlr0031 := fBuscaPD(cPd0031) 	// Vlr Salário.

                // Obtem quantidade das verbas
                nQtd0031 := fBuscaPD(cPd0031,"H")     
                    
                //Calculo do valor da Gratificação
                If vlrPiso > 0 // Se o valor do salário incorporador for maior que o valor do salário cálcula o Ad. Noturno com base no salario incorporado. 
                    nVlrGrat := (vlrPiso*(perGrat/100))
                EndIf

                // Gera verba Gratificação
                If nVlrGrat > 0    
                    FGeraVerba(vbGrat1,nVlrGrat,nQtd0031,,,"V","C",,,,)        
                EndIf
            EndIF
        
        EndIf
        
        IF bsCalc2 == '1'

            IF  ALLTRIM(SRA->RA_CODFUNC) $  ALLTRIM(codFunc2)
                // Obtem código de verbas
                cPd0031 := aCodFol[0031,1] 	// Verba de Salário. 

                // Obtem valor das verbas 
                nVlr0031 := fBuscaPD(cPd0031) 	// Vlr Salário.

                // Obtem quantidade das verbas
                nQtd0031 := fBuscaPD(cPd0031,"H")     
                    
                //Calculo do valor da Gratificação
                If nVlr0031 > 0 // Se o valor do salário incorporador for maior que o valor do salário cálcula o Ad. Noturno com base no salario incorporado. 
                    nVlrGrat := (nVlr0031*(perGrat2/100))
                EndIf

                // Gera verba Gratificação
                If nVlrGrat > 0    
                    FGeraVerba(vbGrat2,nVlrGrat,nQtd0031,,,"V","C",,,,)        
                EndIf

            endif

        ElseIF bsCalc2 == '2'

            if ALLTRIM(SRA->RA_CODFUNC) $  ALLTRIM(codFunc2)

                // Obtem código de verbas
                cPd0037 := aCodFol[0037,1]  // Verba de insalubridade Min. 
                cPd0038 := aCodFol[0038,1] 	// Verba de insalubridade Méd. 
                cPd0039 := aCodFol[0039,1] 	// Verba de insalubridade Máx.     
                cPd0036 := aCodFol[0036,1] 	// Verba de Periculasidade. 
                cPd0031 := aCodFol[0031,1] 	// Verba de Salário. 

                // Obtem valor das verbas 
                nVlr0037 := fBuscaPD(cPd0037) 	// Vlr insalubridade Min. 
                nVlr0038 := fBuscaPD(cPd0038) 	// Vlr insalubridade Méd. 
                nVlr0039 := fBuscaPD(cPd0039) 	// Vlr insalubridade Máx. 
                nVlr0036 := fBuscaPD(cPd0036) 	// Vlr Periculasidade.
                nVlr0031 := fBuscaPD(cPd0031) 	// Vlr Salário.

                // Obtem quantidade das verbas
                nQtd0031 := fBuscaPD(cPd0031,"H")     
                    
                //Calcula o valor do salário incorporado
                salIncorp := nVlr0031 + nVlr0037 + nVlr0038 + nVlr0039 + nVlr0036 // Soma valor das verbas encontradas com o valor do salário. 

                //Calculo do valor da Gratificação
                If salIncorp > 0 // Se o valor do salário incorporador for maior que o valor do salário cálcula o Ad. Noturno com base no salario incorporado. 
                    nVlrGrat := (salIncorp*(perGrat2/100))
                EndIf

                // Gera verba Gratificação
                If nVlrGrat > 0    
                    FGeraVerba(vbGrat2,nVlrGrat,nQtd0031,,,"V","C",,,,)        
                EndIf
            endif

        ElseIF bsCalc2 == '3'

            IF ALLTRIM(SRA->RA_CODFUNC) $  ALLTRIM(codFunc2)

                // Obtem quantidade das verbas
                nQtd0031 := fBuscaPD(cPd0031,"H")     
                    
                //Calculo do valor da Gratificação
                If salMin > 0 // Se o valor do salário incorporador for maior que o valor do salário cálcula o Ad. Noturno com base no salario incorporado. 
                    nVlrGrat := (salMin*(perGrat2/100))
                EndIf

                // Gera verba Gratificação
                If nVlrGrat > 0    
                    FGeraVerba(vbGrat2,nVlrGrat,nQtd0031,,,"V","C",,,,)        
                EndIf

            EndIf

        ElseIF bsCalc2 == '4'

            IF ALLTRIM(SRA->RA_CODFUNC) $  ALLTRIM(codFunc2)

                nVlr0031 := fBuscaPD(cPd0031) 	// Vlr Salário.

                // Obtem quantidade das verbas
                nQtd0031 := fBuscaPD(cPd0031,"H")     
                    
                //Calculo do valor da Gratificação
                If vlrPiso > 0 // Se o valor do salário incorporador for maior que o valor do salário cálcula o Ad. Noturno com base no salario incorporado. 
                    nVlrGrat := (vlrPiso*(perGrat2/100))
                EndIf

                // Gera verba Gratificação
                If nVlrGrat > 0    
                    FGeraVerba(vbGrat2,nVlrGrat,nQtd0031,,,"V","C",,,,)        
                EndIf
            EndIF


        EndIF

        IF bsCalc3 == '1'

            IF  ALLTRIM(SRA->RA_CODFUNC) $  ALLTRIM(codFunc3)
                // Obtem código de verbas
                cPd0031 := aCodFol[0031,1] 	// Verba de Salário. 

                // Obtem valor das verbas 
                nVlr0031 := fBuscaPD(cPd0031) 	// Vlr Salário.

                // Obtem quantidade das verbas
                nQtd0031 := fBuscaPD(cPd0031,"H")     
                    
                //Calculo do valor da Gratificação
                If nVlr0031 > 0 // Se o valor do salário incorporador for maior que o valor do salário cálcula o Ad. Noturno com base no salario incorporado. 
                    nVlrGrat := (nVlr0031*(perGrat3/100))
                EndIf

                // Gera verba Gratificação
                If nVlrGrat > 0    
                    FGeraVerba(vbGrat3,nVlrGrat,nQtd0031,,,"V","C",,,,)        
                EndIf

            endif

        ElseIF bsCalc3 == '2'

            if ALLTRIM(SRA->RA_CODFUNC) $  ALLTRIM(codFunc3)

                // Obtem código de verbas
                cPd0037 := aCodFol[0037,1]  // Verba de insalubridade Min. 
                cPd0038 := aCodFol[0038,1] 	// Verba de insalubridade Méd. 
                cPd0039 := aCodFol[0039,1] 	// Verba de insalubridade Máx.     
                cPd0036 := aCodFol[0036,1] 	// Verba de Periculasidade. 
                cPd0031 := aCodFol[0031,1] 	// Verba de Salário. 

                // Obtem valor das verbas 
                nVlr0037 := fBuscaPD(cPd0037) 	// Vlr insalubridade Min. 
                nVlr0038 := fBuscaPD(cPd0038) 	// Vlr insalubridade Méd. 
                nVlr0039 := fBuscaPD(cPd0039) 	// Vlr insalubridade Máx. 
                nVlr0036 := fBuscaPD(cPd0036) 	// Vlr Periculasidade.
                nVlr0031 := fBuscaPD(cPd0031) 	// Vlr Salário.

                // Obtem quantidade das verbas
                nQtd0031 := fBuscaPD(cPd0031,"H")     
                    
                //Calcula o valor do salário incorporado
                salIncorp := nVlr0031 + nVlr0037 + nVlr0038 + nVlr0039 + nVlr0036 // Soma valor das verbas encontradas com o valor do salário. 

                //Calculo do valor da Gratificação
                If salIncorp > 0 // Se o valor do salário incorporador for maior que o valor do salário cálcula o Ad. Noturno com base no salario incorporado. 
                    nVlrGrat := (salIncorp*(perGrat3/100))
                EndIf

                // Gera verba Gratificação
                If nVlrGrat > 0    
                    FGeraVerba(vbGrat3,nVlrGrat,nQtd0031,,,"V","C",,,,)        
                EndIf
            endif

        ElseIF bsCalc3 == '3'

            IF ALLTRIM(SRA->RA_CODFUNC) $  ALLTRIM(codFunc3)

                // Obtem quantidade das verbas
                nQtd0031 := fBuscaPD(cPd0031,"H")     
                    
                //Calculo do valor da Gratificação
                If salMin > 0 // Se o valor do salário incorporador for maior que o valor do salário cálcula o Ad. Noturno com base no salario incorporado. 
                    nVlrGrat := (salMin*(perGrat3/100))
                EndIf

                // Gera verba Gratificação
                If nVlrGrat > 0    
                    FGeraVerba(vbGrat3,nVlrGrat,nQtd0031,,,"V","C",,,,)        
                EndIf

            EndIf

        ElseIF bsCalc3 == '4'

            IF ALLTRIM(SRA->RA_CODFUNC) $  ALLTRIM(codFunc3)

                nVlr0031 := fBuscaPD(cPd0031) 	// Vlr Salário.

                // Obtem quantidade das verbas
                nQtd0031 := fBuscaPD(cPd0031,"H")     
                    
                //Calculo do valor da Gratificação
                If vlrPiso > 0 // Se o valor do salário incorporador for maior que o valor do salário cálcula o Ad. Noturno com base no salario incorporado. 
                    nVlrGrat := (vlrPiso*(perGrat3/100))
                EndIf

                // Gera verba Gratificação
                If nVlrGrat > 0    
                    FGeraVerba(vbGrat3,nVlrGrat,nQtd0031,,,"V","C",,,,)        
                EndIf
            EndIF


        EndIF        

        IF bsCalc4 == '1'

            IF  ALLTRIM(SRA->RA_CODFUNC) $  ALLTRIM(codFunc4)
                // Obtem código de verbas
                cPd0031 := aCodFol[0031,1] 	// Verba de Salário. 

                // Obtem valor das verbas 
                nVlr0031 := fBuscaPD(cPd0031) 	// Vlr Salário.

                // Obtem quantidade das verbas
                nQtd0031 := fBuscaPD(cPd0031,"H")     
                    
                //Calculo do valor da Gratificação
                If nVlr0031 > 0 // Se o valor do salário incorporador for maior que o valor do salário cálcula o Ad. Noturno com base no salario incorporado. 
                    nVlrGrat := (nVlr0031*(perGrat4/100))
                EndIf

                // Gera verba Gratificação
                If nVlrGrat > 0    
                    FGeraVerba(vbGrat4,nVlrGrat,nQtd0031,,,"V","C",,,,)        
                EndIf

            endif

        ElseIF bsCalc4 == '2'

            if ALLTRIM(SRA->RA_CODFUNC) $  ALLTRIM(codFunc4)

                // Obtem código de verbas
                cPd0037 := aCodFol[0037,1]  // Verba de insalubridade Min. 
                cPd0038 := aCodFol[0038,1] 	// Verba de insalubridade Méd. 
                cPd0039 := aCodFol[0039,1] 	// Verba de insalubridade Máx.     
                cPd0036 := aCodFol[0036,1] 	// Verba de Periculasidade. 
                cPd0031 := aCodFol[0031,1] 	// Verba de Salário. 

                // Obtem valor das verbas 
                nVlr0037 := fBuscaPD(cPd0037) 	// Vlr insalubridade Min. 
                nVlr0038 := fBuscaPD(cPd0038) 	// Vlr insalubridade Méd. 
                nVlr0039 := fBuscaPD(cPd0039) 	// Vlr insalubridade Máx. 
                nVlr0036 := fBuscaPD(cPd0036) 	// Vlr Periculasidade.
                nVlr0031 := fBuscaPD(cPd0031) 	// Vlr Salário.

                // Obtem quantidade das verbas
                nQtd0031 := fBuscaPD(cPd0031,"H")     
                    
                //Calcula o valor do salário incorporado
                salIncorp := nVlr0031 + nVlr0037 + nVlr0038 + nVlr0039 + nVlr0036 // Soma valor das verbas encontradas com o valor do salário. 

                //Calculo do valor da Gratificação
                If salIncorp > 0 // Se o valor do salário incorporador for maior que o valor do salário cálcula o Ad. Noturno com base no salario incorporado. 
                    nVlrGrat := (salIncorp*(perGrat4/100))
                EndIf

                // Gera verba Gratificação
                If nVlrGrat > 0    
                    FGeraVerba(vbGrat4,nVlrGrat,nQtd0031,,,"V","C",,,,)        
                EndIf
            endif

        ElseIF bsCalc4 == '3'

            IF ALLTRIM(SRA->RA_CODFUNC) $  ALLTRIM(codFunc4)

                // Obtem quantidade das verbas
                nQtd0031 := fBuscaPD(cPd0031,"H")     
                    
                //Calculo do valor da Gratificação
                If salMin > 0 // Se o valor do salário incorporador for maior que o valor do salário cálcula o Ad. Noturno com base no salario incorporado. 
                    nVlrGrat := (salMin*(perGrat4/100))
                EndIf

                // Gera verba Gratificação
                If nVlrGrat > 0    
                    FGeraVerba(vbGrat4,nVlrGrat,nQtd0031,,,"V","C",,,,)        
                EndIf

            EndIf

        ElseIF bsCalc4 == '4'

            IF ALLTRIM(SRA->RA_CODFUNC) $  ALLTRIM(codFunc4)

                nVlr0031 := fBuscaPD(cPd0031) 	// Vlr Salário.

                // Obtem quantidade das verbas
                nQtd0031 := fBuscaPD(cPd0031,"H")     
                    
                //Calculo do valor da Gratificação
                If vlrPiso > 0 // Se o valor do salário incorporador for maior que o valor do salário cálcula o Ad. Noturno com base no salario incorporado. 
                    nVlrGrat := (vlrPiso*(perGrat4/100))
                EndIf

                // Gera verba Gratificação
                If nVlrGrat > 0    
                    FGeraVerba(vbGrat4,nVlrGrat,nQtd0031,,,"V","C",,,,)        
                EndIf
            EndIF


        EndIF


        DbCloseArea()
        RCE->(DbCloseArea())

Return()
