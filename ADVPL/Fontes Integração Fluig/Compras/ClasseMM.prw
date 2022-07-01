#include 'totvs.ch'

Class IPFluigClass

	data oWs as object 
	data oWsTransf as object
	data oWsSearch as object
	data oWsCard   as object
	data cUserName as String
	data cPassword as String 
	data nCompanyId as String 
	data cUserId  as String 
	
	method newIPFluigClass() CONSTRUCTOR
	
	method setWs(oWs)
	method getWs()
	
	method getUsuario(cUsrIni)
	
	method setUserName(cUsername)
	method getUserName()
	
	method setPassword(cPassword)
	method getPassword()
	
	method setCompanyId(nCompanyId)
	method getCompanyId()
	
	method setUserId()
	method getUserId()
	
	method getCardValue(cIdProcessId,cCardFieldName)
	method getInstanceCardData(processInstanceId)
		
	method startProcess(cIdProcessId,cComments,aCardData)
	method saveAndSendTask(nProcessInstanceId,nChoosedState,cComments,lManagerMode,nThreadSequence,aUsrDest,aCardData,lcompleteTask)
	method getAvailableProcess() 
	method getErroAuto()  
endClass


method newIPFluigClass() class IPFluigClass 
	::oWs      := WSECMWorkflowEngineServiceService():New()
return


/*/{Protheus.doc} setUserName

Define o nome do usu�rio
	
@author TOTVS IP
@since 22/06/2017
@type method

@param cUserName, Caracter, Nome do Usuario
/*/
method setUserName(cUserName) class IPFluigClass 
	::cUserName := cUserName
return


/*/{Protheus.doc} getUserName

Coleta o atributo nome do usuario
	
@author TOTVS IP
@since 22/06/2017
@type method

@return cUserName , Nome do usu�rio
/*/
method getUserName() class IPFluigClass 
return ::cUserName


/*/{Protheus.doc} setPassword

Define o atributo senha.
	
@author TOTVS IP
@since 22/06/2017
@type method

@param cPassword, Caracter, Senha
/*/
method setPassword(cPassword) class IPFluigClass 
	::cPassword := cPassword
return


/*/{Protheus.doc} getPassword

Coleta o atributo senha
	
@author TOTVS IP
@since 22/06/2017
@type method

@return cPassword , Senha
/*/
method getPassword() class IPFluigClass 
return ::cPassword


/*/{Protheus.doc} setCompanyId

Define o atributo c�digo da empresa FLUIG
	
@author TOTVS IP
@since 22/06/2017
@type method

@param nCompanyId, N�merico, C�digo da empresa FLUIG
/*/
method setCompanyId(nCompanyId) class IPFluigClass 
	::nCompanyId := nCompanyId
return


/*/{Protheus.doc} getCompanyId

Coleta o atributo codigo da empresa FLUIG.
	
@author TOTVS IP
@since 22/06/2017
@type method

@return nCompanyId , C�dito da Empresa FLUIG
/*/
method getCompanyId() class IPFluigClass 
return ::nCompanyId


/*/{Protheus.doc} getUserId

Coleta o ID do usu�rio FLUIG
	
@author TOTVS IP
@since 22/06/2017
@type method

@return cUserId , ID do usu�rio FLUIG
/*/
method getUserId() class IPFluigClass 
return ::cUserId


/*/{Protheus.doc} setUserId

Define o atributo ID do usu�rio
	
@author TOTVS IP
@since 22/06/2017
@type method

@param cUserId, Caracter, ID do usu�rio FLUIG
/*/
method setUserId(cUserId) class IPFluigClass 
	::cUserId := cUserId
return 


/*/{Protheus.doc} setCompanyId

Define o atributo objeto do client do  webservice.
	
@author TOTVS IP
@since 22/06/2017
@type method

@param oWs, Objeto, Objeto do client do webservice
/*/
method setWs(oWs) class IPFluigClass 
	::oWs := oWs
return


/*/{Protheus.doc} getWs

Coleta o atributo objeto do client do webservice
	
@author TOTVS IP
@since 22/06/2017
@type method

@return oWs , Objeto do client do webservice
/*/
method getWs() class IPFluigClass 
return ::oWs


/*/{Protheus.doc} saveAndSendTask

M�todo respons�vel por movimentar uma atividade no FLUIG.
	
@author TOTVS
@since 22/06/2017
@type method
@param nProcessInstanceId, N�merico, N�mero da Solicita��o do FLUIG
@param nChoosedState, N�merico, Atividade Destino cada tarefa tem um c�digo
@param cComments, Caracter, Coment�rio que ser� gravado
@param lManagerMode, L�gico, Inclui como Gestor .f.
@param nThreadSequence, N�merico, Thread 0
@param aUsrDest, Array, Array contendo usu�rios destino. 
@param aCardData, Array, Array contendo os campos que ser�o atualizados / preenchidos. 
@param lCompleteTask, L�gico, Inclu� movimentando para a pr�xima atividade? .t.

@return Array , Array contendo o n�mero da solicita��o (1) e mensagem de retorno (2).
/*/
method saveAndSendTask(nProcessInstanceId,nChoosedState,cComments,lManagerMode,nThreadSequence,aUsrDest,aCardData,lCompleteTask) class IPFluigClass 

    Local _cUrsFlg         := ""
    Local _cPasswodFlg      := ""
	Local _cUrsCod			:= ""
	local oWs    	        := ::getWs()
	local oUsrDest          := ECMWorkflowEngineServiceService_stringArray():new()
	local oCardData         := ECMWorkflowEngineServiceService_stringArrayArray():New()
	//local oUsr		    := nil 
    local nI		        := 0
	local aRet		        := {}
	Local lcompleteTask     := .T.
	//local oCardData       := nil
	default lManagerMode 	:= .T.
	default nThreadSequence := 0
	default aUsrDest 		:= {}
	default aCardData       := {}

    _cUrsFlg        := GetNewPar("FLG_NMUSR"    , "caroline.nascimento") 
    _cPasswodFlg    := GetNewPar("FLG_PSWUSR"   , "Carol123#")
	_cUrsCod		:= GetNewPar("FLG_CODUSR"   , "00125")
	
	For nI := 1 To len(aCardData)      	 
	     aadd(oCardData:oWSitem , ECMWorkflowEngineServiceService_stringArrayArray():New() ) 
	     oCardData:oWSitem[len(oCardData:oWSitem)]:cItem := aCardData[nI]   	     	  
	Next nI 	  
	    
	oWS:oWSsaveAndSendTaskcardData := oCardData   
	oUsrDest:cItem := aUsrDest
	oWS:oWSsaveAndSendTaskcolleagueIds := oUsrDest	
	
	If oWs:saveAndSendTask(_cUrsFlg,_cPasswodFlg,1,nProcessInstanceId,nChoosedState,oUsrDest,cComments, _cUrsCod,lcompleteTask,/*oWSsaveAndSendTaskattachments*/,oCardData,/*oWSsaveAndSendTaskappointment*/,lManagerMode,nThreadSequence)
		oResult := oWs:oWSsaveAndSendTaskresult
     	For nI := 1 To len(oResult:oWsItem) 
     		aadd(aRet,{oResult:oWSItem[nI]:cItem[1] , oResult:oWSItem[nI]:cItem[2] })
     	Next nI
	EndIf
	
Return aRet 


/*/{Protheus.doc} getUsuario

M�todo respons�vel por preencher as informa��es de usu�rio e senha que executar� a integra��o.
	
@author TOTVS IP
@since 22/06/2017
@type method
/*/
method getUsuario() class  IPFluigClass

	local cUsrECM   := Alltrim( GetMv("MV_ECMUSER") )
	local cPswECM   := Alltrim( GetMv("MV_ECMPSW") )
	local nComECM   := val(GetMv("MV_ECMEMP"))
	
	if( !Empty(cUsrECM))
		::setUserName(cUsrECM)  
		::setPassword("md5:" + MD5( cPswECM,2 )) 
		::setUserId(cUsrECM)
		::setCompanyId(nComECM)				
	endIf				

return


/*/{Protheus.doc} getCardValue

M�todo respons�vel por retornar o valor de um campo especifico de uma solicita��o FLUIG.
	
@author TOTVS IP
@since 22/06/2017
@type method
@param nProcessInstanceId, Num�rico, N�mero da SOlicita��o do FLUIG
@param cCardFieldName, Nome do campo de formul�rio

@return Caracter , Informa��o do campo
/*/
method getCardValue(nProcessInstanceId,cCardFieldName) class IPFluigClass 
	local oWs    	:= ::getWs()
	local cRet    := ""
	
	if oWs:getCardValue(::getUserName(),::getPassword(),::getCompanyId(),nProcessInstanceId,::getUserId(),cCardFieldName)
		cRet := oWs:ccontent
	endIF

return cRet



/**************************************************************************************************
{Protheus.doc} fMovTask
@description	M�todo respons�vel por retornar todos os campos de uma solicita��o FLUIG.
@type   		Method	
@author			Lucas Rocha Vieira
@version   		1.00
@since     		10/10/2021
@database		10/10/2021
@country		Brasil
@language		PT-BR
@obs			10/10/2021 - Controle de documentacao
@param			nProcessInstanceId, Num�rico, N�mero da SOlicita��o do FLUIG
@return		    Array , Array contendo todos os campos da solicita��o.	
*****************************************************************************************************/
method getInstanceCardData(nProcessInstanceId) class IPFluigClass 
 	local oWs      := ::getWs()
 	local oResult  := nil
 	local aRet     := {}
 	local nI       := 0 
 	local nPosCpo  := 1
 	local nPosVal  := 2
 	
	if oWs:getInstanceCardData(::getUsername(),::getPassword(),::getCompanyId(),::getUserId(),nProcessInstanceId)	
		oResult := oWs:oWSgetInstanceCardDataCardData
		for nI := 1 to Len(oResult:oWsItem) 	     
     		AAdd(aRet,{oResult:oWsItem[nI]:cItem[nPosCpo],oResult:oWsItem[nI]:cItem[nPosVal]})	     	
     	next nI  
	endIf 
return aRet


method getAvailableProcess() class IPFluigClass 
	
	local oWs :=  ::getWs()

	oWs:getAvailableProcess(::getUserName(), ::getPassword(), ::getCompanyId(), ::getUserId()) 

return oWS:oWSgetAvailableProcessAvailableProcesses 


/*/{Protheus.doc} startProcess

M�todo respons�vel pela inclus�o de uma solicita��o no FLUIG.
	
@author TOTVS IP
@since 22/06/2017
@type function
@param cIdProcessId, Caracter, C�digo do Processo FLUIG
@param cUserFluig, Caracter, Usu�rio que Iniciar� a solicita��o.
@param nState, N�merico, Atividade Destino
@param cComments, Caracter, Coment�rio que ser� gravado
@param aCardData, Array, Array contendo os campos que ser�o atualizados / preenchidos.
@param oAttachments, Objeto, Objeto Contento os anexos 
@param aColleagueId, Array, Array contendo usu�rios destino.

@return Array , Array contendo o n�mero da solicita��o (1) e mensagem de retorno (2).
/*/
method startProcess(cIdProcessId, cUserFluig, nState, cComments, aCardData, oAttachments,aColleagueId) class IPFluigClass 

     local oAllProc	        := ::getAvailableProcess()
     local oWs    	        := ::getWs()
     local oResult          :=  nil 
     local aRet 	        := {} 
     local oCardData        := WSECMWorkflowEngineServiceService_stringArrayArray():New()
     local oColleagueIds	:= nil
     local nI               := 0 
     local obj 		        := nil    
         
      if oAllProc !=  nil
        
        if aColleagueId != nil
	        if !empty(aColleagueId)
	        	oColleagueIds	:= WSECMWorkflowEngineServiceService_stringArray():New()
	        	for nI := 1 to len(aColleagueId)
		     		aadd(oColleagueIds:oWSitem , WSECMWorkflowEngineServiceService_stringArray():New() ) 
		     	  	oColleagueIds:oWSitem[len(oColleagueIds:oWSitem)]:cItem := aColleagueId[nI]   	     	  
		    	next nI 
	        endIf
	    endIf
        
        nI	:= 1
        && Inicializa campos  do formul�rio   
      	for nI := 1 to len(aCardData)
      	 
	     aadd(oCardData:oWSitem , WSECMWorkflowEngineServiceService_stringArray():New() ) 
	     	  oCardData:oWSitem[len(oCardData:oWSitem)]:cItem := aCardData[nI]   	     	  
	    next nI 	  
	    
	    oWS:oWSstartProcesscardData := oCardData    
	    
	    if oAttachments <> nil
	    	oWS:oWSstartProcessattachments :=  oAttachments
	    endIf
	    
       if oWs:startProcess(::getUserName(), ::getPassword(), ::getCompanyId(), cIdProcessId, nState, /*colleagueIds*/, cComments, cUserFluig, .T., oAttachments, oCardData, /*appointment*/, .F.)      
	     	oResult := oWs:oWSstartProcessresult
	     	for nI := 1 to len(oResult:oWSitem) 
	     		aadd(aRet,{ AllTrim(oResult:oWSitem[nI]:cItem[1]), AllTrim(oResult:oWSitem[nI]:cItem[2]) })
	     	next nI   
	    endIf	
     
     endIf 

return aRet


/*/{Protheus.doc} getErroAuto

M�todo respons�vel por retornar o erro da rotina automatica tratado para exibi��o no HTML.
	
@author TOTVS IP
@since 22/06/2017
@type function
@param xParam, TipoParam, DescricaoDoParam

@return Caracter, Variavel contendo o erro da rotina automatica.
/*/
method getErroAuto() class IPFluigClass
	local aErro := getAutoGRLog()
	local nI	:= 1
	local cErro	:= ""
	
	for nI := 1 to len(aErro)
		cErro += aErro[nI] + "<br>"
	next nI
	
return cErro   
