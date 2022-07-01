#Include "RWMAKE.CH"
#Include "TBICONN.CH"
#Include "TOPCONN.CH"
#Include "PROTHEUS.CH"

/*/{Protheus.doc} GP650CFO  - Ponto de entrada que realiza a inclusão dos dados do funcionário no cadastro do fornecedor.
@return		Retorno
@author		André Longhini
@version	1.0
@since		28/09/2021
@obs	
*/
User Function GP650CFO()

    Local aCampos := PARAMIXB
    Local cCodFor := ""
    Local cCodLoj := ""
    Local cTipCon := ""
    Local cTpCCon := ""

    cCodFor := GetSxENum("SA2", "A2_COD")
    cCodLoj	:= "01"
    cTipCon := SRA->RA_TPCTSAL
    cTpCCon := SRA->RA_XTPCON


    if cTpCCon == "2"

        aAdd(aCampos,{'A2_COD'     , cCpoFornec                                         , Nil})
        aAdd(aCampos,{'A2_LOJA'    , cCodLoj                                            , Nil})
        aAdd(aCampos,{'A2_NOME  '  , LTRIM(SRA->RA_NOME)                                , Nil})
        aAdd(aCampos,{'A2_NREDUZ'  , Substr(SRA->RA_NOME,1,20)                          , Nil})
        aAdd(aCampos,{'A2_END'     , LTRIM(SRA->RA_ENDEREC)                             , Nil})
        aAdd(aCampos,{'A2_EST'     , LTRIM(SRA->RA_ESTADO)                              , Nil})
        aAdd(aCampos,{'A2_MUN'     , LTRIM(SRA->RA_MUNICIP)                             , Nil})
        aAdd(aCampos,{'A2_TIPO'    , 'F'                                                , Nil})
        aAdd(aCampos,{'A2_CGC'     , SRA->RA_CIC                                        , Nil})
        aAdd(aCampos,{'A2_BAIRRO'  , Alltrim(SRA->RA_BAIRRO)                            , Nil})
        aAdd(aCampos,{'A2_COD_MUN' , SRA->RA_CODMUN                                     , Nil})
        aAdd(aCampos,{'A2_CEP'     , LTRIM(SRA->RA_CEP)                                 , Nil})
        aAdd(aCampos,{'A2_INSCR'   , 'ISENTO'                                           , Nil})
        aAdd(aCampos,{'A2_PAIS'    , '105'                                              , Nil})
        aAdd(aCampos,{'A2_EMAIL'   , SRA->RA_EMAIL                                      , Nil})
        aAdd(aCampos,{'A2_BANCO'   , Substr(SRA->RA_BCDEPSA,1,3)                        , Nil})
        aAdd(aCampos,{'A2_AGENCIA' , Substr(SRA->RA_BCDEPSA,4,4)                        , Nil})
        aAdd(aCampos,{'A2_NUMCON'  , Alltrim(Str(Val(Substr(SRA->RA_CTDEPSA,2,10))))    , Nil})
        aAdd(aCampos,{'A2_DVAGE'   , Substr(SRA->RA_BCDEPSA,8,1)                        , Nil})
        aAdd(aCampos,{'A2_DVCTA'   , Substr(SRA->RA_CTDEPSA,12,1)                       , Nil})

        DbSelectArea("FIL")
        FIL->(DbSetOrder(1))//FIL_FILIAL+FIL_FORNEC+FIL_LOJA+FIL_TIPO+FIL_BANCO+FIL_AGENCI+FIL_CONTA
        If !FIL->(DbSeek(xFilial("FIL")+(cCodLoj+cCodLoj)+"1"+(Substr(SRA->RA_BCDEPSA,1,3)+Substr(SRA->RA_BCDEPSA,4,4)+Alltrim(Str(Val(Substr(SRA->RA_CTDEPSA,1,11)))))))

            Reclock("FIL",.T.)
                FIL->FIL_FILIAL := xFilial("SA2")
                FIL->FIL_FORNEC := cCpoFornec
                FIL->FIL_LOJA 	:= cCodLoj
                FIL->FIL_BANCO 	:= Substr(SRA->RA_BCDEPSA,1,3)
                FIL->FIL_AGENCI := Substr(SRA->RA_BCDEPSA,4,4) 
                FIL->FIL_CONTA 	:= Alltrim(Str(Val(Substr(SRA->RA_CTDEPSA,2,10))))
                FIL->FIL_DETRAC := "0"
                FIL->FIL_MOEDA 	:= 1
                FIL->FIL_TIPO 	:= "1"
                FIL->FIL_DVAGE 	:= Substr(SRA->RA_BCDEPSA,8,1) 
                FIL->FIL_DVCTA 	:= Substr(SRA->RA_CTDEPSA,12,1) 
                FIL->FIL_TIPCTA := cTipCon
                if cTipCon == "1"
                    FIL->FIL_MOVCTO := "1"
                else 
                    FIL->FIL_MOVCTO := ""    
                endif
            FIL->(MsUnlock())

        EndIf

    ELSEIF cTpCCon == "1"

        aAdd(aCampos,{'A2_COD'     , cCpoFornec                                         , Nil})
        aAdd(aCampos,{'A2_LOJA'    , cCodLoj                                            , Nil})
        aAdd(aCampos,{'A2_NOME  '  , LTRIM(SRA->RA_XRSOC)                               , Nil})
        aAdd(aCampos,{'A2_NREDUZ'  , Substr(SRA->RA_XRSOC,1,20)                         , Nil})
        aAdd(aCampos,{'A2_END'     , LTRIM(SRA->RA_ENDEREC)                             , Nil})
        aAdd(aCampos,{'A2_EST'     , SRA->RA_ESTADO                                     , Nil})
        aAdd(aCampos,{'A2_MUN'     , LTRIM(SRA->RA_MUNICIP)                             , Nil})
        aAdd(aCampos,{'A2_TIPO'    , 'J'                                                , Nil})
        aAdd(aCampos,{'A2_CGC'     , SRA->RA_XCNPJ                                      , Nil})
        aAdd(aCampos,{'A2_BAIRRO'  , Alltrim(SRA->RA_BAIRRO)                            , Nil})
        aAdd(aCampos,{'A2_COD_MUN' , SRA->RA_CODMUN                                     , Nil})
        aAdd(aCampos,{'A2_CEP'     , SRA->RA_CEP                                        , Nil})
        aAdd(aCampos,{'A2_INSCR'   , SRA->RA_XINSC                                      , Nil})
        aAdd(aCampos,{'A2_PAIS'    , '105'                                              , Nil})
        aAdd(aCampos,{'A2_EMAIL'   , SRA->RA_EMAIL                                      , Nil})
        aAdd(aCampos,{'A2_BANCO'   , Substr(SRA->RA_BCDEPSA,1,3)                        , Nil})
        aAdd(aCampos,{'A2_AGENCIA' , Substr(SRA->RA_BCDEPSA,4,4)                        , Nil})
        aAdd(aCampos,{'A2_NUMCON'  , Alltrim(Str(Val(Substr(SRA->RA_CTDEPSA,2,10))))    , Nil})
        aAdd(aCampos,{'A2_DVAGE'   , Substr(SRA->RA_BCDEPSA,8,1)                        , Nil})
        aAdd(aCampos,{'A2_DVCTA'   , Substr(SRA->RA_CTDEPSA,12,1)                       , Nil})

        DbSelectArea("FIL")
        FIL->(DbSetOrder(1))//FIL_FILIAL+FIL_FORNEC+FIL_LOJA+FIL_TIPO+FIL_BANCO+FIL_AGENCI+FIL_CONTA
        If !FIL->(DbSeek(xFilial("FIL")+(cCodLoj+cCodLoj)+"1"+(Substr(SRA->RA_BCDEPSA,1,3)+Substr(SRA->RA_BCDEPSA,4,4)+Alltrim(Str(Val(Substr(SRA->RA_CTDEPSA,1,11)))))))

            Reclock("FIL",.T.)
                FIL->FIL_FILIAL := xFilial("SA2")
                FIL->FIL_FORNEC := cCpoFornec
                FIL->FIL_LOJA 	:= cCodLoj
                FIL->FIL_BANCO 	:= Substr(SRA->RA_BCDEPSA,1,3)
                FIL->FIL_AGENCI := Substr(SRA->RA_BCDEPSA,4,4) 
                FIL->FIL_CONTA 	:= Alltrim(Str(Val(Substr(SRA->RA_CTDEPSA,2,10))))
                FIL->FIL_DETRAC := "0"
                FIL->FIL_MOEDA 	:= 1
                FIL->FIL_TIPO 	:= "1"
                FIL->FIL_DVAGE 	:= Substr(SRA->RA_BCDEPSA,8,1) 
                FIL->FIL_DVCTA 	:= Substr(SRA->RA_CTDEPSA,12,1) 
                FIL->FIL_TIPCTA := cTipCon
                if cTipCon == "1"
                    FIL->FIL_MOVCTO := "1"
                else 
                    FIL->FIL_MOVCTO := ""    
                endif
            FIL->(MsUnlock())

        EndIf


    ENDIF

Return aCampos


