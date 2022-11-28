function validateForm(form){
	var state = getValue('WKNumState');
	var PROXIMATIVIDADE = Number(getValue("WKNextState"));
	
	if( PROXIMATIVIDADE =="502" || PROXIMATIVIDADE =="124" || PROXIMATIVIDADE =="472" || PROXIMATIVIDADE =="537"){

		if ((form.getValue("motivoCancelamento") == null || form.getValue("motivoCancelamento") == "")) {
			throw "INFORMAR O MOTIVO DO CANCELAMENTO.";
				}
	}
		
	//validação dos campos obrigatórios na abbertura da solicitação
	/*if ((form.getValue("grupo") == null || form.getValue("grupo") ==  "") && ( getValue('WKNumProces') == null ||
			(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
		throw "Informe um grupo.";
	}*/

	if ((form.getValue("codCentroCusto") == null || form.getValue("codCentroCusto") ==  "") && ( getValue('WKNumProces') == null ||
			(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
				throw "Informe um centro de custo através da pesqusisa.";
	}

	if ((form.getValue("descricao") == null || form.getValue("descricao") ==  "") && ( getValue('WKNumProces') == null ||
	(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
		throw "Informe o centro de custo.";
	}
	
	if ((form.getValue("empresa") == null || form.getValue("empresa") ==  "") && ( getValue('WKNumProces') == null ||
			(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
				throw "Informe a empresa.";
	}

	if (form.getValue("listaProdutos") == ""){
	     throw "Informe ao menos um produto";
	   }  
	if ((form.getValue("justificativa") == null || form.getValue("justificativa") ==  "") && ( getValue('WKNumProces') == null ||
			(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
				throw "Informe uma Justificativa";
	}
	if ((form.getValue("prazoEntrega") == null || form.getValue("prazoEntrega") ==  "") && ( getValue('WKNumProces') == null ||
			(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
				throw "Informar o Prazo para Entrega.";
	}
	
	//Bloqueia botão enviar na atividade 'em atendimento'
	if(state=="550"){
		throw "O processo não pode ser movido, pois essa movimentação é feita no Protheus!"; 
	} 

	//Validação dos campos obrigatórios em outros estados	
	if(state=="433"){
		if (form.getValue("contatoJuridico") == "" && form.getValue("validacaoJuridico") == "sim") {
			throw "Informe o contato.";
		}
		
		if (form.getValue("prazoJuridico") == ""  && form.getValue("validacaoJuridico") == "sim") {
			throw "Informe o prazo estimado para validar o contrato.";
		}
	}
	
	if (state=="511") {
		var quantidadeServicos = form.getValue("countValidaInputServico");		
		//Verifica se os campos são vazios
		for (var count = 0;  count <  quantidadeServicos; count++) {
			if (form.getValue("dataInicioExecucaoServico_"+count) == "") {
				throw "Informe o início da execução do serviço.";
			}	
			
			if (form.getValue("dataFimExecucaoServico_"+count) == "") {
				throw "Informe a data do término da execução do serviço.";
			}	
		}				
	}
	
	if (state=="514") {
		var quantidadeServicos = form.getValue("countValidaInputServico");		
		//Verifica se os campos são vazios
		for (var count = 0;  count <  quantidadeServicos; count++) {
			if (form.getValue("dataInicioExecucaoServico_"+count) == "") {
				throw "Informe o início da execução do serviço.";
			}	
			
			if (form.getValue("dataFimExecucaoServico_"+count) == "") {
				throw "Informe a data do término da execução do serviço.";
			}	
		}				
	}
}