function validateForm(form) {
	var activity = getValue('WKNumState');
	if ((form.getValue("Classificacao") == null || form
			.getValue("Classificacao") == "")
			&& (getValue('WKNumProces') == null || (getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true'))) {
		throw "Classifica\u00E7\u00E3o: n\u00E3o pode ser vazio.";
	}
	if ((form.getValue("Contato") == null || form.getValue("Contato") == "")
			&& (getValue('WKNumProces') == null || (getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true'))) {
		throw "Contato: n\u00E3o pode ser vazio.";
	}
	if ((form.getValue("Setor") == null || form.getValue("Setor") == "")
			&& (getValue('WKNumProces') == null || (getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true'))) {
		throw "Setor: n\u00E3o pode ser vazio.";
	}
	if ((form.getValue("textbox4") == null || form.getValue("textbox4") == "")
			&& (getValue('WKNumProces') == null || (getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true'))) {
		throw "CPF: n\u00E3o pode ser vazio.";
	}
}