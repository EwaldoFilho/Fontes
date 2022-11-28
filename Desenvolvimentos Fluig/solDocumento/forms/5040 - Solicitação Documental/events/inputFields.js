function inputFields(form) {
	if (form
			&& form.getValue("data_de_abertu")
			&& form.getValue("data_de_abertu").match(
					"^[0-3]?[0-9]/[0-3]?[0-9]/(?:[0-9]{2})?[0-9]{2}$")) {
		var split = form.getValue("data_de_abertu").split('/');
		form.setValue("data_de_abertu", split[2] + '-' + split[1] + '-'
				+ split[0]);
	}
}