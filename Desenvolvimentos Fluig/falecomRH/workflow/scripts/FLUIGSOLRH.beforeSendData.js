function beforeSendData(customField, customFact) {

    customField[0] = hAPI.getCardValue("cbAssuntoRH");

    customField[1] = hAPI.getCardValue("txDescricaoRH");

    customField[2] = hAPI.getCardValue("TxTrativaRh");

    customField[3] = hAPI.getCardValue("contratp");
}
