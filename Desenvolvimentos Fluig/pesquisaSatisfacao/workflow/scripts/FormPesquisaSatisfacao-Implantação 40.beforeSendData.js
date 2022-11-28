function beforeSendData(customField, customFact) {

    customField[0] = hAPI.getCardValue("date12");

    customField[1] = hAPI.getCardValue("textbox1");
}
