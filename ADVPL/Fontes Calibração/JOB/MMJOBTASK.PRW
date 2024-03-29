#INCLUDE "PROTHEUS.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TOTVS.CH"
#INCLUDE "RWMAKE.CH"   

/**************************************************************************************************
{Protheus.doc} MMJOBTASK
@description	Rotina para gerar chamado no Fluig para Calibra��o de equipamentos
@type   		Funcao	
@author			Andr� Luis Maximiano Longhini
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
    Local cGetUsr			    := RetCodUsr()      // Recebe c�digo do usu�rio logado. 
    Local _cAlias	            := GetNextAlias()	// Recebe o pr�ximo _cAlias.
    Local cQuery	            := ""
    Local _cUserFluig           := ""



    PREPARE ENVIRONMENT EMPRESA ( cEmp ) FILIAL ( cFil )

    //Query que busca do usu�rio
     cQuery := " SELECT ZZA_MATFG"
     cQuery += " FROM "+RetSqlName("ZZA")
     cQuery += " WHERE ZZA_CODIGO = '"+ cGetUsr +"'" // Diferente de valido
     cQuery += " AND D_E_L_E_T_<>'*'"
     cQuery += " GROUP BY ZZA_MATFG"
    DBUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery), _cAlias , .T. , .F.)
    

    _cUserFluig := (_cAlias)->ZZA_MATFG
    _cUserFluig := ALLTRIM(_cUserFluig)

    DbCloseArea()

    //Query que busca os dados dos equipamentos pr�ximo do vencimento
     _cQry := " SELECT ZZD_FILIAL,ZZD_TPPROD, ZZD_CODCC, ZZD_DESCCC, ZZD_CODPR, ZZD_DESCPD, ZZD_CODATI, ZZD_DESCAT, ZZD_NSERIE,ZZD_DTCAL2,ZZD_STATUS"
     _cQry += " FROM "+RetSqlName("ZZD")
     _cQry += " WHERE ZZD_STATUS <> '1'" // Diferente de valido
     _cQry += " AND D_E_L_E_T_<>'*'"
     _cQry += " ORDER BY ZZD_CODCC"
    TcQuery _cQry New Alias "TZZD"
    DbSelectArea("TZZD")
    TZZD->(DbGoTop())


        Conout("Verificando se existe calibragens pr�ximas do vencimento")
        //----------------------------------------------------------------------------
        // Funcao para gerar as vari�veis para envio da solicita��o.
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
                // Inicia inclus�o do primeiro Centro de Custo e equipamentos
                //----------------------------------------------------------------------------
                aADD(_aCab, { ALLTRIM(TZZD->ZZD_FILIAL),ALLTRIM(TZZD->ZZD_CODCC),ALLTRIM(TZZD->ZZD_DESCCC) })
                aADD(_aVar, { _cCodProd,_cDesProd })

                cCusto  := ALLTRIM(TZZD->ZZD_CODCC)   

            elseif  cCusto1 == cCusto
                
                //----------------------------------------------------------------------------
                // Inclu� demais equipamentos do mesmo Centro de Custo
                //----------------------------------------------------------------------------

                aADD(_aVar, { _cCodProd,_cDesProd })

                cCusto  := ALLTRIM(TZZD->ZZD_CODCC)

            elseif cCusto <> cCusto1

                //----------------------------------------------------------------------------
                // Fun��o para iniciar o Fluig de Calibra��o
                //----------------------------------------------------------------------------
                U_fStartTask(_aCab, _aVar, _cUserFluig)

                //----------------------------------------------------------------------------
                // Fun��o para Limpar Array
                //----------------------------------------------------------------------------
                ASIZE(_aCab, 0)
                ASIZE(_aVar, 0)

                //----------------------------------------------------------------------------
                // Inicia inclus�o do novo Centro de Custo e equipamentos
                //----------------------------------------------------------------------------
                aADD(_aCab, { ALLTRIM(TZZD->ZZD_FILIAL),ALLTRIM(TZZD->ZZD_CODCC),ALLTRIM(TZZD->ZZD_DESCCC) })
                aADD(_aVar, { _cCodProd,_cDesProd })

                cCusto  := ALLTRIM(TZZD->ZZD_CODCC) 

            endif

            TZZD->(DbSkip())

            //Final do Array
            if TZZD->(EoF())

                //----------------------------------------------------------------------------
                // Fun��o para iniciar o Fluig de Calibra��o
                //----------------------------------------------------------------------------
                U_fStartTask(_aCab, _aVar)

                //----------------------------------------------------------------------------
                // Fun��o para Limpar Array
                //----------------------------------------------------------------------------
                ASIZE(_aCab, 0)
                ASIZE(_aVar, 0)    

            endif

        EndDo


        Conout("Finalizada rotina de abertura de calibra��es pr�ximas ao vencimento")
    
    //Fecha Query
    TZZD->(DbCloseArea())
    RestArea(aArea)



Return 


/**************************************************************************************************
{Protheus.doc} fStartTask
@description	Funcao para iniciar chamado no Fluig
@type   		Method	
@author			Andr� Longhini
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
M�todo respons�vel por movimentar uma atividade no FLUIG.
@param cIdProcessId, Caracter, C�digo do Processo FLUIG
@param cUserFluig, Caracter, Usu�rio que Iniciar� a solicita��o.
@param nState, N�merico, Atividade Destino
@param cComments, Caracter, Coment�rio que ser� gravado
@param aCardData, Array, Array contendo os campos que ser�o atualizados / preenchidos.
@param oAttachments, Objeto, Objeto Contento os anexos 
@param aColleagueId, Array, Array contendo usu�rios destino.
*/



    aRet := oWsClient:startProcess(cIdProcessId, cUserFluig, "1", _cComents, _aCab, _aVar, "","")

        
    //Verifica se o Fluig foi aberto com sucesso
    If Len(aRet) >= 5 
        _cMsg := (aRet[6,2]) // Se aberto com sucesso, retorna n�mero do fluig.
        MsgInfo("Processo aberto no fluig com sucesso!", "Aten��o")
        MsgInfo("Fluig aberto sob n�mero: " + _cMsg)
    Else 

        For _nI := 1 to Len(aRet) // Se der falha, retorna motivo
            For _nG := 1 to Len(aRet[_nI])
                _cMsg += aRet[_nI][_nG]+' '
            Next
        Next     

        MsgAlert("Falha na execu��o de envio para o fluig!" ;
                + " Contate o administrador do sistema", "Aten��o")
        MsgInfo(_cMsg)
    EndIf 

Return(.T.)


