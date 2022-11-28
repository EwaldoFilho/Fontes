
function displayFields(form,customHTML){
	
	 var activity = getValue('WKNumState');
	    if (activity == 1 || activity == 0) {
	        var today = new Date();
	        var year = today.getFullYear();
	        var month = today.getMonth() + 1 < 10 ? '0' + (today.getMonth() + 1) : (today.getMonth() + 1);
	        var day = today.getDate() < 10 ? '0' + today.getDate() : today.getDate();
	        form.setValue('datasolicitacao', year + '-' + month + '-' + day);
	    }
	
	
	
	var mode     = form.getFormMode();
	var state    = getValue("WKNumState");
	var complete = getValue("WKCompletTask");
	var user     = getValue("WKUser");
	var locale   = getValue("WKUserLocale");
	var mobile   = form.getMobile();
	var processo = getValue("WKNumProces");
	
	if (state=="0") {
	    form.setVisibleById("informacoes_complementares", false);
	    form.setVisibleById("recrutamento_selecao", false);
	    form.setVisibleById("informacao_colaborador",false);

	}

	if (state=="4") {
	    form.setVisibleById("informacoes_complementares", true);
	    form.setVisibleById("recrutamento_selecao", false);	
	    form.setVisibleById("informacao_colaborador",false);

	}
	if (state=="5") {
	    form.setVisibleById("informacoes_complementares", false);
	    form.setVisibleById("recrutamento_selecao", false);
	    form.setVisibleById("informacao_colaborador",false);

	}
	if (state=="7") {
	    form.setVisibleById("informacoes_complementares", false);
	    form.setVisibleById("recrutamento_selecao", false);	
	    form.setVisibleById("informacao_colaborador",false);

	}
	if (state=="9") {
	    form.setVisibleById("informacoes_complementares", false);
	    form.setVisibleById("recrutamento_selecao", false);
	    form.setVisibleById("informacao_colaborador",false);

	}
	if (state=="12") {
	    form.setVisibleById("informacoes_complementares", false);
	    form.setVisibleById("recrutamento_selecao", true);
	    form.setVisibleById("informacao_colaborador",true);

	}
	if (state=="64") {
	    form.setVisibleById("informacoes_complementares", false);
	    form.setVisibleById("recrutamento_selecao", false);	
	    form.setVisibleById("informacao_colaborador",false);
	    

	}
	if (state=="80") {
	    form.setVisibleById("informacoes_complementares", false);
	    form.setVisibleById("recrutamento_selecao", false);
	    form.setVisibleById("informacao_colaborador",false);

	}
	if (state=="82") {
	    form.setVisibleById("informacoes_complementares", false);
	    form.setVisibleById("recrutamento_selecao", false);	
	    form.setVisibleById("informacao_colaborador",false);

	}
	if (state=="84") {
	    form.setVisibleById("informacoes_complementares", false);
	    form.setVisibleById("recrutamento_selecao", false);	
	    form.setVisibleById("informacao_colaborador",false);

	}
	if (state=="133") {
	    form.setVisibleById("informacoes_complementares", false);
	    form.setVisibleById("recrutamento_selecao", false);	
	    form.setVisibleById("informacao_colaborador",false);

	}
	if (state=="104") {
	    form.setVisibleById("informacoes_complementares", false);
	    form.setVisibleById("recrutamento_selecao", true);
	    form.setVisibleById("informacao_colaborador",true);

	}
	if (state=="106") {
	    form.setVisibleById("informacoes_complementares", false);
	    form.setVisibleById("recrutamento_selecao", false);
	    form.setVisibleById("informacao_colaborador",false);

	}
	if (state=="108") {
	    form.setVisibleById("informacoes_complementares", false);
	    form.setVisibleById("recrutamento_selecao", false);	
	    form.setVisibleById("informacao_colaborador",false);

	}
	
	
	if (state=="28") {
	    form.setVisibleById("informacoes_complementares", false);
	    form.setVisibleById("recrutamento_selecao", false);
	    form.setVisibleById("informacao_colaborador",true);

	}
	if (state=="116") {
	    form.setVisibleById("informacoes_complementares", false);
	    form.setVisibleById("recrutamento_selecao", true);
	    form.setVisibleById("informacao_colaborador",true);

	}
	if (state=="93") {
	    form.setVisibleById("informacoes_complementares", false);
	    form.setVisibleById("recrutamento_selecao", true);
	    form.setVisibleById("informacao_colaborador",true);

	}
	if (state=="91") {
	    form.setVisibleById("informacoes_complementares", true);
	    form.setVisibleById("recrutamento_selecao", true);	
	    form.setVisibleById("informacao_colaborador",true);

	}
	if (state=="139") {
	    form.setVisibleById("informacoes_complementares", false);
	    form.setVisibleById("recrutamento_selecao", true);
	    form.setVisibleById("informacao_colaborador",false);

	}
	if (state=="21") {
	    form.setVisibleById("informacoes_complementares", false);
	    form.setVisibleById("recrutamento_selecao", true);
	    form.setVisibleById("informacao_colaborador",true);

	}
	if (state=="187") {
	    form.setVisibleById("informacoes_complementares", true);
	    form.setVisibleById("recrutamento_selecao", false);
	    form.setVisibleById("informacao_colaborador",true);

	}
	if (state=="162") {
		form.setVisibleById("dados_Inicial",false)
	    form.setVisibleById("informacoes_complementares", true);
	    form.setVisibleById("recrutamento_selecao", false);
	    form.setVisibleById("informacao_colaborador",true);

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


    var activity = getValue('WKNumState');
    if (activity == 1 || activity == 0) {
        var today = new Date();
        var year = today.getFullYear();
        var month = today.getMonth() + 1 < 10 ? '0' + (today.getMonth() + 1) : (today.getMonth() + 1);
        var day = today.getDate() < 10 ? '0' + today.getDate() : today.getDate();
        form.setValue('datasolicitacao', year + '-' + month + '-' + day);
    }
