function beforeTaskSave(colleagueId, nextSequenceId){
    var state      = getValue("WKNumState");
    var nextAtv  = getValue("WKNextState");

    //validação dos campos obrigatórios na abbertura da solicitação

        

        if (hAPI.getCardValue("codCentroCusto") == null || hAPI.getCardValue("codCentroCusto") ==  "") {
            throw "Informe um centro de custo através da pesqusisa.";
        }

        if (hAPI.getCardValue("descricao") == null || hAPI.getCardValue("descricao") ==  "") {
            throw "Informe o centro de custo.";
        }

        if (hAPI.getCardValue("empresa") == null || hAPI.getCardValue("empresa") ==  "") {
            throw "Informe a empresa.";
        }

        if (hAPI.getCardValue("listaProdutos") == "" && hAPI.getCardValue('existeProdutoNovo') == "false") {
            throw "Informe ao menos um serviço ou então cadastre.";
        }


    
    //Validação dos campos obrigatórios em outros estados	
    
		
       

    if (state=="511") {
		var quantidadeServicos = hAPI.getCardValue("countValidaInputServico");		
		//Verifica se os campos são vazios
		for (var count = 0;  count <  quantidadeServicos; count++) {
			if (hAPI.getCardValue("dataInicioExecucaoServico_"+count) == "") {
				throw "Informe o início da execução do serviço.";
			}	
			
			if (hAPI.getCardValue("dataFimExecucaoServico_"+count) == "") {
				throw "Informe a data do término da execução do serviço.";
			}	
		}				
	}
	
	if (state=="514") {
		var quantidadeServicos = hAPI.getCardValue("countValidaInputServico");		
		//Verifica se os campos são vazios
		for (var count = 0;  count <  quantidadeServicos; count++) {
			if (hAPI.getCardValue("dataInicioExecucaoServico_"+count) == "") {
				throw "Informe o início da execução do serviço.";
			}	
			
			if (hAPI.getCardValue("dataFimExecucaoServico_"+count) == "") {
				throw "Informe a data do término da execução do serviço.";
			}	
		}				
	}
}