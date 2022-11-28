function displayFields(form,customHTML){ 
	var mode     = form.getFormMode();
	var state    = getValue("WKNumState");
	var usuario = getValue("WKUser");

	form.setValue("estado", state);
	
	if (state == 0) {
		var usuarioDataSet = DatasetFactory.getDataset("armazem_buscar_empresas", null, null, null);
		form.setValue("nomeSolicitante", usuarioDataSet.getValue(0, "NOME"));
		
		var dia = new Date().getDate();
		var mes = new Date().getMonth()+1;
		
		if(dia<10){
			dia = "0"+dia;
		}
		
		if(mes<10){
			mes = "0"+mes;
		}
		
		var dataAtual =  dia+"/" +mes+"/" +new Date().getFullYear();
		form.setValue("dataAbertura", dataAtual);

    }
	
	if (state == 5 || state == 8 || state == 10) {
		form.setVisibleById("infoCadastroInsumo", false);
		form.setVisibleById("adicionarProduto", false);
	}
	
	
	if (form.getFormMode() == "VIEW"){
		 form.setShowDisabledFields(true);
	}
}