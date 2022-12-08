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

	if (state == "0" || state == "4") {
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

	if (state == "0" || state == "4") {
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

	tdizoom
			.open(
					"FUNC-VAGAS-BUCAS", // Nome do Dataset
					"NOME_COMPLETO,Nome,COD,COD,CATEGORIA,CATEGORIA,TPCONTRATO,TPCONTRATO,FUNCAO,FUNCAO", // Campos
																											// a
																											// serem
																											// exibidos
					"RA_MAT,NOME_COMPLETO,TPCONTRATO,DDD,NUM_CEL,EMAIL,CPF,FUNCAO,RG", // Campos
																						// de
																						// retorno
					"Colaboradores", // Titulo
					filters, // Filtros
					type, // Type (deve ser sempre o atributo name do campo)
					null, // likefield
					null, // likevalue
					searchby // Campo/Constraint que será buscado o conteudo
								// digitado (Seachby)
			);
}

function zoomPeriodos(obj) {
	var type = $(obj).prev("input").attr("name");
	var matColaborador = $("#matColaborador").val();

	// var tipoContrato = $("#tipoContrato").val("TPCONTRATO");
	var filters = "MATCOLABORADOR," + matColaborador.toString();
	var searchby = "FILTRO";

	tdizoom
			.open(
					"dsPerFerias", // Nome do Dataset
					"RA_NOMECMP,Nome,RF_DATABAS,Iní. Dt. Base,RF_DATAFIM,Fim Dt. Base,RF_DFERVAT,Dias Fer. Vencidas,RF_DFERAAT,Dias Fer. Proporcionais,DPROG,Dias Programados,SALDO,Saldo de Dias", // Campos
																																																	// a
																																																	// serem
																																																	// exibidos
					"RF_DATABAS,RF_DFERVAT,RF_DFERAAT,DPROG,SALDO,RF_DATAINI,RF_DFEPRO1,RF_DABPRO1,RF_DATINI2,RF_DFEPRO2,RF_DABPRO2,PER", // Campos
																																// de
																																// retorno
					"Períodos de Férias", // Titulo
					filters, // Filtros
					type, // Type (deve ser sempre o atributo name do campo)
					null, // likefield
					null, // likevalue
					searchby // Campo/Constraint que será buscado o conteudo
								// digitado (Seachby)
			);
}

function setSelectedZoomItem(selectedItem) {
	var name = selectedItem.type.split("___")[0];
	var indice = selectedItem.type.split("___");

	// "CODIGO,DESCRICAO",
	if (name == "descricaoCentroCustoSol") {
		$("#codCentroCustoSol").val(selectedItem.CTT_CUSTO);
		$("#descricaoCentroCustoSol").val(selectedItem.CTT_DESC01);
	} else if (name == "descricaoCentroCusto") {
		$("#codCentroCusto").val(selectedItem.CTT_CUSTO);
		$("#descricaoCentroCusto").val(selectedItem.CTT_DESC01);
		$("#CENTROCUSTOIMP").val(selectedItem.CTT_DESC01);
	} else if (name == "colaborador") {
		$("#colaborador").val(selectedItem.NOME_COMPLETO);
		$("#matColaborador").val(selectedItem.RA_MAT);
		$("#MATRICULA").val(selectedItem.RA_MAT);
		$("#NOMECOLABORADOR").val(selectedItem.NOME_COMPLETO);
	} else if (name == "perFerias") {
		var RF_DATAINI = selectedItem.RF_DATAINI;
		var RF_DATINI2 = selectedItem.RF_DATINI2;
		var qtDias1 = selectedItem.RF_DFEPRO1;
		var qtDias2 = selectedItem.RF_DFEPRO2;
		var qtDias1Convert = parseInt(qtDias1);
		var qtDias2Convert = parseInt(qtDias2);
		var RF_DABPRO1 = selectedItem.RF_DABPRO1;
		var RF_DABPRO2 = selectedItem.RF_DABPRO2;
		var qtAbono1 = parseInt(RF_DABPRO1)
		var qtAbono2 = parseInt(RF_DABPRO2)
		var qtDiasTotal = qtAbono1 + qtAbono2 + qtDias1Convert + qtDias2Convert;
		var RF_DATABAS = selectedItem.RF_DATABAS;
		var RF_DATAFIM = selectedItem.RF_DATAFIM;
		var dia = RF_DATABAS.substring(2, 0);
		var diaConvert = parseInt(dia);
		var diaLimit = String(diaConvert)
		var counterDia = diaLimit.length;
		var RF_DFERVAT = selectedItem.RF_DFERVAT;
		while (counterDia < 2) {

			diaLimit = "0" + diaLimit;

			counterDia++;

		}
		var mes = RF_DATAFIM.substring(5, 3);
		var mesConvert = parseInt(mes) - 2;
		var mesLimit = String(mesConvert);
		var counter = mesLimit.length;
		while (counter < 2) {

			mesLimit = "0" + mesLimit;

			counter++;

		}
		var ano = RF_DATAFIM.substring(10, 6);
		var anoLimit = parseInt(ano) + 1;
		var limitMax = diaLimit + "/" + mesLimit + "/" + anoLimit;

		$("#dataBaseIni").val(selectedItem.RF_DATABAS);
		$("#dataBaseFim").val(selectedItem.RF_DATAFIM);
		$("#perFerias").val(selectedItem.PER);
		$("#perLimite").val(limitMax);
		$("#diasProporcionais").val(selectedItem.RF_DFERAAT);
		$("#dt1programacao").val("");
		$("#dt2programacao").val("");
		if (qtDiasTotal >= 30) {
			$("#programado1").val("sim");
			$("#dt1programacao").prop('readonly', true);
			$("#qtDias1").prop('readonly', true);
			$("#dt2programacao").prop('readonly', true);
			$("#qtDias2").prop('readonly', true);
			if (RF_DABPRO1 > '0.00') {
				$("#abonoPecuniario1").val("sim");
				$("#abonoPecuniario1").attr('readonly', 'readonly');
				$("#abonoPecuniario1").attr("style",
						"pointer-events:none;touch-action:none");
			} else {
				$("#abonoPecuniario1").val("nao");
				$("#abonoPecuniario1").attr('readonly', 'readonly');
				$("#abonoPecuniario1").attr("style",
						"pointer-events:none;touch-action:none");
			}
			if (RF_DABPRO2 > '0.00') {
				$("#abonoPecuniario2").val("sim");
				$("#abonoPecuniario2").attr('readonly', 'readonly');
				$("#abonoPecuniario2").attr("style",
						"pointer-events:none;touch-action:none");
			} else {
				$("#abonoPecuniario2").val("nao");
				$("#abonoPecuniario2").attr('readonly', 'readonly');
				$("#abonoPecuniario2").attr("style",
						"pointer-events:none;touch-action:none");
			}
			Swal
					.fire({
						icon : 'warning',
						title : 'O colaborador já possuí 30 dias de férias programados! Gentileza procurar o Departamento Pessoal, em caso de alteração do Período de Gozo.'
					})
		} else if (RF_DATAINI !== "") {
			$("#dt1programacao").val(RF_DATAINI);
			$("#qtDias1").val(selectedItem.RF_DFEPRO1);
			$("#programado1").val("sim");
			$("#dt1programacao").prop('readonly', true);
			$("#qtDias1").prop('readonly', true);
			if (RF_DABPRO1 > '0.00') {
				$("#abonoPecuniario1").val("sim");
				$("#abonoPecuniario1").attr('readonly', 'readonly');
				$("#abonoPecuniario1").attr("style",
						"pointer-events:none;touch-action:none");
			} else {
				$("#abonoPecuniario1").val("nao");
				$("#abonoPecuniario1").attr('readonly', 'readonly');
				$("#abonoPecuniario1").attr("style",
						"pointer-events:none;touch-action:none");
			}
		} else {
			$("#programado1").val("nao");
			$("#programado2").val("nao");
			$("#dt1programacao").prop('readonly', false);
			$("#qtDias1").prop('readonly', false);
			$("#dt2programacao").prop('readonly', false);
			$("#qtDias2").prop('readonly', false);
			$("#abonoPecuniario2").attr('readonly', false);
			$("#abonoPecuniario2").attr("style",
					"pointer-events:;touch-action:");
			$("#abonoPecuniario1").attr('readonly', false);
			$("#abonoPecuniario1").attr("style",
					"pointer-events:;touch-action:");
			$("#abonoPecuniario1").val("");
			$("#abonoPecuniario2").val("");

		}
		if (RF_DATINI2 !== "") {
			$("#dt2programacao").val(RF_DATINI2);
			$("#qtDias2").val(selectedItem.RF_DFEPRO2);
			$("#programado2").val("sim");
			$("#dt2programacao").prop('readonly', true);
			$("#qtDias2").prop('readonly', true);
			if (RF_DABPRO2 > '0.00') {
				$("#abonoPecuniario2").val("sim");
				$("#abonoPecuniario2").attr('readonly', 'readonly');
				$("#abonoPecuniario2").attr("style",
						"pointer-events:none;touch-action:none");
			} else {
				$("#abonoPecuniario2").val("nao");
				$("#abonoPecuniario2").attr('readonly', 'readonly');
				$("#abonoPecuniario2").attr("style",
						"pointer-events:none;touch-action:none");
			}
		}
	}
}

function removedZoomItem(selectedItem) {
	if (selectedItem == "descricaoCentroCustoSol") {

		$("#codCentroCustoSol").val("");
		$("#descricaoCentroCustoSol").val("");

	} else if (selectedItem == "descricaoCentroCusto") {

		$("#codCentroCusto").val("");
		$("#descricaoCentroCusto").val("");
	} else if (selectedItem == "colaborador") {

		$("#colaborador").val("");
		$("#matColaborador").val("");
	} else if (selectedItem == "perFerias") {
		$("#dataBaseIni").val("");
		$("#dataBaseFim").val("");
		$("#perFerias").val("");
		$("#dt1programacao").val("");
		$("#qtDias1").val("");
		$("#programado1").val("");
		$("#abonoPecuniario1").val("");
		$("#dt2programacao").val("");
		$("#qtDias2").val("");
		$("#abonoPecuniario2").val("");
		$("#programado2").val("");
	}

}