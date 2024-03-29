$(document).on("ready", function() {

	var data = new Date();

	$("#processo").val(getWKNumProces());

});

function fieldDetails() {
}


function zoomCustoBen(obj) {
	var type = "custoBen"
	/* var type = $(obj).prev("input").attr("name"); */
	var Local = $("#codFilialBen").val();
	var FILIAL = Local.substring(0,2);
	var filters = "FILIAL," + FILIAL;
	var searchby = "FILTRO";
	var state = $("#processo").val();

	// FLUIGIP.TABLE.clearTable("itensTabelaRateio")
	$("#qtdCusto").val(0);
	// $("#codCentroCustoForn").val("");
	// $("#descricaoForn").val("");
	if (state == "0") {
		tdizoomCheck.open("DsCustoForn2", // Nome do Dataset
		"CTT_CUSTO,Codigo,CTT_DESC01,Descricao", // Campos a serem exibidos
		"CTT_CUSTO,CTT_DESC01", // Campos de retorno
		"Centro de Custo", // Titulo
		filters, // Filtros
		type, // Type (deve ser sempre o atributo name do campo)
		null, // likefield
		null, // likevalue
		searchby // Campo/Constraint que será buscado o conteudo digitado
		// (Seachby)
		);
		// limpa campos vinculados ao centro de custo

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
function zoomEmpresaSol(obj) {
	var type = $(obj).prev("input").attr("name");
	var filters = "";
	var searchby = "FILTRO";
	var state = $("#processo").val();

	if (state == "0") {
		tdizoom.open("armazem_buscar_filial", // Nome do Dataset
		"FILIAL,Filial,DESCRICAOFILIAL,Descrição", // Campos a serem exibidos
		"FILIAL,DESCRICAOFILIAL", // Campos de retorno
		"Empresa/Filial", // Titulo
		filters, // Filtros
		type, // Type (deve ser sempre o atributo name do campo)
		null, // likefield
		null, // likevalue
		searchby // Campo/Constraint que será buscado o conteudo digitado
		// (Seachby)
		);
	}
}
function zoomBanco(obj) {
	var type = $(obj).prev("input").attr("name");
	var filters = "";
	var searchby = "FILTRO";
	var state = $("#processo").val();

	if (state == "0") {
		tdizoom.open("febraban", // Nome do Dataset
		"name,Banco", // Campos a serem
		// exibidos
		"name", // Campos de retorno
		"Banco", // Titulo
		filters, // Filtros
		type, // Type (deve ser sempre o atributo name do campo)
		null, // likefield
		null, // likevalue
		searchby // Campo/Constraint que será buscado o conteudo digitado
		// (Seachby)
		);
	}

}


function zoomCustoSol(obj) {
	var type = $(obj).prev("input").attr("name");
	var filial = $("#codFilial").val();
	var filters = "FILIAL," + filial;
	var searchby = "FILTRO";
	var state = $("#processo").val();

	if (state == "0") {
		tdizoom.open("armazem_buscar_centro_custo", // Nome do Dataset
		"CUSTO,Custo,DESCRICAO,Descrição,LOCAL,Armazém", // Campos a serem
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
function zoomEmpresaBen(obj) {
	var type = $(obj).prev("input").attr("name");
	var filters = "";
	var searchby = "FILTRO";
	var state = $("#processo").val();

	if (state == "0") {
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
	if (name == "nome") {
		$("#nome").val(selectedItem.NOME);
	} else if (name == "Custo") {
		$("#Custo").val(selectedItem.CUSTO);
	} else if (name == "descricao") {
		$("#descricao").val(selectedItem.DESCRICAO);
		$("#codCentroCusto").val(selectedItem.CUSTO);
		$("#codArmazem").val(selectedItem.LOCAL);
	} else if (name == "empresa") {
		$("#empresa").val(selectedItem.DESCRICAOFILIAL);
		$("#codFilial").val(selectedItem.FILIAL);
	} else if (name == "custoBen") {
		adicionarRateioCusto(selectedItem.CTT_CUSTO, selectedItem.CTT_DESC01)
	} else if (name == "empresaBen") {
		$("#empresaBen").val(selectedItem.M0_FILIAL);
		$("#codFilialBen").val(selectedItem.M0_CODFIL);
	} else if (name == "empresa") {
		$("#empresa").val(selectedItem.CUSTO);
		$("#codFilial").val(selectedItem.FILIAL);
	} else if (name == "banco") {
		$("#banco").val(selectedItem.name);
		}
}

function removedZoomItem(selectedItem) {
	if (selectedItem == "bancoBen") {

		$("#banco").val("");

	} else if (selectedItem == "nameUser") {

		$("#nameUser").val("")
	} else if (selectedItem == "Custo") {

		$("#Custo").val("")
	}

}
