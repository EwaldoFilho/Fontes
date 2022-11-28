function validateForm(form) {		
	var state = getValue('WKNumState');
	
	if(state == 0){
		if (form.getValue("nomeSolicitante") == null || form.getValue("nomeSolicitante") ==  "") {
			throw "Informe o nome do solicitante.";
		}
		
		if (form.getValue("centroCusto") == null || form.getValue("centroCusto") ==  "") {
			throw "Informe o centro de custo.";
		}
		
		if (form.getValue("valorRecarga") == null || form.getValue("valorRecarga") ==  "") {
			throw "Informe o valor da recarga.";
		}
		
		if (form.getValue("justificativaRecarga") == null || form.getValue("justificativaRecarga") ==  "") {
			throw "Informe a justificativa.";
		}
		
		if (form.getValue("formaPagamento") == null || form.getValue("formaPagamento") ==  "") {
			throw "Informe a forma de pagamento.";
		}
		
		//forma de pagamento deposito
		if (form.getValue("formaPagamento") == "deposito") {
			if (form.getValue("banco") == "" || form.getValue("tipoConta") == "" ||
				form.getValue("agencia") == "" || form.getValue("agenciaDV") == "" ||
				form.getValue("conta") == "" || form.getValue("contaDV") == "") {
					throw "Informe os dados bancários.";	
			}		
		}
		
		//forma de pagamento pix
		if (form.getValue("formaPagamento") == "pix") {
			if (form.getValue("chavePix") == "" || form.getValue("chavePix") == null) {
				throw "Informe o tipo da chave.";	
			}
			if (form.getValue("chavePix") == "cpf" && form.getValue("cpf") == "") {
					throw "Informe o CPF.";	
			}else if (form.getValue("chavePix") == "cnpj" && form.getValue("cnpj") == "") {
					throw "Informe o CNPJ.";	
			}else if (form.getValue("chavePix") == "email" && form.getValue("email") == "") {
					throw "Informe o e-mail.";	
			}else if (form.getValue("chavePix") == "telefone" && form.getValue("telefone") == "") {
					throw "Informe o telefone.";	
			}else if (form.getValue("chavePix") == "chaveAleatoria" && form.getValue("chaveAleatoria") == "") {
					throw "Informe a chave aleatória.";	
			}		
		}
		
		if (form.getValue("gerenteContrato") == null || form.getValue("gerenteContrato") ==  "") {
			throw "Usuário não vinculado no grupo gerente de contrato e nem possui responsável! Entrar em contato com a TI.";
		}
	}
}