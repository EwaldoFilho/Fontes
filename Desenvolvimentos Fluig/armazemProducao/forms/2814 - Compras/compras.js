$(document).on("ready", function() {
    
	var data = new Date();

    $("#processo").val(getWKNumProces());
   
//   $("#nameUser").val(getWKUserName());    
});



function fieldDetails(){
}


function zoomProdutoModal(obj) {	
    var type = $(obj).prev("input").attr("name");
    var filters = "";
    var searchby = "FILTRO";
    
    tdizoom.open(
        "armazem_buscar_produtos",
        "CODIGO,Código,DESCRICAO,Descrição,UNIDADE,Unidade",
        "CODIGO,DESCRICAO",
        "Buscar Produtos",
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
        "armazem_buscar_produtos", //Nome do Dataset
        "CODIGO,Código,DESCRICAO,Descrição,UNIDADE,Unidade",  //Campos a serem exibidos
        "CODIGO,DESCRICAO,UNIDADE", //Campos de retorno
        "Produto", //Titulo
        filters, //Filtros
        type, //Type (deve ser sempre o atributo name do campo)
        null, //likefield
        null, //likevalue
        searchby //Campo/Constraint que será buscado o conteudo digitado (Seachby)
    );

}

function zoomnameUser(obj) {	
    var type = $(obj).prev("input").attr("name");
    var filters = "";
    var searchby = "FILTRO";
    
    tdizoom.open(
        "buscar_usuarios", //Nome do Dataset
        "NOME,Nome",  //Campos a serem exibidos
        "NOME", //Campos de retorno
        "Dados do usuario", //Titulo
        filters, //Filtros
        type, //Type (deve ser sempre o atributo name do campo)
        null, //likefield
        null, //likevalue
        searchby //Campo/Constraint que será buscado o conteudo digitado (Seachby)
    );

}
function zoomFilial(obj) {	
    var type = $(obj).prev("input").attr("name");
    var filters = "";
    var searchby = "FILTRO";
    
    tdizoom.open(
        "tetesprotheus", //Nome do Dataset
        "FILIAL,Filial,CUSTO,Custo,DESCRICAO,Descrição",//Campos a serem exibidos
        "CUSTO, FILIAL", //Campos de retorno
        "Filial", //Titulo
        filters, //Filtros
        type, //Type (deve ser sempre o atributo name do campo)
        null, //likefield
        null, //likevalue
        searchby //Campo/Constraint que será buscado o conteudo digitado (Seachby)
    );

}

function zoomCusto(obj) {
    var type = $(obj).prev("input").attr("name");
    var filial = $("#codFilial").val();
    var filters = "FILIAL," + filial;
    var searchby = "FILTRO";
    
    tdizoom.open(
        "armazem_buscar_centro_custo", //Nome do Dataset
        "CUSTO,Custo,DESCRICAO,Descrição,LOCAL,Armazém",  //Campos a serem exibidos
        "CUSTO,DESCRICAO,LOCAL", //Campos de retorno
        "Centro de Custo", //Titulo
        filters, //Filtros
        type, //Type (deve ser sempre o atributo name do campo)
        null, //likefield
        null, //likevalue
        searchby //Campo/Constraint que será buscado o conteudo digitado (Seachby)
    );
}

function zoomEmpresa(obj) {
    var type = $(obj).prev("input").attr("name");
    var filters = "";
    var searchby = "FILTRO";
    
    tdizoom.open(
    "armazem_buscar_filial", //Nome do Dataset
    "FILIAL,Filial,DESCRICAOFILIAL,Descrição", //Campos a serem exibidos
    "FILIAL,DESCRICAOFILIAL", //Campos de retorno
    "Empresa/Filial", //Titulo
    filters, //Filtros
    type, //Type (deve ser sempre o atributo name do campo)
    null, //likefield
    null, //likevalue
    searchby //Campo/Constraint que será buscado o conteudo digitado (Seachby)
    );
    
    //limpa campos vinculados ao centro de custo
    $("#codArmazem").val("");
    $("#codCentroCusto").val("");
    $("#codArmazem").val("");
}

function setSelectedZoomItem(selectedItem){
    var name = selectedItem.type.split("___")[0];
    var indice = selectedItem.type.split("___");
    // "CODIGO,DESCRICAO",
    if(name == "produto"){
    $("#produto").val(selectedItem.DESCRICAO);
    $("#produtoCodigo").val(selectedItem.CODIGO);
    }else if(name == "nome"){
    $("#nome").val(selectedItem.NOME);
    }else if(name == "Custo"){
    $("#Custo").val(selectedItem.CUSTO);
    }else if(name == "descricao"){
	    $("#descricao").val(selectedItem.DESCRICAO);
	    $("#codCentroCusto").val(selectedItem.CUSTO);
	    $("#codArmazem").val(selectedItem.LOCAL);
    }else if(name == "empresa"){
    	$("#empresa").val(selectedItem.DESCRICAOFILIAL);
    	$("#codFilial").val(selectedItem.FILIAL);
    }else if(name == "tipoAtendimento"){
    adicionarItemTipoAtendimento(selectedItem.codigo,selectedItem.Descr)
    }else if(name == "gastos"){
    adicionarItemGastos(selectedItem.codGasto,selectedItem.descrGasto,selectedItem.unidade)
    }else if(name == "filial"){
    $("#filial").val(selectedItem.CUSTO);
    $("#codFilial").val(selectedItem.FILIAL);
    }else if(name == "produtoModal"){
    $("#codigoProdutoModal").val(selectedItem.CODIGO);
    $("#produtoModal").val(selectedItem.DESCRICAO);
    }
    }

function removedZoomItem(selectedItem){
	if(selectedItem == "produto"){
    	
    	$("#produto").val("");
    	$("#produtoCodigo").val("");
  
	 }else if(selectedItem == "nameUser"){
	    	
	    	$("#nameUser").val("")
	    }else if(selectedItem == "Custo"){
	    	
	    	$("#Custo").val("")
	    }
		
}
