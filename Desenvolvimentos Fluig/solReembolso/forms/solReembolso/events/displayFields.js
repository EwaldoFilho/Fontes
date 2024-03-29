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
	var usuarioCorrente = fluigAPI.getUserService().getCurrent();
	
	log.info("Estado"+state);
	form.setValue("estado", state);
	
	if (state=="0" || state == "4" || state == null) {
	//Oculta elementos do formulário
	form.setVisibleById("formaPagamentoPix", false);
	form.setVisibleById("formaDadosBanco", false);
	form.setVisibleById("formaPagamentoBanco", false);
	form.setVisibleById("formaPagamentoPix", false);
	
	//oculta inputs do formulário
	form.setVisibleById("pixCpf", false);
	form.setVisibleById("pixCnpj", false);
	form.setVisibleById("pixEmail", false);
	form.setVisibleById("pixTelefone", false);
	form.setVisibleById("pixChaveAleatoria", false);
	}
	
	if (state!="0" || state != "4" || state != null) {
		if (form.getValue("formaPagamento")== "deposito"){
			//Oculta elementos do formulário
			form.setVisibleById("formaPagamentoPix", false);
			form.setVisibleById("formaDadosBanco", true);
			form.setVisibleById("formaPagamentoBanco", true);
			form.setVisibleById("formaPagamentoPix", false);
			
			//oculta inputs do formulário
			form.setVisibleById("pixCpf", false);
			form.setVisibleById("pixCnpj", false);
			form.setVisibleById("pixEmail", false);
			form.setVisibleById("pixTelefone", false);
			form.setVisibleById("pixChaveAleatoria", false);
			}
		
		if (form.getValue("formaPagamento")== "pix"){
				//Oculta elementos do formulário
				form.setVisibleById("formaPagamentoPix", true);
				form.setVisibleById("formaDadosBanco", false);
				form.setVisibleById("formaPagamentoBanco", false);
				form.setVisibleById("formaPagamentoPix", true);
				
				if (form.getValue("chavePix")== "cpf"){
					//oculta inputs do formulário
					form.setVisibleById("pixCpf", true);
					form.setVisibleById("pixCnpj", false);
					form.setVisibleById("pixEmail", false);
					form.setVisibleById("pixTelefone", false);
					form.setVisibleById("pixChaveAleatoria", false);
				}
				if (form.getValue("chavePix")== "cnpj"){
					//oculta inputs do formulário
					form.setVisibleById("pixCpf", false);
					form.setVisibleById("pixCnpj", true);
					form.setVisibleById("pixEmail", false);
					form.setVisibleById("pixTelefone", false);
					form.setVisibleById("pixChaveAleatoria", false);
				}
				if (form.getValue("chavePix")== "email"){
					//oculta inputs do formulário
					form.setVisibleById("pixCpf", false);
					form.setVisibleById("pixCnpj", false);
					form.setVisibleById("pixEmail", true);
					form.setVisibleById("pixTelefone", false);
					form.setVisibleById("pixChaveAleatoria", false);
				}
				if (form.getValue("chavePix")== "telefone"){
					//oculta inputs do formulário
					form.setVisibleById("pixCpf", false);
					form.setVisibleById("pixCnpj", false);
					form.setVisibleById("pixEmail", false);
					form.setVisibleById("pixTelefone", true);
					form.setVisibleById("pixChaveAleatoria", false);
				}
				if (form.getValue("chavePix")== "chaveAleatoria"){
					//oculta inputs do formulário
					form.setVisibleById("pixCpf", false);
					form.setVisibleById("pixCnpj", false);
					form.setVisibleById("pixEmail", false);
					form.setVisibleById("pixTelefone", false);
					form.setVisibleById("pixChaveAleatoria", true);
				}
			}
	}
	
	
	//panels
	form.setVisibleById("panelDadoSolicitante", true);
	form.setVisibleById("panelDadoReembolso", true);
	form.setVisibleById("panelFormaPagamento", true);

	//botoes
	form.setVisibleById("grupoBotaoProdutos", false);

	

	if (state=="0") {
		form.setVisibleById("panelDadoSolicitante", true);
		form.setVisibleById("panelDadoReembolso", true);
		form.setVisibleById("panelFormaPagamento", true);
		form.setValue("solicitanteNome", usuarioCorrente.getFullName());
		form.setValue("matriculaUsuario", fluigAPI.getUserService().getCurrent().code);
	}
	
	if (state=="4") {
		form.setVisibleById("panelDadoSolicitacao", true);
		form.setVisibleById("grupoBotaoProdutos", true);
		form.setVisibleById("tituloSolicitacao", true);
		form.setValue("solicitanteNome", usuarioCorrente.getFullName());
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

