    var numeroProcesso = $("#processo").val();
    var numState = $("#estado").val();
    var dataEntrega = FLUIGC.calendar('#estimativaEntrega');
    var produtosInput = "";
    var produtosNovosInput = "";
    var matriculaUsuario = $("#matriculaUsuario").val();

    //oculta o nome da atividade no html
    parent.$('#textActivity').hide();
    
    $("#existeProdutoNovo").val(false);
    
    var dataAtual = new Date();
    
    var dia = dataAtual.getDate()+7;
    var mes = dataAtual.getMonth();
    var ano = dataAtual.getFullYear();
    
    if(dia<10){
    	dia = "0"+dia;
    }
    
    if(mes<10){
    	mes = "0"+mes;
    }
    
    dataEntrega.setMinDate(new Date(ano, mes, dia));

    var inputCentroCusto = document.getElementById("descricao");
    var inputEmpresa = document.getElementById("empresa");
    
    //Eventos para não permitir o usuário a digitar ou apagar conteudo no input 
    inputCentroCusto.addEventListener("keypress", function(event){
        event.preventDefault();
    });

    inputEmpresa.addEventListener("keypress", function(event){
        event.preventDefault();
    });

    inputCentroCusto.addEventListener('keydown', function(event) {
        const key = event.key;
        if (key === "Backspace" || key === "Delete") {
            event.preventDefault();
        }
    });

    inputEmpresa.addEventListener('keydown', function(event) {
        const key = event.key;
        if (key === "Backspace" || key === "Delete") {
            event.preventDefault();
        }
    });
    //Fim eventos input

    console.log("NumEstado::::"+numState);
    console.log("NumProcesso::"+numeroProcesso);

    // Colocar no displayFields
    $('#tb_novosProdutos').hide();  
    $('#tb_produtos').hide();  
    $('#labelProdutos').hide(); 
    $('#labelProdutosAdicionais').hide();
    
    var codArmazem = $("#codArmazem").val();
    
    //GERENTES 
    if(numState == 0){
		$("#isGerente").val("false");//Não pertence ao grupo de gerente.
		
		var constraintGrupo = DatasetFactory.createConstraint("colleagueGroupPK.groupId", "gerentesContratos", "gerentesContratos", ConstraintType.MUST); //codigo grupo
		var constraintEmpresa = DatasetFactory.createConstraint("colleagueGroupPK.companyId", "1", "1", ConstraintType.MUST);//codigo empresa
		var constraintUsuario = DatasetFactory.createConstraint("colleagueGroupPK.colleagueId", matriculaUsuario, matriculaUsuario, ConstraintType.MUST);//codigo usuario
		
		var constraints = new Array(constraintGrupo, constraintEmpresa, constraintUsuario);      
		
	    var dsGerentes = DatasetFactory.getDataset("colleagueGroup", null, constraints, null);
	    var dsValues = dsGerentes.values;
	    
	    if(dsValues.length > 0){
			//Caso retorne algum valor o usuário pertence ao grupo de gerente.
	    	$("#isGerente").val("true"); 		
	    }
	}
    
    if(numState != "0"){
        var produtosFormatados = $("#listaProdutos").val();
        var produtosNovosFormatadosInput = $("#listaNovosProdutos").val();

        produtosInput = JSON.parse("["+produtosFormatados.replace(/[\[\]]/g, "")+"]");	   
        produtosNovosInput = JSON.parse("["+produtosNovosFormatadosInput.replace(/[\[\]]/g, "")+"]");	  
    }

    if(numState == "54"){
        parent.$("#workflowActions").hide();
    }

    if(numState == "342"){
        $("#existeProdutoNovo").val(true);
        $("#tb_novosProdutos").show();
    }
    
    if(numState == "4" || numState == "5" || numState == "54" || numState == "73" || numState == "90" || numState == "113" || 
       numState == "119" || numState == "132" || numState == "171" || numState == "491" ||
       numState == "422" || numState == "148" || numState == "464" || numState == "461" || 
       numState == "449" || numState == "388" || numState == "436" || numState == "435" ||
       numState == "433" || numState == "429" || numState == "426" || numState == "404" ||
       numState == "401" || numState == "360" || numState == "287" || numState == "172" ||
       numState == "497" || numState == "502" || numState == "505"){
        	$("#tb_produtos").show();
    }
 
    
    
    
    