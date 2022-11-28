	var numState = $("#estado").val();
	var matriculaUsuario = $("#matriculaUsuario").val();

	console.log("NumEstado::::"+numState);
	
	 parent.$('#textActivity').hide();
	
	if(numState == 0){
		$("#isGerente").val("false");//Não pertence ao grupo de gerente.
		
		var constraintGrupo = DatasetFactory.createConstraint("colleagueGroupPK.groupId", "gerentesContratos", "gerentesContratos", ConstraintType.MUST); //codigo grupo
		var constraintEmpresa = DatasetFactory.createConstraint("colleagueGroupPK.companyId", "1", "1", ConstraintType.MUST);//codigo empresa
		var constraintUsuario = DatasetFactory.createConstraint("colleagueGroupPK.colleagueId", matriculaUsuario, matriculaUsuario, ConstraintType.MUST);//codigo usuario
		
		var constraints = new Array(constraintGrupo, constraintEmpresa, constraintUsuario);      
		
	    var datasetCotacoes = DatasetFactory.getDataset("colleagueGroup", null, constraints, null);
	    var datasetValues = datasetCotacoes.values;
	    
	    if(datasetValues.length > 0){
			//Caso retorne algum valor o usuário pertence ao grupo de gerente.
	    	$("#isGerente").val("true");
	    	$("#gerenteContratoId").val(matriculaUsuario);
			$("#gerenteContratoNome").val($("#nomeSolicitante").val());
	    }else{
			//busca responsavel pelo usuário
			buscarResponsavel();
		}
	}
    
	if(numState != 0 && numState != 1  && numState != 12 && numState != 39){
		$('#banco').attr("style", "pointer-events: none;");
		$('#tipoConta').attr("style", "pointer-events: none;");
		$('#chavePix').attr("style", "pointer-events: none;");
		$('#formaPagamento').attr("style", "pointer-events: none;");
		$('#centroCusto').attr("style", "pointer-events: none;");
	}

	if(numState != 4){
		$('#isAprovado').attr("style", "pointer-events: none;");
	}
	
	if(numState == 39){
		$('#centroCusto').attr("style", "pointer-events: none;");
		$('#valorRecarga').attr("style", "pointer-events: none;");
	}

	function buscarResponsavel(){
		$.ajax({
			url: '/api/public/2.0/users/getCurrent', 
			type: "GET",
		}).then(function(data) {
			//seta o gerente responsavel
			$("#gerenteContratoId").val(data.content.extData.codResponsavel);
			$("#gerenteContratoNome").val(data.content.extData.responsavel);
		});
	}

	function setResponsavelInput(nomeResponsavel){
	/*	var constraintLogin = DatasetFactory.createConstraint("login",nomeResponsavel , nomeResponsavel, ConstraintType.MUST);
		var c0 = DatasetFactory.createConstraint("userSecurityId", "admin", "admin", ConstraintType.MUST);

		var constraintsColleague = new Array(constraintLogin, c0);      

		var datasetAttachment = DatasetFactory.getDataset("colleague", null, constraintsColleague, null);
		
		var objJSON = datasetAttachment.values[0];
		
		for (var property in objJSON) {
			if(property == "colleaguePK.colleagueId"){
				$("#gerenteContrato").val(objJSON[property]);
			}
		}*/
		
	//	var datasetAttachment = DatasetFactory.getDataset("dsTestesIntegracao", null, null, null);
		
		//console.log(datasetAttachment);
		//http://192.168.200.66:9007/api/public/2.0/users/listData/marcus.silva
		
	}