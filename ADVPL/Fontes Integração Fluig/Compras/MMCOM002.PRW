#Include 'Protheus.ch'
#INCLUDE "RWMAKE.CH"
#INCLUDE "TBICONN.CH" 
  
/**************************************************************************************************
{Protheus.doc} fGrav160
@description	Funcao para encerrar a cotacao
@type   		User Function	
@author			Lucas Rocha Vieira
@version   		1.00
@since     		11/10/2021
@database		11/10/2021
@country		Brasil
@language		PT-BR
@obs			11/10/2021 - Controle de documentacao
@param			
@return						
*****************************************************************************************************/
User Function fGrav160(oJson,_cFornec, _cLojaFor, _cEmpC, _cFilC, _cCotacao, _cItemCot, _cnProd, _cQtProd, _cCentrocusto, _cDescCentrocusto, _cSolicitante, _cNumProcesso, _cNumSc, _aProduto)

Local _cCt                := _cCotacao
Local _cArmzm             := ""  
Local _cCotNum            := "" 
Local _cImCt              := ""   
Local _cCodPt             := ""  
Local _cQntPd             := ""  
Local _cFornc             := ""  
Local _cLojaF             := ""
Local _cPrecUnitario      := ""
Local _cPrecoTotal        := ""
Local _cCodPagamento      := ""
Local nY                  := 0
Local _nCont              := 0
Local nArray              := 0
Local nLaco               := 1

Private _cMsg       := ""
Private cDoc        := ""

    
PRIVATE lMsErroAuto := .F.

   //---------------------------------------------------------------------------
   // ABERTURA DO AMBIENTE
   //---------------------------------------------------------------------------
   // PREPARE ENVIRONMENT EMPRESA _cEmpC FILIAL _cFilC MODULO "COM" 
    RpcClearEnv()
    RpcSetEnv( _cEmpC,_cFilC)

    //PEDIDO DE COMPRA
    DbSelectArea("SC7")
    //SC7->(dbSetOrder(1))

    //ENCERRAMENTO COTACAO
    DbSelectArea("SCE")

    //COTACAO
    DbSelectArea("SC8")
    //SC8->(DbSetOrder(1))//FILIAL + NUM. COTACAO + NUM ITEMSC
        For nY := 1 To Len(_aProduto)

            nArray++

            _cArmzm            := IIF(_aProduto[nY][1] == "carmazem"       .AND.  _aProduto[nArray][3] == nLaco    , _aProduto[nY][2], _cArmzm                      )    
            _cImCt             := IIF(_aProduto[nY][1] == "citemcotac"     .AND.  _aProduto[nArray][3] == nLaco    , _aProduto[nY][2], _cImCt                       )
            _cCodPt            := IIF(_aProduto[nY][1] == "cnprod"         .AND.  _aProduto[nArray][3] == nLaco    , _aProduto[nY][2], _cCodPt                      )
            _cQntPd            := IIF(_aProduto[nY][1] == "cqtdprod"       .AND.  _aProduto[nArray][3] == nLaco    , _aProduto[nY][2], _cQntPd                      )
            _cFornc            := IIF(_aProduto[nY][1] == "cfornecedor"    .AND.  _aProduto[nArray][3] == nLaco    , _aProduto[nY][2], _cFornc                      )  
            _cLojaF            := IIF(_aProduto[nY][1] == "clojaforn"      .AND.  _aProduto[nArray][3] == nLaco    , _aProduto[nY][2], _cLojaF                      )  
            _cPrecUnitario     := IIF(_aProduto[nY][1] == "cprecounid"     .AND.  _aProduto[nArray][3] == nLaco    , _aProduto[nY][2], _cPrecUnitario               )  
            _cPrecoTotal       := IIF(_aProduto[nY][1] == "cprecototal"    .AND.  _aProduto[nArray][3] == nLaco    , _aProduto[nY][2], _cPrecoTotal                 )  
            _cCodPagamento     := IIF(_aProduto[nY][1] == "ccodpag"        .AND.  _aProduto[nArray][3] == nLaco    , _aProduto[nY][2], _cCodPagamento               )  

            If  !Empty(_cCt)             .AND.;
                !Empty(_cArmzm)          .AND.;
                !Empty(_cImCt)           .AND.;
                !Empty(_cQntPd)          .AND.;
                !Empty(_cLojaF)          .AND.;
                !Empty(_cCodPt)          .AND.;
                !Empty(_cFornc)          .AND.;
                !Empty(_cPrecUnitario)   .AND.;
                !Empty(_cPrecoTotal)     .AND.;
                !Empty(_cCodPagamento) 
                                
                    // contar do _aProduto ESTA PREENCHIDO CORRETO
                    _nCont++
                    
                    //Funcao para verificar cotacao
                    If !(ValidTables(_cCt, _cFornc, _cLojaF, _cImCt, _cFilC ))
                        Return(.F.)
                    EndIf 

                    //Funcao para gerar pedido de compra
                    If !(InputSC7(_cCt, _cArmzm, _cCotNum, _cImCt, _cQntPd, _cFornc, _cLojaF, _cFilC, _cCodPt, _cCentrocusto, _cDescCentrocusto, _cSolicitante, _cNumProcesso,  _cPrecUnitario, _cPrecoTotal, _cNumSc, _cCodPagamento))
                        Return(.F.)
                    EndIf 
                
                    nLaco++;

                    _cArmzm         := ""
                    _cImCt          := ""
                    _cCodPt         := ""
                    _cQntPd         := ""
                    _cFornc         := ""
                    _cLojaF         := ""
                    _cPrecUnitario  := ""
                    _cPrecoTotal    := ""
                    _cCodPagamento  := ""

            EndIf
        Next 

    If _nCont == 0 
        _cMsg := "Json enviado esta incompleto ou com erro!"
        Treatment(.T., _cMsg)
    EndIf

    //SC8->(DBCloseArea())
    //SC7->(DBCloseArea())
    //SCE->(DBCloseArea())
         
    RpcClearEnv()

Return(.T.)

/**************************************************************************************************
{Protheus.doc} Treatment
@description	Tratativa para mensagem do conout
@type   		funcao
@author			Lucas Rocha Vieira
@version   		1.00
@since     		31/10/2021
@database		31/10/2021
@country		Brasil
@language		PT-BR
@obs			31/10/2021 - Controle de documentacao
@param			
@return						
*****************************************************************************************************/
Static Function Treatment(lmistake, cMessage)

Default lmistake := .T.
Default cMessage := ""

    //--------------------------------------------------------------------------------------
    // Tratamento do Conout
    //--------------------------------------------------------------------------------------
    If lmistake
        ConOut("**ALERTA DE ERRO - FONTE MMCOM002**")
        ConOut(cMessage)
    Else 
        ConOut("**SUCESSO NA ETAPA DO PEDIDO DE COMPRA - FONTE MMCOM002**")
        ConOut(cMessage)
    EndIf 

Return

/**************************************************************************************************
{Protheus.doc} InputSC7
@description	Funcao para gravar o pedido
@type   		funcao
@author			Lucas Rocha Vieira
@version   		1.00
@since     		31/10/2021
@database		31/10/2021
@country		Brasil
@language		PT-BR
@obs			31/10/2021 - Controle de documentacao
@param			
@return						
*****************************************************************************************************/
Static Function InputSC7(_cCt, _cArmzm, _cCotNum, _cImCt, _cQntPd, _cFornc, _cLojaF, _cFilC, _cCodPt, _cCentrocusto, _cDescCentrocusto, _cSolicitante, _cNumProcesso, _cPrecoUnitario, _cPrecoTotal, _cNumSc, _cCodPag)

    Local aCabec  := {}
    Local aItens  := {}
    Local aLinha  := {}
    
    Local _cNumItem := ""
    Local _cNumS    := ""

    PRIVATE lMsErroAuto := .F.

    RpcClearEnv()
    RpcSetEnv("01",_cFilC)

    conout("MATA_120:::"+xFilial("SC7") )

    //--------------------------------------------------------------------------------
    // PROXIMO CODIGO SC7
    //--------------------------------------------------------------------------------
    cDoc := GetSXENum("SC7","C7_NUM")

    While SC7->(dbSeek(_cFilC+cDoc))
        ConfirmSX8()
        cDoc := GetSXENum("SC7","C7_NUM")
    EndDo

    _cMsg := "Iniciando processo de execauto SC7.: " +_cCt+" ! "+CRLF
    
    Aadd(aCabec,{"C7_NUM"           ,   cDoc                          })//NUM PEDIDO
    Aadd(aCabec,{"C7_EMISSAO"       ,   dDataBase                     })//DATA EMISSAO
    Aadd(aCabec,{"C7_FORNECE"       ,   _cFornc                       })//FORNECEDOR
    Aadd(aCabec,{"C7_LOJA"          ,   _cLojaF                       })//LOJA
    Aadd(aCabec,{"C7_COND"          ,   _cCodPag                      })//COD PAGAMENTO
    Aadd(aCabec,{"C7_FILENT"        ,   _cFilC                        })//FILIAL ENTREGA
    Aadd(aCabec,{"C7_MOEDA"         ,   1                             })//MOEDA

    aLinha := {}
    Aadd(aLinha,{"C7_PRODUTO"        ,   _cCodPt,Nil                  })//COD PRODUTO
    Aadd(aLinha,{"C7_QUANT"          ,   Val(_cQntPd),Nil             })//QUANTIDADE
    Aadd(aLinha,{"C7_PRECO"          ,   Val(_cPrecoUnitario),Nil     })//PRECO
    Aadd(aLinha,{"C7_TOTAL"          ,   Val(_cPrecoTotal),Nil        })//TOTAL
    Aadd(aLinha,{"C7_LOCAL"          ,   _cArmzm ,Nil                 })//LOCAL
    Aadd(aLinha,{"C7_CC"             ,   _cCentrocusto,Nil            })//CENTRO DE CUSTO
    Aadd(aLinha,{"C7_XDESCC"         ,   _cDescCentrocusto,Nil        })//DESC CENTRO DE CUSTO
    Aadd(aLinha,{"C7_XSOLICI"        ,   _cSolicitante,Nil            })//SOLCITANTE
    Aadd(aLinha,{"C7_XZSOLIC"        ,   _cNumProcesso,Nil            })//NUM PROCESSO FLUIG
   
    Aadd(aItens,aLinha)

    MSExecAuto({|v,x,y,z,w| MATA120(v,x,y,z,w)},1,aCabec,aItens,3,.F.)

    If !lMsErroAuto
        _cMsg += "Incluido o pedido de compra com sucesso! "+cDoc+CRLF
        _cMsg += "Fim : "+Time()+CRLF
    Else
        _cMsg := "Erro na inclusao do pedido de compra"
        Treatment(.T., _cMsg)
        Return(.F.)
    EndIf

    //Funcoes para atualizar a situacao da cotacao no sistema
    _cNumItem := "0001"
    _cNumS    := cDoc

    UpdateStatusCotacao(_cFilC, _cCt, _cImCt, _cLojaF, _cFornc, _cCodPt, _cQntPd, _cNumItem, _cNumS)

    RpcClearEnv()

Return(.T.)

/**************************************************************************************************
{Protheus.doc} ValidTables
@description	Funcao para validacao 
@type   		funcao
@author			Lucas Rocha Vieira
@version   		1.00
@since     		31/10/2021
@database		31/10/2021
@country		Brasil
@language		PT-BR
@obs			31/10/2021 - Controle de documentacao
@param			
@return						
*****************************************************************************************************/
Static Function ValidTables(_cCt, _cFornc, _cLojaF, _cImCt, _cFilial )

    //--------------------------------------------------------------------------------
    // VERIFICA A COTACAO E POSICIONA
    //--------------------------------------------------------------------------------
    RpcClearEnv()
    RpcSetEnv("01",_cFilial)

    If  !SC8->(DbSeek(_cFilial+_cCt +_cFornc +_cLojaF + _cImCt) )
        _cMsg := "Nao encontrou a cotacao de numero.: " +_cCt+" ! "
        Treatment(.T., _cMsg)
        Return(.F.)
    EndIf

    RpcClearEnv()
Return(.T.)

/**************************************************************************************************
{Protheus.doc}  UpdateStatusCotacao
@description	Funcao para atualizar status das cotacoes realizadas
@type   		funcao
@author			Marcus Vinicius
@version   		1.00
@since     		12/02/2022
@database		12/02/2022
@country		Brasil
@language		PT-BR
@obs			
@param			
@return						
*****************************************************************************************************/
Static Function UpdateStatusCotacao(_cFilC, _cCt, _cImCt, _cLojaF, _cFornc, _cCodPt, _cQntPd, _cItem, _cNum)
    RpcClearEnv()
    RpcSetEnv("01",_cFilC)

    If  !SC8->(DbSeek(_cFilC+_cCt +_cFornc +_cLojaF + _cImCt) )
        _cMsg := "Nao foi possivel encontrar o pedido de compra.: " +cDoc+" ! "
        Treatment(.T., _cMsg)
        Return(.F.)
    Else
        //Atualizada status cotacao
        SC8->(RecLock("SC8",.F.))
            SC8->C8_ITEMPED := _cItem
            SC8->C8_NUMPED  := _cNum
        SC8->(MsUnlock())
        
        //Atualiza historico das cotacoes
        SCE->(RecLock("SCE",.T.))
            SCE->CE_FILIAL  := _cFilC
            SCE->CE_NUMCOT  := _cCt
            SCE->CE_ITEMCOT := _cImCt
            SCE->CE_NUMPRO  := "01"
            SCE->CE_PRODUTO := _cCodPt
            SCE->CE_FORNECE := _cFornc
            SCE->CE_LOJA    := SC8->C8_LOJA
            SCE->CE_QUANT   := Val(_cQntPd)
            SCE->CE_ENTREGA := SC8->C8_DATPRF
        SCE->(MsUnlock())

        Return(.T.)
    EndIf

    RpcClearEnv()

Return(.T.)


/**************************************************************************************************
{Protheus.doc}  UpdateHistoricoCotacao
@description	Funcao para atualizar o histórico das cotacoes realizadas
@type   		funcao
@author			Marcus Vinicius
@version   		1.00
@since     		12/02/2022
@database		12/02/2022
@country		Brasil
@language		PT-BR
@obs			
@param			
@return						
*****************************************************************************************************/
Static Function UpdateHistoricoCotacao()

Return(.T.)

/**************************************************************************************************
{Protheus.doc} UpdateSc8
@description	Funcao para atualizar status das cotacoes que ficaram em aberto
@type   		funcao
@author			Lucas Rocha Vieira
@version   		1.00
@since     		07/12/2021
@database		07/12/2021
@country		Brasil
@language		PT-BR
@obs			07/12/2021 - Controle de documentacao
@param			
@return						
*****************************************************************************************************/
Static Function UpdateSc8(_cCt, _cFilC)

    Local _cQry     := ""
    Local _cAlias   := GetNextAlias()
    Local _cNum     := ""
    Local _cForn    := ""
    Local _cLoja    := ""
    Local _ciTem    := ""

    RpcClearEnv()
    RpcSetEnv("01",_cFilC)

    DbSelectArea("SC8")
    SC8->(DBGoTop())

    _cQry := "SELECT                            "
    _cQry += "C8_NUM      ,                     "
    _cQry += "C8_FORNECE  ,                     "
    _cQry += "C8_LOJA     ,                     "
    _cQry += "C8_ITEM     ,                     "
    _cQry += "C8_ITEMPED  ,                     "
    _cQry += "C8_NUMPED                         "
    _cQry += "FROM "+RetSqlName("SC8") +" C8    "
    _cQry += "WHERE                             "
    _cQry += "C8_NUM        =  '"+_cCt+"'    AND    "
    _cQry += "C8_FILIAL     =  '"+_cFilC+"'    AND    "
    _cQry += "C8.D_E_L_E_T_ = ''                "

    DBUseArea( .T. , "TOPCONN" , TcGenQry(,,_cQry), _cAlias , .T. , .F.)

   While (_cAlias)->( !Eof() )
        If Empty(SC8->C8_ITEMPED) .OR. Empty(SC8->C8_NUMPED)

            _cNum     := _cQry
            _cForn    := SC8->C8_FORNECE
            _cLoja    := SC8->C8_LOJA
            _ciTem    := SC8->C8_ITEM

            //---------------------------------------------------------------------------------------------
            //FUNCAO PARA POSICONAR NO ITEM 
            //-----------------------------------------------------------------------------------------------
            ValidTables(_cNum, _cForn, _cLoja, _ciTem, _cFilC )

            RecLock("SC8",.F.)
            
            SC8->C8_ITEMPED := "XXXXXX"
            SC8->C8_NUMPED  := "XXXXXX"

            MsUnlock()

        EndIf 
    EndDo
    
    RpcClearEnv()
    
    SC8->(DBCloseArea())
    SC7->(DBCloseArea())
    SCE->(DBCloseArea())
    
    (_cAlias)->(DbCloseArea())

Return 
