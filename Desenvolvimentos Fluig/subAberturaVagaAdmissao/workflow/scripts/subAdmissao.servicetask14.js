function servicetask14(attempt, message) {
log.info("### Inclusão de ADMISSÃO - servicetask14 - INICIO ###");
	

	var cObj       = '"'+hAPI.getCardValue("obj")+'"';	
	
	var objBackEnd = JSON.parse(cObj);

	log.info("INFO OBJBACK::::"+JSON.stringify(objBackEnd));
	
	try {
	
		var clientService = fluigAPI.getAuthorizeClientService();	
		var compID = getValue("WKCompany");
		
		var data = {
			companyId: compID + "",
			serviceCode: "WSRESTPROTHEUS",
			endpoint: "/WSFUNC",
			method: "post",
			timeoutService: "200",
			params: objBackEnd,
			options : {
				encoding : "iso-8859-1",
				mediaType: "application/json"
			}
		}
		
		var vo = clientService.invoke(JSONUtil.toJSON(data));
		
		if(vo.getResult() == null || vo.getResult().isEmpty()){
			throw "Erro na integração da Pré Nota.";	
		}else{	
			var response =  vo.getResult();
			var responseJson = JSON.parse(response);//Para os erros que são gerados via Protheus
			var erroRest =  "com.fluig.authorize.client.exception.ClientBasicAuthorizeException: org.apache.http.conn.HttpHostConnectException: Connect to 192.168.200.66:8012 [/192.168.200.66] failed: Connection refused: connect";			
			
			log.info("RESPONSE:::"+response);
			
			if ((response.indexOf(erroRest)) == 0){
				throw "Não foi possível estabelecer uma conexçao com o Protheus. Tente novamente!"
			}else if(responseJson.errorCode == 500){
				throw "Erro interno no servidor! Entre em contato com o administrador do sistema.";
			}else if(responseJson.errorCode == 401 || responseJson.errorCode == 403 || responseJson.errorCode == 404 ){
				throw "Erro na autenticação/endereço inexistente"; 
			}
		}		
	 } catch (error) {
		log.info("Erro::::"+error);
		throw error;
	 }
	 log.info("### Finalização da integração ADMISSÃO TOTVS Protheus - servicetask14 - FIM ###");
}