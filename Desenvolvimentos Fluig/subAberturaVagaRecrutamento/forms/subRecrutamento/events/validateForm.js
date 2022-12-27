function validateForm(form) {
	var activity = getValue('WKNumState');
	var state    = getValue("WKNumState");
	var PROXIMATIVIDADE = Number(getValue("WKNextState"));
	
	if (state == 10) {		

			if ((form.getValue("nomeColaborador") == null || form.getValue("nomeColaborador") == "") && ( getValue('nomeColaborador') == null ) &&  getValue('WKCompletTask') == 'true') {
					throw "Informe o NOME do Colaborador Selecionado";
					}

			if ((form.getValue("emalColaborador") == null || form.getValue("emalColaborador") == "") && ( getValue('emalColaborador') == null )&&  getValue('WKCompletTask') == 'true') {
					throw "Informe o EMAIL do colaborador selecionado";
					}

			if ((form.getValue("telCandidato") == null || form.getValue("telCandidato") == "") && ( getValue('telCandidato') == null )&&  getValue('WKCompletTask') == 'true') {
					throw "Informe o TELEFONE do colaborador selecionado";
					}

			if ((form.getValue("cpfAso") == null || form.getValue("cpfAso") == "") && ( getValue('cpfAso') == null )&&  getValue('WKCompletTask') == 'true') {
					throw "Informe o CPF do colaborador selecionado";
					}

			if ((form.getValue("rgAso") == null || form.getValue("rgAso") == "") && ( getValue('rgAso') == null )&&  getValue('WKCompletTask') == 'true') {
					throw "Informe o RG do colaborador selecionado";
					}

			if ((form.getValue("dtNascimentoAso") == null || form.getValue("dtNascimentoAso") == "") && ( getValue('dtNascimentoAso') == null )&&  getValue('WKCompletTask') == 'true') {
					throw "Informe a DATA DE NASCIMENTO do colaborador selecionado";
					}

			if ((form.getValue("uniformeSoa") == null || form.getValue("uniformeSoa") == "") && ( getValue('uniformeSoa') == null )&&  getValue('WKCompletTask') == 'true') {
					throw "Informar o TAMANHO DO UNIFORME do colaborador selecionado";
					}
			
			if ((form.getValue("botaSoa") == null || form.getValue("botaSoa") == "") && ( getValue('botaSoa') == null )&&  getValue('WKCompletTask') == 'true') {
				throw "Informar TAMANHO DA BOTA do colaborador selecionado.";
				}						
		}
}
