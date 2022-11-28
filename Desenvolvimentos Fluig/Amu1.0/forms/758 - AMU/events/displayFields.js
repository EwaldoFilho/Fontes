function displayFields(form, customHTML) {

    var mode = form.getFormMode();
    var state = getValue("WKNumState");
    var complete = getValue("WKCompletTask");
    var user = getValue("WKUser");
    var locale = getValue("WKUserLocale");
    var mobile = form.getMobile();
    var processo = getValue("WKNumProces");

    if (form.getFormMode() == "VIEW") {
        form.setShowDisabledFields(true);
    }

    var c1 = DatasetFactory.createConstraint("colleaguePK.colleagueId", getValue("WKUser"), getValue("WKUser"), ConstraintType.MUST);
    var constraints = new Array(c1);
    var userDataSet = DatasetFactory.getDataset("colleague", null, constraints, null);
    var userName = userDataSet.getValue(0, "colleagueName");
    var userLogin = userDataSet.getValue(0, "login");
   
    form.setValue("estado", state);
    
    customHTML.append("<script>");
    customHTML.append("		function getFormMode(){ return '" + mode + "'};");
    customHTML.append("		function getMobile(){ return '" + mobile + "'};");
    customHTML.append("		function getWKNumState(){ return '" + state + "'};");
    customHTML.append("		function getWKUser(){ return '" + user + "'};");
    customHTML.append("		function getWKUserName(){ return '" + userName + "'};");
    customHTML.append("		function getWKUserLogin(){ return '" + userLogin + "'};");
    customHTML.append("		function getWKNumProces(){ return '" + processo + "'};");
    customHTML.append("		function getWKUserLocale(){ return '" + locale + "'};");
    customHTML.append("</script>");
}