function validateForm(form) {
	var activity = getValue('WKNumState');
	if ((form.getValue("contato") == null || form.getValue("contato") == "")
			&& (getValue('WKNumProces') == null || (getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true'))) {
		throw "Contato n\u00E3o pode ser vazio.";
	}
	if ((form.getValue("setor") == null || form.getValue("setor") == "")
			&& (getValue('WKNumProces') == null || (getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true'))) {
		throw "Setor n\u00E3o pode ser vazio.";
	}
	
	if ((form.getValue("tipo_solici") == null || form.getValue("tipo_solici") == "")
			&& (getValue('WKNumProces') == null || (getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true'))) {
		throw "Tipo de solicita\u00E7\u00E3o n\u00E3o pode ser vazio.";
	}
	if ((form.getValue("informe_tema") == null || form.getValue("informe_tema") == "")
			&& (getValue('WKNumProces') == null || (getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true'))) {
		throw "Informe o tema n\u00E3o pode ser vazio.";
	}
	if ((form.getValue("descreva_finali") == null || form
			.getValue("descreva_finali") == "")
			&& (getValue('WKNumProces') == null || (getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true'))) {
		throw "Descreva a finalidade n\u00E3o pode ser vazio.";
	}
	if ((form.getValue("prazoEntrega") == null || form
			.getValue("prazoEntrega") == "")
			&& (getValue('WKNumProces') == null || (getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true'))) {
		throw "Estimativa de prazo n\u00E3o pode ser vazio.";
	}
}