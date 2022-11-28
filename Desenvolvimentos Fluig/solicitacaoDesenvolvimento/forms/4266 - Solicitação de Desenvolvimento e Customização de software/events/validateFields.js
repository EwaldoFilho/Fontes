function validateForm(form) {
	var activity = getValue('WKNumState');
	if ((form.getValue("dtAbertura") == null || form.getValue("dtAbertura") == "")
			&& (getValue('WKNumProces') == null || (getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true'))) {
		throw "Data de abertura n\u00E3o pode ser vazio.";
	}
	if ((form.getValue("descricao") == null || form.getValue("descricao") == "")
			&& (getValue('WKNumProces') == null || (getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true'))) {
		throw "Selecione o Centro de .";
	}
	if ((form.getValue("combo5") == null || form.getValue("combo5") == "")
			&& (getValue('WKNumProces') == null || (getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true'))) {
		throw "Informe o Sistema n\u00E3o pode ser vazio.";
	}
	if ((form.getValue("combo6") == null || form.getValue("combo6") == "")
			&& (getValue('WKNumProces') == null || (getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true'))) {
		throw "Informe o M\u00F3dulo n\u00E3o pode ser vazio.";
	}
	if ((form.getValue("combo4") == null || form.getValue("combo4") == "")
			&& (getValue('WKNumProces') == null || (getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true'))) {
		throw "Tipo de solicita\u00E7\u00E3o n\u00E3o pode ser vazio.";
	}
	if ((form.getValue("obs1") == null || form.getValue("obs1") == "")
			&& (getValue('WKNumProces') == null || (getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true'))) {
		throw "Descreva a solicita\u00E7\u00E3o detalhada n\u00E3o pode ser vazio.";
	}
	if ((form.getValue("date4") == null || form.getValue("date4") == "")
			&& (getValue('WKNumProces') == null || (getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true'))) {
		throw "Data sugerida n\u00E3o pode ser vazio.";
	}
}