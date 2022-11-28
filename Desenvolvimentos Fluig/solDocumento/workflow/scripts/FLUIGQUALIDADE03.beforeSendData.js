function beforeSendData(customField, customFact) {

    customField[0] = hAPI.getCardValue("setor");

    customField[1] = hAPI.getCardValue("criticidade");

    customField[2] = hAPI.getCardValue("tipo_solici");
}
