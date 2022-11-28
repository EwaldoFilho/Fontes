const bodyTabela = [];

$(document).ready(function () {
	//console.log("##################### JAF")
	indicandoFilial();// função para capturar a filial digitada 

	$("#gerar").on('click', async () => {

		try {
			var filial = $("#codFilial").val();
			//var solicitacao1 = $("#solicitacaoInicial").val();
			//var solicitacao2 = $("#solicitacaoFinal").val(); 
			if (filial == "") {
				FLUIGC.message.alert({
					message: 'Informe a filial antes de continuar com a pesquisa.',
					title: 'Alerta',
					label: 'OK'
				}, function (el, ev) {

				});
			} else {
				//valorfinalValido(solicitacao1,solicitacao2);

				bodyTabela.length = 0;
				dadosLoading(true)
				setTimeout(async () => {
					const constraints = await gerarConstraints()
					const usuarios = await carregarDados(constraints)

					if (usuarios.length == 0) {
						exibirMensagem("Atenção", "Nenhum registro foi encontrado para sua busca.", "warning")
					}

					exibirTabela(usuarios)
					dadosLoading(false)
					linkParaSolicitacao();
					OcultarLinhasTabela();
				}, 2000);
			}

		} catch (err) {
			bodyTabela.length = 0;
			exibirTabela([])
			dadosLoading(false)
			console.error(err.message)
			//exibirMensagem("Erro", "Houve um problema ao gerar o relatório", "danger")
		}

	})

});


function gerarConstraints() {
	return new Promise(function (resolve, reject) {
		try {
			var codFilial = $("#codFilial").val();
			let constraints = []
			
//			var c01 = DatasetFactory.createConstraint("PROCESSO", "Movimentação de Pessoal", "Movimentação de Pessoal", ConstraintType.MUST, true);
//			var c02 = DatasetFactory.createConstraint("STATUSPPROCESSO", 0, 0, ConstraintType.MUST, true);
//			var c03 = DatasetFactory.createConstraint("RESPONSAVEL", "Nacime"+"%", "Nacime"+"%", ConstraintType.MUST, true);
//			var c04 = DatasetFactory.createConstraint("FILIAL", codFilial, codFilial, ConstraintType.MUST, true);

			constraints.push(DatasetFactory.createConstraint("FILIAL", codFilial, codFilial, ConstraintType.MUST, true));
			constraints.push(DatasetFactory.createConstraint("FILIAL2", codFilial, codFilial, ConstraintType.MUST, true));
			//console.log("######## constraints2 ");
//			constraints.push(c01);
//			constraints.push(c02);
//			constraints.push(c03);
//			constraints.push(c04);

			resolve(constraints)
			//console.log("######## constraints3 ");
		} catch (erro) {
			reject({ erro: true, message: `Houve um erro de implementação na sua função gerarConstraints`, details: erro })
		}
	})
}

function carregarDados(constraints) {

	return new Promise(function (resolve, reject) {
		try {
			//Define os campos para ordenação
			//const ordenar = new Array("idSolicitacao;asc");
			//Busca dados do dataset
			
			const dataset = DatasetFactory.getDataset("ds_consultaMP_filiais", null, constraints, null);

			if (dataset.values.length) {
				/*const data = dataset.values;
					for (i in data) {
										const rows = new Array();
										rows.push(data[i].colleagueName)
										rows.push(data[i].mail)
						rows.push(data[i]["colleaguePK.colleagueId"])
						rows.push(data[i].login)
					rows.push(data[i].active == 'true' ? 'Sim' : 'Não')
					rows.push(data[i].adminUser == 'true' ? 'Sim' : 'Não')
										bodyTabela.push(rows)
								}*/
				resolve(dataset.values)

			} else {
				resolve([])
			}
		} catch (erro) {
			reject({ erro: true, message: `Houve um erro de implementação na sua função carregarDados`, details: erro })
		}
	})
}



function exibirTabela(dados) {
	$('#tabela').DataTable({

		data: dados,
		processing: true,
		responsive: true,
		dom: 'Bfrtip',
		buttons: [
			{ extend: 'excel', text: 'Excel' },
			{
				text: 'Movimentar em bloco',
				action: function (e, dt, node, config) {
					movimentarEmBloco()
				},
				className: 'movimentarButton'
			},
		],


		createdRow: function (row, data, dataIndex) {
			//console.log(data)
			if (data.active === "false") {
				$(row).addClass('rowErro');
			}

		},

		columns: [

			{ data: null, className: "center", defaultContent: '<input type="checkbox" id="checkMovimentar" class="custom-checkbox custom-checkbox-primary"/>' },

			{ // numero da solicitação
				data: 'SOLICITACAO' 
//				render: function (data, type, row, meta) {
//					return numSolicitacao(data, type, row, meta)
//				}

			},
			{ // nome do solicitante
				data: 'NOME' 
//				render: function (data, type, row, meta) {
//					return solicitanteProcessoMP(data, type, row, meta)
//				}

			},
			{// Filial
				//data: 'FILIAL2'  
				render: function (data, type, row, meta) {
					return filialProcessoMP(row)
				
				}
			},
			{
				// data MP
				render: function (data, type, row, meta) {

					return dataProcessoMP(row)
				}

			},

			{ // sattus MP
				data: 'STATUSPPROCESSO'  
//				render: function (data, type, row, meta) {
//
//					return statusProcessoMP(data, type, row, meta)  //meta.row + meta.settings._iDisplayStart + 1; 
//				}
			}
		],

		select: {
			style: 'multi',
		},
		order: [],
		pagingType: "numbers",
		pageLength: 100,
		language: {
			lengthMenu: "Mostrar _MENU_ registros",
			info: "Mostrando _START_ até _END_ de _TOTAL_ registros",
			infoEmpty: "Mostrando 0 até 0 de 0 registros",
			infoFiltered: "(Filtrados de _MAX_ registros)",
			loadingRecords: "Carregando...",
			processing: "Processando...",
			search: "Pesquisar:",
			zeroRecords: "Nenhum registro encontrado",
			emptyTable: "Nenhum registro encontrado",
			paginate: {
				first: "Primeiro",
				last: "Útimo",
				next: "Próximo",
				previous: "Anterior"
			},
			aria: {
				sortAscending: ": Clicar para ordenar a coluna de maneira crescente",
				sortDescending: ": Clicar para ordenar a coluna de maneira decrescente"
			},
		},
		bDestroy: true
	});

	ajustarAltura()
}


function dadosLoading(iniciar) {
	var btn = $("#gerar");

	if (iniciar) {
		btn.prop('disabled', iniciar).find('.text').text("Gerando Relatório...");
		btn.find('img').removeClass("fs-display-none");

	} else {
		btn.prop('disabled', iniciar).find('.text').text("Gerar Relatório");
		btn.find('img').addClass("fs-display-none");

	}
}

function alerta(mensagem) {
	FLUIGC.message.alert({
		message: mensagem,
		title: 'Atenção!',
		label: 'OK, Entendi'
	}, function (el, ev) {
	});
}

function exibirMensagem(titulo, mensagem, tipo) {
	if ((tipo == null) || (tipo == undefined) || tipo == "") {
		tipo = "info";
	}
	FLUIGC.toast({
		title: titulo,
		message: mensagem,
		type: tipo
	});
}

function ajustarAltura() {
	const iframePai = window.parent.$("#iframeForm")[0]
	const alturaFormulario = $("#relatorio").height()
	iframePai.style.height = `${alturaFormulario + 100}px`
}

function FormataStringData(data) {
	var dia = data.split("-")[2];
	var mes = data.split("-")[1];
	var ano = data.split("-")[0];

	var dt_format = ano + "-" + mes + "-" + dia + "T00:00:00.000-3:00"

	return dt_format
}

//function numSolicitacao(data, type, row, meta) {
//	try {
//		var solicitacao = (row.SOLICITACAO)
//
//		return (solicitacao);
//
//	} catch (e) {
//		console.log("erro ao consultar dataset")
//	}
//}

//function statusProcessoMP(data, type, row, meta) {
//	try {
//
//		var status = (row.STATUSPPROCESSO)
//		//console.log(row)
//		//console.log(status)
//
//		if (status == "0") {
//			return "ABERTA"
//		} else if (status == "1") {
//			return "CANCELADA"
//		} else if (status == "2") {
//			return "FINALIZADO"
//		}
//
//	} catch (e) {
//		console.log("erro ao pegar meta")
//	}
//}

//function solicitanteProcessoMP(data, type, row, meta) {
//	try {
//
//		var solicitanteId = String(row.SOLICITANTE)
//		var c1 = DatasetFactory.createConstraint("login", solicitanteId, solicitanteId, ConstraintType.MUST);
//		var constraints = new Array(c1)
//		var dsDataset = DatasetFactory.getDataset("colleague", null, constraints, null);
//
//		if (dsDataset.values.length > 0) {
//			for (var i = 0; i < dsDataset.values.length; i++) {
//				var solicitanteName = dsDataset.values[i].colleagueName;
//				return solicitanteName
//			}
//		} else {
//			return solicitanteId
//		}
//
//	} catch (e) {
//		console.log("erro ao pegar meta")
//	}
//}

function dataProcessoMP(row) {
	try {
		var data = (row.STARTDATE) // data no formato TIMESTAMP
		/* console.log(data);
		 
		 var newData = new Date(data).toLocaleString();
		 var dataReturn  = newData.split(",")[0];
		// console.log(newData);*/

		return data
	} catch (e) {
		console.log("erro ao pegar meta")
	}
}

//function filialProcessoMP(row) {
//	//console.log("####### FILIAL PROCESS MP")
//	var idSolicitacao = row.SOLICITACAO;
//	console.log("############# idSolicitacao "+idSolicitacao)
//	var codFilial = $("#codFilial").val();
//
//	console.log("########## codFilial "+codFilial)
//		var c1 = DatasetFactory.createConstraint("SOLICITACAO", idSolicitacao, idSolicitacao, ConstraintType.MUST);
//		var c3 = DatasetFactory.createConstraint("codFilial", codFilial, codFilial, ConstraintType.MUST);
//		var constraintsID = new Array(c1, c3);
//
//		var datasetMP = DatasetFactory.getDataset("ds_movimentacaoPessoas_Sync", null, constraintsID, null);
//		//console.log(datasetMP);
//		//console.log(cardId);
//		if (datasetMP.values.length > 0) {
//			for (var i = 0; i < datasetMP.values.length; i++) {
//				var codFilial = (datasetMP.values[i].CODFILIAL)
//				console.log(codFilial)
//				return codFilial
//			}
//		} else {
//					return "--"
//				}
	// if (idSolicitacao <= "36188") {
	// 	var c1 = DatasetFactory.createConstraint("SOLICITACAO", idSolicitacao, idSolicitacao, ConstraintType.MUST);
	// 	var c3 = DatasetFactory.createConstraint("codFilial", codFilial, codFilial, ConstraintType.MUST);
	// 	var constraintsID = new Array(c1,c3)

	// 	var datasetMP = DatasetFactory.getDataset("ds_movimentacaoPessoas_Sync", null, constraintsID, null);
	// 	//console.log(datasetMP)
	// 	//console.log(cardId)
	// 	if (datasetMP.values.length > 0) {
	// 		for (var i = 0; i < datasetMP.values.length; i++) {
	// 			var codFilial = (datasetMP.values[i].CODFILIAL)
	// 			//console.log(codFilial)
	// 			return codFilial
	// 		}
	// 	} else {
	// 		return "--"
	// 	}
	// } else {
		// var c2 = DatasetFactory.createConstraint("solicitacaoID", idSolicitacao, idSolicitacao, ConstraintType.MUST);
		// var c3 = DatasetFactory.createConstraint("codFilial", codFilial, codFilial, ConstraintType.MUST);
		// var constraintsID = new Array(c2, c3)
		// var constraintsID = new Array(c2)

		// var datasetMPNew = DatasetFactory.getDataset("ds_mp_refatorada", null, constraintsID, null);
		// console.log(datasetMPNew)
		// // console.log(cardId)
		// if (datasetMPNew.values.length > 0) {
		// 	for (var i = 0; i < datasetMPNew.values.length; i++) {
		// 		var codFilial = (datasetMPNew.values[i].codFilial)
		// 		console.log("#### ### #### # #### # I = "+i)
		// 		return codFilial;
		// 	}
		// } else {
		// 	return "--"
		// }
	// }

//}

function OcultarLinhasTabela() {
	var filtro = String($("#codFilial").val());
	//let tabela = document.getElementById("tabela");

	let linhas = document.getElementsByTagName("tr");

	let info = document.getElementById("tabela_info");
	info.classList.add("hide")
	var rowCount = $("#tabela").find("tbody tr").length;


	for (var i = 1; i < rowCount + 1; i++) {

		var filial = String(linhas[i]["cells"][3]["innerHTML"]);

		if (filial != filtro) {
			linhas[i].classList.add("hide")

		}
	}
}

function movimentarEmBloco() {

	let linhas = document.getElementsByTagName("tr");

	var rowCount = $("#tabela").find("tbody tr").length;

	for (var i = 1; i < rowCount + 1; i++) {

		var id = String(linhas[i]["cells"][1]["innerHTML"]);

		var c1 = DatasetFactory.createConstraint("closureStatus", 0, 0, ConstraintType.MUST);
		var c2 = DatasetFactory.createConstraint("processTaskPK.processInstanceId", id, id, ConstraintType.MUST);
		var constraints = new Array(c1, c2)

		var dsresult = DatasetFactory.getDataset("processTask", null, constraints, null);

		var movimentSequenceId = (dsresult.values[0]["processTaskPK.movementSequence"])

		var classesList = (linhas[i]["className"])
		var classSelected = (classesList.split(" ")[1]);

		if (classSelected == "selected") {
			linhas[i].classList.add("hide")
			$.ajax({
				url: "/process-management/api/v2/requests/" + id + "/move",
				type: "POST",
				async: false,
				contentType: "application/json",
				dataType: "json",
				data: JSON.stringify(

					{
						"movementSequence": movimentSequenceId,//processTaskPK.movementSequence colocar a última movimentação
						"comment": "MOVIMENTADO AUTOMATICAMENTE",
						"asManager": false,
						"assignee": "Nacime", //matrícula do responsável pela atividade atual
						"targetState": 141, // cod da atividade destino

					}

				),
			}).done(function (data) {
				FLUIGC.toast({
					message: 'Solicitação ' + id + ' movimentadas com sucesso.',
					type: 'success'
				});
			}).fail(function (jqXHR, textStatus) {
				_this.erros += id + " - ";
				FLUIGC.toast({
					message: 'Solicitação com erro:<br>' + id + " - " + jqXHR.responseJSON.message,
					type: 'danger'
				});
			});
		}
	}
}

function indicandoFilial() {
	$("#filial").change(function () {
		var codFilial = String($("#filial").val());
		$("#codFilial").val(codFilial);

		var c1 = DatasetFactory.createConstraint("CODFILIAL", codFilial, codFilial, ConstraintType.MUST);

		var constraints = new Array(c1)

		var ds = DatasetFactory.getDataset("dsFiliaisConsulta", null, constraints, null);

		if (ds.values.length > 0) {
			for (var i = 0; i < ds.values.length; i++) {

				var descricao = ds.values[i].NOMEFANTASIA;
				$("#descricaoFilial").val(descricao);
			}
		}

	});
}

function filialProcessoMP(row) {
	try {
		if (row.FILIAL == $("#codFilial").val()){
			var data = (row.FILIAL);
			console.log(data);
			
		}else if(row.FILIAL2 == $("#codFilial").val()){
			var data = (row.FILIAL2);
			console.log(data);
			
		}else{
			var data = ' ';
		}


		return data
	} catch (e) {
		console.log("erro ao pegar meta");
	}
}

function linkParaSolicitacao() {

	//FUNÇÕES PARA ADICIONAR A CLASSE TRCLICK NAS LINHAS DA TABELA, APÓS ESSA ADIÇÃO É FEITA FORMATAÇÃO DO CURSOR RECONHECENDO
	//QUE É UMA LINHA CLICÁVEL. aPÓS ISSO A FUNÇÃO CLICK CAPTURA O NUMERO DA SOLICITAÇÃO DA LINHA QUE FOI CLICADA E REDIRECIONA
	//PARA A SOLICITAÇÃO MP

	$.each($('#tabela'), function (index) {
		$(this).find('tbody tr td:nth-child(2)').addClass("trClick");

	});
	$(function () {
		$(".trClick").mouseenter(
			function () { $(this).css({ "font-weight": "bold", "cursor": "pointer" }) },
		);
	});
	$(function () {
		$(".trClick").mouseout(
			function () { $(this).css("font-weight", "normal") },

		);
	});


	$("td.trClick").click(function () {
		var linha = $(this);

		var id = (linha[0]["innerText"])
		var login = String($("#userID").val());

		//var urlSolicitacaoMP = "https://fluight.spdmafiliadas.org.br:8143/portal/p/1/pageworkflowview?app_ecm_workflowview_detailsProcessInstanceID=" + (String(id));
		var urlSolicitacaoMP = "https://fluig.spdmafiliadas.org.br/portal/p/1/pageworkflowview?app_ecm_workflowview_detailsProcessInstanceID="+(String(id))+"&app_ecm_workflowview_taskUserId="+login;


		window.open(urlSolicitacaoMP, '_blank');
	});
}


