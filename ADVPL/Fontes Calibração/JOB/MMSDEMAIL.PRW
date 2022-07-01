#INCLUDE "Protheus.ch"
#Include "TopConn.ch"
#INCLUDE "AP5MAIL.CH"
#INCLUDE'PROTHEUS.CH'
#INCLUDE'TOPCONN.CH'
#INCLUDE'TOTVS.CH'
#INCLUDE'RWMAKE.CH'
#INCLUDE'PARMTYPE.CH'

/**************************************************************************************************
{Protheus.doc} MMSDEMAIL
@description	Rotina para processar envio de e-mail
@type   		Funcao 
@author			André Longhini Maximiano Longhini
@version   		1.00
@since     		29/03/2022
@database		29/03/2022
@country		Brasil
@language		PT-BR
@obs			29/03/2022 - Controle de documentacao
@param          _cDest    , conta de e-mail de destino do e-mail
@param          _cAssunt  , assunto que será configurado no e-mail
@param          _cMsg     , mensagem a ser enviada no corpo do e-mail
@param          _cAnexos  , anexos a serem enviados com o e-mail
@param          _lMsg     , define se serão registradas mensagens no console.log do serviço
@param          _cLog     , variável para gravação do log do processamento
@param          _lAuth    , identifica se o servidor requer autenticação para envio do e-mail
@param          _cDestCO  , Destinatários para cópias ocultas
@param          _cDestCC  , Destinatários para cópias normais
@return			Logico		
*****************************************************************************************************/
User Function MMSDEMAIL( _cDest , _cAssunt , _cMsg , _lMsg , _cLog , _lAuth , _cDestCO , _cDestCC )

Local _lResult		:= .F.
Local _cError		:= ""
Local _cConta		:= AllTrim( GetMV( "COM_CCP07" ,, "" ) )
Local _cPasswd	    := AllTrim( GetMV( "COM_CCP08"  ,, "" ) )
Local _cServer	    := AllTrim( GetMV( "MV_RELSERV" ,, "" ) )
Local _cFrom		:= AllTrim( GetMV( "COM_CCP07" ,, "" ) )
Local _nAt          := ""

Default _cDest		:= ''
Default _cAssunt	:= ''
Default _cMsg		:= ''
Default _lMsg		:= .T.
Default _cLog		:= ""
Default _lAuth		:= GetMV( "MV_RELAUTH" ,, .F. )
Default _cDestCO	:= ''
Default _cDestCC	:= ''

_cFrom		:= _cConta

    //----------------------------------------------------------------------------------------------------
    // Envia o e-mail para a lista selecionada. Envia como CC
    //----------------------------------------------------------------------------------------------------
    CONNECT SMTP SERVER _cServer ACCOUNT _cConta PASSWORD _cPasswd RESULT _lResult

    //----------------------------------------------------------------------------------------------------
    // Verifica se o Servidor de EMAIL necessita de Autenticacao
    //----------------------------------------------------------------------------------------------------
    If !_lResult 
        ConOut("PROBLEMAS com Servidor de e-mail! Em " + DtoC(Date()) + " " + Time() )
        Return(.F.)
    EndIf

    //-----------------------------------------------------------------------------------------------------
    // Realiza a autenticação no servidor de email SMTP
    //----------------------------------------------------------------------------------------------------
	if !MailAuth(_cConta,_cPasswd)
		_nAt		:= At( "@" , _cConta )
		_cUser		:= If( _nAt > 0 , Subs( _cConta , 1 , _nAt - 1 ) , _cConta )
		_lResult	:= MailAuth( _cUser , _cPasswd )
	Endif

    //----------------------------------------------------------------------------------------------------
    // Envio do email 
    //----------------------------------------------------------------------------------------------------
    If _lResult

        SEND MAIL FROM _cFrom	TO      	_cDest		;
                                CC     		_cDestCC	;
                                BCC			_cDestCO	;
                                SUBJECT 	_cAssunt	;
                                BODY    	_cMsg		;
                                RESULT		_lResult

    Else 
        ConOut("Erro de autenticação! "+_cConta + " Em " + DtoC(Date()) + " " + Time() )
		DISCONNECT SMTP SERVER
		Return(.F.)
    EndIf 

    //----------------------------------------------------------------------------------------------------
    // Falha no envio do email 
    //----------------------------------------------------------------------------------------------------
	If !_lResult
        GET MAIL ERROR _cError
        ConOut( "Erro no envio do email: "+ _cError , '[WZSNDEML]' )
        DISCONNECT SMTP SERVER
        Return(.F.)
    EndIf

Return( _lResult )
