function servicetask238(attempt, message) {

	// Pega os valores que pertecem a tabela de produtos que estão armazenado dentro de uma lista na function modalBuscarProduto
	var produtos = hAPI.getCardValue("listaProdutos");	
	var produtosFormatado = JSON.parse("["+produtos+"]");
	// Monta objeto para envio no backend
	var objBackEnd = {
		"cuser": hAPI.getCardValue("nameUser"),
		"csolicitacao": hAPI.getCardValue ("processo"),
		"cfilial": hAPI.getCardValue("codFilial"),
		"cempresa":"01"
	};
	// Converte lista em objetos sequenciais 
	for(var count = 0; count < produtosFormatado.length; count++){            
		objBackEnd["produtos"+(count+1)] = JSON.parse('{"cidProduto":"'+produtosFormatado[count].cidProduto+'", "cquantidade":"'+produtosFormatado[count].cquantidade+'", "cobs":"'+produtosFormatado[count].cobs+'", "ccusto":"18.01.02", "carmazem":"01MZ01"}');
	// 	log.info("produto111"+item);
		log.info(count);
	}

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
		
		if(vo.getResult() == null || vo.getResult().isEmpty()){
			throw "Erro na integração da requisição de materiais.";	
		}else{	
			log.info("### Inclusão de Cliente no TOTVS Protheus - servicetask44 - response - "+vo.getResult());	
			var response = JSON.parse(vo.getResult());	
			if(response.STATUS == undefined || response.STATUS == null){	
				throw "Erro de comunicação com o Protheus";	
			}else{
				if(response.STATUS == false){
					throw response.MESSAGE;	
				}
			}
		}
		log.info("### Inclusão de Cliente no TOTVS Protheus - servicetask44 - FIM ###");
		
	} catch (error) {
		log.info("DEU RUIM...");
	}

}