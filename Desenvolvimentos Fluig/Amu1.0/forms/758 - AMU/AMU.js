var initiateFunction

parent.$('#textActivity').hide();//esconde a descrição da atividade do processo 

$("#medicoObrigatoriedade").hide();//esconde obrigatoriedade de campo
$("#crmMedicoObrigatoriedade").hide();
$("#outrosLocais").hide();

//$("#assinaturaPac").val("asd");

$(document).on("ready", function() {

    if (getMobile() == "true") {
        initiateFunction = setInterval(function() { initiate() }, 3000);
    } else {
        initiate()
    }

});

/*  INICIO bloqueio de inputs
	** Bloqueia digitação dos inputs que estão com o campo Zoom
*/
var inputTomador = document.getElementById("tomador");
var inputNacionalidade = document.getElementById("nacionalidade");
var inputAeroportoOrigem = document.getElementById("AeroportoOrigem");
var inputCompanhiaAerea = document.getElementById("CompanhiaAerea");

inputTomador.addEventListener('keydown', function(event) {
	const key = event.key;
	if (key === "Backspace" || key === "Delete") {
		event.preventDefault();
	}
});

inputTomador.addEventListener("keypress", function(event){
	event.preventDefault();
});

inputNacionalidade.addEventListener('keydown', function(event) {
	const key = event.key;
	if (key === "Backspace" || key === "Delete") {
		event.preventDefault();
	}
});

inputNacionalidade.addEventListener("keypress", function(event){
	event.preventDefault();
});

inputAeroportoOrigem.addEventListener('keydown', function(event) {
	const key = event.key;
	if (key === "Backspace" || key === "Delete") {
		event.preventDefault();
	}
});

inputAeroportoOrigem.addEventListener("keypress", function(event){
	event.preventDefault(); 
});

inputCompanhiaAerea.addEventListener('keydown', function(event) {
	const key = event.key;
	if (key === "Backspace" || key === "Delete") {
		event.preventDefault();
	}
});

inputCompanhiaAerea.addEventListener("keypress", function(event){
	event.preventDefault();
});
// FIM bloqueio inputs

/* INICIO  -  NAVEGAÇÃO ABAS */
$("#abaIdentificacao").click(function() {
	//seleciona a pagina atual
	$("#abaIdentificacao").addClass("actual");// adiciona classe para mostrar a aba selecionada
	$("#abaAtendimento").removeClass("actual");//remove classe das abas que não está selecionada
	$("#abaDiagnostico").removeClass("actual");
	$("#abaPosologia").removeClass("actual");
	
	//oculta tabela e apresentada a correta
	$("#identificacao").show(); //apresenta as informações da aba selecionada
	$("#Atendimento").hide(); // esconde as informações da aba que não está selecionada
	$("#diagnostico").hide();
	$("#recusaAtendimento").show();
	$("#posologia").hide();

});

$("#abaAtendimento").click(function() {
	//seleciona a pagina atual
	$("#abaIdentificacao").removeClass("actual");
	$("#abaAtendimento").addClass("actual");
	$("#abaDiagnostico").removeClass("actual");
	$("#abaPosologia").removeClass("actual");

	//oculta tabela e apresentada a correta
	$("#identificacao").hide();
	$("#Atendimento").show();
	$("#diagnostico").hide();
	$("#recusaAtendimento").hide();
	$("#posologia").hide();

});

$("#abaDiagnostico").click(function() {
	//seleciona a pagina atual
	$("#abaIdentificacao").removeClass("actual");
	$("#abaAtendimento").removeClass("actual");
	$("#abaPosologia").removeClass("actual");
	$("#abaDiagnostico").addClass("actual");

	//oculta tabela e apresentada a correta
	$("#identificacao").hide();
	$("#Atendimento").hide();
	$("#diagnostico").show();
	$("#recusaAtendimento").hide();
	$("#posologia").hide();
});

$("#abaPosologia").click(function() {
	//seleciona a pagina atual
	$("#abaIdentificacao").removeClass("actual");
	$("#abaAtendimento").removeClass("actual");
	$("#abaDiagnostico").removeClass("actual");
	$("#abaPosologia").addClass("actual");

	//oculta tabela e apresentada a correta
	$("#posologia").show();
	$("#identificacao").hide();
	$("#Atendimento").hide();
	$("#diagnostico").hide();
	$("#recusaAtendimento").hide();
});

/* FIM  -  NAVEGAÇÃO ABAS */

/* Desabilita/Habilita obrigatoriedade segundo o campo atendimento recusada? */
$("#recusado").change(function() {
var inputAtendimento = $("#recusado").val();
	
	if(inputAtendimento == "SIM"){	    
		//oculta aba informacoes
		$("#identificacao").hide();
		//apresenta aba de recusa de atendimento
	    $("#termoRecusa").show();
	}else{	    	    
		//apresenta aba informacoes
		$("#identificacao").show();
		//oculta aba de recusa de atendimento
		$("#termoRecusa").hide();
	}
});


/* INICIO - TIPO PACIENTE 
** Desabilita/Habilita obrigatoriedade de alguns campos segundo o tipo de paciente
*/

$("#outrosDados1").change(function() {
	  if ($(this).prop("checked") == true) {
		  $("#outrosDados2").prop("checked", false);
		  $("#outrosDados3").prop("checked", false);
		  $("#outrosDados4").prop("checked", false);
		  $("#outrosDados5").prop("checked", false);
		  $("#outrosDados6").prop("checked", false);
		  
		  $("#empresa").closest("td").find("label").addClass("required");
		  $("#CompanhiaAerea").closest("td").find("label").removeClass("required");
		  $("#vooN").closest("td").find("label").removeClass("required");
	  }
});

$("#outrosDados2").change(function() {
	  if ($(this).prop("checked") == true) {
		  $("#outrosDados1").prop("checked", false);
		  $("#outrosDados3").prop("checked", false);
		  $("#outrosDados4").prop("checked", false);
		  $("#outrosDados5").prop("checked", false);
		  $("#outrosDados6").prop("checked", false);
		  
		  $("#empresa").closest("td").find("label").removeClass("required");
		  $("#CompanhiaAerea").closest("td").find("label").removeClass("required");
		  $("#vooN").closest("td").find("label").removeClass("required");
	  }
});


$("#outrosDados3").change(function() {
	  if ($(this).prop("checked") == true) {
		  $("#outrosDados1").prop("checked", false);
		  $("#outrosDados2").prop("checked", false);
		  $("#outrosDados4").prop("checked", false);
		  $("#outrosDados5").prop("checked", false);
		  $("#outrosDados6").prop("checked", false);
		  
		  $("#empresa").closest("td").find("label").addClass("required");
		  $("#CompanhiaAerea").closest("td").find("label").removeClass("required");
		  $("#vooN").closest("td").find("label").removeClass("required");
	  }
});

$("#outrosDados4").change(function() {
	  if ($(this).prop("checked") == true) {
		  $("#outrosDados1").prop("checked", false);
		  $("#outrosDados2").prop("checked", false);
		  $("#outrosDados3").prop("checked", false);
		  $("#outrosDados5").prop("checked", false);
		  $("#outrosDados6").prop("checked", false);
		  
		  $("#empresa").closest("td").find("label").removeClass("required");
		  $("#CompanhiaAerea").closest("td").find("label").removeClass("required");
		  $("#vooN").closest("td").find("label").removeClass("required");
	  }
});

$("#outrosDados5").change(function() {
	  if ($(this).prop("checked") == true) {
		  $("#outrosDados1").prop("checked", false);
		  $("#outrosDados2").prop("checked", false);
		  $("#outrosDados3").prop("checked", false);
		  $("#outrosDados4").prop("checked", false);
		  $("#outrosDados6").prop("checked", false);
		  
		  $("#empresa").closest("td").find("label").removeClass("required");
		  $("#CompanhiaAerea").closest("td").find("label").addClass("required");
		  $("#vooN").closest("td").find("label").addClass("required");
	  }
});

$("#outrosDados6").change(function() {
	  if ($(this).prop("checked") == true) {
		  $("#outrosDados1").prop("checked", false);
		  $("#outrosDados2").prop("checked", false);
		  $("#outrosDados3").prop("checked", false);
		  $("#outrosDados4").prop("checked", false);
		  $("#outrosDados5").prop("checked", false);
		  
		  $("#empresa").closest("td").find("label").addClass("required");
		  $("#CompanhiaAerea").closest("td").find("label").removeClass("required");
		  $("#vooN").closest("td").find("label").removeClass("required");
	  }
});
/* FIM - TIPO PACIENTE */

$("#libPassiente").change(function() {
	$("#reavaliacaoMedico").val("0");
});

//Função responsável por desabilitar/habilitar obrigatoriedades na aba de Diagnóstico/Tratamento
$("#historia").blur(function(){
	var historia = $("#historia").val();
	
	  $("#obrigatoriedadeAntecedentes").closest("td").find("label").addClass("required");
	  $("#obrigatoriedadeExameFisico").closest("td").find("label").addClass("required");
	  $("#obrigatoriedadeClassCuidado").closest("td").find("label").addClass("required");
	  $("#obrigatoriedadeReavaliacao").closest("td").find("label").addClass("required");
	  $("#obrigatoriedadePrescricao").closest("td").find("label").addClass("required");
	  $("#obrigatoriedadeEvolucaoEnf").closest("td").find("label").addClass("required");
	
	if(historia == ""){
		$("#obrigatoriedadeAntecedentes").closest("td").find("label").removeClass("required");
		$("#obrigatoriedadeExameFisico").closest("td").find("label").removeClass("required");
		$("#obrigatoriedadeClassCuidado").closest("td").find("label").removeClass("required");
		$("#obrigatoriedadeReavaliacao").closest("td").find("label").removeClass("required");
		$("#obrigatoriedadePrescricao").closest("td").find("label").removeClass("required");
		$("#obrigatoriedadeEvolucaoEnf").closest("td").find("label").removeClass("required");
	}
});


//Troca o nome do paciente/responsavel de acordo com as informções do input #RespDados
$("#RespDados").blur(function(){
	var responsavel = $("#RespDados").val();
	var nome = $("#nome").val();

	if(responsavel == ""){
		$("#assinturaPaciente").show();
		$("#assinturaResponsavel").hide();
		$("#assinaturaPac").val(nome);
	}else{
		$("#assinturaPaciente").hide();
		$("#assinturaResponsavel").show();
		$("#assinaturaPac").val(responsavel);
	}
});

//Troca o nome do paciente/responsavel de acordo com as informções do input #RespDados
$("#nome").blur(function(){
	var responsavel = $("#RespDados").val();
	var nome = $("#nome").val();
	if(responsavel == ""){
		$("#assinturaPaciente").show();
		$("#assinturaResponsavel").hide();
		$("#assinaturaPac").val(nome);
		$("#declaracao8").val(nome);
	}else{
		$("#assinturaPaciente").hide();
		$("#assinturaResponsavel").show();
		$("#assinaturaPac").val(responsavel);
	}
});

//Habilita obrigatoriedade caso a prescrição médica for preenchida
$("#precricaoMedica").blur(function(){
	var precricaoMedica = $("#precricaoMedica").val();
	
	if(precricaoMedica == ""){
		$("#medicoObrigatoriedade").hide();
		$("#crmMedicoObrigatoriedade").hide();
	}else{
		$("#medicoObrigatoriedade").show();
		$("#crmMedicoObrigatoriedade").show();
	}
});


//função responsavel por setar as listas conforme a localização do atendimento
$("#localizacaoAtendimento").change(function() {
	var localizacaoAtendimento = $('#localizacaoAtendimento').val();
	
	//itens para preencher os options de forma dinamica para o local do atendimento 
	var locaisAr = ["AERONAVE", "EMBARQUE", "PONTE", "MAMUTE", "BOX", "PORTÃO", "FINGE", "PATIO", "CENTRAL DE MANUTENÇÃO LATAM", "REMOTA", "AERONAVE REMORA", "ENFRENTE AO DELTA EMBARQUE", "AERONAVE PONTE 09", "SALA DO COA", "REMOTA SUL", "CANAL DE INSPERSÃO", "DESEMBARQUE DOMESTICO", "HANGAR"];
	var locaisTerra = ["SALA DE SUPERVISÃO", "CESSIONARIOS", "ATENDIMENTO EXTERNO", "DESEMBARQUE", "POLICIA FEDERAL", "CHECK-IN", "SANGUÃO", "SCI", "AMBULANCIA", "DELTA", "PRAÇA DE ALIMENTAÇÃO", "SAÍDA", "TERRAÇO PANORÂMICO", "ADMINISTRAÇÃO AEROPORTO", "PAPH", "ACESSO TRIPULANTES", "VIA PÚBLICA - PONTO DE ÔNIBUS", "BANHEIRO DO EMBARQUE ", "ESTACIONAMENTO",  "LOJA", "ELEVADOR", "RAIO X", "PREDIO DA MANUTENÇÃO", "PONTO DE TAXI", "FRENTE DO AEROPORTO", "POSTO MÉDICO", "PORTÃO", "ESCADA ROLANTE SAGUÃO"];
	
	var select = document.querySelector('#localAtendimento');
	$("#localAtendimento").empty();

	locaisAr.sort(); //realiza o ordenamento da lista locais ar
	locaisTerra.sort(); //realiza o ordenamento da lista locais terra

	//preenche o option do select segundo a localização do atendimento
	if (localizacaoAtendimento == "AR") {
		$("#localAtendimento").show();
		$("#outrosLocais").hide();
		for(var count=0; count < locaisAr.length; count++){
			select.options[select.options.length] = new Option(locaisAr[count], locaisAr[count]);	
		}

	}else if(localizacaoAtendimento == "TERRA"){
		$("#localAtendimento").show();
		$("#outrosLocais").hide();
		for(var count=0; count < locaisAr.length; count++){
			select.options[select.options.length] = new Option(locaisTerra[count], locaisTerra[count]);	
		}
	}else if(localizacaoAtendimento == "OUTROS"){
		$("#outrosLocais").show();
		$("#localAtendimento").hide();
	}
});



function initiate() {
    var data = new Date();
    var task = getWKNumState();

    if (task == "0" || task == "4") {
    	$("#itensGastos").val([]);
		$("#dataAmu").val(data.toLocaleDateString("pt-BR"));
		//$("#nomeAtendente").val(getWKUserName());
		//$("#horarioInicialCadastro").val(data.getHours() + ":" + data.getMinutes())

    	$("#reavaliacaoMedico").val("0");
    	
        $('#aceitaColeta').prop('checked', true);
        aceitaColetaValidation();

		$("#libPassiente").closest("td").find("label").addClass("required");
    	$("#reavaliacaoMedico").val("1");
        
		//Função para buscar o centro de custo do usuário logado
    	$.ajax({
    		url: '/api/public/2.0/users/getCurrent', 
    		type: "GET",
    	}).then(function(data) {
    		
    		var grupos = data.content.groups;
    		
    		for (var property in grupos) {
    			var grupo = grupos[property];
    			var existeGrupo = grupo.indexOf("Aeroporto");
    			
    			if(existeGrupo == 0){
    				$("#grupoAMU").val(grupos[property]);//seta o grupo do usuário
    			}
    		}
    	});
    }
    
	//Apresentaas informações no status finalizado segundo o input Atendimento recusado?
    if(task == 46){
    	var inputAtendimento = $("#recusado").val();
    	
    	if(inputAtendimento == "SIM"){
    		//Oculta todas as abas
        	$("#identificacao").hide();
        	$("#Atendimento").hide();
        	$("#diagnostico").hide();
        	//apresenta somente as informações da recusa do atendimento
        	$("#termoRecusa").show();	
        	
        	//bloqueia o acesso nas abas
        	$('#abaAtendimento').attr("style", "pointer-events: none;");
        	$('#abaDiagnostico').attr("style", "pointer-events: none;");
        	$('#abaPosologia').attr("style", "pointer-events: none;");
        	$('#abaIdentificacao').attr("style", "pointer-events: none;");
    	}else{
        	$("#identificacao").show();
        	
    	}
    }

    $("#actualPage").val("1");

    setSignatureFunctions();

    validSignatures();

    clearInterval(initiateFunction);
    
    var dataNascimento = FLUIGC.calendar('#dataNascimento');
    //dataNascimento.setMinDate(new Date());//seta data minima para a dataAtual
    
    //Habilita a coleta de dados
    console.log("NumState::"+task);
    aceitaColetaValidation();
}

$(document).on('keydown', '[data-mask-for-cpf-cnpj]', function(e) {

    var digit = e.key.replace(/\D/g, '');

    var value = $(this).val().replace(/\D/g, '');

    var size = value.concat(digit).length;

    $(this).mask((size <= 11) ? '000.000.000-00' : '00.000.000/0000-00');
});


$(document).on('keydown', '[data-mask-for-cpf]', function(e) {

    var digit = e.key.replace(/\D/g, '');

    var value = $(this).val().replace(/\D/g, '');

    var size = value.concat(digit).length;

    $(this).mask('000.000.000-00');
});

function fieldDetails() {


}

function setNameInTerm() {

    $("#termoRecusa1").val($("#nome").val())
}

function validSignatures() {

    var signatureImageData1 = $("#signatureImageData1").val();
    var signatureImageData2 = $("#signatureImageData2").val();
    var signatureImageData3 = $("#signatureImageData3").val();

    if (signatureImageData1 != "" && signatureImageData1 != null) {
        document.getElementById("signatureImage1").src = "data:image/png;base64," + signatureImageData1;
    }

    if (signatureImageData2 != "" && signatureImageData2 != null) {
        document.getElementById("signatureImage2").src = "data:image/png;base64," + signatureImageData2;
    }

    if (signatureImageData3 != "" && signatureImageData3 != null) {
        document.getElementById("signatureImage3").src = "data:image/png;base64," + signatureImageData3;
    }
}

// Desabilita/habilita campos caso o paciente autorize a coleta dos dados
function aceitaColetaValidation() {

    var aceitaColeta = $("#aceitaColeta:checked").val();
    var validationReturn = false;

    if (aceitaColeta == "on") {

        validationReturn = true;
        
        $("#nome").closest("td").find("label").addClass("required");
        $("#Sexo1").closest("td").find("label").addClass("required");
        $("#Sexo2").closest("td").find("label").addClass("required");
        $("#Sexo2").closest("td").find("label").addClass("required");
        $("#nacionalidadeCodigo").closest("td").find("label").addClass("required");
        $("#dataNascimento").closest("td").find("label").addClass("required");
        $("#DocIdentificacao").closest("td").find("label").addClass("required");
        $("#AeroportoOrigem").closest("td").find("label").addClass("required");
        //$("#telefone").closest("td").find("label").addClass("required");
        
        $(".dadosPessoais").removeClass("hide");
    } else {
        $("#nome").closest("td").find("label").removeClass("required");
        $("#email").closest("td").find("label").removeClass("required");
        $("#Sexo1").closest("td").find("label").removeClass("required");
        $("#Sexo2").closest("td").find("label").removeClass("required");
        $("#Sexo2").closest("td").find("label").removeClass("required");
        $("#nacionalidadeCodigo").closest("td").find("label").removeClass("required");
        $("#dataNascimento").closest("td").find("label").removeClass("required");
        $("#cpf").closest("td").find("label").removeClass("required");
        $("#DocIdentificacao").closest("td").find("label").removeClass("required");
        $("#AeroportoOrigem").closest("td").find("label").removeClass("required");
        $("#endereco").closest("td").find("label").removeClass("required");
        $("#cidade").closest("td").find("label").removeClass("required");
        $("#cep").closest("td").find("label").removeClass("required");
        $("#telefone").closest("td").find("label").removeClass("required");
    
        $(".dadosPessoais").addClass("hide");
    }

    return validationReturn;
}

//Busca contrato do usuário logado
function getDadosContrato() {

    var constraints = [];

    constraints.push(DatasetFactory.createConstraint("USER", getWKUserLogin(), getWKUserLogin(), ConstraintType.MUST));
    var dataset = DatasetFactory.getDataset("dsDadosContrato", null, constraints, null);

    $("#tomador").val(dataset.values[0].CTT_NOME.trim());
    $("#codigoCentroCusto").val(dataset.values[0].ZZA_CUSTO.trim());
    $("#filial").val(dataset.values[0].ZZA_FILIAL.trim());
    $("#armazem").val(dataset.values[0].ZZA_LOCAL.trim());
}

function preencheIdade(){
	var dataAtual = new Date,
	    ano_atual = dataAtual.getFullYear(),
	    mes_atual = dataAtual.getMonth() + 1,
	    dia_atual = dataAtual.getDate();
        
    var dataNascimento = $("#dataNascimento").val(), 
    	ano_aniversario = dataNascimento.substr(6,4),
        mes_aniversario = dataNascimento.substr(3,2),
        dia_aniversario = dataNascimento.substr(0,2);

   var idade = ano_atual - ano_aniversario;

    if (mes_atual < mes_aniversario || mes_atual == mes_aniversario && dia_atual < dia_aniversario) {
    	idade--;
    }
    
    $("#dataNasc").val($("#dataNascimento").val());
    $("#idade").val(idade < 0 ? 0 : idade);
}

function mostrarTermoRecusa(){
}

//Função para formatar hora nos inputs
function formatarHora(input){
	var inputId = input.id;
	var inputValue = $("#"+inputId).val();
	
	var inputValueFormatado = inputValue.replace(/[^0-9]/g, '');
	
	if(inputValueFormatado.length > 3){
		inputValueFormatado = inputValueFormatado.substr(0, 2)+":"+inputValueFormatado.substr(2, 2);
	}
	
	$("#"+inputId).val(inputValueFormatado)
	
	console.log("id:::"+inputId);
	console.log("value:::"+inputValue);
}