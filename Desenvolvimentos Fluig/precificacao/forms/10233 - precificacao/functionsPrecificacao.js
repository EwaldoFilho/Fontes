

function formatarMoeda() {
  var elemento = document.getElementById('valorDocumentos');
  var valor = elemento.value;
  
  valor = valor + '';
  valor = parseInt(valor.replace(/[\D]+/g,''));
  valor = valor + '';
  valor = valor.replace(/([0-9]{2})$/g, ",$1");

  if (valor.length > 6) {
    valor = valor.replace(/([0-9]{3}),([0-9]{2}$)/g, ".$1,$2");
  }

  elemento.value = valor;
}

function formatarMoeda(input){
	var inputId = input.id;
	var inputValue = $("#"+inputId).val();
	
	inputValue = inputValue + '';
	inputValue = parseInt(inputValue.replace(/[\D]+/g,''));
	inputValue = inputValue + '';
	inputValue = inputValue.replace(/([0-9]{2})$/g, ",$1");
	
	if(inputValue.length > 6){
		inputValue = inputValue.replace(/([0-9]{3}),([0-9]{2}$)/g, ".$1,$2");
	}
	
	$("#"+inputId).val(inputValue)
	
	console.log("id:::"+inputId);
	console.log("value:::"+inputValue);
}

function buttom1Validation() {

    var recursosHjCheckbox = $("#recursosHjCheckbox:checked").val();
    var validationReturn = false;

    if (recursosHjCheckbox == "on"){

    validationReturn = true;

    $("#dados_recursos_humanos").show();              
    $("#existeRh").val(true);
    } else{
    $("#dados_recursos_humanos").hide();
    $("#existeRh").val(false);
    }
    return validationReturn;
}

function buttom2Validation() {

    var aliquotaIssCheckbox = $("#aliquotaIssCheckbox:checked").val();
    var validationReturn = false;
    

    if (aliquotaIssCheckbox == "on" ) {

        validationReturn = true;
        
        $("#dados_financeiro").show();              
        $("#existefinanceiro").val(true);
    } else {
    	$("#dados_financeiro").hide();
    	$("#existefinanceiro").val(false);
    }

    return validationReturn;
}
function buttom3Validation() {

    var uniformeEpiCheckbox = $("#uniformeEpiCheckbox:checked").val();
    var validationReturn = false;
    

    if (uniformeEpiCheckbox == "on" ) {

        validationReturn = true;
        
        $("#dados_uniformes_epi").show();              
        $("#existeUniformes").val(true);
    } else {
    	$("#dados_uniformes_epi").hide();
    	$("#existeUniformes").val(false);
    }

    return validationReturn;
}
function buttom4Validation() {

    var avaliacoesCheckbox = $("#avaliacoesCheckbox:checked").val();
    var validationReturn = false;
    

    if (avaliacoesCheckbox == "on" ) {

        validationReturn = true;
        
        $("#dados_avaliacoes").show();              
        $("#existeAVA").val(true);
    } else {
    	$("#dados_avaliacoes").hide();
    	$("#existeAVA").val(false);
    }

    return validationReturn;
}
function buttom5Validation() {

    var suprimentosDgCheckbox = $("#suprimentosDgCheckbox:checked").val();
    var validationReturn = false;
    

    if (suprimentosDgCheckbox == "on" ) {

        validationReturn = true;
        
        $("#dadosSuprimentos").show();              
        $("#existeSuprimentos").val(true);
    } else {
    	$("#dadosSuprimentos").hide();
    	$("#existeSuprimentos").val(false);
    }

    return validationReturn;
}
function buttom6Validation() {

    var examescompCheckbox = $("#examescompCheckbox:checked").val();
    var validationReturn = false;
    

    if (examescompCheckbox == "on" ) {

        validationReturn = true;
        
        $("#dadosExames").show();              
        $("#existeExame").val(true);
    } else {
    	$("#dadosExames").hide();
    	$("#existeExame").val(false);
    }

    return validationReturn;
}
function buttom7Validation() {

    var supriLocCheckbox = $("#supriLocCheckbox:checked").val();
    var validationReturn = false;
    

    if (supriLocCheckbox == "on" ) {

        validationReturn = true;
        
        $("#dadosLocacao").show();              
        $("#existeLocacao").val(true);
    } else {
    	$("#dadosLocacao").hide();
    	$("#existeLocacao").val(false);
    }

    return validationReturn;
}
function buttom8Validation() {

    var treinamentoCheckbox = $("#treinamentoCheckbox:checked").val();
    var validationReturn = false;
    

    if (treinamentoCheckbox == "on" ) {

        validationReturn = true;
        
        $("#dadosTreinamento").show();              
        $("#existeTreinamento").val(true);
    } else {
    	$("#dadosTreinamento").hide();
    	$("#existeTreinamento").val(false);
    }

    return validationReturn;
}
function buttom9Validation() {

    var juridicoImpLocCheckbox = $("#juridicoImpLocCheckbox:checked").val();
    var validationReturn = false;
    

    if (juridicoImpLocCheckbox == "on" ) {

        validationReturn = true;
        
        $("#dadosImpugnacao").show();              
        $("#existeJuri").val(true);
    } else {
    	$("#dadosImpugnacao").hide();
    	$("#existeJuri").val(false);
    }

    return validationReturn;
}

function buttom10Validation() {

    var cotacaoSegCheckbox = $("#cotacaoSegCheckbox:checked").val();
    var validationReturn = false;
    

    if (cotacaoSegCheckbox == "on" ) {

        validationReturn = true;
        
        $("#dadosCotacao").show();              
        $("#existeCotacao").val(true);
    } else {
    	$("#dadosCotacao").hide();
    	$("#existeCotacao").val(false);
    }

    return validationReturn;
}

function buttom11Validation() {

    var documentoCheckbox = $("#documentoCheckbox:checked").val();
    var validationReturn = false;
    

    if (documentoCheckbox == "on" ) {

        validationReturn = true;
        
        $("#dadosDocumentos").show();              
        $("#existeDocumento").val("1");
    } else {
    	$("#dadosDocumentos").hide();
    	$("#existeDocumento").val("2");
    }

    return validationReturn;
}

function buttom12Validation() {

    var SistemasCheckbox = $("#SistemasCheckbox:checked").val();
    var validationReturn = false;
    

    if (SistemasCheckbox == "on" ) {

        validationReturn = true;
        
        $("#dadosTecnologia").show();              
        $("#existeTI").val(true);
    } else {
    	$("#dadosTecnologia").hide();
    	$("#existeTI").val(false);
    }

    return validationReturn;
}
function buttom13Validation() {

    var ProgramasSmsCheckbox = $("#ProgramasSmsCheckbox:checked").val();
    var validationReturn = false;
    

    if (ProgramasSmsCheckbox == "on" ) {

        validationReturn = true;
        
        $("#dadosAREATECNICA").show();              
        $("#existesms").val(true);
    } else {
    	$("#dadosAREATECNICA").hide();
    	$("#existesms").val(false);
    }

    return validationReturn;
}