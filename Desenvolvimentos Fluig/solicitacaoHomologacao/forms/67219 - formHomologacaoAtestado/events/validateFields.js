function validateForm(form){
	var activity = getValue('WKNumState');
	var state    = getValue("WKNumState");
	
	if (state == 0 || state == 4) {
		
	
			
		if ((form.getValue("codCentroCusto") == null || form.getValue("codCentroCusto") ==  "") && ( getValue('WKNumProces') == null ||
				(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
			throw "Selecione o Centro de Custo";
		}	
		if ((form.getValue("colaborador") == null || form.getValue("colaborador") ==  "") && ( getValue('WKNumProces') == null ||
				(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
			throw "Selecione o Colaborador";
		}
		if ((form.getValue("dataAtestado") == null || form.getValue("dataAtestado") ==  "") && ( getValue('WKNumProces') == null ||
				(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
			throw "Informe a Data do Atestado";
		}
		
		if ((form.getValue("qtdDias") == null || form.getValue("qtdDias") ==  "") && ( getValue('WKNumProces') == null ||
				(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
			throw "Informe a Quantidade de Dias do Afastamento";
		}
	}
	
	 
}