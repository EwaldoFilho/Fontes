function servicetask31(attempt, message) {
	log.info("### Inclusão de titulo financeiro SE2 - servicetask31 - INICIO ###");

    var objeto = {};
    var data = new Date()

    objeto.company = "01";
    objeto.branch = hAPI.getCardValue("codFilialForn");
    objeto.header = {  
<<<<<<< HEAD
    	"cCodFilial"
    	"cNum"
    	"cPrefixo"	
        "cParcela" : hAPI.getCardValue("codFornecedor"),
        "cTp" : hAPI.getCardValue("lojaFornecedor"),
        "cNatureza" : hAPI.getCardValue(""),
        "cNum" : "12345678",
        "cTp" : "NF",
        "cNatureza" : "20230",
        "dEmissao" : "20220117",
        "dVencimento" : "20220117",
        "dVenc_Real" : "20220117",
        "nValor" : "500",
        "nVlr" : "500",
        "cCusto" : "18.01.01",
=======
    	"cCodFilial" : hAPI.getCardValue("codFilialForn"),
    	"cNum" : hAPI.getCardValue("processo"),
    	"cPrefixo" : hAPI.getCardValue("FLG"),	
        "cParcela" : hAPI.getCardValue("quantidadeparce"),
        "cTp" : hAPI.getCardValue("NF"),
        "cNatureza" : hAPI.getCardValue(""),
        "cCodFornec" : "12345678",
        "cLojaForec" : "NF",
        "dEmissao" : hAPI.getCardValue(""),,
        "dVencimento" : hAPI.getCardValue ("vencimento"),
        "dVenc_Real" : hAPI.getCardValue ("20220117"),
        "nValor" : hAPI.getCardValue ("20220117"),
        "nVlr" : "500",
        "cCusto" : "500",
        "cHist" : hAPI.getCardValue ("historicodescri"),
>>>>>>> 1216723ee8a734a31c11c03007b2a529e7036f6a
        "cOpc" : "3"
    };
    
    var indicesrateioCusto = hAPI.getChildrenIndexes("rateioCusto");
    if (indicesrateioCusto.length > 0) {
        objeto.items = [];
        for (var i = 0; i < indicesrateioCusto.length; i++) {
            var id = indicesrateioCusto[i];

            var item = {};
<<<<<<< HEAD
            item.D3_COD = hAPI.getCardValue("codGasto___" + id);
            item.D3_UM = hAPI.getCardValue("unidade___" + id);
            item.D3_LOCAL = hAPI.getCardValue("armazem");
=======
            item.cCodFilial = hAPI.getCardValue("codFilialForn");
            item.cNum = hAPI.getCardValue("processo");
            item.cPrefixo = hAPI.getCardValue("FLG");
            item.cParcela = hAPI.getCardValue("unidade___" + id);
            item.cTp = hAPI.getCardValue("NF");
>>>>>>> 1216723ee8a734a31c11c03007b2a529e7036f6a
            item.D3_QUANT = hAPI.getCardValue("quantidade___" + id);
            item.D3_LOTECTL = hAPI.getCardValue("lote___" + id);

            objeto.items.push(item);
        }


        log.info("### Inclusão de titulo financeiro SE2 - servicetask31 - objeto - " + JSONUtil.toJSON(objeto));
        var clientService = fluigAPI.getAuthorizeClientService();
        var compID = getValue("WKCompany");
        var data = {
            companyId: compID + "",
            serviceCode: "WSRESTPROTHEUS",
            endpoint: "/APImovimentacaoEstoque/add",
            method: "post",
            timeoutService: "1200",
            params: objeto,
            options: {
                encoding: "iso-8859-1",
                mediaType: "application/json"
            }
        }

        var vo = clientService.invoke(JSONUtil.toJSON(data));
        if (vo.getResult() == null || vo.getResult().isEmpty()) {
            throw "Erro na integração da inclusão de títulos.";
        } else {
            log.info("### Inclusão de títulos no Protheus - servicetask31 - response - " + vo.getResult());
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

        log.info("### Movimentação de Estoque no Protheus - servicetask5 - FIM ###");
    }
}