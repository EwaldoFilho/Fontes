function displayFields(form,customHTML){
	
	var mode     = form.getFormMode();
	var state    = getValue("WKNumState");
	var complete = getValue("WKCompletTask");
	var user     = getValue("WKUser");
	var locale   = getValue("WKUserLocale");
	var mobile   = form.getMobile();
	var processo = getValue("WKNumProces");
	
	// Seta usuário no input
	var usuarioDataSet = DatasetFactory.getDataset("armazem_buscar_empresas", null, null, null);
	var MODE = form.getFormMode()
	var usuarioCorrente = fluigAPI.getUserService().getCurrent();
	
	if(MODE == "ADD"){
		
		form.setValue("nameUser", usuarioCorrente.getFullName());
		
	}
	log.info("Estado"+state);
	log.info("processo"+processo);
	form.setValue("estado", state);
	form.setValue("processo", processo);

	//panels	
	form.setVisibleById("panelDadoSolicitante", true);
	form.setVisibleById("panelDadoSolicitacao", false);	
	form.setVisibleById("panelCotacoes", false);
	form.setVisibleById("panelOrcamento", false);
	form.setVisibleById("panelProcessoContratacao", false);	
	form.setVisibleById("panelValidarServico", false);
	form.setVisibleById("panelCancelamento", false);	

	//botoes
	form.setVisibleById("grupoBotaoProdutos", false);

	//tabelas
	form.setVisibleById("produtosNovosView", false);
	form.setVisibleById("produtosView", false);

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

	if (state=="0") {
		form.setVisibleById("panelDadoSolicitacao", true);
		form.setVisibleById("grupoBotaoProdutos", true);
		form.setVisibleById("tituloSolicitacao", true);
		form.setValue("nameUser", usuarioCorrente.getFullName());
		form.setValue("matriculaUsuario", fluigAPI.getUserService().getCurrent().code);
	}
	
	if (state=="4") {
		form.setVisibleById("panelDadoSolicitacao", true);
		form.setVisibleById("grupoBotaoProdutos", true);
		form.setVisibleById("tituloSolicitacao", true);
		form.setValue("nameUser", usuarioCorrente.getFullName());
	}

	if (state=="5") {
		form.setVisibleById("grupoBotaoProdutos", false); 		
	 	form.setVisibleById("panelDadoSolicitante", true);
    	form.setVisibleById("panelDadoSolicitacao", true);
		form.setVisibleById("produtosView", true);
		form.setVisibleById("tituloApGerente", true);
		form.setVisibleById("panelCancelamento", true);
		form.setVisibleById("tb_produtos", true);
	 }
	
	if (state=="44") {
			form.setVisibleById("grupoBotaoProdutos", false); 		
		 	form.setVisibleById("panelDadoSolicitante", true);
	    	form.setVisibleById("panelDadoSolicitacao", true);
			form.setVisibleById("produtosView", true);
			form.setVisibleById("tituloSolicitacao", true);
	}

	if (state=="54") {
		form.setVisibleById("grupoBotaoProdutos", false); 		
	 	form.setVisibleById("panelDadoSolicitante", true);
    	form.setVisibleById("panelDadoSolicitacao", true);
		form.setVisibleById("produtosView", true);
		form.setVisibleById("tituloSolicitacao", true);
	}

	if (state=="73") {
		form.setVisibleById("grupoBotaoProdutos", false); 		
	 	form.setVisibleById("panelDadoSolicitante", true);
    	form.setVisibleById("panelDadoSolicitacao", true);
		form.setVisibleById("produtosView", true);
		form.setVisibleById("tituloSolicitacao", true);
		form.setVisibleById("tb_produtos", true);
	}

	if (state=="113") {
		form.setVisibleById("grupoBotaoProdutos", false); 		
	 	form.setVisibleById("panelDadoSolicitante", true);
    	form.setVisibleById("panelDadoSolicitacao", true);
		form.setVisibleById("produtosView", true);
		form.setVisibleById("tituloSolicitacao", true);
	}	 

	if (state=="119") {
		form.setVisibleById("grupoBotaoProdutos", true); 		
	 	form.setVisibleById("panelDadoSolicitante", true);
    	form.setVisibleById("panelDadoSolicitacao", true);
		form.setVisibleById("produtosView", true);
		form.setVisibleById("tituloSolicitacao", true);
	}		 

	if (state=="124") {
		form.setVisibleById("panelDadoSolicitante", true);
    	form.setVisibleById("panelDadoSolicitacao", false);
		form.setVisibleById("panelCotacoes", true);
		form.setVisibleById("panelOrcamento", true);
		form.setVisibleById("tituloCotacao", true);
		form.setVisibleById("panelCancelamento", true);
	}
	
	if (state=="136") {
		form.setVisibleById("panelDadoSolicitante", true);
    	form.setVisibleById("panelDadoSolicitacao", false);
		form.setVisibleById("panelCotacoes", true);
		form.setVisibleById("panelOrcamento", true);
		form.setVisibleById("tituloCotacao", true);
	}	

	if (state=="132") {
		form.setVisibleById("grupoBotaoProdutos", false); 		
	 	form.setVisibleById("panelDadoSolicitante", true);
    	form.setVisibleById("panelDadoSolicitacao", true);
		form.setVisibleById("produtosView", true);
		form.setVisibleById("tituloSolicitacao", true);
		form.setVisibleById("panelCancelamento", true);
	}
	
	if (state=="342") {
		form.setVisibleById("grupoBotaoProdutos", false); 		
		form.setVisibleById("modalAdicionarProduto", false); 		
	 	form.setVisibleById("panelDadoSolicitante", false);
    	form.setVisibleById("panelDadoSolicitacao", true);
		form.setVisibleById("produtosNovosView", true);
		form.setVisibleById("tituloCadastroProtheus", true);

	 }

	 if (state=="344") {
		form.setVisibleById("grupoBotaoProdutos", true); 		
	 	form.setVisibleById("panelDadoSolicitante", true);
    	form.setVisibleById("panelDadoSolicitacao", true);
		form.setVisibleById("tituloSolicitacao", true);
	 }

	if (state=="433") {
		form.setVisibleById("grupoBotaoProdutos", false); 		
	 	form.setVisibleById("panelDadoSolicitante", true);
    	form.setVisibleById("panelDadoSolicitacao", true);
		form.setVisibleById("produtosView", true);
		form.setVisibleById("tituloContratacaoServiço", true);
		form.setVisibleById("panelProcessoContratacao", true);		
	}

	if (state=="471") {
		form.setVisibleById("panelDadoSolicitante", true);
    	form.setVisibleById("panelDadoSolicitacao", true);
		form.setVisibleById("tituloValidarContrato", true);
    	form.setVisibleById("produtosView", true);
    	form.setVisibleById("grupoBotaoProdutos", false);
	}
	
	if (state=="475") {
		form.setVisibleById("grupoBotaoProdutos", false); 		
	 	form.setVisibleById("panelDadoSolicitante", true);
    	form.setVisibleById("panelDadoSolicitacao", true);
		form.setVisibleById("produtosView", true);
		form.setVisibleById("tituloSolicitacaoFinalizada", true);
	}
	
	if (state=="492") {
		form.setVisibleById("panelDadoSolicitante", true);
    	form.setVisibleById("panelDadoSolicitacao", true);
    	form.setVisibleById("produtosView", true);
    	form.setVisibleById("grupoBotaoProdutos", false);
		form.setVisibleById("tituloAssinaturaContrato", true);
	}

	if (state=="497") {
		form.setVisibleById("panelDadoSolicitante", true);
    	form.setVisibleById("panelDadoSolicitacao", false);
		form.setVisibleById("panelCotacoes", true);
		form.setVisibleById("panelOrcamento", true);
		form.setVisibleById("tituloCotacao", true);
		form.setVisibleById("panelCancelamento", true);
	}

	if (state=="500") {
		form.setVisibleById("grupoBotaoProdutos", false); 		
	 	form.setVisibleById("panelDadoSolicitante", true);
    	form.setVisibleById("panelDadoSolicitacao", true);
		form.setVisibleById("produtosView", true);
		form.setVisibleById("tituloSolicitacao", true);
	}

	if (state=="511") {
		form.setVisibleById("grupoBotaoProdutos", false); 		
	 	form.setVisibleById("panelDadoSolicitante", true);
    	form.setVisibleById("panelDadoSolicitacao", true);
		form.setVisibleById("panelValidarServico", true);
		form.setVisibleById("produtosView", true);
		form.setVisibleById("tituloValidarServico", true);
	}

	if (state=="514") {
		form.setVisibleById("grupoBotaoProdutos", false); 		
	 	form.setVisibleById("panelDadoSolicitante", true);
    	form.setVisibleById("panelDadoSolicitacao", true);
		form.setVisibleById("panelValidarServico", true);
		form.setVisibleById("produtosView", true);
		form.setVisibleById("tituloValidarServico", true);
	}
	if (state=="539") {
		form.setVisibleById("grupoBotaoProdutos", false); 		
	 	form.setVisibleById("panelDadoSolicitante", true);
    	form.setVisibleById("panelDadoSolicitacao", true);
		form.setVisibleById("produtosView", true);
		form.setVisibleById("tituloContratacaoServiço", true);
		form.setVisibleById("panelProcessoContratacao", true);		
	}
	if (state=="541") {
		form.setVisibleById("grupoBotaoProdutos", false); 		
	 	form.setVisibleById("panelDadoSolicitante", true);
    	form.setVisibleById("panelDadoSolicitacao", true);
		form.setVisibleById("produtosView", true);
		form.setVisibleById("tituloContratacaoServiço", true);
		form.setVisibleById("panelProcessoContratacao", true);		
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

