function enableFields(form) {
    var activity = getValue('WKNumState');
    var indexes = form.getChildrenIndexes("rateioCusto");
    
    if (activity != 0) {
		form.setEnabled("codCentroCusto",false);
		form.setEnabled("centroCusto",false);
		form.setEnabled("codCustoA",false);
		form.setEnabled("custoAlterar",false);
		form.setEnabled("tipoModificacao",false);
		form.setEnabled("perAlteracao",false);
		form.setEnabled("justificativa",false);
	}
    
    

    
}