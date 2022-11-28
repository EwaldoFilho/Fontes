function beforeSendData(customField, customFact) {

    customField[0] = hAPI.getCardValue("combo7");

    customField[1] = hAPI.getCardValue("radio7");

    customField[2] = hAPI.getCardValue("textbox5");

    customField[3] = hAPI.getCardValue("textarea4");

    var field0 = hAPI.getCardValue('ratingstar8');
    field0 = +field0;
    if (!isNaN(field0)) {
        customFact[0] = field0;
    }
}
