function getFormInputs(selectedTarget){
	var formData = new Array();
	selectedTarget = (typeof(selectedTarget) == 'object')? selectedTarget : $( selectedTarget ) ;
	selectedTarget.find('input, select, textarea').each(function(){
		var id = $(this).attr('id');
		var type = $(this).attr('type');
		if(id !== undefined){
			if(type == 'radio'){
				var name = $(this).attr('name');
				var val = $('[name=' + name + ']').val()
				id = name;
			} else {
			//var val = getElement(id);
				var val = $(this).val();
				if(typeof(val) === 'object'  &&  val !== null  &&  val !== undefined){
					val = val[0];
				}
			}
			var objInput = {
				"name":  id,
	        	"value": ( (val === null  ||  val === undefined)? '' : val )
			}
			formData.push( objInput );
		}
	});
	return formData;
}

var _returnAjax = {
	'api':		'',
	'data': 	{'content': {columns: [], values: []} },
	'mensage': 	'',
	'status':	0,
	'error': 	''
};


function createFormAjax(url, publisherId, WDParentDocumentId, attachments, cardDescription, cardFormData, objData){
	console.log('createFormAjax: ', url, publisherId, WDParentDocumentId, typeof(attachments), cardDescription, typeof(cardFormData), typeof(objData));
	
	var ok = false;
	var rrAjax = null;	

	var api = url + "/ecm/api/rest/ecm/cardPublisher/saveNewCardItem";
	_returnAjax.api = api;
	
	if(typeof(objData) === 'undefined'){
		var objData = new Object();
		objData = {
		   "companyId":1,
		   "documentId":0,
		   "version":1000,
		   "parentDocumentId": WDParentDocumentId,
		   "privateDocument":false,
		   "manualVersion":false,
		   "documentDescription":"",
		   "additionalComments":"",
		   "versionDescription":null,
		   "cardDescription": cardDescription,
		   "publisherId": publisherId,
		   "inheritSecurity":true,
		   "publicDocument":false,
		   "inheritApprovers":false,
		   "uploadFolder": url + "/webdesk/Upload",
		   "deleteUploadFiles":true,
		   "documentType":"5",
		   "documentTypeId":null,
		   "infGeralVO":null,
		   "approved":false,
		   "securityPermissionVOs":null,
		   "securityRestrictionVOs":null,
		   "publisherApproverVOs":null,
		   "activeApproverTab":false,
		   "relatedDocumentVO":null,
		   "principalFileName":"",
		   "hasParentApprover":false,
		   "attachments": attachments,
		   "allocatedPK":null,
		   "editableDocumentData":"",
		   "saveDraft":false,
		   "userSecurityLevel":3,
		   "defaultPropertyVO":null,
		   "ckbDefaultPropertyVO":null,
		   "adminUser":false, // true,
		   "phisicalFile": url + "/webdesk/streamcontrol/" + WDParentDocumentId + "/0/0/?WDCompanyId=1&WDNrDocto=0&WDNrVersao=0&WDParentDocumentId=" + WDParentDocumentId,
		   "folderList":null,
		   "formData":null,
		   "attach":null,
		   "relatedFiles":null,
		   "rootPrivateFolder":false,
		   "tabActivated":false,
		   "metaListId":4,
		   "cardFormData": cardFormData,
		   "changeAllActiveCards":false,
		   "permissionType":0,
		   "restrictionType":0,
		   "uploadId":null,
		   "oldViewer":false,
		   "uploadUrl":null,
		   "imutable":null,
		   "hasPendentApprovals":false,
		   "formDatasetVOs":null,
		   "message":null,
		   "internalFields":[]
		};
	}
	
	if(typeof(objData) == 'object'){
		objData = JSON.stringify(objData);
	}
	//console.log('objData: ', (typeof(objData) === 'undefined'), objData, cardFormData);
	
	var settings = {
		"async": false,
		"crossDomain": false,
		"url": api,
		"method": "POST",
		"headers": {
			"Accept": "application/json, text/javascript, */*; q=0.01",
//			"Accept-Encoding": "gzip, deflate, br",
			"Accept-Language": "pt-BR,pt;q=0.9,en-US;q=0.8,en;q=0.7",
//			"Connection": "keep-alive",
			"Content-Type": "application/json; charset=UTF-8",
//			"Host": host,
//			"Referer": url,
//			"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Safari/537.36",
			"X-Requested-With": "XMLHttpRequest",
			"Authorization": readCookie("jwt.token"),
			"cache-control": "no-cache",
		},
		"data": objData
	}
	
	
	$.when(
//		$.ajax({
//			async: 			false,
//			contentType:	"application/json",
//			type:			_authorized[typeHttp].request_data.method,
//			url:			_authorized[typeHttp].request_data.url,
//			data:			auxData,
//			headers:		_authorized[typeHttp].oauth			
//		//}).success(function(data) {
//		//}).success(function(dataAjax, textStatus, jqXHR) {
//		}).done(function(dataAjax, textStatus, jqXHR) {
		$.ajax(settings).done(function(dataAjax, textStatus, jqXHR) {
			//console.log('-> requestAjax 3 - 1');
			//console.log("OK: ", dataAjax);
			
			ok = true;
			_returnAjax.data 	= dataAjax;
			_returnAjax.mensage = 'return.';
			_returnAjax.status 	= jqXHR.status;
			_returnAjax.error 	= (!ok);
			//rrAjax = _returnAjax;
			return  _returnAjax;
	
		//}).fail(function(data) {
		}).fail(function(jqXHR, textStatus, errorThrown) {
			//console.log('-> requestAjax 3 - 2');				
			//var msgErro = ' ERRO: ' + jqXHR.status + ' - ' + jqXHR.responseText;
			var msgErro = jqXHR.responseText;
			//console.log(msgErro);
			
			ok = false;
			_returnAjax.data 	= {'content': {columns: [], values: []} };
			_returnAjax.mensage = msgErro;
			_returnAjax.status 	= jqXHR.status;
			_returnAjax.error 	= (!ok);
			if(ok == false){
				rrAjax = _returnAjax;
				//alert( msgErro );
			}
			return  _returnAjax;
		})		
	).then(function( data, textStatus, jqXHR ) {
		//console.log('-> requestAjax 3 - 3');
		rrAjax = _returnAjax;
		if(ok == false){
			console.log( 'ERRO: ' + jqXHR.status + ' - ' + jqXHR.responseText );
		}
		//return  _returnAjax;
	});
	
	return rrAjax;
}


//function saveFormAjax(url, host, documentId, version, formData){
function saveFormAjax(url, documentId, version, formData){
	console.log('saveFormAjax: ', url, documentId, version, typeof(formData));
	
	var ok = false;
	var rrAjax = null;	

	var api = url + "/ecm/api/rest/ecm/cardView/editCard/" + documentId + "/" + version;
	_returnAjax.api = api;
	
	if(typeof(formData) == "object"){
		formData = JSON.stringify(formData);
	}
	
	var settings = {
		"async": false,
		"crossDomain": false,
		"url": api,
		"method": "POST",
		"headers": {
			"Accept": "application/json, text/javascript, */*; q=0.01",
//			"Accept-Encoding": "gzip, deflate, br",
			"Accept-Language": "pt-BR,pt;q=0.9,en-US;q=0.8,en;q=0.7",
//			"Connection": "keep-alive",
			"Content-Type": "application/json; charset=UTF-8",
//			"Host": host,
//			"Referer": url,
//			"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Safari/537.36",
			"X-Requested-With": "XMLHttpRequest",
			"Authorization": readCookie("jwt.token"),
			"cache-control": "no-cache",
		},
		"data": formData
	}
	
	
	$.when(
//		$.ajax({
//			async: 			false,
//			contentType:	"application/json",
//			type:			_authorized[typeHttp].request_data.method,
//			url:			_authorized[typeHttp].request_data.url,
//			data:			auxData,
//			headers:		_authorized[typeHttp].oauth			
//		//}).success(function(data) {
//		//}).success(function(dataAjax, textStatus, jqXHR) {
//		}).done(function(dataAjax, textStatus, jqXHR) {
		$.ajax(settings).done(function(dataAjax, textStatus, jqXHR) {
			//console.log('-> requestAjax 3 - 1');
			//console.log("OK: ", dataAjax);
			
			ok = true;
			_returnAjax.data 	= dataAjax;
			_returnAjax.mensage = 'return.';
			_returnAjax.status 	= jqXHR.status;
			_returnAjax.error 	= (!ok);
			//rrAjax = _returnAjax;
			return  _returnAjax;
	
		//}).fail(function(data) {
		}).fail(function(jqXHR, textStatus, errorThrown) {
			//console.log('-> requestAjax 3 - 2');				
			//var msgErro = ' ERRO: ' + jqXHR.status + ' - ' + jqXHR.responseText;
			var msgErro = jqXHR.responseText;
			//console.log(msgErro);
			
			ok = false;
			_returnAjax.data 	= {'content': {columns: [], values: []} };
			_returnAjax.mensage = msgErro;
			_returnAjax.status 	= jqXHR.status;
			_returnAjax.error 	= (!ok);
			if(ok == false){
				rrAjax = _returnAjax;
				//alert( msgErro );
			}
			return  _returnAjax;
		})		
	).then(function( data, textStatus, jqXHR ) {
		//console.log('-> requestAjax 3 - 3');
		rrAjax = _returnAjax;
		if(ok == false){
			console.log( 'ERRO: ' + jqXHR.status + ' - ' + jqXHR.responseText );
		}
		//return  _returnAjax;
	});
	
	return rrAjax;
}


function RequisicaoXML(url, xml){
	
	var xhr = new XMLHttpRequest();
	xhr.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var response = (this.responseText);  
			console.log(response);     
		}
	};
	xhr.open("POST", url, false);
	xhr.setRequestHeader('Content-Type', 'application/json');
	xhr.send(xml);
}


function AtualizarFormulario(processo, campo, valor) {
	console.log('%c -> AtualizarFormulario: [' +  processo + '] ' + campo + '=(' + valor + ')', 'color:orange');

	var url = parent.WCMAPI.serverURL + "/webdesk/ECMCardService?wsdl";
	var cardId = FormularioProcesso(processo);

	var xmlItem = "<item>";
	xmlItem += "	<field>" + campo + "</field>";
	xmlItem += "	<value>" + valor + "</value>";
	xmlItem += "</item>";

	var xml = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.dm.ecm.technology.totvs.com/">'
		+'<soapenv:Header/>'
		+'<soapenv:Body>'
			+'<ws:updateCardData>'
			+'<companyId>' + top.WCMAPI.organizationId + '</companyId>'
			+'<username></username>'
			+'<password></password>'
			+'<cardId>' + cardId + '</cardId>'
			+'<cardData>'
				+ xmlItem
			+'</cardData>'
			+'</ws:updateCardData>'
		+'</soapenv:Body>'
		+'</soapenv:Envelope>';
	
	RequisicaoXML(url, xml);
	
}