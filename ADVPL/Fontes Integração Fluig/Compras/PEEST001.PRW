#INCLUDE 'PROTHEUS.CH'

/**************************************************************************************************
{Protheus.doc} M185GRV
@description	P.E para realizar a tratativas para a solicitacao vindo do estoque
@type   		User function	
@author			Lucas Rocha Vieira
@version   		1.00
@since     		06/10/2021
@database		06/10/2021
@country		Brasil
@language		PT-BR
@obs			06/10/2021 - Controle de documentacao
@param			
@return						
*****************************************************************************************************/
User Function M185GRV()
    
Local _cAlias := GetNextAlias()
Local _cQry   := ""
Local nCheck  := Val(SD3->(D3_TM))
Local _cMsg   := ""
Local _nRet   := 0
Local _nPeg   := 0


    DbSelectArea( 'SCP' )
    SCP->( DbSetOrder( 1 ) ) // CP_FILIAL + CP_NUM + CP_ITEM + DTOS(CP_EMISSAO)

    //---------------------------------------------------------------------
    // Produção - Códigos menores que 500
    // Devolução - Códigos menores que 500
    // Requisição - Códigos maiores ou iguais a 500
    //---------------------------------------------------------------------
    If nCheck >= 500

        _cQry := " SELECT                                    "
        _cQry += " CP_ZSTIPO,                                "
        _cQry += " CP_NUM,                                   "
        _cQry += " CP_ITEM,                                  "
        _cQry += " D3_COD,                                   "
        _cQry += " D3_QUANT,                                 "
        _cQry += " D3_LOCAL,                                 "
        _cQry += " D3_EMISSAO,                               "
        _cQry += " D3_USUARIO,                               "
        _cQry += " D3_NUMSA,                                 "
        _cQry += " D3_COD,                                   "
        _cQry += " D3_COD,                                   "
        _cQry += " D3_COD,                                   "
        _cQry += " D3_TM,                                    "
        _cQry += " CP_ZSOLIC,                                "
        _cQry += " B2_QATU                                   "
        _cQry += " FROM "+       RetSqlName("SCP") +" CP     "
        _cQry += " INNER JOIN "+ RetSqlName("SD3") +" D3 ON" + RetSqlDel("D3") +" AND D3_FILIAL  = '" + xFilial("SD3") + "' AND  D3_NUMSA = CP_NUM  
        _cQry += " INNER JOIN "+ RetSqlName("SB2") +" B2 ON" + RetSqlDel("B2") +" AND D3_FILIAL  = '" + xFilial("SB2") + "' AND  B2_COD = D3_COD AND B2_LOCAL = D3_LOCAL 
        _cQry += " WHERE                                     " 
        _cQry += " CP_NUM    =  '"+AllTrim(SD3->(D3_NUMSA))+"'     AND           " 
        _cQry += " CP_ITEM   =  '"+AllTrim(SD3->(D3_ITEMSA))+"'    AND           " 
        _cQry += " CP.D_E_L_E_T_ = ' '                       "

        DBUseArea( .T. , "TOPCONN" , TcGenQry(,,_cQry), _cAlias , .T. , .F.)

        If Select(_cAlias) > 0 .AND. !Empty((_cAlias)->CP_ZSOLIC)

            _nPeg := fCarve(_cAlias, @_cMsg)

            If _nPeg <> 2
                _nRet := U_VldAllSolit((_cAlias)->CP_NUM)
            EndIf 

            If _nRet != 0 .and. _nPeg <> 2
                U_fMovTask((_cAlias)->CP_ZSOLIC, _nRet)
            EndIf 
            
        EndIf 
        
        If !Empty(_cMsg)
            MsgInfo(_cMsg)
        EndIf

    EndIf

    SCP->(DbCloseArea())
Return 

/**************************************************************************************************
{Protheus.doc} fCarve
@description	Funcao para carregar a mensagem ao usuario e realizar a tratativa da tarefa a ser movimentada
@type   		funcao	
@author			Lucas Rocha Vieira
@version   		1.00
@since     		06/10/2021
@database		06/10/2021
@country		Brasil
@language		PT-BR
@obs			06/10/2021 - Controle de documentacao
@param			
@return						
*****************************************************************************************************/
Static Function fCarve(_cAlias, _cMsg)

Local nQtArm := 0
Local ntipo  := 0
    //-----------------------------------------------------------------------
    // nItem == 1 -> armazem com esse produto saldo em negativo
    // nItem == 2 -> foi solicitado mais quantidade do que tinha no armazem
    // nItem == 3 -> armazem foi capaz de suprir a quantidade desejada
    //-----------------------------------------------------------------------


    If SCP->( DbSeek( xFilial( 'SCP' ) + (_cAlias)->CP_NUM + (_cAlias)->CP_ITEM ) )

        //-----------------------------------------------------------------------------------
        // RecLock para definir o tipo
        //-----------------------------------------------------------------------------------
        SCP->(RecLock("SCP",.F.))

        //-----------------------------------------------------------------------------------
        // nQtArm recebe quant. solicitada porque o P.E e acionado depois da gravacao SB2
        //-----------------------------------------------------------------------------------
        nQtArm := (_cAlias)->B2_QATU + SD3->(D3_QUANT)
        If nQtArm > 0
            
            IF SCP->(CP_QUANT) > SD3->(D3_QUANT)
                SCP->CP_ZSTIPO := 2
                ntipo := 2
                _cMsg := "Quantidade solicitado foi maior do tinha disponível no armazém" + CRLF
                _cMsg += "A quantidade faltante deverá seguir o processo para a cotação"  + CRLF 
                _cMsg += "Produto .: '"+SD3->(D3_COD)+"' "                                  + CRLF 
                _cMsg += "Armazém .: '"+SD3->(D3_LOCAL)+"' "                                + CRLF 
                _cMsg += "Quantidade no armazém .: '"+cValToChar((_cAlias)->B2_QATU)+"' "   + CRLF 
                _cMsg += "Quantidade solicitada .: '"+cValToChar(SD3->(D3_QUANT)) +"' "     + CRLF
                _cMsg += "Data .: '"+Dtoc(SD3->(D3_EMISSAO))+"' "                           + CRLF 
                _cMsg += "Usuário .: '"+ALLTRIM(SD3->(D3_USUARIO))+"' "

                Return(ntipo)
            EndIf 

            If SD3->(D3_QUANT) > nQtArm 
                SCP->CP_ZSTIPO := 2
                ntipo := 2
                _cMsg := "Quantidade solicitado foi maior do tinha disponível no armazém" + CRLF
                _cMsg += "A quantidade faltante deverá seguir o processo para a cotação"  + CRLF 

            ElseIf SD3->(D3_QUANT) <= nQtArm
                SCP->CP_ZSTIPO := 3
                ntipo := 3
                _cMsg := "O armazém suprio a quantidade solicitada!" + CRLF
            EndIf

        Else 
            SCP->CP_ZSTIPO := 1
            ntipo := 1
            _cMsg := "Esse armazém está com a quantidade deste produto negativo"  + CRLF  
        EndIf 

        _cMsg += "Produto .: '"+SD3->(D3_COD)+"' "                                  + CRLF 
        _cMsg += "Armazém .: '"+SD3->(D3_LOCAL)+"' "                                + CRLF 
        _cMsg += "Quantidade no armazém .: '"+cValToChar((_cAlias)->B2_QATU)+"' "   + CRLF 
        _cMsg += "Quantidade solicitada .: '"+cValToChar(SD3->(D3_QUANT)) +"' "     + CRLF
        _cMsg += "Data .: '"+Dtoc(SD3->(D3_EMISSAO))+"' "                           + CRLF 
        _cMsg += "Usuário .: '"+ALLTRIM(SD3->(D3_USUARIO))+"' "

        SCP->(MsUnlock())
    EndIf


Return(ntipo) 

User Function VldAllSolit(_cNum)

Local _lOk          := .T.
Local nTrata        := 0
Local _cAlias       := GetNextAlias()
Local _cQry         := ""

    _cQry := " SELECT                                    "
    _cQry += " CP_ZSTIPO,                                "
    _cQry += " CP_NUM,                                   "
    _cQry += " CP_ITEM,                                  "
    _cQry += " CP_NUM                                    "
    _cQry += " FROM "+       RetSqlName("SCP") +" CP     "
    _cQry += " WHERE                                     "
    _cQry += " CP_NUM    =  '"+AllTrim(_cNum)+"'  AND    " 
    _cQry += " CP.D_E_L_E_T_ = ' '                       "

    DBUseArea( .T. , "TOPCONN" , TcGenQry(,,_cQry), _cAlias , .T. , .F.)

    DbSelectArea( _cAlias )
    (_cAlias)->( DBGoTop() )

    While (_cAlias)->(!EOF())

        SCP->( DbSeek( xFilial( 'SCP' ) + (_cAlias)->CP_NUM + (_cAlias)->CP_ITEM ) ) //TRATAR

        If SCP->(CP_ZSTIPO) == 0
            _lOk := .F.
            Return(nTrata)
        EndIf

        (_cAlias)->(DbSkip())

    EndDo

    //-----------------------------------------------------------------------------------
    // Estando todos os campos preenchidos eu verifico se há divergencia entre eles
    //-----------------------------------------------------------------------------------
    If _lOk 

        (_cAlias)->( DBGoTop() )
        While (_cAlias)->(!EOF())

            If nTrata == 0
                nTrata := (_cAlias)->(CP_ZSTIPO)
            Else 

                If nTrata != (_cAlias)->(CP_ZSTIPO)
                    nTrata := 2
                    Return(nTrata)
                EndIf

            EndIF

            (_cAlias)->(DbSkip())

        EndDo

    EndIf

    (_cAlias)->(DbCloseArea())

Return(nTrata)

