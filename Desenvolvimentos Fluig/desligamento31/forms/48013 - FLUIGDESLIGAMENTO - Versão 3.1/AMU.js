var initiateFunction



$(document).on("ready", function() {

    if (getMobile() == "true") {
        initiateFunction = setInterval(function() { initiate() }, 3000);
    } else {
        initiate()
    }

});


function initiate() {
    var data = new Date();
    var task = getWKNumState();
    $("#dataAmu").val(data.toLocaleDateString("pt-BR"));
    $("#nomeAtendente").val(getWKUserName());
    $("#horarioInicialCadastro").val(data.getHours() + ":" + data.getMinutes())


    if (task == "0" || task == "4") {
        aceitaColetaValidation();
    }

    $("#actualPage").val("1");

    setSignatureFunctions();

    validSignatures();

    clearInterval(initiateFunction);
    
    var dataNascimento = FLUIGC.calendar('#dataNascimento');
    dataNascimento.setMinDate(new Date());
    
    //Habilita a coleta de dados
    $('#aceitaColeta').prop('checked', true);
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

function aceitaColetaValidation() {

    var aceitaColeta = $("#aceitaColeta:checked").val();
    var validationReturn = false;

    if (aceitaColeta == "on") {

        validationReturn = true;
        
        $("#nome").closest("td").find("label").addClass("required");
        $("#email").closest("td").find("label").addClass("required");
        $("#Sexo1").closest("td").find("label").addClass("required");
        $("#Sexo2").closest("td").find("label").addClass("required");
        $("#Sexo2").closest("td").find("label").addClass("required");
        $("#nacionalidadeCodigo").closest("td").find("label").addClass("required");
        $("#dataNascimento").closest("td").find("label").addClass("required");
        $("#cpf").closest("td").find("label").addClass("required");
        $("#DocIdentificacao").closest("td").find("label").addClass("required");
        $("#AeroportoOrigem").closest("td").find("label").addClass("required");
        $("#endereco").closest("td").find("label").addClass("required");
        $("#cidade").closest("td").find("label").addClass("required");
        $("#cep").closest("td").find("label").addClass("required");
        $("#telefone").closest("td").find("label").addClass("required");
        
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
$("#recusado").change(function() {
	var inputAtendimento = $("#recusado").val();
		
		if(inputAtendimento == "SIM"){
		    //oculta obrigatoriedade
		    $("#localAtendimento").closest("td").find("label").removeClass("required");
		    $("#ladoArTerra").closest("td").find("label").removeClass("required");
		    $("#RespDados").closest("td").find("label").removeClass("required");	    
			//oculta aba informacoes
			$("#identificacao").hide();
			//apresenta aba de recusa de atendimento
		    $("#termoRecusa").show();
		}else{	    	    
		    //Add a obrigatoriedade dos campos 
		    $("#localAtendimento").closest("td").find("label").addClass("required");
		    $("#ladoArTerra").closest("td").find("label").addClass("required");
		    $("#RespDados").closest("td").find("label").addClass("required");
			//apresenta aba informacoes
			$("#identificacao").show();
			//oculta aba de recusa de atendimento
			$("#termoRecusa").hide();
		}
	});
