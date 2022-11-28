function inputFields(form) {
    if (form && form.getValue("datasolicitacao") && form.getValue("datasolicitacao").match("^[0-3]?[0-9]/[0-3]?[0-9]/(?:[0-9]{2})?[0-9]{2}$")) {
        var split = form.getValue("datasolicitacao").split('/');
        form.setValue("datasolicitacao", split[2] + '-' + split[1] + '-' + split[0]);
    }
}
