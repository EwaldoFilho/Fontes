function validateForm(form){
	var activity = getValue('WKNumState');
	var state    = getValue("WKNumState");
	
	if (form.getValue("centroCusto") == null || form.getValue("centroCusto") == "") {
		throw "Informe o Contrato que encontra-se lotado.";
	}
	
	if (form.getValue("cpf") == null || form.getValue("cpf") == "") {
		throw "Informe o CPF para identificação do Colaborador/Prestador.";
	}
	
	if (form.getValue("assuntoRh") == null || form.getValue("assuntoRh") == "") {
		throw "Selecione o Assunto a ser tratado";
	}
	
	
	if (form.getValue("Informa_Add") == null || form.getValue("Informa_Add") == "") {
		throw "Informe os detalhes da sua solicitação.";
	}
	
	if (state == 8){
		if (form.getValue("retorno") == null || form.getValue("retorno") == "") {
			throw "Informe a tratativa dada para esta solicitação.";
		}
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