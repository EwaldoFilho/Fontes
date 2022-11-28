function validateForm(form) {
	var state = getValue('WKNumState');
	var indexes = form.getChildrenIndexes("itensGastos");
	if (indexes.length > 0) {
		for (var i = 0; i < indexes.length; i++) {
			if (form.getValue('quantidade___' + indexes[i]) == null
					|| form.getValue('quantidade___' + indexes[i]) == ''|| form.getValue('quantidade___' + indexes[i]) <= '0') {
				throw "Informe a quantidade!";
			}
			if (form.getValue('lote___' + indexes[i]) == null
					|| form.getValue('lote___' + indexes[i]) == '') {
				throw "Informe o lote da medicação!";
			}
			if (form.getValue('respGasto___' + indexes[i]) == null
					|| form.getValue('respGasto___' + indexes[i]) == '') {
				throw "Informe o responsável da medicação!";
			}
			if (form.getValue('horaGasto___' + indexes[i]) == null
					|| form.getValue('horaGasto___' + indexes[i]) == '') {
				throw "Informe o responsável da medicação!";
			}
		}
	}

	if (form.getValue("recusado") == null || form.getValue("recusado") == "") {
		throw "Informe se o atendimento foi recusado. - Guia identificação.";
	}

	if (form.getValue("recusado") == "SIM") {
		if (form.getValue("termoRecusa1") == null
				|| form.getValue("termoRecusa1") == "") {
			throw "Informe o nome do paciente. - Guia identificação.";
		}

		/*if ((form.getValue("termoRecusa2") == null || form
				.getValue("termoRecusa2") == "")
				&& (form.getValue("termoRecusa3") == null || form
						.getValue("termoRecusa3") == "")
				&& (form.getValue("termoRecusa4") == null || form
						.getValue("termoRecusa4") == "")) {
			throw "Informe o motivo da recusa do atendimento. - Guia de identificação.";
		}*/
	}

	if (form.getValue("recusado") == "NAO") {
		if (form.getValue("nomeAtendente") == "") {
			throw "Informe o nome do atendente. - Guia identificação.";
		}

		if (form.getValue("horarioInicialCadastro") == "") {
			throw "Informe o horário inicial do atendimento. - Guia identificação.";
		}

		if (form.getValue("horarioFinalCadastro") == "") {
			throw "Informe o horário final do atendimento. - Guia identificação.";
		}

		if (form.getValue("tomador") == "") {
			throw "Informe o tomador. - Guia identificação.";
		}

		if (form.getValue("AtendimentoPaciente") == "") {
			throw "Informe o atendimento. - Guia identificação.";
		}

		if (form.getValue("aceitaColeta") == "on") {
			if (form.getValue("nome") == null || form.getValue("nome") == "") {
				throw "Informe o nome. - Guia de identificação.";
			}

			if (form.getValue("nacionalidade") == null
					|| form.getValue("nacionalidade") == "") {
				throw "Informe a nacionalidade. - Guia de identificação.";
			}

			if (form.getValue("dataNascimento") == null
					|| form.getValue("dataNascimento") == "") {
				throw "Informe a data de nascimento. - Guia de identificação.";
			}

			if (form.getValue("DocIdentificacao") == null
					|| form.getValue("DocIdentificacao") == "") {
				throw "Informe o dcoumento de identificação. - Guia de identificação.";
			}

			if (form.getValue("AeroportoOrigem") == null
					|| form.getValue("AeroportoOrigem") == "") {
				throw "Informe o aerporto. - Guia de identificação.";
			}
		}

		if ((form.getValue("outrosDados1") == null || form
				.getValue("outrosDados1") == "")
				&& (form.getValue("outrosDados2") == null || form
						.getValue("outrosDados2") == "")
				&& (form.getValue("outrosDados3") == null || form
						.getValue("outrosDados3") == "")
				&& (form.getValue("outrosDados4") == null || form
						.getValue("outrosDados4") == "")
				&& (form.getValue("outrosDados5") == null || form
						.getValue("outrosDados5") == "")
				&& (form.getValue("outrosDados6") == null || form
						.getValue("outrosDados6") == "")) {
			throw "Informe o tipo de paciente. - Guia de identificação.";
		}

		if (form.getValue("outrosDados1") == "on"
				&& (form.getValue("empresa") == "" || form.getValue("empresa") == null)) {
			throw "Informe a empresa. - Guia identificação.";
		}

		if (form.getValue("outrosDados3") == "on"
				&& (form.getValue("empresa") == "" || form.getValue("empresa") == null)) {
			throw "Informe a empresa. - Guia identificação.";
		}

		if (form.getValue("outrosDados5") == "on"
				&& (form.getValue("CompanhiaAerea") == "" || form
						.getValue("CompanhiaAerea") == null)) {
			throw "Informe a companhia. - Guia identificação.";
		}

		if (form.getValue("outrosDados5") == "on"
				&& (form.getValue("vooN") == "" || form.getValue("vooN") == null)) {
			throw "Informe o número do voo. - Guia identificação.";
		}

		if (form.getValue("outrosDados6") == "on"
				&& (form.getValue("empresa") == "" || form.getValue("empresa") == null)) {
			throw "Informe a empresa. - Guia identificação.";
		}

		if (form.getValue("localizacaoAtendimento") == null
				|| form.getValue("localizacaoAtendimento") == "") {
			throw "Informe o local do atendimento. - Guia identificação.";
		}

		if (form.getValue("classRisco") == null
				|| form.getValue("classRisco") == "") {
			throw "Informe a classificação de risco. - Guia de atendimento.";
		}

		if (form.getValue("exame_fisico1") == null
				|| form.getValue("exame_fisico1") == "") {
			throw "Informe a pressão arterial. - Guia de atendimento.";
		}

		if (form.getValue("exame_fisico4") == null
				|| form.getValue("exame_fisico4") == "") {
			throw "Informe a saturação. - Guia de atendimento.";
		}

		if (form.getValue("exame_fisico5") == null
				|| form.getValue("exame_fisico5") == "") {
			throw "Informe a temperatura.  - Guia de atendimento.";
		}

		if (form.getValue("libPassiente") == null
				|| form.getValue("libPassiente") == "") {
			throw "Informe se o paciente foi liberado - Guia de atendimento.";
		}

		if (form.getValue("recusaRemocao") == null
				|| form.getValue("recusaRemocao") == "") {
			throw "Informe se o paciente recusou a remoção - Guia de atendimento.";
		}

		/*if (form.getValue("enfermeiroResponsavel") == null || form.getValue("enfermeiroResponsavel") ==  "") {
			throw "Informe o responsável enfermagem - Guia de atendimento.";
		}
		
		
		if (form.getValue("corenEnfermeiro") == null || form.getValue("corenEnfermeiro") ==  "") {
			throw "Informe o coren - Guia de atendimento.";
		}*/

		if (form.getValue("historia") != ""
				&& (form.getValue("Antecedentes") == null || form
						.getValue("Antecedentes") == "")) {
			throw "Informe os antecedentes - Guia de diagnóstico e tratamento.";
		}

		if (form.getValue("historia") != ""
				&& (form.getValue("exame_fisico") == null || form
						.getValue("exame_fisico") == "")) {
			throw "Informe o exame físico - Guia de diagnóstico e tratamento.";
		}

		if (form.getValue("historia") != ""
				&& (form.getChildrenIndexes("itensClassCuidado").length == 0)) {
			throw "Informe classificação do cuidado - Guia de diagnóstico e tratamento.";
		}

		if (form.getValue("historia") != ""
				&& (form.getValue("reavaliacao") == null || form
						.getValue("reavaliacao") == "")) {
			throw "Informe a reavaliação - Guia de diagnóstico e tratamento.";
		}

		if (form.getValue("historia") != ""
				&& (form.getValue("precricaoMedica") == null || form
						.getValue("precricaoMedica") == "")) {
			throw "Informe a prescrição médica - Guia de diagnóstico e tratamento.";
		}

		if (form.getValue("medicoSME") == ""
				&& form.getValue("precricaoMedica") != "") {
			throw "Informe o nome do médico - Guia de diagnóstico e tratamento.";
		}

		if (form.getValue("crmMedico") == ""
				&& form.getValue("precricaoMedica") != "") {
			throw "Informe os CRM do médico - Guia de diagnóstico e tratamento.";
		}

		if (form.getValue("historia") != ""
				&& (form.getValue("evolucao_enfermagem") == "" && form
						.getValue("evolucao_enfermagem") == "")) {
			throw "Informe a evolução de enfermagem - Guia prescrição médica.";
		}

	}
}

