#include 'totvs.ch'
#include 'protheus.ch'
#include 'parmtype.ch'
#INCLUDE "FWMBROWSE.CH"
#include "RESTFUL.CH"
#include 'topconn.ch'


/**************************************************************************************************
{Protheus.doc} MTA161BUT
@description	Ponto de entrada para startar o processo de cotacao no fluig
@type   		Method	
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
User Function MTA161BUT()

Local aRotina:= PARAMIXB[1]

    aadd(aRotina,{'Envio fluig', "U_CotacaoFluig()" , 0 , 3,0,NIL}) //Crio um novo botao

Return (aRotina)

/**************************************************************************************************
@author         Marcus Vinicius Dias da Silva
@version        1.0
@since          13/12/2021
@database          13/12/2021
**************************************************************************************************/
User Function VerificarCotacaoComprasFluig(_cCod)

    Local _cAlias   := GetNextAlias() 
    Local _cQryCompra     := "" 
    Local nRecNo    := SC8->(RecNo())
    Local _cSolFg   := ""
    Local _cSC1     := ""
    Local lValid    := .F.

    DBSelectArea("SC8")
    SC8->(DbGoTo(nRecNo))

    _cQryCompra += " SELECT                         " 
    _cQryCompra += " C8.C8_ITEM,                    " 
    _cQryCompra += " C8.C8_ITEMSC,                  "
    _cQryCompra += " C8.C8_FILIAL,                  " 
    _cQryCompra += " C8.C8_NUM,                     " 
    _cQryCompra += " C8.C8_PRODUTO,                 " 
    _cQryCompra += " C8.C8_UM,                      "
    _cQryCompra += " C8.C8_QUANT,                   " 
    _cQryCompra += " C8.C8_COND,                    " 
    _cQryCompra += " C8.C8_VALICM,                  " 
    _cQryCompra += " C8.C8_BASEICM,                 " 
    _cQryCompra += " C8.C8_BASEIPI,                 " 
    _cQryCompra += " C8.C8_TXMOEDA,                 " 
    _cQryCompra += " C8.C8_ITEMPED,                 "
    _cQryCompra += " C8.C8_NUMPED,                  " 
    _cQryCompra += " C8.C8_PRECO,                   " 
    _cQryCompra += " C8.C8_TOTAL,                   "
    _cQryCompra += " C8.C8_FORNECE,                 " 
    _cQryCompra += " C8.C8_FORNOME,                 "  
    _cQryCompra += " C8.C8_LOJA,                    "
    _cQryCompra += " C8.C8_TOTFRE,                  " 
    _cQryCompra += " C8.C8_NUMSC,                   " 
    _cQryCompra += " C1.C1_ZSOLIC                   "
    _cQryCompra += " FROM "      + RetSqlName("SC8") +" C8                           
    _cQryCompra += " INNER JOIN "+ RetSqlName("SC1") +" C1 ON C8.C8_NUMSC = C1.C1_NUM  AND C1_FILIAL  = '" + xFilial("SC1") + "' "
    _cQryCompra += " WHERE C8.C8_NUMSC='"+_cCod+"' AND C8_FILIAL  = '" + xFilial("SC8") + "' AND "
    _cQryCompra += " C8.D_E_L_E_T_ = ' '"

    DBUseArea( .T. , "TOPCONN" , TcGenQry(,,_cQryCompra), _cAlias , .T. , .F.)
    SC8->(DbCloseArea())

    //Verifica se o codigo da solicitação está preenchido na SC1
    IF Empty((_cAlias)->C1_ZSOLIC)
        MsgAlert("Solicitação não possui o código FLUIG.", "Atenção!")
        Return(.F.)
    ELSE
        _cSolFg := (_cAlias)->C1_ZSOLIC
        _cSC1   := (_cAlias)->C8_NUMSC
    EndIf

    lValid := fAnalysis(_cAlias)
    
    If lValid
        U_fMovTask(_cSolFg, 1)
    EndIf
Return(.T.)

/**************************************************************************************************
{Protheus.doc} CotacaoFluig
@description	Rotina para de validacao e a chamada da classe de movimentacao
@type   		Method	
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
User Function CotacaoFluig()

Local _cAlias   := GetNextAlias() 
Local _cQry     := "" 
Local nRecNo    := SC8->(RecNo())
Local _cCod     := ""
Local _cSolFg   := ""
Local _cSC1     := ""
Local _cNumCp   := ""
Local lValid    := .F.
Local _nRet     := 0

    DBSelectArea("SC8")
    SC8->(DbGoTo(nRecNo))
    _cCod   := SC8->C8_NUMSC

    DbSelectArea( 'SCP' )
    SCP->( DbSetOrder( 1 ) ) // CP_FILIAL + CP_NUM + CP_ITEM + DTOS(CP_EMISSAO)

    _cQry := " SELECT                                    "
    _cQry += " CP_NUM,                                   "
    _cQry += " CP_ITEM,                                  "
    _cQry += " C8_TOTAL,                                 "
    _cQry += " C8_COND,                                  "
    // _cQry += " C8_TAXAFIN,                               "
    _cQry += " C8_PRECO,                                 "
    _cQry += " C8_VALICM,                                "
    _cQry += " C8_BASEICM,                               "
    _cQry += " C8_BASEIPI,                               "
    _cQry += " C8_TXMOEDA,                               "
    _cQry += " C8_NUMPED,                                "
    _cQry += " C8_ITEMPED,                               "
    _cQry += " C8_NUMSC,                                 "
    _cQry += " CP_ZSOLIC                                 "
    _cQry += " FROM "+       RetSqlName("SCQ") +" CQ     "
    _cQry += " INNER JOIN "+ RetSqlName("SCP") +" CP ON" + RetSqlDel("CP") +" AND CP_FILIAL  = '" + xFilial("SCP") + "' AND  CP_NUM = CQ_NUM
    _cQry += " INNER JOIN "+ RetSqlName("SC8") +" C8 ON" + RetSqlDel("C8") +" AND C8_FILIAL  = '" + xFilial("SC8") + "' AND  C8_NUMSC = CQ_NUMSC 
    _cQry += " WHERE                                     " 
    _cQry += " C8_NUMSC    =  '"+_cCod+"'    AND           " 
    _cQry += " CQ.D_E_L_E_T_ = ' '         AND           "
    _cQry += " CQ.CQ_FILIAL  = '" + xFilial("SCQ") + "'           AND            "
    _cQry += " C8.D_E_L_E_T_ = ' '                       "

    DBUseArea( .T. , "TOPCONN" , TcGenQry(,,_cQry), _cAlias , .T. , .F.)
    SC8->(DbCloseArea())

    //----------------------------------------------------------------------------------------------------
    // Valido se o codigo de solicitacao do fluig esta preenchido
    //----------------------------------------------------------------------------------------------------
    If Empty((_cAlias)->CP_ZSOLIC)
       // MsgAlert("Essa solicitação ao armazem esta com o campo CP_ZSOLIC vazio", "Atenção!")
       // Return(.F.)
        U_VerificarCotacaoComprasFluig(_cCod)
        Return(.F.)
    Else 
        _cSolFg := (_cAlias)->CP_ZSOLIC
        _cSC1   := (_cAlias)->C8_NUMSC
        _cNumCp := (_cAlias)->CP_NUM
        U_buscarDadosSCP(_cCod)
    EndIf
    
    //----------------------------------------------------------------------------------------------------
    // Funcao para fazer as validacoes
    //----------------------------------------------------------------------------------------------------
    lValid := fAnalysis(_cAlias)
    
    If lValid

        fSttusCot(cValToChar(nRecNo), _cSC1)

        _nRet := U_VldAllSolit(_cNumCp)

        If _nRet != 0
            //----------------------------------------------------------------------------------------------------
            // Funcao para enviar a cotacao para o fluig
            //----------------------------------------------------------------------------------------------------
            U_fMovTask(_cSolFg, _nRet)
        Else 
            MsgInfo("Não foi possível movimentar a tarefa para fluig pois ainda há itens pendentes!", "Atenção")
        EndIf 

    EndIf
    SCP->(DbCloseArea())
    //If lValid 
    //    U_MT161LEG("2") // tratar a legenda
    //EndIf


Return(.T.)

/**************************************************************************************************
{Protheus.doc} fAnalysis
@description	Validacao para verificar se a cotacao se encontra 'EM ANALISE'
@type   		Method	
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
Static Function fAnalysis(_cAlias)
Local _cMsg := ""

    DBSelectArea(_cAlias)
    (_cAlias)->( DBGoTop() )

    While (_cAlias)->( !Eof() )

        //----------------------------------------------------------------------------------------------------
        // Valido se os campos de valores que contem o status em analise estao preenchidos 
        //----------------------------------------------------------------------------------------------------
        If  !Empty((_cAlias)->C8_PRECO)     .AND.;
            !Empty((_cAlias)->C8_TOTAL)     .AND.;
            !Empty((_cAlias)->C8_COND)      .AND.;
            !Empty((_cAlias)->C8_PRECO)

            //----------------------------------------------------------------------------------------------------
            // Valido se os campos de imposto que contem o status em analise estao preenchidos 
            //----------------------------------------------------------------------------------------------------
            If  (Empty((_cAlias)->C8_VALICM)    .AND.;
                Empty((_cAlias)->C8_BASEICM)    .AND.;
                Empty((_cAlias)->C8_BASEIPI)    .AND.; 
                Empty((_cAlias)->C8_TXMOEDA))

                _cMsg := "C8_VALICM:  "+ cValToChar((_cAlias)->C8_VALICM ) + CRLF 
                _cMsg += "C8_BASEICM: "+ cValToChar((_cAlias)->C8_BASEICM) + CRLF
                _cMsg += "C8_BASEIPI: "+ cValToChar((_cAlias)->C8_BASEIPI) + CRLF
                _cMsg += "C8_TXMOEDA: "+ cValToChar((_cAlias)->C8_TXMOEDA) + CRLF

                MsgInfo("Existem campos que não foram preenchidos para a gerecão correta da cotacao!", "Atencão!")
                MsgInfo(_cMsg, "Verificar os campos!")
                Return(.F.) 
            EndIf 

        Else  
            _cMsg := "C8_PRECO:   "+ cValToChar((_cAlias)->C8_PRECO )  + CRLF 
            _cMsg += "C8_TOTAL:   "+ cValToChar((_cAlias)->C8_TOTAL)   + CRLF
            _cMsg += "C8_COND:    "+ cValToChar((_cAlias)->C8_COND)    + CRLF
            // _cMsg += "C8_TAXAFIN: "+ cValToChar((_cAlias)->C8_TAXAFIN) + CRLF
            _cMsg += "C8_PRECO:   "+ cValToChar((_cAlias)->C8_PRECO)   + CRLF

            MsgInfo("Existem campos que não foram preenchidos para a gerecão correta da cotacao!", "Atencão!")
            MsgInfo(_cMsg, "Verificar os campos!")
            Return(.F.) 
        EndIf 

        //----------------------------------------------------------------------------------------------------
        // Valido se os campos que contem a cotacao ja analisada estao preenchidos 
        //----------------------------------------------------------------------------------------------------
        If !(Empty((_cAlias)->C8_ITEMPED) .AND. Empty((_cAlias)->(C8_NUMPED)))

            MsgInfo("Atenção a cotação já foi analisada"+CRLF+"Status:'ANALISADA'")
            Return(.F.)
        EndIf


        (_cAlias)->( DBSkip() )

    EndDo

    (_cAlias)->(DbCloseArea())


Return(.T.)  


Static Function fSttusCot(_cRecnol, _cNum)

Local _cQry     := ""
Local _cAlias   := GetNextAlias()

    _cQry := " SELECT                                    "
    _cQry += " CP_NUM,                                   "
    _cQry += " CP_ITEM                                   "
    _cQry += " FROM "+       RetSqlName("SC8") +" C8     "
    _cQry += " INNER JOIN "+ RetSqlName("SCQ") +" CQ ON" + RetSqlDel("CQ") +" AND CQ_FILIAL  = '" + xFilial("SC8") + "' AND  C8_ITEMSC = CQ_ITSC AND  C8_NUMSC = CQ_NUMSC
    _cQry += " INNER JOIN "+ RetSqlName("SCP") +" CP ON" + RetSqlDel("CP") +" AND CP_FILIAL  = '" + xFilial("SC8") + "' AND  CP_NUM = CQ_NUM AND CP_ITEM = CQ_ITEM
    _cQry += " WHERE                                     " 
    _cQry += " C8_NUMSC       =  '"+_cNum+"'    AND      " 
    _cQry += " C8.R_E_C_N_O_  =  '"+_cRecnol+"' AND      " 
    _cQry += " CQ.D_E_L_E_T_ = ' '              AND      "
    _cQry += " C8.D_E_L_E_T_ = ' '                       "

    DBUseArea( .T. , "TOPCONN" , TcGenQry(,,_cQry), _cAlias , .T. , .F.)

    If SCP->( DbSeek( xFilial( 'SCP' ) + (_cAlias)->CP_NUM + (_cAlias)->CP_ITEM ) )

        //-----------------------------------------------------------------------------------
        // RecLock para definir o tipo
        //-----------------------------------------------------------------------------------
        If SCP->CP_ZSTIPO == 0
            SCP->(RecLock("SCP",.F.))
            SCP->CP_ZSTIPO := 1
            SCP->(MsUnlock())
            // desenvolver a lógica quando ele pedir direto na cotacao n ter nada no estoque 
        EndIf

    EndIf

Return 

/**************************************************************************************************
{Protheus.doc} fMovTask
@description	Funcao para a chamada da classe de envio 
@type   		Method	
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
User Function fMovTask(_cSolFg, nItem)

Local oWsClient  := IPFluigClass():newIPFluigClass()
Local cSolitacao := ""
Local aRet       := {}
Local _nI        := 0
Local _nG        := 0
Local _cMsg      := ""
Local _nProcesso := ""
Local _cUsrRecb  := ""

Default _cSolFg := ""
Default nItem   := 0
/*
Método responsável por movimentar uma atividade no FLUIG.
@param nProcessInstanceId, Númerico, Número da Solicitação do FLUIG 
@param nChoosedState, Númerico, Numero da atividade que vai receber a movimentacao
@param cComments, Caracter, Comentário que será gravado 
@param lManagerMode, Lógico, Inclui como Gestor? 
@param nThreadSequence, Númerico, Thread 0 
@param aUsrDest, Array, Array contendo usuários destino que vai receber o alerta.
@param aCardData, Array, Array contendo os campos que serão atualizados / preenchidos.
@param lCompleteTask, Lógico, Incluí movimentando para a próxima atividade
*/

//------------------------------------------------------------------------------------------
// nItem == 1 -> armazem com esse produto saldo em negativo - Fluxo cotacoa 124
// nItem == 2 -> foi solicitado mais quantidade do que tinha no armazem - SubFluxo 184
// nItem == 3 -> armazem foi capaz de suprir a quantidade desejada - Fluxo retirada 156
//------------------------------------------------------------------------------------------

    Do Case 
        Case nItem == 1
            _nProcesso := GetNewPar("FLG_NPROCX", 124) 
            _cUsrRecb  := GetNewPar("FLG_USRECX", "00001")
        Case nItem == 2
            _nProcesso := GetNewPar("FLG_NPROCY", 184)
            _cUsrRecb  := GetNewPar("FLG_USRECY", "")
        Case nItem == 3 
            _nProcesso := GetNewPar("FLG_NPROCZ", 360)
            _cUsrRecb  := GetNewPar("FLG_USRECZ", "")
    EndCase
    cSolitacao := Val(_cSolFg)

    aRet := oWsClient:saveAndSendTask(cSolitacao,_nProcesso,"",.F.,0,{_cUsrRecb},{},.T.)

    If Len(aRet) >= 5 
        MsgInfo("Processo movido para o fluig com sucesso!", "Atenção")
    Else 

        For _nI := 1 to Len(aRet)
            For _nG := 1 to Len(aRet[_nI])
                _cMsg += aRet[_nI][_nG]+' '
            Next
        Next     

        MsgAlert("Falha na execução de envio para o fluig "+ CRLF ;
                + "contate o administrador do sistema", "Atenção")
        MsgInfo(_cMsg)
    EndIf 

Return(.T.)

/**************************************************************************************************
{Protheus.doc} itemCotacaoUpd
@description	Funcao para buscar todos os itens que foram cotados e validados. 
@type   		Method	
@author			Marcus Vinicius Dias da Silva
@version   		1.00
@since     		23/01/2022
@database		23/01/2022
@country		Brasil
@language		PT-BR
@obs			Essa função só poderá ser utilizada para itens que foram cotados.
@param			
@return						
*****************************************************************************************************/
User Function buscarDadosSCP(_cCod)

    Local _cCpNum  := ""
    Local _cCpItem := ""

    Local aArea := GetArea()
    Local cQry     := ""
    Local cAlias   := GetNextAlias()  

    cQry := "SELECT                                                                                                                                                                                    "
    cQry += "  C8_NUMSC,                                                                                                                                                                               "
    cQry += "  C8_PRODUTO,                                                                                                                                                                             "
    cQry += "  CP_NUM,                                                                                                                                                                                 "
    cQry += "  CP_ZSTIPO,                                                                                                                                                                              "
    cQry += "  CQ.CQ_NUM,                                                                                                                                                                              "
    cQry += "  CQ_ITEM                                                                                                                                                                                 "
    cQry += "FROM "+      RetSqlName("SC8") +" C8                                                                                                                                                      "
    cQry += "INNER JOIN "+ RetSqlName("SCQ") +" CQ ON" + RetSqlDel("CQ") +" AND CQ_FILIAL  = '" + xFilial("SCQ") + "' AND  C8_NUMSC = CQ_NUMSC   AND C8_ITEMSC = CQ_ITSC                               "
    cQry += "INNER JOIN "+ RetSqlName("SCP") +" CP ON" + RetSqlDel("CP") +" AND CP_FILIAL  = '" + xFilial("SCP") + "' AND  CP_NUM = CQ_NUM       AND CP_ITEM = CQ_ITEM AND CP.D_E_L_E_T_ = ''          "
    cQry += "WHERE                                                                                                                                                                                     "
    cQry += "  C8_NUMSC='"+_cCod+"'                                                                                                                                                                       "
    cQry += "  AND CQ.D_E_L_E_T_ = ''                                                                                                                                                                  "
    cQry += "  AND C8.D_E_L_E_T_ = ''                                                                                                                                                                  "
    
    cQry  := ChangeQuery(cQry)

    DBUseArea(.T., "TOPCONN", TCGenQry(NIL,NIL,cQry), (cAlias) , .F., .T. )
 
    WHILE !Eof()
        _cCpNum  := (cAlias)->CQ_NUM
        _cCpItem := (cAlias)->CQ_ITEM

        U_itemCotacaoUpd(_cCpNum, _cCpItem)
        DbSkip()
    ENDDO
    
    DBCloseArea()

    RestArea(aArea)
Return(.T.)

/**************************************************************************************************
{Protheus.doc} itemCotacaoUpd
@description	Funcao para atualizar todos os itens que foram cotados e validos. 
@type   		Method	
@author			Marcus Vinicius Dias da Silva
@version   		1.00
@since     		23/01/2022
@database		23/01/2022
@country		Brasil
@language		PT-BR
@obs			Essa função só poderá ser utilizada para atualização dos itens que foram cotados. 
                Função utilizada para deixar o item como suprido para passar pela validação.
@param			
@return						
*****************************************************************************************************/
User Function itemCotacaoUpd(_cCpNumSCP, _cCpItemSCP)
    cQryUpd := ""

    TCLink()
        cQryUpd := " UPDATE                                                  "
        cQryUpd += " "+RetSqlName("SCP") +" SET                              " 
        cQryUpd += "   CP_ZSTIPO='1'                                         "
        cQryUpd += " WHERE                                                   "
        cQryUpd += "   CP_ITEM = '" +  _cCpItemSCP  + "'                     "
        cQryUpd += "   AND CP_NUM='"+  _cCpNumSCP   + "'                     "
                    
    nStatus := TCSqlExec(cQryUpd)

    if (nStatus < 0)
        conout("TCSQLError() " + TCSQLError())
    endif

    TCUnlink()

Return(.T.)
