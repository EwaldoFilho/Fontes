function displayFields(form, customHTML) {
	var activity = getValue('WKNumState');
	if (activity == 1 || activity == 0) {
		var today = new Date();
		var year = today.getFullYear();
		var month = today.getMonth() + 1 < 10 ? '0' + (today.getMonth() + 1)
				: (today.getMonth() + 1);
		var day = today.getDate() < 10 ? '0' + today.getDate() : today
				.getDate();
		form.setValue('data_de_abertu', year + '-' + month + '-' + day);
	}
}