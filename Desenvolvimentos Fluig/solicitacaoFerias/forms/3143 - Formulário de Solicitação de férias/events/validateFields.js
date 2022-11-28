function validateForm(form) {
	var activity = getValue('WKNumState');
	if ((form.getValue("codCentroCusto") == null || form.getValue("codCentroCusto") == "")
			&& (getValue('WKNumProces') == null || (getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true'))) {
		throw "Contrato: n\u00E3o pode ser vazio.";
	}
	if ((form.getValue("Ano") == null || form.getValue("Ano") == "")
			&& (getValue('WKNumProces') == null || (getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true'))) {
		throw "Ano: n\u00E3o pode ser vazio.";
	}
	if ((form.getValue("Mes") == null || form.getValue("Mes") == "")
			&& (getValue('WKNumProces') == null || (getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true'))) {
		throw "M\u00EAs: n\u00E3o pode ser vazio.";
	}
	if ((form.getValue("nomecolaborador") == null || form
			.getValue("nomecolaborador") == "")
			&& (getValue('WKNumProces') == null || (getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true'))) {
		throw "Colaborador: n\u00E3o pode ser vazio.";
	}
	if ((form.getValue("Cargo") == null || form.getValue("Cargo") == "")
			&& (getValue('WKNumProces') == null || (getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true'))) {
		throw "Cargo: n\u00E3o pode ser vazio.";
	}
	if ((form.getValue("gozoinicio") == null || form.getValue("gozoinicio") == "")
			&& (getValue('WKNumProces') == null || (getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true'))) {
		throw "Periodo de gozo - In\u00EDcio: n\u00E3o pode ser vazio.";
	}
	if ((form.getValue("Gozofim") == null || form.getValue("Gozofim") == "")
			&& (getValue('WKNumProces') == null || (getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true'))) {
		throw "Per\u00EDodo de gozo - Fim: n\u00E3o pode ser vazio.";
	}
	if ((form.getValue("nomesubstituto") == null || form
			.getValue("nomesubstituto") == "")
			&& (getValue('WKNumProces') == null || (getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true'))) {
		throw "Substituto: n\u00E3o pode ser vazio.";
	}
	if ((form.getValue("justificativa") == null || form
			.getValue("justificativa") == "")
			&& (getValue('WKNumProces') == null || (getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true'))) {
		throw "Justificativa(s): n\u00E3o pode ser vazio.";
	}
}