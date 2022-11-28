function enableFields(form) {
    var activity = getValue('WKNumState');
    var indexes = form.getChildrenIndexes("rateioCusto");
    
    if (activity != 0) {
		form.setEnabled("codCentroCusto",false);
		form.setEnabled("centroCusto",false);
		form.setEnabled("codFilial",false);
		form.setEnabled("empresa",false);
		form.setEnabled("gestorContrato",false);
		form.setEnabled("localServico",false);
		form.setEnabled("historicodescri",false);
		form.setEnabled("tipoServico",false);
		form.setEnabled("nomeTomador",false);
		form.setEnabled("cnpjTomador",false);
		form.setEnabled("dataInicio",false);
	}
    
    

    
}