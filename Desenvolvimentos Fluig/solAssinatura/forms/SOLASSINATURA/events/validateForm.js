function validateForm(form){
	var activity = getValue('WKNumState');
	var state    = getValue("WKNumState");

	
	if (form.getValue("centroCusto") == null || form.getValue("centroCusto") == "") {
		throw "Informe o centro de custo.";
	}
	
	if (form.getValue("nomeCol") == null || form.getValue("nomeCol") == "") {
		throw "Informe o nome do colaborador.";
	}
	
	if (form.getValue("telContato") == null || form.getValue("telContato") == "") {
		throw "Informe o Telefone/Ramal do colaborador";
	}
	
	
	if (form.getValue("colEmail") == null || form.getValue("colEmail") == "") {
		throw "Informe o e-mail do colaborador.";
	}
	if (form.getValue("funcao") == null || form.getValue("funcao") == "") {
		throw "Selecione o Cargo do colaborador.";
	}
	
	
	if (form.getValue("Tipo0") == "" && form.getValue("Tipo1") == "") {
		throw "Informe o tipo de solicitação.";
	}
	
}