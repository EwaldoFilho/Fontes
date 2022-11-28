function validateForm(form){
var state = getValue('WKNumState');



if ((form.getValue("AdmiReal") == null || form.getValue("AdmiReal") == "") && ( getValue('WKNumProces') == null ||
		(getValue('WKNumProces') > 0 && getValue('WKNextState') == '210') )) {
		throw "informe a data de admissao real.";
		}



//validação dos campos obrigatórios na abbertura da solicitação
/*if ((form.getValue("grupo") == null || form.getValue("grupo") == "") && ( getValue('WKNumProces') == null ||
(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
throw "Informe um grupo.";
}*/


/*
if ((form.getValue("nomeSolicitante") == null || form.getValue("nomeSolicitante") == "") && ( getValue('WKNumProces') == null ||
(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
throw "Informe o nome do solicitante.";
}



if ((form.getValue("Contrato") == null || form.getValue("Contrato") == "") && ( getValue('WKNumProces') == null ||
(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
throw "Informe o contrato.";
}

if ((form.getValue("cargos") == null || form.getValue("cargos") == "") && ( getValue('WKNumProces') == null ||
(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
throw "Informe o cargo.";
}


if ((form.getValue("epi") == null || form.getValue("epi") == "") && ( getValue('WKNumProces') == null ||
		(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
		throw "Selecione um  epi.";
		}
if ((form.getValue("uniforme") == null || form.getValue("uniforme") == "") && ( getValue('WKNumProces') == null ||
		(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
		throw "Selecione um  uniforme.";
		}
if ((form.getValue("salario") == null || form.getValue("salario") == "") && ( getValue('WKNumProces') == null ||
		(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
		throw "informe o salario.";
		}
if ((form.getValue("tipocontratacao") == null || form.getValue("tipocontratacao") == "") && ( getValue('WKNumProces') == null ||
		(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
		throw "informe o tipo de contratação.";
		}
if ((form.getValue("sistemas") == null || form.getValue("sistemas") == "") && ( getValue('WKNumProces') == null ||
		(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
		throw "informe os sistemas para acessos.";
		}
if ((form.getValue("equipamentos") == null || form.getValue("equipamentos") == "") && ( getValue('WKNumProces') == null ||
		(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
		throw "informe os equipamentos.";
		}
*/
//Bloqueia botão enviar na atividade 'em atendimento'
//if(state=="54"){
//throw "O processo não pode ser movido, pois essa movimentação é feita no Protheus!";
//}



//Validação dos campos obrigatórios em outros estados
/*if(state=="12"){

if ((form.getValue("nomeFuncionario") == null || form.getValue("nomeFuncionario") == "") && ( getValue('WKNumProces') == null ||
		(getValue('WKNumProces') > 0 && getValue('WKNextState') == '210') )) {
		throw "informe os nome Funcionario.";
		}

if ((form.getValue("NumeroFuncionario") == null || form.getValue("NumeroFuncionario") == "") && ( getValue('WKNumProces') == null ||
		(getValue('WKNumProces') > 0 && getValue('WKNextState') == '210') )) {
		throw "informe os telefone do funcionario.";
		}



if ((form.getValue("estadoCivil") == null || form.getValue("estadoCivil") == "") && ( getValue('WKNumProces') == null ||
		(getValue('WKNumProces') > 0 && getValue('WKNextState') == '210') )) {
		throw "informe o estado civil do funcionario .";
		}
if ((form.getValue("maeColaborador") == null || form.getValue("maeColaborador") == "") && ( getValue('WKNumProces') == null ||
		(getValue('WKNumProces') > 0 && getValue('WKNextState') == '210') )) {
		throw "informe o nome da mae do colaborador .";
		}

if ((form.getValue("tipoSangue") == null || form.getValue("tipoSangue") == "") && ( getValue('WKNumProces') == null ||
		(getValue('WKNumProces') > 0 && getValue('WKNextState') == '210') )) {
		throw "informe o tipo sanguineo .";
		}

if ((form.getValue("rg") == null || form.getValue("rg") == "") && ( getValue('WKNumProces') == null ||
		(getValue('WKNumProces') > 0 && getValue('WKNextState') == '210') )) {
		throw "informe o rg .";
		}

if ((form.getValue("naturezaAso") == null || form.getValue("naturezaAso") == "") && ( getValue('WKNumProces') == null ||
		(getValue('WKNumProces') > 0 && getValue('WKNextState') == '210') )) {
		throw "informe o aso .";
		}

if ((form.getValue("email") == null || form.getValue("email") == "") && ( getValue('WKNumProces') == null ||
		(getValue('WKNumProces') > 0 && getValue('WKNextState') == '210') )) {
		throw "informe o email .";
		}

if ((form.getValue("perfil") == null || form.getValue("perfil") == "") && ( getValue('WKNumProces') == null ||
		(getValue('WKNumProces') > 0 && getValue('WKNextState') == '210') )) {
		throw "informe o perfil .";
		}



}


if (state=="116") {
	
	if ((form.getValue("codempresa") == null || form.getValue("codempresa") == "") && ( getValue('WKNumProces') == null ||
			(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
			throw "informe a  empresa .";
			}
	if ((form.getValue("grupo") == null || form.getValue("grupo") == "") && ( getValue('WKNumProces') == null ||
			(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
			throw "informe o  grupo .";
			}


if ((form.getValue("descricao1") == null || form.getValue("descricao1") == "") && ( getValue('WKNumProces') == null ||
		(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
		throw "Informe o centro de custo. .";
		}*/
	
//Verifica se os campos são vazios
//}
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
}
