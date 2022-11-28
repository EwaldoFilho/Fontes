function displayFields(form,customHTML){
	
	var mode     = form.getFormMode();
	var state    = getValue("WKNumState");
	var complete = getValue("WKCompletTask");
	var user     = getValue("WKUser");
	var locale   = getValue("WKUserLocale");
	var mobile   = form.getMobile();
	var processo = getValue("WKNumProces");
	
	var activity = getValue('WKNumState');
	form.setValue("etapa", activity);
	form.setValue("processo", processo);
	// Seta usuário no input
	var usuarioDataSet = DatasetFactory.getDataset("armazem_buscar_empresas", null, null, null);
	
	
	log.info("Estado"+state);
	form.setValue("estado", state);
	if (state == 530) {

        var comentario = getValue("WKUserComment");

        if (comentario == "") {
            throw "Obrigatório informar um Complemento justificando a reprovação.";
        }}
	
	//panels	
	form.setVisibleById("panelDadoSolicitante", true);
	form.setVisibleById("panelDadoSolicitacao", true);	
	form.setVisibleById("panelOrcamento", false);
	form.setVisibleById("panelCotacoes", false);
	form.setVisibleById("panelValidarServico", false);	
	form.setVisibleById("panelCancelamento", false);
	
	//botoes
	form.setVisibleById("grupoBotaoProdutos", false);

	//titulos paginas
	form.setVisibleById("tituloSolicitacao", false);
	form.setVisibleById("tituloCadastroProtheus", false);
	form.setVisibleById("tituloApGerente", false);
	form.setVisibleById("tituloCotacao", false);
	form.setVisibleById("tituloProcessoContratacao", false);
	form.setVisibleById("tituloSolicitacaoFinalizada", false);
	form.setVisibleById("tituloValidarContrato", false);
	form.setVisibleById("tituloContratacaoServiço", false);
	form.setVisibleById("tituloAssinaturaContrato", false);
	form.setVisibleById("tituloValidarServico", false);
	form.setVisibleById("tituloFechamentoCompra", false);
	form.setVisibleById("tituloAguardandoEntrega", false);
	form.setVisibleById("tituloConfirmacaoRecebimento", false);
	
	//inputs
	form.setVisibleById("setorDiv", false);
	var MODE = form.getFormMode()
	var usuarioCorrente = fluigAPI.getUserService().getCurrent();
	
	if(MODE == "ADD"){
		
		form.setValue("nameUser", usuarioCorrente.getFullName());
		
	}

	if (state=="0") {
		form.setVisibleById("panelDadoSolicitacao", true);
		form.setVisibleById("grupoBotaoProdutos", true);
		form.setVisibleById("tituloSolicitacao", true);
		
	}
	
	if (state=="4") {
		form.setVisibleById("panelDadoSolicitacao", true);
		form.setVisibleById("grupoBotaoProdutos", true);
		form.setVisibleById("tituloSolicitacao", true);
		
	}
	
	if (state=="5") {
		form.setVisibleById("grupoBotaoProdutos", false); 		
	 	form.setVisibleById("panelDadoSolicitante", true);
    	form.setVisibleById("panelDadoSolicitacao", true);
		form.setVisibleById("tituloApGerente", true);
	 }

	if (state=="54") {
		form.setVisibleById("grupoBotaoProdutos", false); 		
	 	form.setVisibleById("panelDadoSolicitante", true);
	 	form.setVisibleById("panelOrcamento", false);
		form.setVisibleById("tituloSolicitacao", true);
	}	
	
	if (state=="90") {
		form.setVisibleById("grupoBotaoProdutos", false); 		
	 	form.setVisibleById("panelDadoSolicitante", true);
    	form.setVisibleById("panelDadoSolicitacao", true);
		form.setVisibleById("tituloSolicitacao", true);
	}	
	
	if (state=="136") {
		form.setVisibleById("panelDadoSolicitante", true);
    	form.setVisibleById("panelDadoSolicitacao", false);
		form.setVisibleById("panelCotacoes", true);
		form.setVisibleById("panelOrcamento", true);
		form.setVisibleById("tituloCotacao", true);
		form.setVisibleById("setorDiv", true);
	}
	
	if (state=="124") {
		form.setVisibleById("panelDadoSolicitante", true);
    	form.setVisibleById("panelDadoSolicitacao", false);
		form.setVisibleById("panelCotacoes", true);
		form.setVisibleById("panelOrcamento", true);
		form.setVisibleById("tituloCotacao", true);
		form.setVisibleById("setorDiv", true);
		form.setVisibleById("panelCancelamento", true);
	}

	if (state=="132") {
		form.setVisibleById("grupoBotaoProdutos", false); 		
	 	form.setVisibleById("panelDadoSolicitante", true);
    	form.setVisibleById("panelDadoSolicitacao", true);
		form.setVisibleById("tituloSolicitacao", true);
		form.setVisibleById("panelCotacoes", true);
		form.setVisibleById("panelOrcamento", true);
		form.setVisibleById("tituloCotacao", true);
		form.setVisibleById("panelCancelamento", true);
	}


	if (state=="433") {
		form.setVisibleById("grupoBotaoProdutos", false); 		
	 	form.setVisibleById("panelDadoSolicitante", true);
    	form.setVisibleById("panelDadoSolicitacao", false);
		form.setVisibleById("tituloContratacaoServiço", true);
		form.setVisibleById("panelCotacoes", true);
		form.setVisibleById("panelValidarServico", true);
		form.setVisibleById("tituloFechamentoCompra", true);
		//form.setVisibleById("panelProcessoContratacao", true);		
	}
	
	if (state=="475") {
		form.setVisibleById("grupoBotaoProdutos", false); 		
	 	form.setVisibleById("panelDadoSolicitante", true);
    	form.setVisibleById("panelDadoSolicitacao", true);		
		form.setVisibleById("tituloSolicitacaoFinalizada", true);
	 }
	
	if (state=="497") {
		form.setVisibleById("panelDadoSolicitante", true);
    	form.setVisibleById("panelDadoSolicitacao", false);
		form.setVisibleById("panelCotacoes", true);
		form.setVisibleById("panelOrcamento", true);
		form.setVisibleById("tituloCotacao", true);
		form.setVisibleById("setorDiv", true);
		form.setVisibleById("panelCancelamento", true);
	}

	if (state=="500") {
		form.setVisibleById("grupoBotaoProdutos", false); 		
	 	form.setVisibleById("panelDadoSolicitante", true);
    	form.setVisibleById("panelDadoSolicitacao", true);
		form.setVisibleById("tituloSolicitacao", true);
		form.setVisibleById("panelCotacoes", true);
		form.setVisibleById("panelOrcamento", true);
		form.setVisibleById("tituloCotacao", true);
	}

	if (state=="511") {
		form.setVisibleById("grupoBotaoProdutos", false); 		
	 	form.setVisibleById("panelDadoSolicitante", true);
    	form.setVisibleById("panelDadoSolicitacao", true);
		form.setVisibleById("panelValidarServico", true);
		form.setVisibleById("tituloAguardandoEntrega", true);
	}
	
	if (state=="515") {
		form.setVisibleById("grupoBotaoProdutos", false); 		
	 	form.setVisibleById("panelDadoSolicitante", true);
    	form.setVisibleById("panelDadoSolicitacao", true);
		form.setVisibleById("tituloSolicitacao", true);
		form.setVisibleById("tb_produtos", true);
		
	 }if (state=="530") {
			form.setVisibleById("grupoBotaoProdutos", false); 		
		 	form.setVisibleById("panelDadoSolicitante", true);
		 	form.setVisibleById("panelDadoSolicitacao", true);
			form.setVisibleById("tituloSolicitacao", true);
			form.setVisibleById("tb_produtos", true);
			form.setVisibleById("panelCancelamento", true);
		}
	
	if (state=="537") {
		form.setVisibleById("grupoBotaoProdutos", false); 		
	 	form.setVisibleById("panelDadoSolicitante", true);
    	form.setVisibleById("panelDadoSolicitacao", true);
		form.setVisibleById("panelValidarServico", true);
		form.setVisibleById("tituloConfirmacaoRecebimento", true);
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

	customHTML.append("		function getWKUser(){ return '" + user + "'};");
	customHTML.append("		function getWKUserName(){ return '" + userName + "'};");
	customHTML.append("		function getWKNumProces(){ return '" + processo + "'};");
	customHTML.append("		function getWKUserLocale(){ return '" + locale + "'};");
	customHTML.append("</script>");	
}

