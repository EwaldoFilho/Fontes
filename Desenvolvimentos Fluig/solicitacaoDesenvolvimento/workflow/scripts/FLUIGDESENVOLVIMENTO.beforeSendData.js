function beforeSendData(customField, customFact) {

    customField[0] = hAPI.getCardValue("date4");

    customField[1] = hAPI.getCardValue("cbSetor");

    customField[2] = hAPI.getCardValue("dtAbertura");

    customField[3] = hAPI.getCardValue("combo4");

    customField[4] = hAPI.getCardValue("combo6");

    customField[5] = hAPI.getCardValue("combo5");

    var field0 = hAPI.getCardValue('ratingstar7');
    field0 = +field0;
    if (!isNaN(field0)) {
        customFact[0] = field0;
    }
}
