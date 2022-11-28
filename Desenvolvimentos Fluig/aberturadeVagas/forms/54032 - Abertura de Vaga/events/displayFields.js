function displayFields(form,customHTML){
	
	form.setShowDisabledFields(true);
	form.setHidePrintLink(true);
	form.setValue("matriculaUsuario", fluigAPI.getUserService().getCurrent().code);

	var ATIVIDADE = Number(getValue("WKNumState")) ? Number(getValue("WKNumState")) : INICIO;
	var MODE = form.getFormMode()
	var usuarioCorrente = fluigAPI.getUserService().getCurrent();
	var customJS = "<script>";
	 var activity = getValue('WKNumState');
	    if (activity == 1 || activity == 0) {
	        var today = new Date();
	        var year = today.getFullYear();
	        var month = today.getMonth() + 1 < 10 ? '0' + (today.getMonth() + 1) : (today.getMonth() + 1);
	        var day = today.getDate() < 10 ? '0' + today.getDate() : today.getDate();
	        form.setValue('datasolicitacao', day + '/' + month + '/' + year);
	    }
	
	
	if(MODE == "ADD"){
		form.setValue("solicitanteCode", usuarioCorrente.getCode());
		form.setValue("solicitanteNome", usuarioCorrente.getFullName());
		form.setValue("solicitanteEmail", usuarioCorrente.getEmail());
		
		/**
		 * Os campos que armazenam as descrições dos anexos, deverão ter seus valores setados no modo ADD caso estejam bloqueados pelo enableFields em ADD.
		 * Caso contrário, terão seus valores zerados e as funções para anexos não funcionarão como esperado.
	     * Isso não se aplica as tabelas pai e filho, pois a descrição do anexo é gravada no campo mo momento em que é adicionada uam nova linha
		 */  
	
		form.setValue("fdRegistroNascimento", "Registro Nascimento");
		form.setValue("fdCpf", "CPF");
		form.setValue("fdFoto", "Foto");
		form.setValue("fdComprovante", "Comprovante");
	}
	
	
	 /**
	  * No modo de visualização, irá remove o botão que adiciona uma nova linha na tabela pai e filho e a td que fica a lixeira de cada linha
	  */ 
//	if(MODE == "VIEW"){
//		customJS += "$('.btnAddNewRow').remove();";
//		customJS += "$('.tdDeleteRow').remove();";
//	}
//	
	
	/**
	 * Remove o botão de upload/delete da tabela pai e filho com o uso da função invisibleBtnUpload
	 * Remove também o botão da lixeira e o botão de adicionar uma nova linha
	 */
//	if(ATIVIDADE != INICIO){
//		var totalDependentes = form.getChildrenIndexes("dependentes");
//		for (var i = 0; i < totalDependentes.length; i++) {
//			var inputId = "fnRegistroNascDep___" + totalDependentes[i]
//			customJS += "invisibleBtnUpload('" + inputId +"');";
//		}
//		customJS += "$('.btnAddNewRow').remove();";
//		customJS += "$('.tdDeleteRow').remove();";
//	}
//	
	if((ATIVIDADE == APROVACAO) && (MODE == "MOD")){
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
	
	
	//panels
	form.setVisibleById("panelDadosSolicitacao",true);
	form.setVisibleById("panelDadosCandidato",false);
	form.setVisibleById("panelDadosContratado",false);
	
	
	//botoes
	form.setVisibleById("btnAddNewRowDependente",false);
	
	if (ATIVIDADE==5) {
		form.setVisibleById("panelDadosSolicitacao",true);
		form.setVisibleById("panelDadosCandidato",false);
		form.setVisibleById("btnAddNewRowDependente",false);
		form.setVisibleById("panelDadosContratado",false);  
		form.setVisibleById("substituicaoNome",true);
		form.setVisibleById("indicacaoContato",true);
		form.setVisibleById("indicacaoNome",true);
		form.setVisibleById("tipoFolguista",true);
	}
	
	if (ATIVIDADE==7) {
		form.setVisibleById("panelDadosSolicitacao",true);
		form.setVisibleById("panelDadosCandidato",false);
		form.setVisibleById("btnAddNewRowDependente",false);
		form.setVisibleById("panelDadosContratado",false);
		form.setVisibleById("substituicaoNome",true);
		form.setVisibleById("indicacaoContato",true);
		form.setVisibleById("indicacaoNome",true);
		form.setVisibleById("tipoFolguista",true);
	}
	
	if (ATIVIDADE==236) {
		form.setVisibleById("panelDadosSolicitacao",true);
		form.setVisibleById("panelDadosCandidato",true);
		form.setVisibleById("btnAddNewRowDependente",true);
		form.setVisibleById("panelDadosContratado",false);
		form.setVisibleById("substituicaoNome",true);
		form.setVisibleById("indicacaoContato",true);
		form.setVisibleById("indicacaoNome",true);
		form.setVisibleById("tipoFolguista",true);
	}
	
	if (ATIVIDADE==239) {
		form.setVisibleById("panelDadosSolicitacao",true);
		form.setVisibleById("panelDadosCandidato",false);
		form.setVisibleById("btnAddNewRowDependente",false);
		form.setVisibleById("panelDadosContratado",false);
		form.setVisibleById("substituicaoNome",true);
		form.setVisibleById("indicacaoContato",true);
		form.setVisibleById("indicacaoNome",true);
		form.setVisibleById("tipoFolguista",true);
	}
	if (ATIVIDADE==12) {
		form.setVisibleById("panelDadosSolicitacao",true);
		form.setVisibleById("panelDadosCandidato",true);
		form.setVisibleById("btnAddNewRowDependente",true);
		form.setVisibleById("panelDadosContratado",true);
		form.setVisibleById("substituicaoNome",true);
		form.setVisibleById("indicacaoContato",true);
		form.setVisibleById("indicacaoNome",true);
		form.setVisibleById("tipoFolguista",true);
	}
	if (ATIVIDADE==104) {
		form.setVisibleById("panelDadosSolicitacao",true);
		form.setVisibleById("panelDadosCandidato",false);
		form.setVisibleById("btnAddNewRowDependente",false);
		form.setVisibleById("panelDadosContratado",false);
		form.setVisibleById("substituicaoNome",true);
		form.setVisibleById("indicacaoContato",true);
		form.setVisibleById("indicacaoNome",true);
		form.setVisibleById("tipoFolguista",true);
	}
	if (ATIVIDADE==106) {
		form.setVisibleById("panelDadosSolicitacao",true);
		form.setVisibleById("panelDadosCandidato",true);
		form.setVisibleById("btnAddNewRowDependente",true);
		form.setVisibleById("panelDadosContratado",true);
		form.setVisibleById("substituicaoNome",true);
		form.setVisibleById("indicacaoContato",true);
		form.setVisibleById("indicacaoNome",true);
		form.setVisibleById("tipoFolguista",true);
	}
	if (ATIVIDADE==28) {
		form.setVisibleById("panelDadosSolicitacao",true);
		form.setVisibleById("panelDadosCandidato",true);
		form.setVisibleById("btnAddNewRowDependente",true);
		form.setVisibleById("panelDadosContratado",true);
		form.setVisibleById("substituicaoNome",true);
		form.setVisibleById("indicacaoContato",true);
		form.setVisibleById("indicacaoNome",true);
		form.setVisibleById("tipoFolguista",true);
	}
	if (ATIVIDADE==266) {
		form.setVisibleById("panelDadosSolicitacao",true);
		form.setVisibleById("panelDadosCandidato",true);
		form.setVisibleById("btnAddNewRowDependente",false);
		form.setVisibleById("panelDadosContratado",true);
		form.setVisibleById("substituicaoNome",true);
		form.setVisibleById("indicacaoContato",true);
		form.setVisibleById("indicacaoNome",true);
		form.setVisibleById("tipoFolguista",true);
	}
	if (ATIVIDADE==226) {
		form.setVisibleById("panelDadosSolicitacao",true);
		form.setVisibleById("panelDadosCandidato",true);
		form.setVisibleById("btnAddNewRowDependente",true);
		form.setVisibleById("panelDadosContratado",true);
		form.setVisibleById("substituicaoNome",true);
		form.setVisibleById("indicacaoContato",true);
		form.setVisibleById("indicacaoNome",true);
		form.setVisibleById("tipoFolguista",true);
	}
	if (ATIVIDADE==283) {
		form.setVisibleById("panelDadosSolicitacao",true);
		form.setVisibleById("panelDadosCandidato",true);
		form.setVisibleById("btnAddNewRowDependente",true);
		form.setVisibleById("panelDadosContratado",true);
		form.setVisibleById("substituicaoNome",true);
		form.setVisibleById("indicacaoContato",true);
		form.setVisibleById("indicacaoNome",true);
		form.setVisibleById("tipoFolguista",true);
	}
	if (ATIVIDADE==285) {
		form.setVisibleById("panelDadosSolicitacao",true);
		form.setVisibleById("panelDadosCandidato",true);
		form.setVisibleById("btnAddNewRowDependente",true);
		form.setVisibleById("panelDadosContratado",true);
		form.setVisibleById("substituicaoNome",true);
		form.setVisibleById("indicacaoContato",true);
		form.setVisibleById("indicacaoNome",true);
		form.setVisibleById("tipoFolguista",true);
	}



 }