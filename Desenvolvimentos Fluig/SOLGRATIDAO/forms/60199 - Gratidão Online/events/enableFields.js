function enableFields(form) {
    var activity = getValue('WKNumState');
    var indexes = form.getChildrenIndexes("rateioCusto");
    
    if (activity != 0) {
		form.setEnabled("codCentroCusto",false);
		form.setEnabled("centroCusto",false);
		form.setEnabled("comentario",false);
	}
    
    if (activity != 5) {
		form.setEnabled("codCentroCusto",false);
		form.setEnabled("centroCusto",false);
		form.setEnabled("validacao",false);
		form.setEnabled("comentario",false);
	}
    
    

    
}