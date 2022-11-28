function enableFields(form) {		
	var activity = getValue('WKNumState');
	
	if (activity != 0 && activity != 8) {
		form.setEnabled("codCentroCusto",false);
		form.setEnabled("centroCusto",false);
		form.setEnabled("classificacao",false);
		form.setEnabled("telContato",false);
		form.setEnabled("servicoPres",false);
		form.setEnabled("municipio",false);
		form.setEnabled("Informa_Add",false);
	}
}
