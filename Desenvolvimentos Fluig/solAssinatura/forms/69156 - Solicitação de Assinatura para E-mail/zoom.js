function zoomCusto(obj) {
	var type = $(obj).prev("input").attr("name");
	var filters = "";
	var searchby = "FILTRO";
	var state = $("#ativAtual").val();
	
		
	if(state == null || state == 0 || state == 4 || state == '')
    {
	tdizoom.open(
	"DsCustoForn", //Nome do Dataset
	"CTT_CUSTO,Custo,CTT_DESC01,Descrição", //Campos a serem exibidos
	"CTT_CUSTO,CTT_DESC01", //Campos de retorno
	"Centro de Custo", //Titulo
	filters, //Filtros
	type, //Type (deve ser sempre o atributo name do campo)
	null, //likefield
	null, //likevalue
	searchby //Campo/Constraint que será buscado o conteudo digitado (Seachby)
	);
	}

}

function zoomFuncao(obj) {
	var type = $(obj).prev("input").attr("name");
	var filters = "";
	var searchby = "FILTRO";
	var state = $("#ativAtual").val();
	
		
	if(state == null || state == 0 || state == 4 || state == '')
    {
	tdizoom.open(
	"vagas-buscar-cargos", //Nome do Dataset
	"DESCRICAO,Descrição", //Campos a serem exibidos
	"DESCRICAO", //Campos de retorno
	"Cargos", //Titulo
	filters, //Filtros
	type, //Type (deve ser sempre o atributo name do campo)
	null, //likefield
	null, //likevalue
	searchby //Campo/Constraint que será buscado o conteudo digitado (Seachby)
	);
	}

}


function setSelectedZoomItem(selectedItem){
    var name = selectedItem.type.split("___")[0];
    var indice = selectedItem.type.split("___");
    // "CODIGO,DESCRICAO",
    if(name == "centroCusto"){
    $("#codCentroCusto").val(selectedItem.CTT_CUSTO);
    $("#centroCusto").val(selectedItem.CTT_DESC01);
    }else if(name == "funcao"){
    	$("#funcao").val(selectedItem.DESCRICAO);
    }
    else{
        $("#codCentroCusto").val(null);
        $("#centroCusto").val(null);
        $("#funcao").val(null);
    }
    }
	
function removedZoomItem(selectedItem) {
	if (selectedItem == "centroCusto") {

		$("#centroCusto").val("");
		$("#codCentroCusto").val("");

	}else if (selectedItem == "funcao") {

		$("#funcao").val("");

	} 
}


