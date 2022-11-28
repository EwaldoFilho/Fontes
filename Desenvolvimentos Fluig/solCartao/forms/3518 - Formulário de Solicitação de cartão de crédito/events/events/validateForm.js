function validateForm(form){
	var activity = getValue('WKNumState');
	var state    = getValue("WKNumState");
	
	if (form.getValue("centroCusto") == null || form.getValue("centroCusto") == "") {
		throw "Informe o centro de custo.";
	}
	
	if (form.getValue("telContato") == null || form.getValue("telContato") == "") {
		throw "Informe o Telefone para Contato";
	}
	
	if (form.getValue("nMaquina") == null || form.getValue("nMaquina") == "") {
		throw "Informe a Identificação da Máquina - A mesma encontra-se na área de trabalho.";
	}
	
	if (form.getValue("Tipo0") == "" && form.getValue("Tipo1") == "" && form.getValue("Tipo2") == "" && form.getValue("Tipo3") == "" && form.getValue("Tipo4") == "" && form.getValue("Tipo5") == "" && form.getValue("Tipo6") == "" && form.getValue("Tipo7") == "" && form.getValue("Tipo8") == "") {
		throw "Informe o Tipo de Solicitação.";
	}
	
	if (form.getValue("Informa_Add") == null || form.getValue("Informa_Add") == "") {
		throw "Informe os detalhes da sua solicitação.";
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