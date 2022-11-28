function beforeSendData(customField, customFact) {

    customField[0] = hAPI.getCardValue("contrato");

    customField[1] = hAPI.getCardValue("Modulo");

    customField[2] = hAPI.getCardValue("Equipamentos0");

    customField[3] = hAPI.getCardValue("Equipamentos1");

    customField[4] = hAPI.getCardValue("Equipamentos2");

    customField[5] = hAPI.getCardValue("Equipamentos3");

    customField[6] = hAPI.getCardValue("Equipamentos4");

    customField[7] = hAPI.getCardValue("Equipamentos5");

    customField[8] = hAPI.getCardValue("Equipamentos6");

    customField[9] = hAPI.getCardValue("Equipamentos7");
}
