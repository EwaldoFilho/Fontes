function validateForm(form) {
	var activity = getValue('WKNumState');
	var state    = getValue("WKNumState");
	
	if (state == 5) {		

			if ((form.getValue("nomeColaborador") == null || form.getValue("nomeColaborador") == "") && ( getValue('nomeColaborador') == null )) {
					throw "Informe o NOME do Colaborador Selecionado";
					}

			if ((form.getValue("emalColaborador") == null || form.getValue("emalColaborador") == "") && ( getValue('emalColaborador') == null )) {
					throw "Informe o EMAIL do colaborador selecionado";
					}

			if ((form.getValue("telCandidato") == null || form.getValue("telCandidato") == "") && ( getValue('telCandidato') == null )) {
					throw "Informe o TELEFONE do colaborador selecionado";
					}

			if ((form.getValue("cpfAso") == null || form.getValue("cpfAso") == "") && ( getValue('cpfAso') == null )) {
					throw "Informe o CPF do colaborador selecionado";
					}

			if ((form.getValue("rgAso") == null || form.getValue("rgAso") == "") && ( getValue('rgAso') == null )) {
					throw "Informe o RG do colaborador selecionado";
					}

			if ((form.getValue("dtNascimentoAso") == null || form.getValue("dtNascimentoAso") == "") && ( getValue('dtNascimentoAso') == null )) {
					throw "Informe a DATA DE NASCIMENTO do colaborador selecionado";
					}

			if ((form.getValue("uniformeSoa") == null || form.getValue("uniformeSoa") == "") && ( getValue('uniformeSoa') == null )) {
					throw "Informar o TAMANHO DO UNIFORME do colaborador selecionado";
					}
			
			if ((form.getValue("botaSoa") == null || form.getValue("botaSoa") == "") && ( getValue('botaSoa') == null )) {
				throw "Informar TAMANHO DA BOTA do colaborador selecionado.";
				}						
		}
}
