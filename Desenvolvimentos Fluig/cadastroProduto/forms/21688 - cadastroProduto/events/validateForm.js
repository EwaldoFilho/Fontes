function validateForm(form){
	var state = getValue('WKNumState');
	
	if(state == 0 || state == 4){
		if (form.getValue("nomeSolicitante") == null || form.getValue("nomeSolicitante") ==  "") {
			throw "Informe o nome do solicitante.";
		}
		
		var tabela = form.getChildrenIndexes("tb_produtos");
		
		if (tabela.length == 0) {
			throw "Informe ao menos um produto.";
		}
		
	    for(var i = 0; i < tabela.length; i++) {
	    	var descricaoProduto = form.getValue("descricao___"+tabela[i]);
	    	var observacaoProduto = form.getValue("observacao___"+tabela[i])
	    	
	    	if(descricaoProduto == null || descricaoProduto == ""){
	    		throw "Informe a descrição do produto.";
	    	}
	    	
	    	if(observacaoProduto == null || observacaoProduto == ""){
	    		throw "Informe a observação do produto.";
	    	}
	    }
		
		if (form.getValue("justificativa") == null || form.getValue("justificativa") ==  "") {
			throw "Informe a justificativa.";
		}
	}
}