function validateForm(form) {
	var activity = getValue('WKNumState');
	var state    = getValue("WKNumState");
	
	if (state == 0 || state == 4) {
		
		if ((form.getValue("codCentroCusto") == null || form.getValue("codCentroCusto") ==  "") && ( getValue('WKNumProces') == null ||
				(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
			throw "Selecione o Centro de Custo na aba dos dados do Solicitante";
		}
		
		if ((form.getValue("codCustoA") == null || form.getValue("codCustoA") ==  "") && ( getValue('WKNumProces') == null ||
				(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
			throw "Selecione o Centro de Custo a ser Alterado";
		}
		if ((form.getValue("tipoModificacao") == null || form.getValue("tipoModificacao") ==  "") && ( getValue('WKNumProces') == null ||
				(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
			throw "Selecione o Tipo do Ajuste - Alteração ou Revisão";
		}
		if ((form.getValue("perAlteracao") == null || form.getValue("perAlteracao") ==  "") && ( getValue('WKNumProces') == null ||
				(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
			throw "Informe o Período da Revisão/Alteração";
		}
		if ((form.getValue("justificativa") == null || form.getValue("justificativa") ==  "") && ( getValue('WKNumProces') == null ||
				(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
			throw "Justifique a razão para realizar a alteração";
		}
		
	}
}

