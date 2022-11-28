function enableFields(form) {
	var activity = getValue('WKNumState');
	if (activity == 1 || activity == 0) {
		form.setEnabled('data_de_abertu', false);
	}
}