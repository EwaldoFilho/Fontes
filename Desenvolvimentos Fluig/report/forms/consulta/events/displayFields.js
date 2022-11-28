function displayFields(form,customHTML){ 
	
	//form.setValue("dataInicial", "01/01/2022"); // iniciando a data a partir da data de modificação do formulário com inclusão da MP para sol de gratificação por substituição
	//form.setValue("dataFinal", dataAtual());//informando sempre a data atual como data final da pesquisa 
	//form.setValue("solicitacaoInicial", "3586"); 
	//form.setValue("solicitacaoFinal", "3592");
	var currentUser = fluigAPI.getUserService().getCurrent().getCode();
	form.setValue("userID", currentUser);
}

 function dataAtual() {
    var data = new Date();
    var dia = data.getDate();
    var mes = data.getMonth() + 1;
    var ano = data.getFullYear();
  
    dia = (dia <= 9 ? "0" + dia : dia);
    mes = (mes <= 9 ? "0" + mes : mes);
  
    var newData = dia + "/" + mes + "/" + ano;
  
    return newData;
  }