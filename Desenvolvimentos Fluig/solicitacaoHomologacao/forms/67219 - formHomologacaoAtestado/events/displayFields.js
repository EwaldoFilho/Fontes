function displayFields(form, customHTML) {
	form.setShowDisabledFields(true);
	form.setHidePrintLink(true);
	form.setValue("matriculaUsuario", fluigAPI.getUserService().getCurrent().code);
		var dataset = DatasetFactory.getDataset("tetesprotheus", null, null, null);
		
		
		
		var activity = getValue('WKNumState');
		form.setValue("processo", activity);
		
		if (activity == 1 || activity == 0) {
	        var today = new Date();
	        var year = today.getFullYear();
	        var month = today.getMonth() + 1 < 10 ? '0' + (today.getMonth() + 1) : (today.getMonth() + 1);
	        var day = today.getDate() < 10 ? '0' + today.getDate() : today.getDate();
	        form.setValue('datasolicitacao', day + '/' + month + '/' + year);
	    }
		
		if (activity == 0 || activity == 4){
			form.setVisibleById("panelDadoSolicitante",true);
			form.setVisibleById("panelDadoSolicitacao",true);
			form.setVisibleById("panelAgendamento",false);			
		}
		if (activity == 5){
			form.setVisibleById("panelDadoSolicitante",true);
			form.setVisibleById("panelDadoSolicitacao",true);
			form.setVisibleById("panelAgendamento",true);			
		}
		if (activity == 8){
			form.setVisibleById("panelDadoSolicitante",true);
			form.setVisibleById("panelDadoSolicitacao",true);
			form.setVisibleById("panelAgendamento",true);			
		}
		if (activity == 10){
			form.setVisibleById("panelDadoSolicitante",true);
			form.setVisibleById("panelDadoSolicitacao",true);
			form.setVisibleById("panelAgendamento",true);			
		}
		if (activity == 12){
			form.setVisibleById("panelDadoSolicitante",true);
			form.setVisibleById("panelDadoSolicitacao",true);
			form.setVisibleById("panelAgendamento",true);			
		}
		
		if (activity == 14){
			form.setVisibleById("panelDadoSolicitante",true);
			form.setVisibleById("panelDadoSolicitacao",true);
			form.setVisibleById("panelAgendamento",false);			
		}
		if (activity == 17){
			form.setVisibleById("panelDadoSolicitante",true);
			form.setVisibleById("panelDadoSolicitacao",true);
			form.setVisibleById("panelAgendamento",true);			
		}
		if (activity == 20){
			form.setVisibleById("panelDadoSolicitante",true);
			form.setVisibleById("panelDadoSolicitacao",true);
			form.setVisibleById("panelAgendamento",false);			
		}
		if (activity >= 0) { 
		
			
		var today = new Date();     
		var year = today.getFullYear();     
		var month = today.getMonth() + 1 < 10 ? '0' + (today.getMonth() + 1) : (today.getMonth() + 1);     
		var day = today.getDate() < 10 ? '0' + today.getDate() : today.getDate();     form.setValue('dataAbertura', year + '-' + month  + '-' + day);
		}
		var MODE = form.getFormMode()
		var usuarioCorrente = fluigAPI.getUserService().getCurrent();
		
		if(MODE == "ADD"){
			form.setValue("solicitanteCode", usuarioCorrente.getCode());
			form.setValue("solicitanteNome", usuarioCorrente.getFullName());
			form.setValue("solicitanteEmail", usuarioCorrente.getEmail());
					
			/**
			 * Os campos que armazenam as descrições dos anexos, deverão ter seus valores setados no modo ADD caso estejam bloqueados pelo enableFields em ADD.
			 * Caso contrário, terão seus valores zerados e as funções para anexos não funcionarão como esperado.
		     * Isso não se aplica as tabelas pai e filho, pois a descrição do anexo é gravada no campo mo momento em que é adicionada uam nova linha
			 */  
		
		
		}
		
		
	
}



function onMobileSync(user) {

}

