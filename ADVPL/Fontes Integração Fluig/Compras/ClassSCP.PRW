#INCLUDE 'TOTVS.CH'

/**************************************************************************************************
{Protheus.doc} ArmzScp
@description	Classe para gravar dados enviado do fluig na tabela de armazem(SCP)
@type   		Class	
@author			Lucas Rocha Vieira
@version   		1.00
@since     		22/09/2021
@database		22/09/2021
@country		Brasil
@language		PT-BR
@obs			22/09/2021 - Controle de documentacao
@param			
@return						
*****************************************************************************************************/
Class ArmzScp 

    Method New() CONSTRUCTOR

    Method Storage()    
    Method Validation() 

EndClass 

/**************************************************************************************************
{Protheus.doc} ArmzScp
@description	Construtor da classe
@type   		Method	
@author			Lucas Rocha Vieira
@version   		1.00
@since     		22/09/2021
@database		22/09/2021
@country		Brasil
@language		PT-BR
@obs			22/09/2021 - Controle de documentacao
@param			
@return						
*****************************************************************************************************/
Method New() class ArmzScp
Return()

/**************************************************************************************************
{Protheus.doc} ArmzScp
@description	Gravar dados na tabela SCP
@type   		Method	
@author			Lucas Rocha Vieira
@version   		1.00
@since     		22/09/2021
@database		22/09/2021
@country		Brasil
@language		PT-BR
@obs			22/09/2021 - Controle de documentacao
@param			
@return						
*****************************************************************************************************/
Method Storage(_cEmp, _cFil, _cOk, _cErro, _cAlias, _cSolicit, aProduto, _cUser) Class ArmzScp 

Local lRet          := .T.
Local nSaveSx8      := 0
Local nOpcx         := 0
Local _nCont        := 0
Local _nBl          := 0
Local cNumero       := ''
Local aCab          := {}
Local aItens        := {}
Local cCodSist      := ""
Local _cProduto     := ""
Local _nQuant       := ""
Local _cCusto       := ""
Local _cObs         := ""
Local _cArmz        := ""
Local _cAlias       := GetNextAlias() 
Local _cQry         := "" 

Private lMsErroAuto := .F.
Private lMsErroHelp := .T.

    _cQry   := "SELECT ZZA_FILIAL, ZZA_NOME, ZZA_CODIGO"
            _cQry += " FROM " + RetSqlName("ZZA") + " ZZA "
            _cQry += " WHERE ZZA.ZZA_FILIAL = '" + alltrim(_cFil) + "'"
            _cQry += " AND   ZZA.ZZA_NOME   = '" + alltrim(_cUser) + "'"
            _cQry += " AND ZZA.D_E_L_E_T_ = '' "
            _cQry += " GROUP BY ZZA.ZZA_FILIAL, ZZA.ZZA_NOME, ZZA.ZZA_CODIGO"
            _cQry += " ORDER BY ZZA.ZZA_CODIGO DESC "


    DBUseArea( .T. , "TOPCONN" , TcGenQry(,,_cQry) , _cAlias , .T. , .F.)

    cCodSist := (_cAlias)->ZZA_CODIGO

    RpcClearEnv()
    RpcSetType( 3 )
    // Abrindo a empresa 
    lRet := RpcSetEnv( _cEmp, _cFil )


    If ( !lRet ) 
        ConOut( 'Problemas na Inicialização do Ambiente' )
    Else
        
        nOpcx       := 3
        nSaveSx8    := GetSx8Len()
        cNumero     := GetSx8Num( 'SCP', 'CP_NUM' )
    
        DbSelectArea( 'SCP' )
        SCP->( DbSetOrder( 1 ) ) // CP_FILIAL + CP_NUM + CP_ITEM + DTOS(CP_EMISSAO)

        dbSelectArea( 'SB1' )
        SB1->( dbSetOrder( 1 ) )

        If nOpcx == 3
            While SCP->( DbSeek( xFilial( 'SCP' ) + cNumero ) )
                   ConfirmSx8()
                   cNumero := GetSx8Num('SCP', 'CP_NUM')
            EndDo
        EndIf

        //-------------------------------------------------------------------
        // Alimenta os campos da tabela com os valores das variaveis
        //-------------------------------------------------------------------        
        Aadd( aCab, { "CP_NUM"      , cNumero                                 ,  Nil }) // Num. armazem
        Aadd( aCab, { "CP_EMISSAO"  , dDataBase                               ,  Nil }) // Data de criacao
        Aadd( aCab, { "CP_SOLICIT"  ,  UsrRetName(cCodSist)                   ,  Nil }) // Nome Solicitante
                                                                                                        

        For _nCont := 1 to len(aProduto)

            _cProduto   := IIF(aProduto[_nCont][1] == "cidProduto"          , aProduto[_nCont][2]       , _cProduto )
            _nQuant     := IIF(aProduto[_nCont][1] == "cquantidade"         , Val(aProduto[_nCont][2])  , _nQuant   )
            _cCusto     := IIF(aProduto[_nCont][1] == "ccusto"              , aProduto[_nCont][2]       , _cCusto   )
            _cDescCc    := IIF(aProduto[_nCont][1] == "cDescCc"              , aProduto[_nCont][2]       , _cDescCc )
            _cObs       := IIF(aProduto[_nCont][1] == "cobs"                , aProduto[_nCont][2]       , _cObs     )
            _cArmz      := IIF(aProduto[_nCont][1] == "carmazem"            , aProduto[_nCont][2]       , _cArmz    )

            If  !Empty(_cProduto)   .AND.;
                !Empty(_nQuant)     .AND.;
                !Empty(_cCusto)     .AND.;
                !Empty(_cObs)       .AND.;
                !Empty(_cArmz)

                _nBl += 1
                Aadd( aItens, {} )

                Aadd( aItens[ Len( aItens ) ],{ "CP_ITEM"   ,  STRZERO(_nBl , 2, 0)      , Nil } ) // Num Item
                Aadd( aItens[ Len( aItens ) ],{ "CP_PRODUTO" ,  _cProduto                , Nil } ) // Num Produto
                Aadd( aItens[ Len( aItens ) ],{ "CP_QUANT"   ,  _nQuant                  , Nil } ) // Num Quantidade
                Aadd( aItens[ Len( aItens ) ],{"CP_OBS"      ,  _cObs                    , Nil } ) // Observacao
                Aadd( aItens[ Len( aItens ) ],{"CP_LOCAL"    ,  _cArmz                   , Nil } ) // Cod armazem
                Aadd( aItens[ Len( aItens ) ],{"CP_CC"          ,  _cCusto               , Nil } ) // Cod solicitacao fluig
                Aadd( aItens[ Len( aItens ) ],{"CP_DESCC"     ,  _cDescCc                 , Nil } ) // Desc Centro de custo 
                Aadd( aItens[ Len( aItens ) ],{"CP_USER"     ,  cCodSist                 , Nil } ) // Cod usuario
                Aadd( aItens[ Len( aItens ) ],{"CP_ZSOLIC"   ,  _cSolicit                , Nil } ) // Cod solicitacao fluig

                _cProduto   := ""
                _nQuant     := 0
                _cCusto     := ""
                _cObs       := ""
                _cArmz      := ""
            EndIf
        Next 

        MsExecAuto( { | x, y, z | Mata105( x, y , z ) }, aCab, aItens , nOpcx )
    
        If lMsErroAuto
            If !__lSX8
                RollBackSx8()
            EndIf
            _cErro := '{"mensagem":  "Falha no processo"}'
        Else

           While ( GetSx8Len() > nSaveSx8 )
               ConfirmSx8()
           End

            _cOk := '{ "mensagem": "Processo executado com sucesso!"}'
        EndIf
    
    EndIf

    DbClosearea()

Return(.T.)  


/**************************************************************************************************
{Protheus.doc} ArmzScp
@description	Validacao dos dados enviados via json
@type   		Method	
@author			Lucas Rocha Vieira
@version   		1.00
@since     		22/09/2021
@database		22/09/2021
@country		Brasil
@language		PT-BR
@obs			22/09/2021 - Controle de documentacao
@param			
@return						
*****************************************************************************************************/
Method Validation(cUsr, cCcusto, cFil, cProd, cErro, cAlias) Class ArmzScp 

Local _cQry     := ""

    _cQry := " SELECT                                       "
    _cQry += " ZZA_NOME,                                    "
	_cQry += " ZZA_CUSTO,                                   "
    _cQry += " ZZA_CODIGO,                                  "
    _cQry += " ZZA_NMUSR                                    "
    _cQry += " FROM "+ RetSqlName("ZZA") +" ZZA             "
    _cQry += " WHERE                                        " 
    _cQry += " ZZA_FILIAL = '"+ AllTrim(cFil) +"'           " 
    _cQry += " AND   ZZA_NOME LIKE  '%"+AllTrim(cUsr)+"%'   " 
    _cQry += " AND   ZZA_CUSTO =  '"+AllTrim(cCcusto)+"'    " 
    _cQry += " AND   ZZA_STATUS = '1'                       "
    _cQry += " AND ZZA.D_E_L_E_T_ = ''                      "

    DBUseArea( .T. , "TOPCONN" , TcGenQry(,,_cQry), cAlias , .T. , .F.)


    If Empty((cAlias)->ZZA_CODIGO)
        cErro := '{ "mensagem": "O cadastro nao foi localizado na ZZA"'	    +','+ CRLF
        cErro += '	"cidproduto" :  '+ cCcusto                              +','+ CRLF
	    cErro += ' "cuser" :        '+  cUsr		                        +'}'
        ConOut(PadC("Erro ao encontrar o usuario na tablea ZZA", 80))
        ConOut("Error: "+ cErro) 

        Return
    EndIf 

    //-------------------------------------------------------------------
    // TABELA: SB1
    // INDICE(1)-> B1_FILIAL + B1_COD
    //-------------------------------------------------------------------
    DbSelectArea( 'SB1' )
    SB1->(DbSetOrder(1))

    If !( SB1->(DBSeek( xFilial('SB1') + AllTrim(cProd))) )

        cErro := '{ "mensagem": "Codigo do produto nao localizado"'	    +','+ CRLF
	    cErro += ' "cidProduto" : '+ cProd          		            +'}'
        ConOut(PadC("Erro ao encontrar o produto", 80))
        ConOut("Error: "+ cErro)  
        Return(.T.)
    EndIf

    SB1->( DbCloseArea())

Return(.T.)
