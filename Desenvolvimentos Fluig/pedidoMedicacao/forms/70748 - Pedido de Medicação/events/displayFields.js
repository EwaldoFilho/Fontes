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
	form.setValue("estado", state);
	form.setValue("processo", processo);

	//panels
	form.setVisibleById("panelDadoSolicitante", true);
	form.setVisibleById("panelCotacoes", false);
	form.setVisibleById("panelOrcamento", false);
	form.setVisibleById("panelDadoSolicitacao", false);	
	form.setVisibleById("panelCancelamento", false);

	//botoes
	form.setVisibleById("grupoBotaoProdutos", false);

	
	//titulos paginas
	form.setVisibleById("tituloSolicitacao", false);
	form.setVisibleById("tituloCadastroProtheus", false);
	form.setVisibleById("tituloApGerente", false);
	form.setVisibleById("tituloLancaNota", false);
	form.setVisibleById("tituloCotacao", false);
	form.setVisibleById("tituloRetirarMaterial", false);
	form.setVisibleById("tituloSolicitacaoFinalizada", false);

	if (state=="0") {
		form.setVisibleById("panelDadoSolicitacao", true);
		form.setVisibleById("grupoBotaoProdutos", true);
		form.setVisibleById("tituloSolicitacao", true);
		form.setVisibleById("tb_novosProdutos", false);		
		
		form.setValue("matriculaUsuario", fluigAPI.getUserService().getCurrent().code);
	}
	
	if (state=="4") {
		form.setVisibleById("panelDadoSolicitacao", true);
		form.setVisibleById("grupoBotaoProdutos", true);
		form.setVisibleById("tituloSolicitacao", true);
		form.setVisibleById("tb_novosProdutos", false);
		form.setValue("nameUser", usuarioDataSet.getValue(0, "NOME"));
	}
	
	if (state=="5") {
		form.setVisibleById("grupoBotaoProdutos", false); 		
	 	form.setVisibleById("panelDadoSolicitante", true);
    	form.setVisibleById("panelDadoSolicitacao", true);
		form.setVisibleById("tituloApGerente", true);
	 }
	
	if (state=="502") {
		form.setVisibleById("grupoBotaoProdutos", false); 		
	 	form.setVisibleById("panelDadoSolicitante", true);
    	form.setVisibleById("panelDadoSolicitacao", true);
		form.setVisibleById("tituloApGerente", true);
		form.setVisibleById("panelCancelamento", true);
	 }

	 if (state=="54") {
		form.setVisibleById("grupoBotaoProdutos", false); 		
	 	form.setVisibleById("panelDadoSolicitante", true);
    	form.setVisibleById("panelDadoSolicitacao", true);
		form.setVisibleById("tituloSolicitacao", true);
	 }
	 
	 if (state=="497") {
			form.setVisibleById("grupoBotaoProdutos", false); 		
		 	form.setVisibleById("panelDadoSolicitante", true);
	    	form.setVisibleById("panelDadoSolicitacao", true);
			form.setVisibleById("tituloSolicitacao", true);
     }	 

	 if (state=="73") {
		form.setVisibleById("grupoBotaoProdutos", false); 		
	 	form.setVisibleById("panelDadoSolicitante", true);
    	form.setVisibleById("panelDadoSolicitacao", true);
		form.setVisibleById("tituloSolicitacao", true);
	 }
	 if (state=="528") {
			form.setVisibleById("grupoBotaoProdutos", false); 		
		 	form.setVisibleById("panelDadoSolicitante", true);
	    	form.setVisibleById("panelDadoSolicitacao", true);
			form.setVisibleById("tituloSolicitacao", true);
		 }
	 
	 if (state=="90") {
			form.setVisibleById("grupoBotaoProdutos", false); 		
		 	form.setVisibleById("panelDadoSolicitante", true);
	    	form.setVisibleById("panelDadoSolicitacao", true);
			form.setVisibleById("tituloSolicitacao", true);
		 }

	 if (state=="113") {
		form.setVisibleById("grupoBotaoProdutos", false); 		
	 	form.setVisibleById("panelDadoSolicitante", true);
    	form.setVisibleById("panelDadoSolicitacao", true);
		form.setVisibleById("tituloSolicitacao", true);
	 }	 

	 if (state=="119") {
		form.setVisibleById("grupoBotaoProdutos", true); 		
	 	form.setVisibleById("panelDadoSolicitante", true);
    	form.setVisibleById("panelDadoSolicitacao", true);
		form.setVisibleById("tituloSolicitacao", true);
	 }		 

	if (state=="124") {
		form.setVisibleById("panelDadoSolicitante", true);
    	form.setVisibleById("panelDadoSolicitacao", true);
		form.setVisibleById("panelCotacoes", true);
		form.setVisibleById("panelOrcamento", true);
		form.setVisibleById("tituloCotacao", true);
		form.setVisibleById("panelCancelamento", true);
		form.setVisibleById("tb_produtos", true);
		form.setVisibleById("motivoCancelamento",true);
	}

	if (state=="537") {
		form.setVisibleById("panelDadoSolicitante", true);
    	form.setVisibleById("panelDadoSolicitacao", false);
		form.setVisibleById("panelCotacoes", true);
		form.setVisibleById("panelOrcamento", true);
		form.setVisibleById("tituloCotacao", true);
		form.setVisibleById("panelCancelamento", true);
	}
	if (state=="132") {
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
	}
	
	if (state=="171") {
		form.setVisibleById("grupoBotaoProdutos", false); 		
	 	form.setVisibleById("panelDadoSolicitante", true);
    	form.setVisibleById("panelDadoSolicitacao", true);
		form.setVisibleById("tituloSolicitacao", true);
	}

	if (state=="172") {
		form.setVisibleById("panelDadoSolicitacao", true);
		form.setVisibleById("panelDadoSolicitante", false);
		form.setVisibleById("tituloSolicitacao", true);
	}


	if (state=="190") {
		form.setVisibleById("panelDadoSolicitante", true);
    	form.setVisibleById("panelDadoSolicitacao", false);
		form.setVisibleById("panelCotacoes", true);
		form.setVisibleById("panelOrcamento", true);
		form.setVisibleById("tituloCotacao", true);
	}
	
	if (state=="192") {
		form.setVisibleById("panelDadoSolicitante", true);
    	form.setVisibleById("panelDadoSolicitacao", false);
		form.setVisibleById("panelCotacoes", true);
		form.setVisibleById("panelOrcamento", true);
		form.setVisibleById("tituloCotacao", true);
	}

	if (state=="287") {
		form.setVisibleById("panelDadoSolicitacao", true);
		form.setVisibleById("panelDadoSolicitante", false);
		form.setVisibleById("tituloSolicitacao", true);
	}

	if (state=="342") {
		form.setVisibleById("grupoBotaoProdutos", false); 		
		form.setVisibleById("modalAdicionarProduto", false); 		
	 	form.setVisibleById("panelDadoSolicitante", false);
    	form.setVisibleById("panelDadoSolicitacao", true);
		form.setVisibleById("tituloCadastroProtheus", true);

	 }

	 if (state=="344") {
		form.setVisibleById("grupoBotaoProdutos", true); 		
	 	form.setVisibleById("panelDadoSolicitante", true);
    	form.setVisibleById("panelDadoSolicitacao", true);
		form.setVisibleById("tituloSolicitacao", true);
	 }

	 if (state=="360") {
		form.setVisibleById("grupoBotaoProdutos", false); 		
	 	form.setVisibleById("panelDadoSolicitante", true);
    	form.setVisibleById("panelDadoSolicitacao", true);
		form.setVisibleById("tituloSolicitacao", true);
	 }	

	 if (state=="401") {
		form.setVisibleById("panelDadoSolicitacao", true);
		form.setVisibleById("panelDadoSolicitante", false);
		form.setVisibleById("tituloRetirarMaterial", true);
	}	 


	 if (state=="404") {
		form.setVisibleById("panelDadoSolicitacao", true);
		form.setVisibleById("panelDadoSolicitante", false);
		form.setVisibleById("tituloRetirarMaterial", true);
	}

	if (state=="426") {
		form.setVisibleById("grupoBotaoProdutos", false); 		
	 	form.setVisibleById("panelDadoSolicitante", true);
    	form.setVisibleById("panelDadoSolicitacao", true);
		form.setVisibleById("tituloSolicitacao", true);
	}	

	if (state=="429") {
		form.setVisibleById("panelDadoSolicitacao", true);
		form.setVisibleById("panelDadoSolicitante", false);
		form.setVisibleById("tituloSolicitacao", true);
	}

	if (state=="433") {
		form.setVisibleById("grupoBotaoProdutos", false); 		
	 	form.setVisibleById("panelDadoSolicitante", true);
    	form.setVisibleById("panelDadoSolicitacao", true);
		form.setVisibleById("tituloSolicitacao", true);
	}

	if (state=="435") {
		form.setVisibleById("grupoBotaoProdutos", false); 		
	 	form.setVisibleById("panelDadoSolicitante", true);
    	form.setVisibleById("panelDadoSolicitacao", true);
		form.setVisibleById("tituloSolicitacao", true);
	}

	if (state=="436") {
		form.setVisibleById("grupoBotaoProdutos", false); 		
	 	form.setVisibleById("panelDadoSolicitante", true);
    	form.setVisibleById("panelDadoSolicitacao", true);
		form.setVisibleById("tituloSolicitacao", true);
	 }
	
	if (state=="388") {
		form.setVisibleById("grupoBotaoProdutos", false); 		
	 	form.setVisibleById("panelDadoSolicitante", true);
    	form.setVisibleById("panelDadoSolicitacao", true);
		form.setVisibleById("tituloSolicitacao", true);
	 }

	 if (state=="449") {
		form.setVisibleById("grupoBotaoProdutos", false); 		
	 	form.setVisibleById("panelDadoSolicitante", true);
    	form.setVisibleById("panelDadoSolicitacao", true);
		form.setVisibleById("tituloSolicitacao", true);
	}

	if (state=="461") {
		form.setVisibleById("grupoBotaoProdutos", false); 		
	 	form.setVisibleById("panelDadoSolicitante", true);
    	form.setVisibleById("panelDadoSolicitacao", true);
		form.setVisibleById("tituloSolicitacao", true);
	 }	

	if (state=="464") {
		form.setVisibleById("panelDadoSolicitacao", true);
		form.setVisibleById("panelDadoSolicitante", false);
		form.setVisibleById("tituloSolicitacao", true);
	}

	if (state=="404") {
		form.setVisibleById("panelDadoSolicitacao", true);
		form.setVisibleById("panelDadoSolicitante", false);
		form.setVisibleById("tituloRetirarMaterial", true);
	}
	
	if (state=="148") {
		form.setVisibleById("grupoBotaoProdutos", false); 		
	 	form.setVisibleById("panelDadoSolicitante", true);
    	form.setVisibleById("panelDadoSolicitacao", true);
		form.setVisibleById("tituloSolicitacaoFinalizada", true);
	}
	
	if (state=="422") {
		form.setVisibleById("grupoBotaoProdutos", false); 		
	 	form.setVisibleById("panelDadoSolicitante", true);
    	form.setVisibleById("panelDadoSolicitacao", true);
		form.setVisibleById("tituloSolicitacaoFinalizada", true);
	}
	
	if (state=="475") {
		form.setVisibleById("panelDadoSolicitante", true);
    	form.setVisibleById("panelDadoSolicitacao", false);
		form.setVisibleById("panelCotacoes", true);
		form.setVisibleById("panelOrcamento", true);
		form.setVisibleById("tituloCotacao", true);
	}
	
	if (state=="472") {
		form.setVisibleById("panelDadoSolicitante", true);
    	form.setVisibleById("panelDadoSolicitacao", true);
		form.setVisibleById("panelCotacoes", true);
		form.setVisibleById("panelOrcamento", true);
		form.setVisibleById("tituloCotacao", true);
		form.setVisibleById("panelCancelamento", true);
		form.setVisibleById("tb_produtos", true);
		form.setVisibleById("motivoCancelamento",true);
	}
	if (state=="548") {
		form.setVisibleById("panelDadoSolicitante", true);
    	form.setVisibleById("panelDadoSolicitacao", true);
		form.setVisibleById("panelCotacoes", true);
		form.setVisibleById("panelOrcamento", true);
		form.setVisibleById("tituloCotacao", true);
		form.setVisibleById("panelCancelamento", true);
		form.setVisibleById("tb_produtos", true);
		form.setVisibleById("motivoCancelamento",true);
	}
	if (state=="542") {
		form.setVisibleById("panelDadoSolicitante", true);
    	form.setVisibleById("panelDadoSolicitacao", true);
		form.setVisibleById("panelCotacoes", true);
		form.setVisibleById("panelOrcamento", true);
		form.setVisibleById("tituloCotacao", true);
		form.setVisibleById("panelCancelamento", true);
		form.setVisibleById("tb_produtos", true);
		form.setVisibleById("motivoCancelamento",true);
	}
	if (state=="544") {
		form.setVisibleById("panelDadoSolicitante", true);
    	form.setVisibleById("panelDadoSolicitacao", true);
		form.setVisibleById("panelCotacoes", true);
		form.setVisibleById("panelOrcamento", true);
		form.setVisibleById("tituloCotacao", true);
		form.setVisibleById("panelCancelamento", true);
		form.setVisibleById("tb_produtos", true);
		form.setVisibleById("motivoCancelamento",true);
	}
	if (state=="550") {
		form.setVisibleById("panelDadoSolicitante", true);
    	form.setVisibleById("panelDadoSolicitacao", true);
		form.setVisibleById("panelCotacoes", false);
		form.setVisibleById("panelOrcamento", false);
		form.setVisibleById("tituloCotacao", true);
		form.setVisibleById("panelCancelamento", true);
		form.setVisibleById("tb_produtos", true);
		form.setVisibleById("motivoCancelamento",true);
	}
	if (state=="136") {
		form.setVisibleById("panelDadoSolicitante", true);
    	form.setVisibleById("panelDadoSolicitacao", true);
		form.setVisibleById("panelCotacoes", true);
		form.setVisibleById("panelOrcamento", true);
		form.setVisibleById("tituloCotacao", true);
		form.setVisibleById("panelCancelamento", true);
		form.setVisibleById("tb_produtos", true);
		form.setVisibleById("motivoCancelamento",true);
	}
	if(state =="524"){
	form.setVisibleById("panelDadoSolicitacao", true);
	form.setVisibleById("grupoBotaoProdutos", true);
	form.setVisibleById("tituloSolicitacao", true);
	form.setVisibleById("tb_novosProdutos", false);
}
	 if (state=="491") {
			form.setVisibleById("grupoBotaoProdutos", true); 		
		 	form.setVisibleById("panelDadoSolicitante", true);
	    	form.setVisibleById("panelDadoSolicitacao", true);
			form.setVisibleById("tituloSolicitacao", true);
     }
	 
	 if (state=="505") {
			form.setVisibleById("grupoBotaoProdutos", true); 		
		 	form.setVisibleById("panelDadoSolicitante", true);
	    	form.setVisibleById("panelDadoSolicitacao", true);
			form.setVisibleById("tituloSolicitacao", true);
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

