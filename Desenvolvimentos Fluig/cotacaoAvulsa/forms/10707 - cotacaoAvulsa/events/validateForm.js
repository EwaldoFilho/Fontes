function validateForm(form){
    var state = getValue('WKNumState');

    if ((form.getValue("codCentroCusto") == null || form.getValue("codCentroCusto") ==  "") && ( getValue('WKNumProces') == null ||
    (getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
        throw "Informe um centro de custo através da pesqusisa.";
    }
	
	if (form.getValue("listaProdutos") == "") {
		throw "Informe ao menos um produto.";
	}
	
	if(state == "6"){
		var quantidadeProdutos = form.getValue("countValidaInputProdutos");
		
		for (var count = 0;  count <  quantidadeProdutos; count++) {			
			if (form.getValue("formaPagamento_"+count) == "") {
				throw "Informe a forma de pagamento.";
			}	
			
			if (form.getValue("precoUnitario_"+count) == "") {
				throw "Informe o preço.";
			}				
		}
	}
}