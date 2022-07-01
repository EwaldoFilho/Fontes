#Include "Protheus.ch"

/*/{Protheus.doc} 
Classe genérica utilizado como response pelas API`s

@type class
@author Alisson Hausmann
@since 12/01/2021
/*/
class APIresponse
	data status
	data message
	data payLoad

	method new() Constructor
	method setStatus()
	method setMessage()
	method setPayload()
endClass

method new() class APIresponse
	self:status := .F.
	self:message := ""
return(self)

method setStatus(status) class APIresponse
	self:status := status
return

method setMessage(message) class APIresponse
	self:message := message
return

method setPayload(payLoad) class APIresponse
	self:payLoad := payLoad
return
