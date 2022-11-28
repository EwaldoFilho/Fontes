function displayFields(form,customHTML){
	
	var mode     = form.getFormMode();
	var state    = getValue("WKNumState");
	var complete = getValue("WKCompletTask");
	var user     = getValue("WKUser");
	var locale   = getValue("WKUserLocale");
	var mobile   = form.getMobile();
	var processo = getValue("WKNumProces");
	
	
	
	/* Painel Seguro*/
	if (state=="338") {
		form.setVisibleById("dadosCotacao", true);
		form.setVisibleById("dados_Inicial", true);
		form.setVisibleById("dados_areas_envolvidas", false);
		form.setVisibleById("dados_recursos_humanos", false);
		form.setVisibleById("dados_financeiro", false);
		form.setVisibleById("dados_uniformes_epi", false);
		form.setVisibleById("dados_avaliacoes", false);
		form.setVisibleById("dadosExames", false);
		form.setVisibleById("dadosSuprimentos", false);
		form.setVisibleById("dadosLocacao", false);
		form.setVisibleById("dadosTreinamento", false);
		form.setVisibleById("dadosImpugnacao", false);
		form.setVisibleById("dadosDocumentos", false);
		form.setVisibleById("exame_area1", false);
		form.setVisibleById("area_tec1", false);
		form.setVisibleById("dadosDocumentos", false);
		form.setVisibleById("dadosAREATECNICA", false);
		form.setVisibleById("dadosTecnologia", false);
	}
/*-----------------------------------------------------------------*/
	/* Painel docuento*/
	if (state=="347") {
		form.setVisibleById("dadosCotacao", false);
		form.setVisibleById("dados_Inicial", true);
		form.setVisibleById("dados_areas_envolvidas", false);
		form.setVisibleById("dados_recursos_humanos", false);
		form.setVisibleById("dados_financeiro", false);
		form.setVisibleById("dados_uniformes_epi", false);
		form.setVisibleById("dados_avaliacoes", false);
		form.setVisibleById("dadosExames", false);
		form.setVisibleById("dadosSuprimentos", false);
		form.setVisibleById("dadosLocacao", false);
		form.setVisibleById("dadosTreinamento", false);
		form.setVisibleById("dadosImpugnacao", false);
		form.setVisibleById("dadosDocumentos", false);
		form.setVisibleById("exame_area1", false);
		form.setVisibleById("area_tec1", false);
		form.setVisibleById("dadosDocumentos", true);
		form.setVisibleById("dadosAREATECNICA", false);
		form.setVisibleById("dadosTecnologia", false);
	}
/*-----------------------------------------------------------------*/
	/* Painel juridico rh*/
	if (state=="288") {
		form.setVisibleById("dadosCotacao", false);
		form.setVisibleById("dados_Inicial", true);
		form.setVisibleById("dados_areas_envolvidas", false);
		form.setVisibleById("dados_recursos_humanos", true);
		form.setVisibleById("dados_financeiro", false);
		form.setVisibleById("dados_uniformes_epi", false);
		form.setVisibleById("dados_avaliacoes", false);
		form.setVisibleById("dadosExames", false);
		form.setVisibleById("dadosSuprimentos", false);
		form.setVisibleById("dadosLocacao", false);
		form.setVisibleById("dadosTreinamento", false);
		form.setVisibleById("dadosImpugnacao", false);
		form.setVisibleById("exame_area1", false);
		form.setVisibleById("dadosDocumentos", false);
		form.setVisibleById("area_tec1", false);
		form.setVisibleById("dadosAREATECNICA", false);
		form.setVisibleById("dadosTecnologia", false);
	}
	/*-----------------------------------------------------------------*/
	/* Painel juridico normal*/
	if (state=="135") {
		form.setVisibleById("dadosCotacao", false);
		form.setVisibleById("dados_Inicial", true);
		form.setVisibleById("dados_areas_envolvidas", false);
		form.setVisibleById("dados_recursos_humanos", false);
		form.setVisibleById("dados_financeiro", false);
		form.setVisibleById("dados_uniformes_epi", false);
		form.setVisibleById("dados_avaliacoes", false);
		form.setVisibleById("dadosExames", false);
		form.setVisibleById("dadosSuprimentos", false);
		form.setVisibleById("dadosLocacao", false);
		form.setVisibleById("dadosTreinamento", false);
		form.setVisibleById("dadosImpugnacao", true);
		form.setVisibleById("exame_area1", false);
		form.setVisibleById("area_tec1", false);
		form.setVisibleById("dadosDocumentos", false);
		form.setVisibleById("dadosAREATECNICA", false);
		form.setVisibleById("dadosTecnologia", false);
	 }
	/*-----------------------------------------------------------------*/
	/* Painel juridico normal*/
	 if (state=="22") {
		 form.setVisibleById("dadosCotacao", false);
			form.setVisibleById("dados_Inicial", true);
			form.setVisibleById("dados_areas_envolvidas", false);
			form.setVisibleById("dados_recursos_humanos", false);
			form.setVisibleById("dados_financeiro", true);
			form.setVisibleById("dados_uniformes_epi", false);
			form.setVisibleById("dados_avaliacoes", false);
			form.setVisibleById("dadosExames", false);
			form.setVisibleById("dadosSuprimentos", false);
			form.setVisibleById("dadosLocacao", false);
			form.setVisibleById("dadosTreinamento", false);
			form.setVisibleById("dadosImpugnacao", false);
			form.setVisibleById("exame_area1", false);
			form.setVisibleById("area_tec1", false);
			form.setVisibleById("dadosDocumentos", false);
			form.setVisibleById("dadosAREATECNICA", false);
			form.setVisibleById("dadosTecnologia", false);
	 }
	
	 if (state=="137") {
		 form.setVisibleById("dadosCotacao", false);
			form.setVisibleById("dados_Inicial", true);
			form.setVisibleById("dados_areas_envolvidas", false);
			form.setVisibleById("dados_recursos_humanos", false);
			form.setVisibleById("dados_financeiro", true);
			form.setVisibleById("dados_uniformes_epi", false);
			form.setVisibleById("dados_avaliacoes", false);
			form.setVisibleById("dadosExames", false);
			form.setVisibleById("dadosSuprimentos", false);
			form.setVisibleById("dadosLocacao", false);
			form.setVisibleById("dadosTreinamento", false);
			form.setVisibleById("dadosImpugnacao", false);
			form.setVisibleById("exame_area1", false);
			form.setVisibleById("area_tec1", false);
			form.setVisibleById("dadosDocumentos", false);
			form.setVisibleById("dadosAREATECNICA", false);
			form.setVisibleById("dadosTecnologia", false);
	 }
	 /*-----------------------------------------------------------------*/
		/* Painel RH*/
	 if (state=="20") {
		 form.setVisibleById("dadosCotacao", false);
			form.setVisibleById("dados_Inicial", true);
			form.setVisibleById("dados_areas_envolvidas", false);
			form.setVisibleById("dados_recursos_humanos", true);
			form.setVisibleById("dados_financeiro", false);
			form.setVisibleById("dados_uniformes_epi", false);
			form.setVisibleById("dados_avaliacoes", false);
			form.setVisibleById("dadosExames", false);
			form.setVisibleById("dadosSuprimentos", false);
			form.setVisibleById("dadosLocacao", false);
			form.setVisibleById("dadosTreinamento", false);
			form.setVisibleById("dadosImpugnacao", false);
			form.setVisibleById("exame_area1", false);
			form.setVisibleById("area_tec1", false);
			form.setVisibleById("dadosDocumentos", false);
			form.setVisibleById("dadosAREATECNICA", false);
			form.setVisibleById("dadosTecnologia", false);
		 }
	 /*-----------------------------------------------------------------*/
		/* Painel SOA */
	 if (state=="21") {
		 form.setVisibleById("dadosCotacao", false);
			form.setVisibleById("dados_Inicial", true);
			form.setVisibleById("dados_areas_envolvidas", false);
			form.setVisibleById("dados_recursos_humanos", false);
			form.setVisibleById("dados_financeiro", false);
			form.setVisibleById("dados_uniformes_epi", false);
			form.setVisibleById("dados_avaliacoes", false);
			form.setVisibleById("dadosExames", false);
			form.setVisibleById("dadosSuprimentos", false);
			form.setVisibleById("dadosLocacao", true);
			form.setVisibleById("dadosTreinamento", false);
			form.setVisibleById("dadosImpugnacao", false);
			form.setVisibleById("exame_area1", false);
			form.setVisibleById("area_tec1", false);
			form.setVisibleById("dadosDocumentos", false);
			form.setVisibleById("dadosAREATECNICA", false);
			form.setVisibleById("dadosTecnologia", false);

	 }
	 if (state=="129") {
		 form.setVisibleById("dadosCotacao", false);
			form.setVisibleById("dados_Inicial", true);
			form.setVisibleById("dados_areas_envolvidas", false);
			form.setVisibleById("dados_recursos_humanos", false);
			form.setVisibleById("dados_financeiro", false);
			form.setVisibleById("dados_uniformes_epi", false);
			form.setVisibleById("dados_avaliacoes", false);
			form.setVisibleById("dadosExames", false);
			form.setVisibleById("dadosSuprimentos", false);
			form.setVisibleById("dadosLocacao", true);
			form.setVisibleById("dadosTreinamento", false);
			form.setVisibleById("dadosImpugnacao", false);
			form.setVisibleById("exame_area1", false);
			form.setVisibleById("area_tec1", false);
			form.setVisibleById("dadosAREATECNICA", false);
			form.setVisibleById("dadosTecnologia", false);
		 }	
	 
	 if (state=="430") {
		 form.setVisibleById("dadosCotacao", false);
			form.setVisibleById("dados_Inicial", true);
			form.setVisibleById("dados_areas_envolvidas", false);
			form.setVisibleById("dados_recursos_humanos", false);
			form.setVisibleById("dados_financeiro", false);
			form.setVisibleById("dados_uniformes_epi", true);
			form.setVisibleById("dados_avaliacoes", false);
			form.setVisibleById("dadosExames", false);
			form.setVisibleById("dadosSuprimentos", false);
			form.setVisibleById("dadosLocacao", false);
			form.setVisibleById("dadosTreinamento", false);
			form.setVisibleById("dadosImpugnacao", false);
			form.setVisibleById("exame_area1", false);
			form.setVisibleById("area_tec1", false);
			form.setVisibleById("dadosAREATECNICA", false);
			form.setVisibleById("dadosTecnologia", false);
		 }	
	 if (state=="433") {
		 form.setVisibleById("dadosCotacao", false);
			form.setVisibleById("dados_Inicial", true);
			form.setVisibleById("dados_areas_envolvidas", false);
			form.setVisibleById("dados_recursos_humanos", false);
			form.setVisibleById("dados_financeiro", false);
			form.setVisibleById("dados_uniformes_epi", true);
			form.setVisibleById("dados_avaliacoes", false);
			form.setVisibleById("dadosExames", false);
			form.setVisibleById("dadosSuprimentos", false);
			form.setVisibleById("dadosLocacao", false);
			form.setVisibleById("dadosTreinamento", false);
			form.setVisibleById("dadosImpugnacao", false);
			form.setVisibleById("exame_area1", false);
			form.setVisibleById("area_tec1", false);
			form.setVisibleById("dadosAREATECNICA", false);
			form.setVisibleById("dadosTecnologia", false);
		 }	
	 
	 if (state=="439") {
		 form.setVisibleById("dadosCotacao", false);
			form.setVisibleById("dados_Inicial", true);
			form.setVisibleById("dados_areas_envolvidas", false);
			form.setVisibleById("dados_recursos_humanos", false);
			form.setVisibleById("dados_financeiro", false);
			form.setVisibleById("dados_uniformes_epi", false);
			form.setVisibleById("dados_avaliacoes", false);
			form.setVisibleById("dadosExames", false);
			form.setVisibleById("dadosSuprimentos", true);
			form.setVisibleById("dadosLocacao", false);
			form.setVisibleById("dadosTreinamento", false);
			form.setVisibleById("dadosImpugnacao", false);
			form.setVisibleById("exame_area1", false);
			form.setVisibleById("area_tec1", false);
			form.setVisibleById("dadosAREATECNICA", false);
			form.setVisibleById("dadosTecnologia", false);
		 }
	 
	 if (state=="441") {
		 form.setVisibleById("dadosCotacao", false);
			form.setVisibleById("dados_Inicial", true);
			form.setVisibleById("dados_areas_envolvidas", false);
			form.setVisibleById("dados_recursos_humanos", false);
			form.setVisibleById("dados_financeiro", false);
			form.setVisibleById("dados_uniformes_epi", false);
			form.setVisibleById("dados_avaliacoes", false);
			form.setVisibleById("dadosExames", false);
			form.setVisibleById("dadosSuprimentos", true);
			form.setVisibleById("dadosLocacao", false);
			form.setVisibleById("dadosTreinamento", false);
			form.setVisibleById("dadosImpugnacao", false);
			form.setVisibleById("exame_area1", false);
			form.setVisibleById("area_tec1", false);
			form.setVisibleById("dadosAREATECNICA", false);
			form.setVisibleById("dadosTecnologia", false);
		 }
	 if (state=="446") {
		 form.setVisibleById("dadosCotacao", false);
			form.setVisibleById("dados_Inicial", true);
			form.setVisibleById("dados_areas_envolvidas", false);
			form.setVisibleById("dados_recursos_humanos", false);
			form.setVisibleById("dados_financeiro", false);
			form.setVisibleById("dados_uniformes_epi", false);
			form.setVisibleById("dados_avaliacoes", true);
			form.setVisibleById("dadosExames", false);
			form.setVisibleById("dadosSuprimentos", false);
			form.setVisibleById("dadosLocacao", false);
			form.setVisibleById("dadosTreinamento", false);
			form.setVisibleById("dadosImpugnacao", false);
			form.setVisibleById("exame_area1", false);
			form.setVisibleById("area_tec1", false);
			form.setVisibleById("dadosAREATECNICA", false);
			form.setVisibleById("dadosTecnologia", false);
		 }
	 if (state=="448") {
		 form.setVisibleById("dadosCotacao", false);
			form.setVisibleById("dados_Inicial", true);
			form.setVisibleById("dados_areas_envolvidas", false);
			form.setVisibleById("dados_recursos_humanos", false);
			form.setVisibleById("dados_financeiro", false);
			form.setVisibleById("dados_uniformes_epi", false);
			form.setVisibleById("dados_avaliacoes", true);
			form.setVisibleById("dadosExames", false);
			form.setVisibleById("dadosSuprimentos", false);
			form.setVisibleById("dadosLocacao", false);
			form.setVisibleById("dadosTreinamento", false);
			form.setVisibleById("dadosImpugnacao", false);
			form.setVisibleById("exame_area1", false);
			form.setVisibleById("area_tec1", false);
			form.setVisibleById("dadosAREATECNICA", false);
			form.setVisibleById("dadosTecnologia", false);
		 }
	 if (state=="453") {
		 form.setVisibleById("dadosCotacao", false);
			form.setVisibleById("dados_Inicial", true);
			form.setVisibleById("dados_areas_envolvidas", false);
			form.setVisibleById("dados_recursos_humanos", false);
			form.setVisibleById("dados_financeiro", false);
			form.setVisibleById("dados_uniformes_epi", false);
			form.setVisibleById("dados_avaliacoes", false);
			form.setVisibleById("dadosExames", true);
			form.setVisibleById("dadosSuprimentos", false);
			form.setVisibleById("dadosLocacao", false);
			form.setVisibleById("dadosTreinamento", false);
			form.setVisibleById("dadosImpugnacao", false);
			form.setVisibleById("exame_area1", false);
			form.setVisibleById("area_tec1", false);
			form.setVisibleById("dadosAREATECNICA", false);
			form.setVisibleById("dadosTecnologia", false);
		 }
	 if (state=="455") {
		 form.setVisibleById("dadosCotacao", false);
			form.setVisibleById("dados_Inicial", true);
			form.setVisibleById("dados_areas_envolvidas", false);
			form.setVisibleById("dados_recursos_humanos", false);
			form.setVisibleById("dados_financeiro", false);
			form.setVisibleById("dados_uniformes_epi", false);
			form.setVisibleById("dados_avaliacoes", false);
			form.setVisibleById("dadosExames", true);
			form.setVisibleById("dadosSuprimentos", false);
			form.setVisibleById("dadosLocacao", false);
			form.setVisibleById("dadosTreinamento", false);
			form.setVisibleById("dadosImpugnacao", false);
			form.setVisibleById("exame_area1", false);
			form.setVisibleById("area_tec1", false);
			form.setVisibleById("dadosAREATECNICA", false);
			form.setVisibleById("dadosTecnologia", false);
		 }
	 if (state=="460") {
		 form.setVisibleById("dadosCotacao", false);
			form.setVisibleById("dados_Inicial", true);
			form.setVisibleById("dados_areas_envolvidas", false);
			form.setVisibleById("dados_recursos_humanos", false);
			form.setVisibleById("dados_financeiro", false);
			form.setVisibleById("dados_uniformes_epi", false);
			form.setVisibleById("dados_avaliacoes", false);
			form.setVisibleById("dadosExames", false);
			form.setVisibleById("dadosSuprimentos", false);
			form.setVisibleById("dadosLocacao", false);
			form.setVisibleById("dadosTreinamento", true);
			form.setVisibleById("dadosImpugnacao", false);
			form.setVisibleById("exame_area1", false);
			form.setVisibleById("area_tec1", false);
			form.setVisibleById("dadosAREATECNICA", false);
			form.setVisibleById("dadosTecnologia", false);
		 }
	 if (state=="462") {
		 form.setVisibleById("dadosCotacao", false);
			form.setVisibleById("dados_Inicial", true);
			form.setVisibleById("dados_areas_envolvidas", false);
			form.setVisibleById("dados_recursos_humanos", false);
			form.setVisibleById("dados_financeiro", false);
			form.setVisibleById("dados_uniformes_epi", false);
			form.setVisibleById("dados_avaliacoes", false);
			form.setVisibleById("dadosExames", false);
			form.setVisibleById("dadosSuprimentos", false);
			form.setVisibleById("dadosLocacao", false);
			form.setVisibleById("dadosTreinamento", true);
			form.setVisibleById("dadosImpugnacao", false);
			form.setVisibleById("exame_area1", false);
			form.setVisibleById("area_tec1", false);
			form.setVisibleById("dadosAREATECNICA", false);
			form.setVisibleById("dadosTecnologia", false);
		 }
	 
	 

	 /*-----------------------------------------------------------------*/
		/* Painel Area tecnica */
	 
	 if (state=="192") {
		 form.setVisibleById("dadosCotacao", false);
			form.setVisibleById("dados_Inicial", true);
			form.setVisibleById("dados_areas_envolvidas", false);
			form.setVisibleById("dados_recursos_humanos", false);
			form.setVisibleById("dados_financeiro", false);
			form.setVisibleById("dados_uniformes_epi", false);
			form.setVisibleById("dados_avaliacoes", true);
			form.setVisibleById("dadosExames", true);
			form.setVisibleById("dadosSuprimentos", false);
			form.setVisibleById("dadosLocacao", false);
			form.setVisibleById("dadosTreinamento", true);
			form.setVisibleById("dadosImpugnacao", false);
			form.setVisibleById("exame_area1", true);
			form.setVisibleById("area_tec1", true);
			form.setVisibleById("dadosDocumentos", false);
			form.setVisibleById("dadosAREATECNICA", false);
			form.setVisibleById("dadosTecnologia", false);
		 }	

	 /*-----------------------------------------------------------------*/
		/* Painel COEMCIAL */
	 
	if (state=="0") {
		 form.setVisibleById("dadosCotacao", false);
			form.setVisibleById("dados_Inicial", true);
			form.setVisibleById("dados_areas_envolvidas", true);
			form.setVisibleById("dados_recursos_humanos",false);
			form.setVisibleById("dados_financeiro", false);
			form.setVisibleById("dados_uniformes_epi", false);
			form.setVisibleById("dados_avaliacoes", false);
			form.setVisibleById("dadosExames", false);
			form.setVisibleById("dadosSuprimentos", false);
			form.setVisibleById("dadosLocacao", false);
			form.setVisibleById("dadosTreinamento", false);
			form.setVisibleById("dadosImpugnacao", false);
			form.setVisibleById("exame_area1", false);
			form.setVisibleById("area_tec1", false);
			form.setVisibleById("treina_area1", false);
			form.setVisibleById("dadosDocumentos", false);
			form.setVisibleById("dadosAREATECNICA", false);
			form.setVisibleById("dadosTecnologia", false);
			
		 }
	

	if (state=="4") {
		 form.setVisibleById("dadosCotacao", false);
			form.setVisibleById("dados_Inicial", true);
			form.setVisibleById("dados_areas_envolvidas", true);
			form.setVisibleById("dados_recursos_humanos", false);
			form.setVisibleById("dados_financeiro", false);
			form.setVisibleById("dados_uniformes_epi", false);
			form.setVisibleById("dados_avaliacoes", false);
			form.setVisibleById("dadosExames", false);
			form.setVisibleById("dadosSuprimentos", false);
			form.setVisibleById("dadosLocacao", false);
			form.setVisibleById("dadosTreinamento", false);
			form.setVisibleById("dadosImpugnacao", false);
			form.setVisibleById("exame_area1", false);
			form.setVisibleById("area_tec1", false);
			form.setVisibleById("treina_area1", false);
			form.setVisibleById("dadosDocumentos", false);
			form.setVisibleById("dadosAREATECNICA", false);
			form.setVisibleById("dadosTecnologia", false);

	}
	
	if (state=="309") {
		 form.setVisibleById("dadosCotacao", true);
			form.setVisibleById("dados_Inicial", true);
			form.setVisibleById("dados_areas_envolvidas", false);
			form.setVisibleById("dados_recursos_humanos", true);
			form.setVisibleById("dados_financeiro", true);
			form.setVisibleById("dados_uniformes_epi", true);
			form.setVisibleById("dados_avaliacoes", true);
			form.setVisibleById("dadosExames", true);
			form.setVisibleById("dadosSuprimentos", true);
			form.setVisibleById("dadosLocacao", true);
			form.setVisibleById("dadosTreinamento", true);
			form.setVisibleById("dadosImpugnacao", true);
			form.setVisibleById("exame_area1", false);
			form.setVisibleById("area_tec1", false);
			form.setVisibleById("dadosDocumentos", true);
			form.setVisibleById("dadosAREATECNICA", true);
			form.setVisibleById("dadosTecnologia", true);
	}

	if (state=="303") {
		 form.setVisibleById("dadosCotacao", true);
			form.setVisibleById("dados_Inicial", true);
			form.setVisibleById("dados_areas_envolvidas", false);
			form.setVisibleById("dados_recursos_humanos", true);
			form.setVisibleById("dados_financeiro", true);
			form.setVisibleById("dados_uniformes_epi", true);
			form.setVisibleById("dados_avaliacoes", true);
			form.setVisibleById("dadosExames", true);
			form.setVisibleById("dadosSuprimentos", true);
			form.setVisibleById("dadosLocacao", true);
			form.setVisibleById("dadosTreinamento", true);
			form.setVisibleById("dadosImpugnacao", true);
			form.setVisibleById("exame_area1", false);
			form.setVisibleById("area_tec1", false);
			form.setVisibleById("dadosDocumentos", true);
			form.setVisibleById("dadosAREATECNICA", true);
			form.setVisibleById("dadosTecnologia", true);
	}


	if (state=="332") {
		 form.setVisibleById("dadosCotacao", true);
			form.setVisibleById("dados_Inicial", true);
			form.setVisibleById("dados_areas_envolvidas", false);
			form.setVisibleById("dados_recursos_humanos", true);
			form.setVisibleById("dados_financeiro", true);
			form.setVisibleById("dados_uniformes_epi", true);
			form.setVisibleById("dados_avaliacoes", true);
			form.setVisibleById("dadosExames", true);
			form.setVisibleById("dadosSuprimentos", true);
			form.setVisibleById("dadosLocacao", true);
			form.setVisibleById("dadosTreinamento", true);
			form.setVisibleById("dadosImpugnacao", false);
			form.setVisibleById("exame_area1", false);
			form.setVisibleById("area_tec1", false);
			form.setVisibleById("treina_area1", false);
			form.setVisibleById("dadosDocumentos", true);
			form.setVisibleById("dadosAREATECNICA", true);
			form.setVisibleById("dadosTecnologia", true);
	}

	if (state=="299") {
		 form.setVisibleById("dadosCotacao", true);
			form.setVisibleById("dados_Inicial", true);
			form.setVisibleById("dados_areas_envolvidas", false);
			form.setVisibleById("dados_recursos_humanos", true);
			form.setVisibleById("dados_financeiro", true);
			form.setVisibleById("dados_uniformes_epi", true);
			form.setVisibleById("dados_avaliacoes", true);
			form.setVisibleById("dadosExames", true);
			form.setVisibleById("dadosSuprimentos", true);
			form.setVisibleById("dadosLocacao", true);
			form.setVisibleById("dadosTreinamento", true);
			form.setVisibleById("dadosImpugnacao", true);
			form.setVisibleById("exame_area1", false);
			form.setVisibleById("area_tec1", false);
			form.setVisibleById("dadosDocumentos", true);
			form.setVisibleById("dadosAREATECNICA", true);
			form.setVisibleById("dadosTecnologia", true);
	}

	if (state=="341") {
		 form.setVisibleById("dadosCotacao", true);
			form.setVisibleById("dados_Inicial", true);
			form.setVisibleById("dados_areas_envolvidas", false);
			form.setVisibleById("dados_recursos_humanos", true);
			form.setVisibleById("dados_financeiro", true);
			form.setVisibleById("dados_uniformes_epi", true);
			form.setVisibleById("dados_avaliacoes", true);
			form.setVisibleById("dadosExames", true);
			form.setVisibleById("dadosSuprimentos", true);
			form.setVisibleById("dadosLocacao", true);
			form.setVisibleById("dadosTreinamento", true);
			form.setVisibleById("dadosImpugnacao", false);
			form.setVisibleById("exame_area1", false);
			form.setVisibleById("area_tec1", false);
			form.setVisibleById("dadosDocumentos", true);
			form.setVisibleById("dadosAREATECNICA", true);
			form.setVisibleById("dadosTecnologia", true);

	 }

	 if (state=="280") {
		 form.setVisibleById("dadosCotacao", true);
			form.setVisibleById("dados_Inicial", true);
			form.setVisibleById("dados_areas_envolvidas", false);
			form.setVisibleById("dados_recursos_humanos", true);
			form.setVisibleById("dados_financeiro", true);
			form.setVisibleById("dados_uniformes_epi", true);
			form.setVisibleById("dados_avaliacoes", true);
			form.setVisibleById("dadosExames", true);
			form.setVisibleById("dadosSuprimentos", true);
			form.setVisibleById("dadosLocacao", true);
			form.setVisibleById("dadosTreinamento", true);
			form.setVisibleById("dadosImpugnacao", true);
			form.setVisibleById("exame_area1", false);
			form.setVisibleById("area_tec1", false);
			form.setVisibleById("treina_area1", true);
			form.setVisibleById("dadosDocumentos", true);

	 }

	 if (state=="329") {
		 form.setVisibleById("dadosCotacao", true);
			form.setVisibleById("dados_Inicial", true);
			form.setVisibleById("dados_areas_envolvidas", false);
			form.setVisibleById("dados_recursos_humanos", true);
			form.setVisibleById("dados_financeiro", true);
			form.setVisibleById("dados_uniformes_epi", true);
			form.setVisibleById("dados_avaliacoes", true);
			form.setVisibleById("dadosExames", true);
			form.setVisibleById("dadosSuprimentos", true);
			form.setVisibleById("dadosLocacao", true);
			form.setVisibleById("dadosTreinamento", true);
			form.setVisibleById("dadosImpugnacao", true);
			form.setVisibleById("exame_area1", false);
			form.setVisibleById("area_tec1", false);
			form.setVisibleById("treina_area1", false);
			form.setVisibleById("dadosDocumentos", true);
			form.setVisibleById("dadosAREATECNICA", true);
			form.setVisibleById("dadosTecnologia", true);
	 }	
	 if (state=="423") {
		 form.setVisibleById("dadosCotacao", true);
			form.setVisibleById("dados_Inicial", true);
			form.setVisibleById("dados_areas_envolvidas", false);
			form.setVisibleById("dados_recursos_humanos", true);
			form.setVisibleById("dados_financeiro", true);
			form.setVisibleById("dados_uniformes_epi", true);
			form.setVisibleById("dados_avaliacoes", true);
			form.setVisibleById("dadosExames", true);
			form.setVisibleById("dadosSuprimentos", true);
			form.setVisibleById("dadosLocacao", true);
			form.setVisibleById("dadosTreinamento", true);
			form.setVisibleById("dadosImpugnacao", true);
			form.setVisibleById("exame_area1", false);
			form.setVisibleById("area_tec1", false);
			form.setVisibleById("treina_area1", false);
			form.setVisibleById("dadosDocumentos", true);
			form.setVisibleById("dadosAREATECNICA", true);
			form.setVisibleById("dadosTecnologia", true);
	 }
	 if (state=="413") {
		 form.setVisibleById("dadosCotacao", true);
			form.setVisibleById("dados_Inicial", true);
			form.setVisibleById("dados_areas_envolvidas", false);
			form.setVisibleById("dados_recursos_humanos", false);
			form.setVisibleById("dados_financeiro", false);
			form.setVisibleById("dados_uniformes_epi", false);
			form.setVisibleById("dados_avaliacoes", false);
			form.setVisibleById("dadosExames", false);
			form.setVisibleById("dadosSuprimentos", false);
			form.setVisibleById("dadosLocacao", false);
			form.setVisibleById("dadosTreinamento", false);
			form.setVisibleById("dadosImpugnacao", false);
			form.setVisibleById("exame_area1", false);
			form.setVisibleById("area_tec1", false);
			form.setVisibleById("treina_area1", false);
			form.setVisibleById("dadosDocumentos", false);
			form.setVisibleById("dadosAREATECNICA", false);
			form.setVisibleById("dadosTecnologia", true);
	 }
	 /*-----------------------------------------------------------------*/

		/* Painel TI*/
		if (state=="409") {
			form.setVisibleById("dadosCotacao", false);
			form.setVisibleById("dados_Inicial", true);
			form.setVisibleById("dados_areas_envolvidas", false);
			form.setVisibleById("dados_recursos_humanos", false);
			form.setVisibleById("dados_financeiro", false);
			form.setVisibleById("dados_uniformes_epi", false);
			form.setVisibleById("dados_avaliacoes", false);
			form.setVisibleById("dadosExames", false);
			form.setVisibleById("dadosSuprimentos", false);
			form.setVisibleById("dadosLocacao", false);
			form.setVisibleById("dadosTreinamento", false);
			form.setVisibleById("dadosImpugnacao", false);
			form.setVisibleById("dadosDocumentos", false);
			form.setVisibleById("exame_area1", false);
			form.setVisibleById("area_tec1", false);
			form.setVisibleById("dadosDocumentos", false);
			form.setVisibleById("dadosAREATECNICA", false);
			form.setVisibleById("dadosTecnologia", true);
		}
		if (state=="411") {
			form.setVisibleById("dadosCotacao", false);
			form.setVisibleById("dados_Inicial", true);
			form.setVisibleById("dados_areas_envolvidas", false);
			form.setVisibleById("dados_recursos_humanos", false);
			form.setVisibleById("dados_financeiro", false);
			form.setVisibleById("dados_uniformes_epi", false);
			form.setVisibleById("dados_avaliacoes", false);
			form.setVisibleById("dadosExames", false);
			form.setVisibleById("dadosSuprimentos", false);
			form.setVisibleById("dadosLocacao", false);
			form.setVisibleById("dadosTreinamento", false);
			form.setVisibleById("dadosImpugnacao", false);
			form.setVisibleById("dadosDocumentos", false);
			form.setVisibleById("exame_area1", false);
			form.setVisibleById("area_tec1", false);
			form.setVisibleById("dadosDocumentos", false);
			form.setVisibleById("dadosAREATECNICA", false);
			form.setVisibleById("dadosTecnologia", true);
		}
	 /*-----------------------------------------------------------------*/
		 /*-----------------------------------------------------------------*/

		/* Painel area tecnica 2 */
		if (state=="421") {
			form.setVisibleById("dadosCotacao", false);
			form.setVisibleById("dados_Inicial", true);
			form.setVisibleById("dados_areas_envolvidas", false);
			form.setVisibleById("dados_recursos_humanos", false);
			form.setVisibleById("dados_financeiro", false);
			form.setVisibleById("dados_uniformes_epi", false);
			form.setVisibleById("dados_avaliacoes", false);
			form.setVisibleById("dadosExames", false);
			form.setVisibleById("dadosSuprimentos", false);
			form.setVisibleById("dadosLocacao", false);
			form.setVisibleById("dadosTreinamento", false);
			form.setVisibleById("dadosImpugnacao", false);
			form.setVisibleById("dadosDocumentos", false);
			form.setVisibleById("exame_area1", false);
			form.setVisibleById("area_tec1", false);
			form.setVisibleById("dadosDocumentos", false);
			form.setVisibleById("dadosAREATECNICA", true);
			form.setVisibleById("dadosTecnologia", false);
		}
		 /*-----------------------------------------------------------------*/

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

