$(document).on("ready", function() {

	var data = new Date();

	$("#processo").val(getWKNumProces());
	$("#estado").val(getWKNumState());

});

function zoomCustoSol(obj) {
	var type = $(obj).prev("input").attr("name");	
	var filters = "";
	var searchby = "FILTRO";
	var state = $("#estado").val();

	if (state == "0" || state =="4") {
		tdizoom.open("DsCustoSol", // Nome do Dataset
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

function zoomCusto(obj) {
	var type = $(obj).prev("input").attr("name");
	var filial = $("#codFilial").val();
	var filters = "FILIAL," + filial;
	var searchby = "FILTRO";
	var state = $("#estado").val();

	if (state == "0" || state =="4") {
		tdizoom.open("DsCustoSol", // Nome do Dataset
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

function zoomColaboradores(obj) {
    var type = $(obj).prev("input").attr("name");
    var codCentroCusto = $("#codCentroCusto").val();    
    var filters = "COD," + codCentroCusto;
    var searchby = "FILTRO";
   
        tdizoom.open(
            "FUNC-VAGAS-BUCAS", //Nome do Dataset
            "NOME_COMPLETO,Nome,COD,COD,CATEGORIA,CATEGORIA,TPCONTRATO,TPCONTRATO,FUNCAO,FUNCAO",  //Campos a serem exibidos
            "RA_MAT,NOME_COMPLETO,TPCONTRATO,DDD,NUM_CEL,EMAIL,CPF,FUNCAO,RG", //Campos de retorno
            "Colaboradores", //Titulo
            filters, //Filtros
            type, //Type (deve ser sempre o atributo name do campo)
            null, //likefield
            null, //likevalue
            searchby //Campo/Constraint que será buscado o conteudo digitado (Seachby)
        );   
}

function zoomPeriodos(obj) {
    var type = $(obj).prev("input").attr("name");
    var matColaborador = $("#matColaborador").val();

    // var tipoContrato = $("#tipoContrato").val("TPCONTRATO");
    var filters = "MATCOLABORADOR," + matColaborador.toString();
    var searchby = "FILTRO";
   
        tdizoom.open(
            "dsPerFerias", //Nome do Dataset
            "RA_NOMECMP,Nome,RF_DATABAS,Iní. Dt. Base,RF_DATAFIM,Fim Dt. Base,RF_DFERVAT,Dias Fer. Vencidas,RF_DFERAAT,Dias Fer. Proporcionais,DPROG,Dias Programados,SALDO,Saldo de Dias",  //Campos a serem exibidos
            "RF_DATABAS,RF_DFERVAT,DPROG,SALDO,RF_DATAINI,RF_DFEPRO1,RF_DABPRO1,RF_DATINI2,RF_DFEPRO2,RF_DABPRO2", //Campos de retorno
            "Períodos de Férias", //Titulo
            filters, //Filtros
            type, //Type (deve ser sempre o atributo name do campo)
            null, //likefield
            null, //likevalue
            searchby //Campo/Constraint que será buscado o conteudo digitado (Seachby)
        );   
}


function setSelectedZoomItem(selectedItem) {
	var name = selectedItem.type.split("___")[0];
	var indice = selectedItem.type.split("___");	
	// "CODIGO,DESCRICAO",
	if (name == "descricaoCentroCustoSol") {
		$("#codCentroCustoSol").val(selectedItem.CTT_CUSTO);
		$("#descricaoCentroCustoSol").val(selectedItem.CTT_DESC01);					
	} 	else if (name == "descricaoCentroCusto") {
		$("#codCentroCusto").val(selectedItem.CTT_CUSTO);
		$("#descricaoCentroCusto").val(selectedItem.CTT_DESC01)
	} else if (name == "colaborador") {		
		$("#colaborador").val(selectedItem.NOME_COMPLETO);
		$("#matColaborador").val(selectedItem.RA_MAT);	
	}		
}

function removedZoomItem(selectedItem) {
	if (selectedItem == "descricaoCentroCustoSol") {

		$("#codCentroCustoSol").val("");
		$("#descricaoCentroCustoSol").val("");		

	} else if (selectedItem == "descricaoCentroCusto") {

		$("#codCentroCusto").val("")
		$("#descricaoCentroCusto").val("")
	} else if (selectedItem == "colaborador") {

		$("#colaborador").val("")
		$("#matColaborador").val("")
	}

}
