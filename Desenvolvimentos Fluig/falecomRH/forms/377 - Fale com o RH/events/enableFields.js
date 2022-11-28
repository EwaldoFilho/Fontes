function enableFields(form) {		
	var activity = getValue('WKNumState');
	
	if (activity != 0) {
		form.setEnabled("codCentroCusto",false);
		form.setEnabled("centroCusto",false);
		form.setEnabled("cpf",false);
		form.setEnabled("assuntoRh",false);
		form.setEnabled("Informa_Add",false);
	}
	if (activity != 8 ) {
		form.setEnabled("retorno",false);
	}
}
