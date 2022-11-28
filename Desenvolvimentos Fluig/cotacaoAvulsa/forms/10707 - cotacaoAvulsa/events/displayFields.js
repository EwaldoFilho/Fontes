function displayFields(form,customHTML){
	var mode     = form.getFormMode();
	var state    = getValue("WKNumState");
	var complete = getValue("WKCompletTask");
	var user     = getValue("WKUser");
	var locale   = getValue("WKUserLocale");
	var mobile   = form.getMobile();
	var processo = getValue("WKNumProces");
	
	var usuarioDataSet = DatasetFactory.getDataset("armazem_buscar_empresas", null, null, null);

	//titulo
	form.setVisibleById("tituloSolicitacao", false);
	form.setVisibleById("tituloTriagem", false);
	form.setVisibleById("tituloAtendimento", false);
	form.setVisibleById("tituloValidar", false);
	form.setVisibleById("tituloSolicitacaoFinalizada", false);
	
	// panels
	form.setVisibleById("panelDadosSolicitante", false);
	form.setVisibleById("panelDadosSolicitacao", false);
	form.setVisibleById("panelAtendimento", false);
	form.setVisibleById("panelValidarAtendimento", false);

	//botao
	form.setVisibleById("grupoBotaoProdutos", false);

	if(state == "0"){
		form.setValue("nameUser", usuarioDataSet.getValue(0, "NOME"));
		form.setVisibleById("tituloSolicitacao", true);
		form.setVisibleById("panelDadosSolicitante", true);
		form.setVisibleById("panelDadosSolicitacao", true);
		form.setVisibleById("grupoBotaoProdutos", true);
	}

	if(state == "4"){
		form.setVisibleById("tituloTriagem", true);
		form.setVisibleById("panelDadosSolicitante", true);
		form.setVisibleById("panelDadosSolicitacao", true);
		form.setVisibleById("grupoBotaoProdutos", false);
	}

	if(state == "6"){
		form.setVisibleById("tituloAtendimento", true);
		form.setVisibleById("panelDadosSolicitante", true);
		form.setVisibleById("panelAtendimento", true);
	}

	if(state == "8"){
		form.setVisibleById("tituloValidar", true);
		form.setVisibleById("panelDadosSolicitante", true);
		form.setVisibleById("panelValidarAtendimento", true);
	}

	if(state == "10"){
		form.setVisibleById("tituloSolicitacaoFinalizada", true);
		form.setVisibleById("panelDadosSolicitante", true);
		form.setVisibleById("panelDadosSolicitacao", true);
	}

	if(state == "12"){
		form.setVisibleById("tituloSolicitacao", true);
		form.setVisibleById("panelDadosSolicitante", true);
		form.setVisibleById("panelDadosSolicitacao", true);
		form.setVisibleById("grupoBotaoProdutos", true);
	}
	
	if(state == "16"){
		form.setVisibleById("tituloSolicitacao", true);
		form.setVisibleById("panelDadosSolicitante", true);
		form.setVisibleById("panelDadosSolicitacao", true);
		form.setVisibleById("grupoBotaoProdutos", true);
	}
	
	form.setValue("estado1", state);
	form.setValue("processo1", processo);
	
	customHTML.append("<script>");
	customHTML.append("		function getFormMode(){ return '" + mode + "'};");
	customHTML.append("		function getMobile(){ return '" + mobile + "'};");
	customHTML.append("		function getWKNumState(){ return '" + state + "'};");
	customHTML.append("		function getWKUser(){ return '" + user + "'};");
	customHTML.append("		function getWKNumProces(){ return '" + processo + "'};");
	customHTML.append("		function getWKUserLocale(){ return '" + locale + "'};");
	customHTML.append("</script>");	
}