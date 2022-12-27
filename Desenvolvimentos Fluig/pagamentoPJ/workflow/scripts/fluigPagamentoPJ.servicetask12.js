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
        if (vo.getResult() == null || vo.getResult().isEmpty()) {
            throw "Erro na integração da requisição Pagamento PJ.";
        } else {
            log.info("### Integração pagamento PJ - servicetask12 - response - " + vo.getResult());
            var response = JSON.parse(vo.getResult());
            if (response.STATUS == undefined || response.STATUS == null) {
                throw "Erro de comunicação com o Protheus";
            } else {
                if (response.STATUS == false) {
                    throw response.MESSAGE;
                } else {

                }
            }
        }
	 log.info("### Finalização da integração Pré Nota TOTVS Protheus - servicetask12 - FIM ###");
}