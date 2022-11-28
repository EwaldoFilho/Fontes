function enableFields(form) {		
	var activity = getValue('WKNumState');
	
	if (activity != 0 && activity != 4) {
		form.setEnabled("centroCusto",false);
		form.setEnabled("nomeCol",false);
		form.setEnabled("telContato",false);
		form.setEnabled("celContato",false);
		form.setEnabled("colEmail",false);
		form.setEnabled("funcao",false);
		form.setEnabled("Tipo0",false);
		form.setEnabled("Tipo1",false);
	}
}
