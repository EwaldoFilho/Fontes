function enableFields(form) {
	var state    = getValue("WKNumState");
	
	form.setEnabled('dataAbertura', false);
	form.setEnabled('nomeSolicitante', false);
	form.setEnabled('justificativaCEO', false);
	
	if(state == 2 || state == 6 || state == 8 || state == 10 || state == 52 || state == 34 ){
		var formaPagamento = form.getValue("formaPagamento");
		
	    if(formaPagamento == "deposito"){
	    	form.setEnabled("agencia", false);
	    	form.setEnabled("agenciaDV", false);	 
	    	form.setEnabled("conta", false);
	    	form.setEnabled("contaDV", false);	 	    	
	    }
	    
	    if(formaPagamento == "pix"){
	    	form.setVisibleById("formaPagamentoPix", true);
	    	
	    	var chavePix = form.getValue("chavePix");
	    	
	    	if(chavePix == "cpf"){
		    	form.setEnabled("cpf", false);
	    	}else if(chavePix == "cnpj"){
		    	form.setEnabled("cnpj", false);
	    	}else if(chavePix == "email"){
		    	form.setEnabled("email", false);
	    	}else if(chavePix == "telefone"){
		    	form.setEnabled("telefone", false);
	    	}else if(chavePix == "chaveAleatoria"){
		    	form.setEnabled("chaveAleatoria", false);
	    	}	 	    	
	    }
	}

	if(state!= 0 && state!= 1 && state != 12 && state != 39){
		form.setEnabled('valorRecarga', false);
		form.setEnabled('justificativaRecarga', false);
		form.setEnabled('cpf', false);
		form.setEnabled('cnpj', false);
		form.setEnabled('email', false);
		form.setEnabled('telefone', false);
		form.setEnabled('agencia', false);
		form.setEnabled('agenciaDV', false);
		form.setEnabled('conta', false);
		form.setEnabled('contaDV', false);
		
		//inputs que substituem o select
		form.setEnabled("centroCustoInput", false);
		form.setEnabled("formaPagamentoInput", false);
		form.setEnabled("isAprovadoInput", false);
	}
	
	if(state == 4){
		form.setEnabled('justificativaCEO', true);		
		form.setEnabled('isAprovado', true);
	}
}