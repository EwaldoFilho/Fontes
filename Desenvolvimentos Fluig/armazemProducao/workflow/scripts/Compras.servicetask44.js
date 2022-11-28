function servicetask44(attempt, message) {

	// Pega os valores que pertecem a tabela de produtos que estão armazenado dentro de uma lista na function modalBuscarProduto
	var produtos = hAPI.getCardValue("listaProdutos");	
	var produtosFormatado = JSON.parse("["+produtos+"]");
	
	var cUser         = '"'+hAPI.getCardValue("nameUser")+'"';
	var cCusto        = '"'+hAPI.getCardValue("codCentroCusto")+'"';
	var cDescCc       = '"'+hAPI.getCardValue("descricao")+'"';
	var cFilial       = '"'+hAPI.getCardValue("codFilial")+'"';
	var cArmazem       = '"'+hAPI.getCardValue("codArmazem")+'"';
	var cNumProcesso  = '"'+hAPI.getCardValue("processo")+'"';
	var itens = [];
		
	// Monta objeto para envio no backend
	var objBackEnd = JSON.parse('{"cfilial": '+cFilial+', "cempresa":"01", "ccentrocusto":'+cCusto+', "cuser":'+cUser+', "csolicitacao":'+cNumProcesso+', "cdesccentrocusto":'+cDescCc+'}');
	
	// Converte lista em objetos sequenciais 
	for(var count = 0; count < produtosFormatado.length; count++){            
		//objBackEnd["produtos"+(count+1)] = JSON.parse('{"cidProduto":"'+produtosFormatado[count].cidProduto+'", "cquantidade":"'+produtosFormatado[count].cquantidade+'", "cobs":"'+produtosFormatado[count].cobs+'", "ccusto":"18.01.02", "carmazem":"01MZ01"}');
		objBackEnd["produtos"+(count+1)] = JSON.parse('{"cidProduto":"'+produtosFormatado[count].cidProduto+'", "cquantidade":"'+produtosFormatado[count].cquantidade+'", "cobs":"'+produtosFormatado[count].cobs+'", "ccusto":'+cCusto+', "cDescCc":'+cDescCc+',  "carmazem":'+cArmazem+'}');
	}
	
	log.info("INFO OBJBACK::::"+JSON.stringify(objBackEnd));
	
	try {
		var clientService = fluigAPI.getAuthorizeClientService();	
		var compID = getValue("WKCompany");
		
		var data = {
				companyId: compID + "",
				serviceCode: "WSRESTPROTHEUS",
				endpoint: "/WSARMAZEM",
				method: "post",
				timeoutService: "200",
				params: objBackEnd,
				options : {
					encoding : "iso-8859-1",
					mediaType: "application/json"
				}
		}
	
		var vo = clientService.invoke(JSONUtil.toJSON(data));
	
		log.info("### Inclusão de solicitação ao armazem no TOTVS Protheus - servicetask44 - INICIO ###");

		if(vo.getResult() == null || vo.getResult().isEmpty()){
			throw "Erro na integração da requisição ao armazém.";	
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
		log.info("### Inclusão de solicitação ao armazem no TOTVS Protheus - servicetask44 - FIM ###");		
	} catch (error) {
		log.info("Erro::::"+error);
		throw error;
	}

}