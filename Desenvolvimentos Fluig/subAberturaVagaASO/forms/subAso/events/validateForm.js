function validateForm(form) {
	var activity = getValue('WKNumState');
	var state    = getValue("WKNumState");
	
	if (state == 5 || state == 10) {		
			if ((form.getValue("nomeColaborador") == null || form.getValue("nomeColaborador") == "") && ( getValue('nomeColaborador') == null )) {
				throw "Favor informar que os dados do contratado está em branco";
				}
			if ((form.getValue("aprovAso") == null || form.getValue("aprovAso") == "") && ( getValue('aprovAso') == null )) {
					throw "Informar se o ASO foi aprovado ou reprovado";
					}

			if ((form.getValue("observacaoAso") == null || form.getValue("observacaoAso") == "") && ( getValue('observacaoAso') == null )) {
					throw "Deverá informar dados adcionais no campo de OBSERVAÇÃO";
					}
		}
}
