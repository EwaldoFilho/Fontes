$(document).on("ready", function() {
	$("#processo").val(getWKNumProces());
	$("#estado").val(getWKNumProces());
});

function fieldDetails(){
}

function zoomProdutoModal(obj) {	
    var type = $(obj).prev("input").attr("name");
    var filters = "";
    var searchby = "FILTRO";
    
    tdizoom.open(
        "compras_buscar_produtos",
        "CODIGO,Código,DESCRICAO,Descrição,UNIDADE,Unidade",
        "CODIGO,DESCRICAO",
        "Selecione um produto",
        filters,
        type,
        null,
        null,
        searchby
    );

}

function zoomprodutos(obj) {	
    var type = $(obj).prev("input").attr("name");
    var filters = "";
    var searchby = "FILTRO";
    
    tdizoom.open(
        "compras_buscar_produtos", //Nome do Dataset
        "CODIGO,Código,DESCRICAO,Descrição,UNIDADE,Unidade",  //Campos a serem exibidos
        "CODIGO,DESCRICAO,UNIDADE", //Campos de retorno
        "Selecione um produto", //Titulo
        filters, //Filtros
        type, //Type (deve ser sempre o atributo name do campo)
        null, //likefield
        null, //likevalue
        searchby //Campo/Constraint que será buscado o conteudo digitado (Seachby)
    );

}

function zoomCusto(obj) {	
    var type = $(obj).prev("input").attr("name");
    var filters = "";
    var searchby = "FILTRO";
    
    tdizoom.open(
        "armazem_buscar_empresas", //Nome do Dataset
        "CUSTO,Custo,DESCRICAO,Descrição",  //Campos a serem exibidos
        "CUSTO,DESCRICAO", //Campos de retorno
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
    
    // input centro de custo
    if(name == "descricaoCentroCusto"){
        $("#descricaoCentroCusto").val(selectedItem.DESCRICAO);
        $("#codCentroCusto").val(selectedItem.CUSTO);
    }else if(name == "produtoModal"){
    	$("#codigoProdutoModal").val(selectedItem.CODIGO);
    	$("#produtoModal").val(selectedItem.DESCRICAO);
    }
}

function removedZoomItem(selectedItem){
	if(selectedItem == "descricaoCentroCusto"){
		$("#descricaoCentroCusto").val("");  
		$("#codCentroCusto").val("");
	}else if(selectedItem == "produtoModal"){
		$("#codigoProdutoModal").val("");
		$("#produtoModal").val("");
	}	
}
