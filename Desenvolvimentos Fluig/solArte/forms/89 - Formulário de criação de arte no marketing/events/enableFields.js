function enableFields(form) {		
	var activity = getValue('WKNumState');
	
	if (activity != 0 && activity != 3) {
		form.setEnabled("centroCusto",false);
		form.setEnabled("classificacao",false);
		form.setEnabled("formato",false);
		form.setEnabled("Tipo0",false);
		form.setEnabled("Tipo1",false);
		form.setEnabled("comunicado0",false);
		form.setEnabled("comunicado1",false);
		form.setEnabled("comunicado2",false);
		form.setEnabled("comunicado3",false);
		form.setEnabled("comunicado4",false);
		form.setEnabled("comunicado5",false);
		form.setEnabled("comunicado6",false);
		form.setEnabled("comunicado7",false);
		form.setEnabled("objetivo",false);
	}
}
