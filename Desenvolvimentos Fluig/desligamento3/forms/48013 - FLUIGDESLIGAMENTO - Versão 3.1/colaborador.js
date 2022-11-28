$(document).on("ready", function() {

	var data = new Date();
	var task = getWKNumState();
	//$("#nomeSolicitante").val(getWKUserName());

});


function zoomSetor(obj) {

	var type = $(obj).prev("input").attr("name");
	var filters = "";
	var searchby = "FILTRO";

	tdizoom.open(
			"vagas_buscar_setor", //Nome do Dataset
			"DESCRICAO,Descrição", //Campos a serem exibidos
			"DESCRICAO", //Campos de retorno
			"SETORES", //Titulo
			filters, //Filtros
			type, //Type (deve ser sempre o atributo name do campo)
			null, //likefield
			null, //likevalue
			searchby //Campo/Constraint que será buscado o conteudo digitado (Seachby)
	);

}

function zoomEpi(obj) {	
    var type = $(obj).prev("input").attr("name");
    var filters = "";
    var searchby = "FILTRO";
    
    tdizoom.open(
		"vagas_buscar_epis", //Nome do Dataset
		"DESCRICA,Descrição", //Campos a serem exibidos
		"DESCRICA", //Campos de retorno
		"EPIS", //Titulo
        filters,
        type,
        null,
        null,
        searchby
    );
}

function zoomSetor(obj) {

	var type = $(obj).prev("input").attr("name");
	var filters = "";
	var searchby = "FILTRO";

	tdizoom.open(
			"vagas_buscar_setor", //Nome do Dataset
			"DESCRICAO,Descrição", //Campos a serem exibidos
			"DESCRICAO", //Campos de retorno
			"Setores", //Titulo
			filters, //Filtros
			type, //Type (deve ser sempre o atributo name do campo)
			null, //likefield
			null, //likevalue
			searchby //Campo/Constraint que será buscado o conteudo digitado (Seachby)
	);

}
function zoomContrato(obj) {

	var type = $(obj).prev("input").attr("name");
	var filters = "";
	var searchby = "FILTRO";

	tdizoom.open(
			"armazem_buscar_centro_custo", //Nome do Dataset
			"DESCRICAO,Descrição", //Campos a serem exibidos
			"DESCRICAO", //Campos de retorno
			"Contratos", //Titulo
			filters, //Filtros
			type, //Type (deve ser sempre o atributo name do campo)
			null, //likefield
			null, //likevalue
			searchby //Campo/Constraint que será buscado o conteudo digitado (Seachby)
	);

}



function zoomCargo(obj) {
	var type = $(obj).prev("input").attr("name");
	var filters = "";
	var searchby = "FILTRO";

	tdizoom.open(
			"vagas-buscar-cargos", //Nome do Dataset
			"DESCRICAO, Descrição", //Campos a serem exibidos
			"DESCRICAO", //Campos de retorno
			"Contratos", //Titulo
			filters, //Filtros
			type, //Type (deve ser sempre o atributo name do campo)
			null, //likefield
			null, //likevalue
			searchby //Campo/Constraint que será buscado o conteudo digitado (Seachby)
	);

}

function setSelectedZoomItem(selectedItem) {
	var name = selectedItem.type.split("___")[0];
	var indice = selectedItem.type.split("___")[1];
	
	if(name=="descricaoSetor"){
		$("#descricaoSetor").val(selectedItem.DESCRICAO);
		$("#codigoSetor").val(selectedItem.DESCRICAO);
	}else if(name=="descricaoContrato"){
		$("#descricaoContrato").val(selectedItem.DESCRICAO);
		$("#codContrato").val(selectedItem.DESCRICAO);
	}
/*
	if (name == "descricaoS") {			

		$("#descricaoS").val(selectedItem.DESCRICAO);
		$("#codsetor").val(selectedItem.DESCRICAO);
	} else if (name == "descontrato") {
		$("#descontrato").val(selectedItem.DESCRICAO);
		$("#descontrato").val(selectedItem.DESCRICAO);
	} else if (name == "descargo") {
		$("#descargo").val(selectedItem.DESCRICAO);
	} else if (name == "descricaoEpi") {
		$("#descricaoEpi").val(selectedItem.DESCRICA);		
	}else if (name == "gastos") {

		adicionarItemGastos(selectedItem.codGasto, selectedItem.descrGasto, selectedItem.unidade)
	} else if (name == "classCuidado") {

		adicionarItemClassCuidado(selectedItem.Descr)
	} else if (name == "lote") {
		$("#lote___" + indice).val(selectedItem.B8_LOTECTL);
	}*/
}


function removedZoomItem(selectedItem) {

	if (selectedItem == "nacionalidade") {

		$("#nacionalidade").val("");
		$("#nacionalidadeCodigo").val("");
	} else if (selectedItem == "AeroportoOrigem") {

		$("#AeroportoOrigem").val("")
	} else if (selectedItem == "CompanhiaAerea") {

		$("#CompanhiaAerea").val("")
	}

}