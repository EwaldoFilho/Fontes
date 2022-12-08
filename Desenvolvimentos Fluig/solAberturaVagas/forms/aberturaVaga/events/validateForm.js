function validateForm(form) {
	var activity = getValue('WKNumState');
	var state    = getValue("WKNumState");
	
	if (state == 0 || state == 4) {		
			
		
		
			if ((form.getValue("descricaoCentroCustoSol") == null || form.getValue("descricaoCentroCustoSol") == "") && ( getValue('descricaoCentroCustoSol') == null )) {
					throw "Favor Informar o seu Centro de Custo";
					}
			if ((form.getValue("headCount") == null || form.getValue("headCount") == "") && ( getValue('headCount') == null )) {
					throw "Selecionar Headcount.";
					}
			if ((form.getValue("Tcontratacao") == null || form.getValue("Tcontratacao") == "") && ( getValue('Tcontratacao') == null )) {
				throw "Selecionar o tipo de Contratação.";
				}

			if ((form.getValue("codCentroCusto") == null || form.getValue("codCentroCusto") == "") && ( getValue('codCentroCusto') == null )) {
					throw "Selecionar Contrato.";
					}

			if ((form.getValue("descricaoFunc") == null || form.getValue("descricaoFunc") == "") && ( getValue('descricaoFunc') == null )) {
					throw "Selecionar Cargo.";
					}

			if ((form.getValue("dataDesejada") == null || form.getValue("dataDesejada") == "") && ( getValue('dataDesejada') == null )) {
					throw "Colocar data desejada para início.";
					}

			if ((form.getValue("dataDocumentacao") == null || form.getValue("dataDocumentacao") == "") && ( getValue('dataDocumentacao') == null )) {
					throw "Colocar data de retorno da documentação.";
					}

			if ((form.getValue("salario") == null || form.getValue("salario") == "") && ( getValue('salario') == null )) {
					throw "Informar valor do salário.";
					}

			if ((form.getValue("valeRefeicao") == null || form.getValue("valeRefeicao") == "") && ( getValue('valeRefeicao') == null )) {
					throw "Informar valor do Vale Refeição.";
					}
			
			if ((form.getValue("cargahora") == null || form.getValue("cargahora") == "") && ( getValue('cargahora') == null )) {
				throw "Informar carga horaria.";
				}
			
			if ((form.getValue("valorTransporte") == null || form.getValue("valorTransporte") == "") && ( getValue('valorTransporte') == null )) {
					throw "Informar valor do Vale Transporte.";
					}

			if ((form.getValue("cursos") == null || form.getValue("cursos") == "") && ( getValue('cursos') == null )) {
					throw "Informar Requisitos Obrigatórios.";
					}

			if ((form.getValue("experienciaPro") == null || form.getValue("experienciaPro") == "") && ( getValue('experienciaPro') == null )) {
					throw "Informar experiência profissional.";
					}

			if ((form.getValue("atividade") == null || form.getValue("atividade") == "") && ( getValue('atividade') == null )) {
					throw "Informar Atividades a serem desenvoldidas.";
					}
		}
}
