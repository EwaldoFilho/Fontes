function beforeSendData(customField, customFact) {

    customField[0] = hAPI.getCardValue("empresas");

    customField[1] = hAPI.getCardValue("fornecedor");

    customField[2] = hAPI.getCardValue("formapagamento");

    customField[3] = hAPI.getCardValue("centrocusto");

    customField[4] = hAPI.getCardValue("natureza");

    var field0 = hAPI.getCardValue('quantidadeparce');
    field0 = +field0;
    if (!isNaN(field0)) {
        customFact[0] = field0;
    }
}
