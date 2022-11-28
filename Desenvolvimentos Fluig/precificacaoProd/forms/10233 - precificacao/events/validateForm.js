function validateForm(form){
var state = getValue('WKNumState');

//validação dos campos obrigatórios na abbertura da solicitação
/*if ((form.getValue("grupo") == null || form.getValue("grupo") == "") && ( getValue('WKNumProces') == null ||
(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
throw "Informe um grupo.";
}*/



if ((form.getValue("nomeCliente") == null || form.getValue("nomeCliente") == "") && ( getValue('WKNumProces') == null ||
(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
throw "Informe o nome do cliente.";
}



if ((form.getValue("objeto") == null || form.getValue("objeto") == "") && ( getValue('WKNumProces') == null ||
(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
throw "Informe o objeto da precificação.";
}



if ((form.getValue("prazoCadastro") == null || form.getValue("prazoCadastro") == "") && ( getValue('WKNumProces') == null ||
		(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
		throw "infome um prazo da proposta.";
		}



if ((form.getValue("previsao") == null || form.getValue("previsao") == "") && ( getValue('WKNumProces') == null ||
		(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
		throw "informe previsao de envio.";
		}
//if(form.getValue('nomecheckbox') == null || form.getValue('nomecheckbox') == '')

//	   throw "Selecione o checkbox";

//Bloqueia botão enviar na atividade 'em atendimento'
//if(state=="54"){
//throw "O processo não pode ser movido, pois essa movimentação é feita no Protheus!";
//}



//Validação dos campos obrigatórios em outros estados


	
//Verifica se os campos são vazios
}
/*
for (var count = 0; count < quantidadeServicos; count++) {
if (form.getValue("dataInicioExecucaoServico_"+count) == "") {
throw "Informe o início da execução do serviço.";

if (form.getValue("dataFimExecucaoServico_"+count) == "") {
throw "Informe a data do término da execução do serviço.";
}
}
}

if (state=="514") {
var quantidadeServicos = form.getValue("countValidaInputServico");
//Verifica se os campos são vazios
for (var count = 0; count < quantidadeServicos; count++) {
if (form.getValue("dataInicioExecucaoServico_"+count) == "") {
throw "Informe o início da execução do serviço.";
}

if (form.getValue("dataFimExecucaoServico_"+count) == "") {
throw "Informe a data do término da execução do serviço.";
}
}
}*/
