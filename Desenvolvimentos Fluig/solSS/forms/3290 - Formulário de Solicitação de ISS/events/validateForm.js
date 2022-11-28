function validateForm(form){
	var activity = getValue('WKNumState');
	var state    = getValue("WKNumState");
	
	if (form.getValue("centroCusto") == null || form.getValue("centroCusto") == "") {
		throw "Informe o centro de custo.";
	}
	
	if (form.getValue("telContato") == null || form.getValue("telContato") == "") {
		throw "Informe o Telefone para Contato";
	}
	
	if (form.getValue("classificacao") == null || form.getValue("classificacao") == "") {
		throw "Informe a Classificação para Atendimento.";
	}
	
	if (form.getValue("servicoPres") == null || form.getValue("servicoPres") == "") {
		throw "Informe o Serviço Prestado.";
	}
	
	if (form.getValue("municipio") == null || form.getValue("municipio") == "") {
		throw "Selecione o Município.";
	}
	
	
	if (form.getValue("Informa_Add") == null || form.getValue("Informa_Add") == "") {
		throw "Informe a justificativa.";
	}
	
	
	
	if (state == 0 || state == 4) {
		var dataAtual = new Date();
		var dataEstimativa = form.getValue("estimativaEntrega");

		if (dataEstimativa != null && dataEstimativa != "") {
			var dataEstimativaFormatada = new Date(dataEstimativa.substring(6,10), dataEstimativa.substring(3,5), dataEstimativa.substring(0,2));			
			
			if (dataEstimativaFormatada <= dataAtual ) {
				throw "Informe uma data superior a sete dias.";
			}
		}
	
		if ((form.getValue("solicitanteEmail") == null || form.getValue("solicitanteEmail") ==  "") && ( getValue('WKNumProces') == null ||
				(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
			throw "Informe o email.";
		}


        
        
		
	}
}
