function displayFields(form, customHTML) {
	var mode     = form.getFormMode();
	var state    = getValue("WKNumState");
	var usuario = getValue("WKUser");
	
	log.info("usuario>>>"+usuario);
	form.setValue("estado", state);
	
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
	form.setVisibleById("justCEO", false);
	
	//oculta panels do formulário
	form.setVisibleById("panelAprovacaoCEO", false);
	
	if (state == 1 || state == 0) {
		var usuarioDataSet = DatasetFactory.getDataset("armazem_buscar_empresas", null, null, null);
		form.setValue("nomeSolicitante", usuarioDataSet.getValue(0, "NOME"));
		form.setValue("matriculaUsuario", fluigAPI.getUserService().getCurrent().code);
		
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
		
		var isAprovado = form.getValue("isAprovado");
	    if(isAprovado == "false"){
	    	form.setVisibleById("justCEO", false);
	    	form.setVisibleById("panelAprovacaoCEO", false);
	    }

    }
	
	if(state == 1 || state == 2 || state == 6 || state == 8 || state == 10 || state == 12 || state == 52 || state == 34 || state == 39 ){
		var isAprovado = form.getValue("isAprovado");
		var formaPagamento = form.getValue("formaPagamento");
		
	    if(isAprovado == "false"){
	    	form.setVisibleById("justCEO", false);
	    	form.setVisibleById("panelAprovacaoCEO", false);
	    }
		
	    if(formaPagamento == "deposito"){
	    	form.setVisibleById("formaDadosBanco", true);
	    	form.setVisibleById("formaPagamentoBanco", true);
	    	form.setVisibleById("banco", true);
	    	form.setVisibleById("tipoConta", true);
	    	form.setVisibleById("agencia", true);
	    	form.setVisibleById("agenciaDV", true);	 
	    	form.setVisibleById("conta", true);
	    	form.setVisibleById("contaDV", true);	 	    	
	    }
	    
	    if(formaPagamento == "pix"){
	    	form.setVisibleById("formaPagamentoPix", true);
	    	
	    	var chavePix = form.getValue("chavePix");
	    	
	    	if(chavePix == "cpf"){
		    	form.setVisibleById("pixCpf", true);
	    	}else if(chavePix == "cnpj"){
		    	form.setVisibleById("pixCnpj", true);
	    	}else if(chavePix == "email"){
		    	form.setVisibleById("pixEmail", true);
	    	}else if(chavePix == "telefone"){
		    	form.setVisibleById("pixTelefone", true);
	    	}else if(chavePix == "chaveAleatoria"){
		    	form.setVisibleById("pixChaveAleatoria", true);
	    	}	 	    	
	    }
	}
	
	if(state == 4){
		var isAprovado = form.getValue("isAprovado");
		form.setVisibleById("isAprovado", true);
		form.setValue("countAprovacao", "1");
		
	    if(isAprovado == "false"){
	    	form.setVisibleById("justCEO", false);
	    }
		
		form.setVisibleById("panelAprovacaoCEO", false);
		form.setVisibleById("panelDadosBancarios", false);
	}
	
	if(state == 10 || state == 34 || state == 52){
		form.setVisibleById("panelAprovacaoCEO", false);
	}
	
	if (form.getFormMode() == "VIEW"){
		 form.setShowDisabledFields(true);
	}
	
}