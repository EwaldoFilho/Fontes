$(document).on("ready", function() {

	var data = new Date();

	$("#processo").val(getWKNumProces());

});

function fieldDetails() {
}



function zoomCusto(obj) {
	var type = $(obj).prev("input").attr("name");	
	var filters = "";
	var searchby = "FILTRO";
	var state = $("#processo").val();

	if (state == "0" || state == "4") {
		tdizoom.open("DsCustoForn", // Nome do Dataset
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

function zoomCid(obj) {
	var type = $(obj).prev("input").attr("name");	
	var filters = "";
	var searchby = "FILTRO";
	var state = $("#processo").val();

	if (state == "0" || state == "4") {
		tdizoom.open("DsCid10", // Nome do Dataset
				"codigo,Codigo,Descr,Descrição", // Campos a serem exibidos
				"codigo,Descr", // Campos de retorno
				"Cid10", // Titulo
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

function zoomColaboradores(obj) {	
    var type = "colaborador"
    var codCentroCusto = $("#codCentroCusto").val();
       
    // var tipoContrato = $("#tipoContrato").val("TPCONTRATO");
    var filters = "COD," + codCentroCusto;  
    var searchby = "FILTRO";
    var state = $("#processo").val();
    
    if (state == "0" || state == "4") {
    tdizoom.open(
        "DsFuncionarios", //Nome do Dataset
        "NOME_COMPLETO,Nome,COD,COD,CATEGORIA,CATEGORIA",  //Campos a serem exibidos
        "NOME_COMPLETO,TPCONTRATO,DDD,NUM_CEL,EMAIL,CPF,FUNCAO,RG", //Campos de retorno
        "Colaboradores", //Titulo
        filters, //Filtros
        type, //Type (deve ser sempre o atributo name do campo)
        null, //likefield
        null, //likevalue
        searchby //Campo/Constraint que será buscado o conteudo digitado (Seachby)
    );
    }
}

function setSelectedZoomItem(selectedItem) {
	var name = selectedItem.type.split("___")[0];
	var indice = selectedItem.type.split("___");
	// "CODIGO,DESCRICAO",
	if (name == "centroCusto") {
		$("#centroCusto").val(selectedItem.CTT_DESC01);	
		$("#codCentroCusto").val(selectedItem.CTT_CUSTO);			
	} else if(name == "colaborador"){
        $("#colaborador").val(selectedItem.NOME_COMPLETO);
        $("#tipocontrato").val(selectedItem.TPCONTRATO);
        $("#tipocontrato1").text(selectedItem.TPCONTRATO);
        $("#telefone").val(selectedItem.DDD + selectedItem.NUM_CEL);
        $("#cpf").val(selectedItem.CPF);
        $("#email").val(selectedItem.EMAIL);
        $("#funcao").val(selectedItem.FUNCAO);
        $("#rg").val(selectedItem.RG);        
    } else if(name == "cid10"){
        $("#cid10").val(selectedItem.Descr);
        $("#codCid").val(selectedItem.codigo);               
    }
	
}


function removedZoomItem(selectedItem) {
	if (selectedItem == "centroCusto") {

		$("#centroCusto").val("");
		$("#codCentroCusto").val("");

	} else if (selectedItem == "colaborador") {

		$("#colaborador").val("")
	} 
}
