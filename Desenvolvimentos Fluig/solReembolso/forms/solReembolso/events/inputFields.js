function inputFields(form) {
	if (form
			&& form.getValue("dataemissao")
			&& form.getValue("dataemissao").match(
					"^[0-3]?[0-9]/[0-3]?[0-9]/(?:[0-9]{2})?[0-9]{2}$")) {
		var split = form.getValue("dataemissao").split('/');
		form
				.setValue("dataemissao", split[2] + '-' + split[1] + '-'
						+ split[0]);
	}
	if (form
			&& form.getValue("vencimento")
			&& form.getValue("vencimento").match(
					"^[0-3]?[0-9]/[0-3]?[0-9]/(?:[0-9]{2})?[0-9]{2}$")) {
		var split = form.getValue("vencimento").split('/');
		form.setValue("vencimento", split[2] + '-' + split[1] + '-' + split[0]);
	}
}