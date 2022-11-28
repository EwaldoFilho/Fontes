function displayFields(form, customHTML) {

    var mode = form.getFormMode();
    var state = getValue("WKNumState");
    var complete = getValue("WKCompletTask");
    var user = getValue("WKUser");
    var locale = getValue("WKUserLocale");
    var mobile = form.getMobile();
    var processo = getValue("WKNumProces");
	var usuarioDataSet = DatasetFactory.getDataset("tetesprotheus", null, null, null);

    if (state=="0") {
        form.setVisibleById("comeco1", true);
        form.setVisibleById("dados_Inicial", false);
        
    }
    
    if (state=="12") {
    	 
    	 form.setVisibleById("rnc", true);
    	 form.setVisible("comeco2", true);
    	 form.setVisible("notaRecomenda", false);
         form.setVisibleById("dados_Inicial", true);
    }
    if (state=="21") {
    	form.setVisibleById("rnc", true);
   	 	form.setVisible("comeco2", true);
   	 	form.setVisible("notaRecomenda", true);
        form.setVisibleById("dados_Inicial", true);
   }
    if (state=="33") {
      	 form.setVisibleById("comeco1", false);
      	 form.setVisible("comeco2", true);
      	 form.setVisibleById("menorQUE", true);
      	 form.setVisibleById("menorq", true);
      	 form.setVisibleById("panelRnc", true);
      	 form.setVisibleById("RNC", true);
           form.setVisibleById("dados_Inicial", true);
      }
    if (state=="23") {
    	form.setVisibleById("comeco1", true);
     	 form.setVisible("comeco2", true);
     	 form.setVisibleById("menorQUE", true);
     	 form.setVisibleById("menorq", true);
     	 form.setVisibleById("panelRnc", true);
     	 form.setVisibleById("RNC", true);
         form.setVisibleById("dados_Inicial", true);
     }
    
    var c1 = DatasetFactory.createConstraint("colleaguePK.colleagueId", getValue("WKUser"), getValue("WKUser"), ConstraintType.MUST);
    var constraints = new Array(c1);
    var userDataSet = DatasetFactory.getDataset("colleague", null, constraints, null);
    var userName = userDataSet.getValue(0, "colleagueName");
    var userLogin = userDataSet.getValue(0, "login");

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

