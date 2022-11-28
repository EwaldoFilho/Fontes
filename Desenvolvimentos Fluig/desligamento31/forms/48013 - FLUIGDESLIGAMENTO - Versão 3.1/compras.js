


$(document).on("ready", function() {
    $("#processo").val(getWKNumProces());
    //$("#nomeAtendente").val(getWKUserName());
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

function zoomnameUser(obj) {	
    var type = $(obj).prev("input").attr("name");
    var filters = "";
    var searchby = "FILTRO";
    
    tdizoom.open(
        "armazem_buscar_empresas", //Nome do Dataset
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
    var filters = "FILIAL," + "0101";
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

function zoomColaboradores(obj) {
    var type = $(obj).prev("input").attr("name");
    var codCentroCusto = $("#codCentroCusto").val();
    var tpContrato = $("#tipocontrato").val()

    // var tipoContrato = $("#tipoContrato").val("TPCONTRATO");
    var filters = "COD," + codCentroCusto;
    var searchby = "FILTRO";
    if (tpContrato == "CLT") {
        tdizoom.open(
            "FUNC-VAGAS-BUCAS", //Nome do Dataset
            "NOME_COMPLETO,Nome,COD,COD,CATEGORIA,CATEGORIA,TPCONTRATO,TPCONTRATO,DDD,DDD,NUM_CEL,NUM_CEL,EMAIL,EMAIL,CPF,CPF,FUNCAO,FUNCAO,RG,RG",  //Campos a serem exibidos
            "NOME_COMPLETO,TPCONTRATO,DDD,NUM_CEL,EMAIL,CPF,FUNCAO,RG", //Campos de retorno
            "Colaboradores", //Titulo
            filters, //Filtros
            type, //Type (deve ser sempre o atributo name do campo)
            null, //likefield
            null, //likevalue
            searchby //Campo/Constraint que será buscado o conteudo digitado (Seachby)
        );
    }
    if (tpContrato == "PJ") {
        tdizoom.open(
            "dsZRA", //Nome do Dataset
            "ZRA_RESP,Nome,ZRA_DDD,DDD,ZRA_TEL,NUM_CEL,ZRA_EMAIL,EMAIL,ZRA_CPF,CPF",  //Campos a serem exibidos
            "ZRA_RESP,ZRA_DDD,ZRA_TEL,ZRA_EMAIL,ZRA_CPF", //Campos de retorno
            "Prestadores", //Titulo
            filters, //Filtros
            type, //Type (deve ser sempre o atributo name do campo)
            null, //likefield
            null, //likevalue
            searchby //Campo/Constraint que será buscado o conteudo digitado (Seachby)
        );
    }
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

function zoomCusto(obj) {	
    var type = $(obj).prev("input").attr("name");
    var filial = $("#codFilial").val();
    var filters = "FILIAL," + "0101";
    var searchby = "FILTRO";
    
    tdizoom.open(
        "dsZZADistrato", //Nome do Dataset
        "CUSTO,Custo,DESCRICAO,Descrição",  //Campos a serem exibidos
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
    var tpContrato = $("#tipocontrato").val()
    
    if(name == "produto"){
        $("#produto").val(selectedItem.DESCRICAO);
        $("#produtoCodigo").val(selectedItem.CODIGO);
    }else if(name == "nome"){
        $("#nome").val(selectedItem.NOME);
    } else if (name == "colaborador2") {
        if (tpContrato == "CLT") {
            $("#colaborador2").val(selectedItem.NOME_COMPLETO);
            $("#tipocontrato").val(selectedItem.TPCONTRATO);
            $("#tipocontrato1").text(selectedItem.TPCONTRATO);
            $("#telefone").val(selectedItem.DDD + selectedItem.NUM_CEL);
            $("#cpf").val(selectedItem.CPF);
            $("#email").val(selectedItem.EMAIL);
            $("#funcao").val(selectedItem.FUNCAO);
            $("#rg").val(selectedItem.RG);
        }     
        if (tpContrato == "PJ") {
            $("#colaborador2").val(selectedItem.ZRA_RESP);
            $("#telefone").val(selectedItem.ZRA_DDD + selectedItem.ZRA_TEL);
            $("#cpf").val(selectedItem.ZRA_CPF);
            $("#email").val(selectedItem.ZRA_EMAIL);
        }    
    }else if(name == "centroCusto"){
    	 $("#codCentroCusto").val(selectedItem.CUSTO);
    	 $("#centroCusto").val(selectedItem.DESCRICAO);
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
