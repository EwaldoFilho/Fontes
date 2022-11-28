$(document).on("ready", function() {
});

function fieldDetails(){
}

function zoomCusto(obj) {	
    var type = $(obj).prev("input").attr("name");
    var filial = "0101";
    var filters = "";
    var searchby = "FILTRO";
    
    tdizoom.open(
        "vagas_buscar_contratos", //Nome do Dataset
        "CENTROCUSTO,Custo,DESCRICAO,Descrição",  //Campos a serem exibidos
        "CENTROCUSTO,DESCRICAO", //Campos de retorno
        "Centro de Custo", //Titulo
        filters, //Filtros
        type, //Type (deve ser sempre o atributo name do campo)
        null, //likefield
        null, //likevalue
        searchby //Campo/Constraint que será buscado o conteudo digitado (Seachby)
    );
}


function setSelectedZoomItem(selectedItem){
	 	var name = selectedItem.type.split("___")[0];
	    var indice = selectedItem.type.split("___");

	    
	    if(name == "centroCusto"){
	        $("#centroCusto").val(selectedItem.DESCRICAO);
	        $("#codCentroCusto").val(selectedItem.CENTROCUSTO);
	    }
}

function removedZoomItem(selectedItem){
}
