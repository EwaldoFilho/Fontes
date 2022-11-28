function validateForm(form){
	var activity = getValue('WKNumState');
	var state    = getValue("WKNumState");

	
	if (form.getValue("centroCusto") == null || form.getValue("centroCusto") == "") {
		throw "Informe o centro de custo.";
	}
	
	if (form.getValue("classificacao") == null || form.getValue("classificacao") == "") {
		throw "Selecione a Classificação do Atendimento.";
	}
	
	if (form.getValue("formato") == null || form.getValue("formato") == "") {
		throw "Selecione o Formato da Arte solicitada.";
	}
	
	if (form.getValue("Tipo0") == "" && form.getValue("Tipo1") == "") {
		throw "Informe se a arte será impressa ou não.";
	}
	
	if (form.getValue("comunicado0") == "" && form.getValue("comunicado1") == "" && form.getValue("comunicado2") == "" && form.getValue("comunicado3") == "" && form.getValue("comunicado4") == "" && form.getValue("comunicado5") == "" && form.getValue("comunicado6") == "" && form.getValue("comunicado7") == "") {
		throw "Selecione onde será comunicado esta arte.";
	}
	
	if (form.getValue("objetivo") == null || form.getValue("objetivo") == "") {
		throw "Descreva o objetivo da solicitação.";
	}
	
}