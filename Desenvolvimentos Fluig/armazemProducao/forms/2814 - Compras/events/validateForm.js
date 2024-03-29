function validateForm(form){
	var activity = getValue('WKNumState');
	var state    = getValue("WKNumState");
	
	if (state == 0 || state == 4) {
		var dataAtual = new Date();
		var dataEstimativa = form.getValue("estimativaEntrega");

		if (dataEstimativa != null && dataEstimativa != "") {
			var dataEstimativaFormatada = new Date(dataEstimativa.substring(6,10), dataEstimativa.substring(3,5), dataEstimativa.substring(0,2));			
			
			if (dataEstimativaFormatada <= dataAtual ) {
				throw "Informe uma data superior a sete dias.";
			}
		}
	
		if ((form.getValue("grupo") == null || form.getValue("grupo") ==  "") && ( getValue('WKNumProces') == null ||
				(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
			throw "Informe um grupo.";
		}
		
		/*
		if ((form.getValue("codFilial") == "xxxxyyyyzzz" || form.getValue("codFilial") ==  "") && ( getValue('WKNumProces') == null ||
				(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
					throw "Informe uma empresa/filial.";
		}*/
		
		if ((form.getValue("codCentroCusto") == null || form.getValue("codCentroCusto") ==  "") && ( getValue('WKNumProces') == null ||
				(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
					throw "Informe um centro de custo através da pesqusisa.";
		}
		
		if ((form.getValue("descricao") == null || form.getValue("descricao") ==  "") && ( getValue('WKNumProces') == null ||
				(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
					throw "Informe o centro de custo.";
		}
		
		/*
		if ((form.getValue("codArmazem") == null || form.getValue("codArmazem") ==  "") && ( getValue('WKNumProces') == null ||
				(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
					throw "Armazém inválido. Informe um armazém válido.";
		}*/
		
		if (form.getValue("listaProdutos") == "" && form.getValue('existeProdutoNovo') == "false") {
			throw "Informe ao menos um produto ou então cadastre.";
		}
		
		if (form.getValue("listaProdutos") == "[]" && form.getValue('existeProdutoNovo') == "false") {
			throw "Informe ao menos um produto ou então cadastre.";
		}
	}
	
	 
}