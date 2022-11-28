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
        form.setVisibleById("dados_Inicial", true);
        form.setVisibleById("Gestor", false);
        form.setVisibleById("aprovacaoCEO",false);
        form.setVisibleById("AprovacaoDiretor",false);
        form.setVisibleById("AvisoPainel",false);
        form.setValue("nomeAtendente", usuarioDataSet.getValue(0, "NOME"));

               
    }
    if (state=="4") {
        form.setVisibleById("dados_Inicial", true);
        form.setVisibleById("Gestor", true);
        form.setVisibleById("aprovacaoCEO",true);
        form.setVisibleById("AprovacaoDiretor",false);
        form.setVisibleById("AvisoPainel",false);
        form.setValue("nomeAtendente", usuarioDataSet.getValue(0, "NOME"));
        form.setValue("colaborador2", usuarioDataSet.getValue(0, "NOME_COMPLETO"));
        form.setValue("tipocontrato", usuarioDataSet.getValue(0, "TPCONTRATO"));
    }
    if (state=="51") {
        form.setVisibleById("dados_Inicial", true);
        form.setVisibleById("Gestor", true);
        form.setVisibleById("aprovacaoCEO",true);
        form.setVisibleById("AprovacaoDiretor",true);
        form.setVisibleById("AvisoPainel",false);
        form.setValue("nomeAtendente", usuarioDataSet.getValue(0, "NOME"));
        form.setValue("colaborador2", usuarioDataSet.getValue(0, "NOME_COMPLETO"));
        form.setValue("tipocontrato", usuarioDataSet.getValue(0, "TPCONTRATO"));
    }
    if (state=="53") {
        form.setVisibleById("dados_Inicial", true);
        form.setVisibleById("Gestor", false);
        form.setVisibleById("aprovacaoCEO",true);
        form.setVisibleById("AprovacaoDiretor",false);
        form.setVisibleById("AvisoPainel",false);
    }
    if (state=="55") {
        form.setVisibleById("dados_Inicial", true);
        form.setVisibleById("Gestor", false);
        form.setVisibleById("aprovacaoCEO",false);
        form.setVisibleById("AprovacaoDiretor",true);
        form.setVisibleById("AvisoPainel",false);
    }
    if (state=="72") {
        form.setVisibleById("dados_Inicial", false);
        form.setVisibleById("Gestor", false);
        form.setVisibleById("aprovacaoCEO",false);
        form.setVisibleById("AprovacaoDiretor",false);
        form.setVisibleById("AvisoPainel",false);
    }
    if (state=="76") {
        form.setVisibleById("dados_Inicial", false);
        form.setVisibleById("Gestor", false);
        form.setVisibleById("aprovacaoCEO",false);
        form.setVisibleById("AprovacaoDiretor",false);
        form.setVisibleById("AvisoPainel",false);
    }
    if (state=="81") {
        form.setVisibleById("dados_Inicial", false);
        form.setVisibleById("Gestor", false);
        form.setVisibleById("aprovacaoCEO",false);
        form.setVisibleById("AprovacaoDiretor",false);
        form.setVisibleById("AvisoPainel",false);
    }
    if (state=="67") {
        form.setVisibleById("dados_Inicial", false);
        form.setVisibleById("Gestor", false);
        form.setVisibleById("aprovacaoCEO",false);
        form.setVisibleById("AprovacaoDiretor",false);
        form.setVisibleById("AvisoPainel",false);
    }
    if (state=="114") {
        form.setVisibleById("dados_Inicial", false);
        form.setVisibleById("Gestor", false);
        form.setVisibleById("aprovacaoCEO",false);
        form.setVisibleById("AprovacaoDiretor",false);
        form.setVisibleById("AvisoPainel",true);
    }
    if (state=="131") {
        form.setVisibleById("dados_Inicial", false);
        form.setVisibleById("Gestor", false);
        form.setVisibleById("aprovacaoCEO",false);
        form.setVisibleById("AprovacaoDiretor",false);
        form.setVisibleById("AvisoPainel",true);
    }
    if (state=="87") {
        form.setVisibleById("dados_Inicial", true);
        form.setVisibleById("Gestor", false);
        form.setVisibleById("aprovacaoCEO",false);
        form.setVisibleById("AprovacaoDiretor",false);
        form.setVisibleById("AvisoPainel",false);
    }
    if (state=="84") {
        form.setVisibleById("dados_Inicial", false);
        form.setVisibleById("Gestor", false);
        form.setVisibleById("aprovacaoCEO",false);
        form.setVisibleById("AprovacaoDiretor",false);
        form.setVisibleById("AvisoPainel",true);
    }
    if (state=="93") {
        form.setVisibleById("dados_Inicial", true);
        form.setVisibleById("Gestor", false);
        form.setVisibleById("aprovacaoCEO",false);
        form.setVisibleById("AprovacaoDiretor",false);
        form.setVisibleById("AvisoPainel",false);
    }
    if (state=="95") {
        form.setVisibleById("dados_Inicial", true);
        form.setVisibleById("Gestor", false);
        form.setVisibleById("aprovacaoCEO",false);
        form.setVisibleById("AprovacaoDiretor",false);
        form.setVisibleById("AvisoPainel",false);
    }
    if (state=="128") {
        form.setVisibleById("dados_Inicial", true);
        form.setVisibleById("Gestor", false);
        form.setVisibleById("aprovacaoCEO",false);
        form.setVisibleById("AprovacaoDiretor",false);
        form.setVisibleById("AvisoPainel",false);
    }
    if (state=="116") {
        form.setVisibleById("dados_Inicial", true);
        form.setVisibleById("Gestor", false);
        form.setVisibleById("aprovacaoCEO",false);
        form.setVisibleById("AprovacaoDiretor",false);
        form.setVisibleById("AvisoPainel",false);
    }
    if (state=="117") {
        form.setVisibleById("dados_Inicial", true);
        form.setVisibleById("Gestor", false);
        form.setVisibleById("aprovacaoCEO",false);
        form.setVisibleById("AprovacaoDiretor",false);
        form.setVisibleById("termoRecusa5",true);
        
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
  //  customHTML.append("		function getWKUserName(){ return '" + userName + "'};");
    customHTML.append("		function getWKUserLogin(){ return '" + userLogin + "'};");
    customHTML.append("		function getWKNumProces(){ return '" + processo + "'};");
    customHTML.append("		function getWKUserLocale(){ return '" + locale + "'};");
    customHTML.append("</script>");
}