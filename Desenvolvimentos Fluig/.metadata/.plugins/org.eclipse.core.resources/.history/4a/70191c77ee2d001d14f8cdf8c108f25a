function validateForm(form){
	
	var msgErro = "";
	
	if (campoVazio(form, "solicitante")) {
	
			msgErro += "<li style='margin-bottom: 5px;'>Informe a Filial desejada</li>";
	}
	
	// formatação da mensgem em lista e título da lista --------------------------------------------------
	if (msgErro != "") {

		msgErro = "<ul style='padding-left: 17px;color: red;list-style: disc;'>" + msgErro + "</ul><br/>";
		exibirMensagem(form, "Favor informar os campos obrigatórios:<br/><br/>" + msgErro);
	}
}

// função para exibição de mensagem personalizada para ambiente mobile
function exibirMensagem(form, mensagem) {
	var mobile = form.getMobile() != null && form.getMobile();

	if (mobile) {
		throw mensagem;
	} else {
		throw "<br/><strong>Atenção:</strong> " + mensagem;
	}
}