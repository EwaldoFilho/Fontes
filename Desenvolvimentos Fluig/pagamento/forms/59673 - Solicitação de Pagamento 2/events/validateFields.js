function validateForm(form){
	var activity = getValue('WKNumState');
	var state    = getValue("WKNumState");
	
	if (state == 0 || state == 4) {
		
	
			
		if ((form.getValue("codFilial") == null || form.getValue("codFilial") ==  "") && ( getValue('WKNumProces') == null ||
				(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
			throw "Selecione sua empresa";
		}	
		if ((form.getValue("codCentroCusto") == null || form.getValue("codCentroCusto") ==  "") && ( getValue('WKNumProces') == null ||
				(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
			throw "Selecione o seu centro de custo";
		}	
		if ((form.getValue("codFilialForn") == null || form.getValue("codFilialForn") ==  "") && ( getValue('WKNumProces') == null ||
				(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
			throw "Informe a empresa relacionada ao fornecedor";
		}	
		if ((form.getValue("cnpjFornecedor") == null || form.getValue("cnpjFornecedor") ==  "") && ( getValue('WKNumProces') == null ||
				(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
			throw "Selecione o fornecedor";
		}	
		if ((form.getValue("numerodocumento") == null || form.getValue("numerodocumento") ==  "") && ( getValue('WKNumProces') == null ||
				(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
			throw "Informe o número da NF/DOC";
		}	
		if ((form.getValue("dataEmissao") == null || form.getValue("dataEmissao") ==  "") && ( getValue('WKNumProces') == null ||
				(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
			throw "Informar a data de emissão";
		}	
		
		if ((form.getValue("datavencimento") == null || form.getValue("datavencimento") ==  "") && ( getValue('WKNumProces') == null ||
				(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
					throw "Informe a data de vencimento do documento";
		}
		
		if ((form.getValue("historicodescri") == null || form.getValue("historicodescri") ==  "") && ( getValue('WKNumProces') == null ||
				(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
					throw "Informar a descrição do pagamento";
		}
		if ((form.getValue("codPagamento") == null || form.getValue("codPagamento") ==  "") && ( getValue('WKNumProces') == null ||
				(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
					throw "Selecione a forma de pagamento";
		}
		if ((form.getValue("codNatureza") == null || form.getValue("codNatureza") ==  "") && ( getValue('WKNumProces') == null ||
				(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
					throw "Selecione a natureza do pagamento";
		}
		if ((form.getValue("valorTotal") == null || form.getValue("valorTotal") ==  "") && ( getValue('WKNumProces') == null ||
				(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
			throw "Informar o valor do documento";
		}
		if ((form.getValue("quantidadeparce") == null || form.getValue("quantidadeparce") ==  "") && ( getValue('WKNumProces') == null ||
				(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
					throw "Informar a quantidade de parcelas";
		}
		
	}
	
	 
}