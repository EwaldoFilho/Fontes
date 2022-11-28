function validateForm(form){

	var nrAtividade = getValue("WKNumState");
	var completou = getValue("WKCompletTask");
	if (completou == "false") { return;	}
	
	if(nrAtividade == 2) {
		if (form.getValue("dsAtividade") == null) { throw "É necessário preencher o campo Descrição."; }
		
	} //nrAtividade 2

}