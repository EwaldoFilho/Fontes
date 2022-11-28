function beforeSendData(customField, customFact) {

    customField[0] = hAPI.getCardValue("Tcontrato");

    customField[1] = hAPI.getCardValue("cargos");

    customField[2] = hAPI.getCardValue("Perfil");

    customField[3] = hAPI.getCardValue("Sistemas0");

    customField[4] = hAPI.getCardValue("Sistemas1");

    customField[5] = hAPI.getCardValue("Sistemas2");

    customField[7] = hAPI.getCardValue("Sistemas4");

    customField[8] = hAPI.getCardValue("Sistemas5");

    customField[9] = hAPI.getCardValue("modulo");

    customField[10] = hAPI.getCardValue("Sistemas6");

    customField[11] = hAPI.getCardValue("Sistemas7");

    customField[12] = hAPI.getCardValue("Sistemas8");

    customField[13] = hAPI.getCardValue("Sistemas9");
}
