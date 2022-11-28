function servicetask130(attempt, message) {
	log.info("### Inicialização da Cotação (Solicitação de compra avulsa) no TOTVS Protheus - solicitarServicoServicetask130 - INICIO ###");
	
	var cCusto        = '"'+hAPI.getCardValue("codCentroCusto")+'"';
	var cDescCc       = '"'+hAPI.getCardValue("descricao")+'"';
	var cSolicitante  = '"'+hAPI.getCardValue("nameUser")+'"';
	var cNumProcesso  = '"'+hAPI.getCardValue ("processo")+'"';
	var cFilial       = '"'+hAPI.getCardValue("codFilial")+'"';
   
	var objBackEnd = JSON.parse('{"cfilialc": '+cFilial+', "cempresac":"01", "ccentrocusto":'+cCusto+', "csolicitante":'+cSolicitante+', "cnumprocesso":'+cNumProcesso+', "cdesccentrocusto":'+cDescCc+'}');

	//input utilizada para armazenar as cotacoes atualizadas
	var inputCotacoes = hAPI.getCardValue("cotacoesInput");
	var cotacoes = JSON.parse(inputCotacoes);

	for (var countProd = 0; countProd < cotacoes.length; countProd++) {
		objBackEnd["cnumcotacao"] = cotacoes[countProd].codNumCotacao;
		
		var fornecedores = cotacoes[countProd].fornecedores;

		for(var countFornec = 0; countFornec < fornecedores.length; countFornec++){
			if(fornecedores[countFornec].ganhador == true){
				objBackEnd["cotacao"+(countProd+1)] = JSON.parse('{"citemcotac":"'+fornecedores[countFornec].codItemCotacao+'", "cqtdprod":"'+cotacoes[countProd].quantidade+'", "cnprod":"'+cotacoes[countProd].codProduto+'", "cfornecedor":"'+fornecedores[countFornec].fornecedor+'", "carmazem":"'+cotacoes[countProd].codArmazem+'", "cprecounid":"'+fornecedores[countFornec].precoUnitario+'", "cprecototal":"'+fornecedores[countFornec].precoTotal+'", "ccodpag":"'+fornecedores[countFornec].condPagamento+'", "clojaforn": "'+fornecedores[countFornec].lojaForn+'"}');
			}			
		}
	}
	
	log.info("INFO OBJBACK::::"+JSON.stringify(objBackEnd));
	
	 try {
	
		var clientService = fluigAPI.getAuthorizeClientService();	
		var compID = getValue("WKCompany");
		
		var data = {
			companyId: compID + "",
			serviceCode: "WSRESTPROTHEUS",
			endpoint: "/WSRESTCOT",
			method: "post",
			timeoutService: "200",
			params: objBackEnd,
			options : {
				encoding : "iso-8859-1",
				mediaType: "application/json"
			}
		}
		
		var vo = clientService.invoke(JSONUtil.toJSON(data));
		
		log.info("response::"+vo.getResult());
		
		if(vo.getResult() == null || vo.getResult().isEmpty()){
			throw "Erro na integração da requisição de contratação de serviços.";	
		}else{
			var response =  vo.getResult();
			var erroRest =  "com.fluig.authorize.client.exception.ClientBasicAuthorizeException: org.apache.http.conn.HttpHostConnectException: Connect to 192.168.200.66:8012 [/192.168.200.66] failed: Connection refused: connect";			
			
			log.info("RESPONSE:::"+response);
			
			if ((response.indexOf(erroRest)) == 0){
				throw "Não foi possível estabelecer uma conexçao com o Protheus. Tente novamente!"
			}else {
				var responseJson = JSON.parse(response);//Para os erros que são gerados via Protheus
				
				if(responseJson.errorCode == 500){
					throw "Erro interno no servidor! Entre em contato com o administrador do sistema.";
				}else if(responseJson.errorCode == 401 || responseJson.errorCode == 403 || responseJson.errorCode == 404 ){
					throw "Erro na autenticação/endereço inexistente"; 
				}
			}
		}	
		
	 } catch (error) {
		log.info("Erro::::"+error);
		throw error;
	 }
	 
	 log.info("### Finalização da Cotação (Solicitação de contratação de serviços) no TOTVS Protheus - solicitarServicoServicetask130 - FIM ###");
}