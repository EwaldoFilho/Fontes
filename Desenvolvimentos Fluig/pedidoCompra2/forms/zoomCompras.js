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
		tdizoom.open("DsFornecedores", // Nome do Dataset
		"A2_COD,Codigo,A2_NOME,Fornecedor,A2_LOJA,Loja,A2_CGC,CNPJ/CPF", // Campos
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
function zoomCustoForn(obj) {
	var type = "custoForn"
	/* var type = $(obj).prev("input").attr("name"); */
	var Local = $("#codFilialForn").val();
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
function zoomEmpresaForn(obj) {
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
function zoomFormaPg(obj) {
	var type = "descricaoPag";
	var filters = "";
	var searchby = "FILTRO";
	var state = $("#processo").val();

	if (state == "0") {
		tdizoom.open("Ds-Pagamento", // Nome do Dataset
		"X5_CHAVE,Codigo,X5_DESCRI,Descrição", // Campos a serem exibidos
		"X5_CHAVE,X5_DESCRI", // Campos de retorno
		"Forma de Pagamento", // Titulo
		filters, // Filtros
		type, // Type (deve ser sempre o atributo name do campo)
		null, // likefield
		null, // likevalue
		searchby // Campo/Constraint que será buscado o conteudo digitado
		// (Seachby)
		);

	}
}
function zoomNatureza(obj) {
	var type = "descricaoNat";
	var filters = "";
	var searchby = "FILTRO";
	var state = $("#processo").val();

	if (state == "0") {
		tdizoom.open("Ds-NaturezaFinanceiro", // Nome do Dataset
		"ED_CODIGO,Codigo,ED_DESCRIC,Descrição", // Campos a serem exibidos
		"ED_CODIGO,ED_DESCRIC", // Campos de retorno
		"Natureza do Pagamento", // Titulo
		filters, // Filtros
		type, // Type (deve ser sempre o atributo name do campo)
		null, // likefield
		null, // likevalue
		searchby // Campo/Constraint que será buscado o conteudo digitado
		// (Seachby)
		);

	}
}

function setSelectedZoomItem(selectedItem) {
	var name = selectedItem.type.split("___")[0];
	var indice = selectedItem.type.split("___");
	// "CODIGO,DESCRICAO",
	if (name == "fornecedor") {
		$("#fornecedor").val(selectedItem.A2_NOME);
		$("#codFornecedor").val(selectedItem.A2_COD);
		$("#lojaFornecedor").val(selectedItem.A2_LOJA);
		$("#cnpjFornecedor").val(selectedItem.A2_CGC);
	} else if (name == "nome") {
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
	} else if (name == "custoForn") {
		adicionarRateioCusto(selectedItem.CTT_CUSTO, selectedItem.CTT_DESC01)
	} else if (name == "empresaForn") {
		$("#empresaForn").val(selectedItem.M0_FILIAL);
		$("#codFilialForn").val(selectedItem.M0_CODFIL);
	} else if (name == "descricaoPag") {
		$("#codPagamento").val(selectedItem.X5_CHAVE);
		$("#descricaoPag").val(selectedItem.X5_DESCRI);
	} else if (name == "descricaoNat") {
		$("#codNatureza").val(selectedItem.ED_CODIGO);
		$("#descricaoNat").val(selectedItem.ED_DESCRIC);
	} else if (name == "empresa") {
		$("#empresa").val(selectedItem.CUSTO);
		$("#codFilial").val(selectedItem.FILIAL);
	}
}

function removedZoomItem(selectedItem) {
	if (selectedItem == "produto") {

		$("#produto").val("");
		$("#produtoCodigo").val("");

	} else if (selectedItem == "nameUser") {

		$("#nameUser").val("")
	} else if (selectedItem == "Custo") {

		$("#Custo").val("")
	}

}
