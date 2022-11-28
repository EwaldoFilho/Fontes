function servicetask5(attempt, message) {

    log.info("### Movimentação de Estoque no Protheus - servicetask5 - INICIO ###");

    var objeto = {};
    var data = new Date()

    objeto.company = "01";
    objeto.branch = hAPI.getCardValue("filial");
    objeto.header = {
        "D3_TM": "501",
        "D3_CC": hAPI.getCardValue("codigoCentroCusto")
    };
    
    var indicesGastos = hAPI.getChildrenIndexes("itensGastos");
    if (indicesGastos.length > 0) {
        objeto.items = [];
        for (var i = 0; i < indicesGastos.length; i++) {
            var id = indicesGastos[i];

            var item = {};
            item.D3_COD = hAPI.getCardValue("codGasto___" + id);
            item.D3_UM = hAPI.getCardValue("unidade___" + id);
            item.D3_LOCAL = hAPI.getCardValue("armazem");
            item.D3_QUANT = hAPI.getCardValue("quantidade___" + id);
            item.D3_LOTECTL = hAPI.getCardValue("lote___" + id);

            objeto.items.push(item);
        }


        log.info("### Movimentação de Estoque no Protheus - servicetask5 - objeto - " + JSONUtil.toJSON(objeto));
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
            throw "Erro na integração da requisição de materiais.";
        } else {
            log.info("### Movimentação de Estoque no Protheus - servicetask5 - response - " + vo.getResult());
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