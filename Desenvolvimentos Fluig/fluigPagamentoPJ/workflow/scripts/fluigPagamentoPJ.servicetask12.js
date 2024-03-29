function servicetask12(attempt, message) {
log.info("### Inclusão de pré nota - servicetask12 - INICIO ###");
	

	var cFilial        = '"'+hAPI.getCardValue("codFilialForn")+'"';
	var cNumero        = '"'+hAPI.getCardValue("numeroNF")+'"';
	var cNumFlg        = '"'+hAPI.getCardValue("processo")+'"';
	var Ccusto       = '"'+hAPI.getCardValue("codCentroCusto")+'"';
	var cSerie       = '"'+hAPI.getCardValue("serieNF")+'"';
	var cFornecedor  = '"'+hAPI.getCardValue("codForn")+'"';
	var cLoja        =  '"'+hAPI.getCardValue ("codLoja")+'"';
	var cCondPagto       = "";
	var dDTemissao       = '"'+hAPI.getCardValue("dataFormatada")+'"';
	var cEspecie       = "";
	var cEstado       = '"'+hAPI.getCardValue("estadoForn")+'"';
	var cValor       = '"'+hAPI.getCardValue("valorFormatado")+'"';
	
	log.info("VARIAVEIS OBJETO PAGAMENTO PJ INICIO");
	log.info("cFilial" + cFilial);
	log.info("cNumero" + cNumero);
	log.info("cNumFlg" + cNumFlg);
	log.info("Ccusto" + Ccusto);
	log.info("cSerie" + cSerie);
	log.info("cFornecedor" + cFornecedor);
	log.info("cLoja" + cLoja);
	log.info("cCondPagto" + cCondPagto);
	log.info("dDTemissao" + dDTemissao);
	log.info("cEspecie" + cEspecie);
	log.info("cEstado" + cEstado);
	log.info("cValor" + cValor);
	log.info("VARIAVEIS OBJETO PAGAMENTO PJ FIM");
	
	var objBackEnd = JSON.parse('{"cNumFlg":'+cNumFlg+',"Ccusto":'+Ccusto+',"cNumero": '+cNumero+', "cSerie":'+cSerie+', "cFornecedor":'+cFornecedor+', "cLoja":'+cLoja+', "cCondPagto":"12", "dDTemissao":'+dDTemissao+',"cEspecie":"NF","cEstado":'+cEstado+',"nota1":[{"D1_FILIAL":'+cFilial+',"D1_ITEM":"0001","D1_COD":"100000000002255","D1_UM":"UN","D1_QUANT":"1","D1_VUNIT":'+cValor+',"D1_TOTAL":'+cValor+'}]}');

	log.info("INFO OBJBACK::::"+JSON.stringify(objBackEnd));
	
	try {
	
		var clientService = fluigAPI.getAuthorizeClientService();	
		var compID = getValue("WKCompany");
		
		var data = {
			companyId: compID + "",
			serviceCode: "WSRESTPROTHEUS",
			endpoint: "/WSPREDOCUMENTO",
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
	 log.info("### Finalização da integração Pré Nota TOTVS Protheus - servicetask12 - FIM ###");
}