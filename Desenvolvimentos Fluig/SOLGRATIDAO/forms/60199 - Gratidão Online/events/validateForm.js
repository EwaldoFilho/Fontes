function validateForm(form) {
	var activity = getValue('WKNumState');
	var state = getValue("WKNumState");

	if (state == 0 || state == 4) {

		if ((form.getValue("codCentroCusto") == null || form
				.getValue("codCentroCusto") == "")
				&& (getValue('WKNumProces') == null || (getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true'))) {
			throw "Selecione o Centro de Custo na aba dos dados do Solicitante";
		}

		if ((form.getValue("comentario") == null || form.getValue("comentario") == "")
				&& (getValue('WKNumProces') == null || (getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true'))) {
			throw "Descreva sua Gratidão";
		}

	}
	if (state == 5) {

		if ((form.getValue("validacao") == null || form.getValue("validacao") == "")
				&& (getValue('WKNumProces') == null || (getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true'))) {
			throw "Gentileza Validar a Gratidão";
		}

	}
}
