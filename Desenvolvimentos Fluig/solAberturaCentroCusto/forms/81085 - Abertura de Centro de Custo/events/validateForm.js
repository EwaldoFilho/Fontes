function validateForm(form) {
	var activity = getValue('WKNumState');
	var state    = getValue("WKNumState");
	
	if (state == 0 || state == 4) {
		
		if ((form.getValue("codCentroCusto") == null || form.getValue("codCentroCusto") ==  "") && ( getValue('WKNumProces') == null ||
				(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
			throw "Selecione o Centro de Custo na aba dos dados do Solicitante";
		}
		
		if ((form.getValue("codFilial") == null || form.getValue("codFilial") ==  "") && ( getValue('WKNumProces') == null ||
				(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
			throw "Selecione a Empresa Prestadora do Serviço";
		}
		if ((form.getValue("gestorContrato") == null || form.getValue("gestorContrato") ==  "") && ( getValue('WKNumProces') == null ||
				(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
			throw "Informe o Nome do Gestor(a) do Contrato";
		}
		if ((form.getValue("localServico") == null || form.getValue("localServico") ==  "") && ( getValue('WKNumProces') == null ||
				(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
			throw "Selecione o Local da Prestação do Serviço";
		}
		if ((form.getValue("historicodescri") == null || form.getValue("historicodescri") ==  "") && ( getValue('WKNumProces') == null ||
				(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
			throw "Descreva o Serviço a ser Prestado";
		}		
		if ((form.getValue("tipoServico") == null || form.getValue("tipoServico") ==  "") && ( getValue('WKNumProces') == null ||
				(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
			throw "Selecione o Tipo do Serviço";
		}
		if ((form.getValue("cnpjTomador") == null || form.getValue("cnpjTomador") ==  "") && ( getValue('WKNumProces') == null ||
				(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
			throw "Informe o CNPJ do tomador";
		}
		if ((form.getValue("dataInicio") == null || form.getValue("dataInicio") ==  "") && ( getValue('WKNumProces') == null ||
				(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
			throw "Informe a Data de Início da Implantação";
		}
		
	}
}

