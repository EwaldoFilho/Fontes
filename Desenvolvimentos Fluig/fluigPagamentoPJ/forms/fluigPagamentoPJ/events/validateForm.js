function validateForm(form) {
	var activity = getValue('WKNumState');
	var state    = getValue("WKNumState");
	
	if (state == 0 || state == 4) {
		
		
		
		if ((form.getValue("codForn") == null || form.getValue("codForn") ==  "") && ( getValue('WKNumProces') == null ||
				(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
			throw "Selecione o Fornecedor";
		}
		if ((form.getValue("numeroNF") == null || form.getValue("numeroNF") ==  "") && ( getValue('WKNumProces') == null ||
				(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
			throw "Informe o Numero da NF";
		}
		if ((form.getValue("serieNF") == null || form.getValue("serieNF") ==  "") && ( getValue('WKNumProces') == null ||
				(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
			throw "Informe a Serie da NF";
		}
		if ((form.getValue("tipoRegime") == null || form.getValue("tipoRegime") ==  "") && ( getValue('WKNumProces') == null ||
				(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
			throw "Informe o Regime, PJ ou Outros";
		}
		if ((form.getValue("dataEmissao") == null || form.getValue("dataEmissao") ==  "") && ( getValue('WKNumProces') == null ||
				(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
			throw "Informe a data de Emissão";
		}
		if ((form.getValue("valorTotal") == null || form.getValue("valorTotal") ==  "") && ( getValue('WKNumProces') == null ||
				(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
			throw "Informe o Valor Total da Nota Fiscal";
		}	
		
		
}if (state == 5) {
	if ((form.getValue("codFilialForn") == null || form.getValue("codFilialForn") ==  "") && ( getValue('WKNumProces') == null ||
		(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
	throw "Informe a Filial";
}}}

