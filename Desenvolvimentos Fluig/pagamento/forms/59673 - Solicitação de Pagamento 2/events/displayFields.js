function displayFields(form,customHTML){
	
	var mode     = form.getFormMode();
	var state    = getValue("WKNumState");
	var complete = getValue("WKCompletTask");
	var user     = getValue("WKUser");
	var locale   = getValue("WKUserLocale");
	var mobile   = form.getMobile();
	var processo = getValue("WKNumProces");
	
	form.setValue('processo', processo);
	// Seta data no input data
	if (state == 1 || state == 0) {
        var today = new Date();
        var year = today.getFullYear();
        var month = today.getMonth() + 1 < 10 ? '0' + (today.getMonth() + 1) : (today.getMonth() + 1);
        var day = today.getDate() < 10 ? '0' + today.getDate() : today.getDate();
        form.setValue('datasolicitacao', day + '/' + month + '/' + year);
    }
	
	
	
	// Seta usuário no input
	var usuarioDataSet = DatasetFactory.getDataset("usuarioProtheus", null, null, null);

	log.info("Estado"+state);
	form.setValue("estado", state);

	
		
	//panels
	form.setVisibleById("panelDadoSolicitante", true);
	form.setVisibleById("panelDadoFornecedor", true);
	form.setVisibleById("panelFormaPagamento", true);

	//botoes
	form.setVisibleById("grupoBotaoProdutos", false);

	

	if (state=="0") {
		form.setVisibleById("panelDadoSolicitante", true);
		form.setVisibleById("panelDadoFornecedor", true);
		form.setVisibleById("panelFormaPagamento", true);
		form.setValue("solicitanteNome", usuarioDataSet.getValue(0, "NOME"));
		form.setValue("matriculaUsuario", fluigAPI.getUserService().getCurrent().code);
	}
	
	if (state=="4") {
		form.setVisibleById("panelDadoSolicitacao", true);
		form.setVisibleById("grupoBotaoProdutos", true);
		form.setVisibleById("tituloSolicitacao", true);
		form.setValue("solicitanteNome", usuarioDataSet.getValue(0, "NOME"));
	}
	if (state=="6") {
		form.setVisibleById("codNatureza", true);
	}
	
	
	
	if (form.getFormMode() == "VIEW"){
		 form.setShowDisabledFields(true);
	}
	
	var c1 = DatasetFactory.createConstraint("colleaguePK.colleagueId", getValue("WKUser"), getValue("WKUser"), ConstraintType.MUST);
	var constraints = new Array(c1);
	var userDataSet = DatasetFactory.getDataset("colleague", null, constraints, null);
	var userName = userDataSet.getValue(0, "colleagueName")
	
	customHTML.append("<script>");
	customHTML.append("		function getFormMode(){ return '" + mode + "'};");
	customHTML.append("		function getMobile(){ return '" + mobile + "'};");
	customHTML.append("		function getWKNumState(){ return '" + state + "'};");
	customHTML.append("		function getWKUser(){ return '" + user + "'};");
	customHTML.append("		function getWKUserName(){ return '" + userName + "'};");
	customHTML.append("		function getWKNumProces(){ return '" + processo + "'};");
	customHTML.append("		function getWKUserLocale(){ return '" + locale + "'};");
	customHTML.append("</script>");	
}

