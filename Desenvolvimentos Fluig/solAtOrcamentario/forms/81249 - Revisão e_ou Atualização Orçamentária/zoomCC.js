$(document).on("ready", function() {

	var data = new Date();

	$("#processo").val(getWKNumProces());

});

function fieldDetails() {
}


function zoomnameUser(obj) {
	var type = $(obj).prev("input").attr("name");
	var filters = "";
	var searchby = "FILTRO";
	var state = $("#ativAtual").val();

	if (state == "0" || state == "4" ) {
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

function zoomCustoAlterar(obj) {
	var type = $(obj).prev("input").attr("name");
	var filial = $("#codFilial").val();
	var filters = "FILIAL," + filial;
	var searchby = "FILTRO";
	var state = $("#ativAtual").val();

	if (state == "0" || state == "4" ) {
		tdizoom.open("DsCustoForn", // Nome do Dataset
		"CTT_CUSTO,Custo,CTT_DESC01,Descrição", // Campos a serem
		// exibidos
		"CUSTO,DESCRICAO,LOCAL", // Campos de retorno
		"Centro de Custo", // Titulo
		filters, // Filtros
		type, // Type (deve ser sempre o atributo name do campo)
		null, // likefield
		null, // likevalue1
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
	var state = $("#ativAtual").val();

	if (state == "0" || state == "4" ) {
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
function zoomEmpresa(obj) {
	var type = $(obj).prev("input").attr("name");
	var filters = "";
	var searchby = "FILTRO";
	var state = $("#ativAtual").val();

	if (state == "0" || state =="4") {
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
	if (name == "centroCusto") {
		$("#codCentroCusto").val(selectedItem.CTT_CUSTO);
		$("#centroCusto").val(selectedItem.CTT_DESC01)
	} else if (name == "custoAlterar") {
		$("#codCustoA").val(selectedItem.CTT_CUSTO);
		$("#custoAlterar").val(selectedItem.CTT_DESC01);
	}
}

function removedZoomItem(selectedItem) {
	if (selectedItem == "custoAlterar") {

		$("#codCustoA").val("");
		$("#custoAlterar").val("");		
		
	}  else if (selectedItem == "centroCusto") {

		$("#centroCusto").val("");
		$("#codCentroCusto").val("");
	}

}
