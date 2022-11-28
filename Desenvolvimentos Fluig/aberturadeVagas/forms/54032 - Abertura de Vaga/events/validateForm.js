function validateForm(form) {
	var ATIVIDADE = Number(getValue("WKNumState")) ? Number(getValue("WKNumState")) : INICIO;
	var PROXIMATIVIDADE = Number(getValue("WKNextState"))
	var MODE = form.getFormMode()
	var COMPLETETASK = (getValue("WKCompletTask") == "true");
	var state = getValue('WKNumState');
	
	if(state=="4"){

		if ((form.getValue("headCount") == null || form.getValue("headCount") == "") && ( getValue('headCount') == null )) {
				throw "Selecionar Headcount.";
				}

		if ((form.getValue("codCentroCusto") == null || form.getValue("codCentroCusto") == "") && ( getValue('codCentroCusto') == null )) {
				throw "Selecionar Contrato.";
				}

		if ((form.getValue("cargos") == null || form.getValue("cargos") == "") && ( getValue('cargos') == null )) {
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
	
	
/**	if(state=="12"){

	
			if ((form.getValue("numeroColaborado") == null || form.getValue("numeroColaborado") == "") && ( getValue('numeroColaborado') == null )) {
			throw "Informar telefone de contato do candidato.";
			}
		
		if ((form.getValue("dataRealAdemissao") == null || form.getValue("dataRealAdemissao") == "") && ( getValue('dataRealAdemissao') == null ) ) {
				throw "Informar data real de admissão.";
				}
		if ((form.getValue("nomeColaborado") == null || form.getValue("nomeColaborado") == "") && ( getValue('nomeColaborado') == null ) ) {
			throw "Informar nome completo do colaborador.";
			}
		if ((form.getValue("emalColaborador") == null || form.getValue("emalColaborador") == "") && ( getValue('emalColaborador') == null ) ) {
			throw "Informar email do colaborador.";
			}
		if ((form.getValue("dataInicio") == null || form.getValue("dataInicio") == "") && ( getValue('dataInicio') == null ) ) {
			throw "Informar data de inicio desejada.";
			}
		if ((form.getValue("cpf") == null || form.getValue("cpf") == "") && ( getValue('cpf') == null )) {
			throw "Informar CPF do colaborador.";
			}
		
	} */
	
	
	
	
	if (!COMPLETETASK || ATIVIDADE == PROXIMATIVIDADE ){
		return;
	}

	var msgErro = "";
	
	
	if(ATIVIDADE == INICIO){
		if (campoVazio(form, "fnRegistroNascimento")) {
			msgErro += "<li style='margin-bottom: 5px;'>Registro de Nascimento</li>";
		} 
		
		var totalDependentes = form.getChildrenIndexes("dependentes");
		for (var i = 0; i < totalDependentes.length; i++) {
			if(campoVazio(form, "dependenteNome___" + totalDependentes[i])){
				msgErro += "<li style='margin-bottom: 5px;'>Informe o campo Nome na linha " +(i+1) + " da tabela</li>";
			}
			if(campoVazio(form, "fnRegistroNascDep___" + totalDependentes[i])){
				msgErro += "<li style='margin-bottom: 5px;'>Informe o campo Registro de Nascimento na linha " +(i+1) + " da tabela</li>";
			}
		}
	}


	if (msgErro != "") {
		msgErro = "<ul style='padding-left: 17px;color: red;list-style: disc;'>" + msgErro + "</ul><br/>";
		exibirMensagem(form, "Favor informar os campos obrigatórios:<br/><br/>" + msgErro);
	}

}


function campoVazio(form, fieldname) {
	if ((form.getValue(fieldname) == null) || (form.getValue(fieldname) == undefined) || (form.getValue(fieldname).trim() == "")) {
		return true;
	}
	return false;
}

function exibirMensagem(form, mensagem) {
	var mobile = form.getMobile() != null && form.getMobile();

	if (mobile) {
		throw mensagem;
	} else {
		throw "<br/><strong>Atenção:</strong> " + mensagem;
	}
}
