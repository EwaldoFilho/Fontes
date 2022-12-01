$(document).on("ready", function() {

	var data = new Date();

	$("#processo").val(getWKNumProces());

});

function fieldDetails() {
}

function zoomFornecedor(obj) {
	var type = $(obj).prev("input").attr("name");
	var filters = "";
	var searchby = "FILTRO";
	var state = $("#processo").val();

	if (state == "0") {
		tdizoom.open("dsPJ", // Nome do Dataset
		"A2_COD,Codigo,A2_NOME,Fornecedor,A2_LOJA,Loja,A2_CGC,CNPJ/CPF,A2_EST,Estado", // Campos
		// a
		// serem
		// exibidos
		"A2_COD,A2_NOME,A2_LOJA,A2_CGC", // Campos de retorno
		"Fornecedor", // Titulo
		filters, // Filtros
		type, // Type (deve ser sempre o atributo name do campo)
		null, // likefield
		null, // likevalue
		searchby // Campo/Constraint que será buscado o conteudo digitado
		// (Seachby)
		);

	}
}

function zoomnameUser(obj) {
	var type = $(obj).prev("input").attr("name");
	var filters = "";
	var searchby = "FILTRO";

	if (state == "0") {
		tdizoom.open("buscar_usuarios", // Nome do Dataset
		"NOME,Nome", // Campos a serem exibidos
		"NOME", // Campos de retorno
		"Dados do usuario", // Titulo
		filters, // Filtros
		type, // Type (deve ser sempre o atributo name do campo)
		null, // likefield
		null, // likevalue
		searchby // Campo/Constraint que será buscado o conteudo digitado
		// (Seachby)
		);

	}
}
function zoomCusto(obj) {
	var type = $(obj).prev("input").attr("name");
	var filial = $("#codFilial").val();
	var filters = "FILIAL," + filial;
	var searchby = "FILTRO";
	var state = $("#processo").val();

	if (state == "0") {
		tdizoom.open("DsCustoForn", // Nome do Dataset
		"CTT_CUSTO,Custo,CTT_DESC01,Descrição", // Campos a serem
		// exibidos
		"CUSTO,DESCRICAO,LOCAL", // Campos de retorno
		"Centro de Custo", // Titulo
		filters, // Filtros
		type, // Type (deve ser sempre o atributo name do campo)
		null, // likefield
		null, // likevalue
		searchby // Campo/Constraint que será buscado o conteudo digitado
		// (Seachby)
		);
	}

}
function zoomEmpresaForn(obj) {
	var type = $(obj).prev("input").attr("name");
	var filters = "";
	var searchby = "FILTRO";
	var state = $("#solicitacao").val();

	if (state == "0" || state =="5") {
		tdizoom.open("Ds-Financeiro", // Nome do Dataset
		"M0_CODFIL,Filial,M0_FILIAL,Descrição", // Campos a serem exibidos
		"M0_CODFIL,M0_FILIAL", // Campos de retorno
		"Empresa/Filial", // Titulo
		filters, // Filtros
		type, // Type (deve ser sempre o atributo name do campo)
		null, // likefield
		null, // likevalue
		searchby // Campo/Constraint que será buscado o conteudo digitado
		// (Seachby)
		);

		// limpa campos vinculados ao centro de custo
		// $("#codArmazem").val("");
		// $("#codCentroCusto").val("");
		// $("#codArmazem").val("");
	}

}

function setSelectedZoomItem(selectedItem) {
	var name = selectedItem.type.split("___")[0];
	var indice = selectedItem.type.split("___");
	// "CODIGO,DESCRICAO",
	if (name == "fornecedor") {
		$("#fornecedor").val(selectedItem.A2_NOME);
		$("#estadoForn").val(selectedItem.A2_EST);		
		$("#cnpjFornecedor").val(selectedItem.A2_CGC);
		$("#codForn").val(selectedItem.A2_COD);
		$("#codLoja").val(selectedItem.A2_LOJA);		
	} 	else if (name == "centroCusto") {
		$("#codCentroCusto").val(selectedItem.CTT_CUSTO);
		$("#centroCusto").val(selectedItem.CTT_DESC01)
	} else if (name == "empresaForn") {
		$("#empresaForn").val(selectedItem.M0_FILIAL);
		$("#codFilialForn").val(selectedItem.M0_CODFIL);
	}
}

function removedZoomItem(selectedItem) {
	if (selectedItem == "fornecedor") {

		$("#fornecedor").val("");
		$("#estadoForn").val("");		
		$("#cnpjFornecedor").val("");
		$("#codForn").val("");
		$("#codLoja").val("");

	} else if (selectedItem == "nameUser") {

		$("#nameUser").val("")
	} else if (selectedItem == "Custo") {

		$("#Custo").val("")
	}

}
