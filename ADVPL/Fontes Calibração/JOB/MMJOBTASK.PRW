#INCLUDE "PROTHEUS.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TOTVS.CH"
#INCLUDE "RWMAKE.CH"   

/**************************************************************************************************
{Protheus.doc} MMJOBTASK
@description	Rotina para gerar chamado no Fluig para Calibração de equipamentos
@type   		Funcao	
@author			André Luis Maximiano Longhini
@version   		1.00
@since     		20/04/2022
@database		20/04/2022
@country		Brasil
@language		PT-BR		
@TesteUser     testeMailSched()
@return			Nil 			
*****************************************************************************************************/
User Function MMJOBTASK()

    Local aArea                 := GetArea()
    Local cEmp                  := "01"
    Local cFil                  := "0101"
    Local cCusto                := ""
    Local cCusto1               := ""
    Local cTpProd               := ""
    Local _cCodProd             := ""
    Local _cDesProd             := ""
    Local _aCab                 := {}
    Local _aVar                 := {}
    Local cGetUsr			    := RetCodUsr()      // Recebe código do usuário logado. 
    Local _cAlias	            := GetNextAlias()	// Recebe o próximo _cAlias.
    Local cQuery	            := ""
    Local _cUserFluig           := ""



    PREPARE ENVIRONMENT EMPRESA ( cEmp ) FILIAL ( cFil )

    //Query que busca do usuário
     cQuery := " SELECT ZZA_MATFG"
     cQuery += " FROM "+RetSqlName("ZZA")
     cQuery += " WHERE ZZA_CODIGO = '"+ cGetUsr +"'" // Diferente de valido
     cQuery += " AND D_E_L_E_T_<>'*'"
     cQuery += " GROUP BY ZZA_MATFG"
    DBUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery), _cAlias , .T. , .F.)
    

    _cUserFluig := (_cAlias)->ZZA_MATFG
    _cUserFluig := ALLTRIM(_cUserFluig)

    DbCloseArea()

    //Query que busca os dados dos equipamentos próximo do vencimento
     _cQry := " SELECT ZZD_FILIAL,ZZD_TPPROD, ZZD_CODCC, ZZD_DESCCC, ZZD_CODPR, ZZD_DESCPD, ZZD_CODATI, ZZD_DESCAT, ZZD_NSERIE,ZZD_DTCAL2,ZZD_STATUS"
     _cQry += " FROM "+RetSqlName("ZZD")
     _cQry += " WHERE ZZD_STATUS <> '1'" // Diferente de valido
     _cQry += " AND D_E_L_E_T_<>'*'"
     _cQry += " ORDER BY ZZD_CODCC"
    TcQuery _cQry New Alias "TZZD"
    DbSelectArea("TZZD")
    TZZD->(DbGoTop())


        Conout("Verificando se existe calibragens próximas do vencimento")
        //----------------------------------------------------------------------------
        // Funcao para gerar as variáveis para envio da solicitação.
        //----------------------------------------------------------------------------
           
        While !(TZZD->(EoF()))
            
            cCusto1         := ALLTRIM(TZZD->ZZD_CODCC)
            cTpProd         := ALLTRIM(TZZD->ZZD_TPPROD)

            if cTpProd == 'N'
                _cCodProd    := ALLTRIM(TZZD->ZZD_CODPR)
                _cDesProd    := ALLTRIM(TZZD->ZZD_DESCPD)
            ELSE
                _cCodProd    := ALLTRIM(TZZD->ZZD_CODATI)
                _cDesProd    := ALLTRIM(TZZD->ZZD_DESCAT)
            ENDIF                

            if cCusto == "" 
                //----------------------------------------------------------------------------
                // Inicia inclusão do primeiro Centro de Custo e equipamentos
                //----------------------------------------------------------------------------
                aADD(_aCab, { ALLTRIM(TZZD->ZZD_FILIAL),ALLTRIM(TZZD->ZZD_CODCC),ALLTRIM(TZZD->ZZD_DESCCC) })
                aADD(_aVar, { _cCodProd,_cDesProd })

                cCusto  := ALLTRIM(TZZD->ZZD_CODCC)   

            elseif  cCusto1 == cCusto
                
                //----------------------------------------------------------------------------
                // Incluí demais equipamentos do mesmo Centro de Custo
                //----------------------------------------------------------------------------

                aADD(_aVar, { _cCodProd,_cDesProd })

                cCusto  := ALLTRIM(TZZD->ZZD_CODCC)

            elseif cCusto <> cCusto1

                //----------------------------------------------------------------------------
                // Função para iniciar o Fluig de Calibração
                //----------------------------------------------------------------------------
                U_fStartTask(_aCab, _aVar, _cUserFluig)

                //----------------------------------------------------------------------------
                // Função para Limpar Array
                //----------------------------------------------------------------------------
                ASIZE(_aCab, 0)
                ASIZE(_aVar, 0)

                //----------------------------------------------------------------------------
                // Inicia inclusão do novo Centro de Custo e equipamentos
                //----------------------------------------------------------------------------
                aADD(_aCab, { ALLTRIM(TZZD->ZZD_FILIAL),ALLTRIM(TZZD->ZZD_CODCC),ALLTRIM(TZZD->ZZD_DESCCC) })
                aADD(_aVar, { _cCodProd,_cDesProd })

                cCusto  := ALLTRIM(TZZD->ZZD_CODCC) 

            endif

            TZZD->(DbSkip())

            //Final do Array
            if TZZD->(EoF())

                //----------------------------------------------------------------------------
                // Função para iniciar o Fluig de Calibração
                //----------------------------------------------------------------------------
                U_fStartTask(_aCab, _aVar)

                //----------------------------------------------------------------------------
                // Função para Limpar Array
                //----------------------------------------------------------------------------
                ASIZE(_aCab, 0)
                ASIZE(_aVar, 0)    

            endif

        EndDo


        Conout("Finalizada rotina de abertura de calibrações próximas ao vencimento")
    
    //Fecha Query
    TZZD->(DbCloseArea())
    RestArea(aArea)



Return 


/**************************************************************************************************
{Protheus.doc} fStartTask
@description	Funcao para iniciar chamado no Fluig
@type   		Method	
@author			André Longhini
@version   		1.00
@since     		18/04/2022
@database		18/04/2022
@country		Brasil
@language		PT-BR
@obs			06/10/2021 - Controle de documentacao
@param			
@return						
*****************************************************************************************************/
User Function fStartTask(_aCab, _aVar, _cUserFluig)

Local oWsClient     := IPFluigClass():newIPFluigClass()
Local aRet          := {}
Local _nI           := 0
Local _nG           := 0
Local _cMsg         := ""
Local _cComents     := "teste"
Local cIdProcessId  := "TESTEANDRE2"
Local cUserFluig    := _cUserFluig
/*
Método responsável por movimentar uma atividade no FLUIG.
@param cIdProcessId, Caracter, Código do Processo FLUIG
@param cUserFluig, Caracter, Usuário que Iniciará a solicitação.
@param nState, Númerico, Atividade Destino
@param cComments, Caracter, Comentário que será gravado
@param aCardData, Array, Array contendo os campos que serão atualizados / preenchidos.
@param oAttachments, Objeto, Objeto Contento os anexos 
@param aColleagueId, Array, Array contendo usuários destino.
*/



    aRet := oWsClient:startProcess(cIdProcessId, cUserFluig, "1", _cComents, _aCab, _aVar, "","")

        
    //Verifica se o Fluig foi aberto com sucesso
    If Len(aRet) >= 5 
        _cMsg := (aRet[6,2]) // Se aberto com sucesso, retorna número do fluig.
        MsgInfo("Processo aberto no fluig com sucesso!", "Atenção")
        MsgInfo("Fluig aberto sob número: " + _cMsg)
    Else 

        For _nI := 1 to Len(aRet) // Se der falha, retorna motivo
            For _nG := 1 to Len(aRet[_nI])
                _cMsg += aRet[_nI][_nG]+' '
            Next
        Next     

        MsgAlert("Falha na execução de envio para o fluig!" ;
                + " Contate o administrador do sistema", "Atenção")
        MsgInfo(_cMsg)
    EndIf 

Return(.T.)


