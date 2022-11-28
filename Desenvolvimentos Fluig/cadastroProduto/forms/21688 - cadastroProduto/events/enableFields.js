function enableFields(form){ 
	var state    = getValue("WKNumState");
	
	form.setEnabled('dataAbertura', false);
	form.setEnabled('nomeSolicitante', false);
	
	if(state == 5 || state == 8){
		var tabela = form.getChildrenIndexes("tb_produtos");
		
	    for(var i = 0; i < tabela.length; i++) {
	    	form.setEnabled("observacao___"+tabela[i], false);
	    	form.setEnabled("descricao___"+tabela[i], false);

	    }	
	}
}