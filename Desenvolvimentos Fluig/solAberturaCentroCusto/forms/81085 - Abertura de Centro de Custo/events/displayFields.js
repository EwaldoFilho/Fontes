function displayFields(form, customHTML) {
	var mode = form.getFormMode();
	var state = getValue("WKNumState");
	var complete = getValue("WKCompletTask");
	var user = getValue("WKUser");
	var locale = getValue("WKUserLocale");
	var mobile = form.getMobile();
	var processo = getValue("WKNumProces");

	form.setVisibleById("panelDadosMEI", false);
	form.setVisibleById("panelDadosPJ", false);
	form.setValue('ativAtual', processo);
	form.setValue('solicitacao', state);
	form.setShowDisabledFields(true);
	form.setHidePrintLink(true);

	if (state == 0 || state == 1 || state == 5 || state == 22 || state == 26) {

		var tipoRegime = form.getValue("tipoRegime");

		if (tipoRegime == "SimplesMei") {
			form.setVisibleById("panelDadosMEI", true);
		} else if (tipoRegime == "Outros") {
			form.setVisibleById("panelDadosPJ", true);
		}
	} if (form.getFormMode() == "VIEW"){
		 form.setShowDisabledFields(true);
	}

	var ATIVIDADE = Number(getValue("WKNumState")) ? Number(getValue("WKNumState"))
			: INICIO;
	var MODE = form.getFormMode()
	var usuarioCorrente = fluigAPI.getUserService().getCurrent();
	var customJS = "<script>";
	var today = new Date();
	var year = today.getFullYear();
	var month = today.getMonth() + 1 < 10 ? '0' + (today.getMonth() + 1)
			: (today.getMonth() + 1);
	var day = today.getDate() < 10 ? '0' + today.getDate() : today.getDate();

	if (MODE == "ADD") {
		form.setValue("solicitanteCode", usuarioCorrente.getCode());
		form.setValue("solicitanteNome", usuarioCorrente.getFullName());
		form.setValue("solicitanteEmail", usuarioCorrente.getEmail());
		form.setValue("fdNfMEI", "Nota Fiscal");
		form.setValue('dataAbertura', day + '/' + month + '/' + year);
		/**
		 * Os campos que armazenam as descrições dos anexos, deverão ter seus
		 * valores setados no modo ADD caso estejam bloqueados pelo enableFields
		 * em ADD. Caso contrário, terão seus valores zerados e as funções para
		 * anexos não funcionarão como esperado. Isso não se aplica as tabelas
		 * pai e filho, pois a descrição do anexo é gravada no campo mo momento
		 * em que é adicionada uam nova linha
		 */

	}

	/**
	 * No modo de visualização, irá remove o botão que adiciona uma nova linha
	 * na tabela pai e filho e a td que fica a lixeira de cada linha
	 */
	if (MODE == "VIEW") {
		customJS += "$('.btnAddNewRow').remove();";
		customJS += "$('.tdDeleteRow').remove();";
	}

	/**
	 * Remove o botão de upload/delete da tabela pai e filho com o uso da função
	 * invisibleBtnUpload Remove também o botão da lixeira e o botão de
	 * adicionar uma nova linha
	 */
	if (ATIVIDADE != INICIO) {
		var totalDependentes = form.getChildrenIndexes("dependentes");
		for (var i = 0; i < totalDependentes.length; i++) {
			var inputId = "fnRegistroNascDep___" + totalDependentes[i]
			customJS += "invisibleBtnUpload('" + inputId + "');";
		}
		customJS += "$('.btnAddNewRow').remove();";
		customJS += "$('.tdDeleteRow').remove();";
	}

	if ((ATIVIDADE == APROVACAO) && (MODE == "MOD")) {
		form.setValue("aprovadorCode", usuarioCorrente.getCode());
		form.setValue("aprovadorNome", usuarioCorrente.getFullName());
		form.setValue("aprovadorEmail", usuarioCorrente.getEmail());
	}

	customJS += "function getAtividade(){ return '" + ATIVIDADE + "'};";
	customJS += "function getMode(){ return '" + MODE + "'};";
	customJS += "displayBtnFiles();";
	customJS += "tableLineCount();";
	customJS += "</script>"
	customHTML.append(customJS)

}