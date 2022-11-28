function adicionarItemPlano(planoAcao, responsavelAcao, prazoAcao, statusAcao) {
    var id = wdkAddChild("tabledetailname5");
    var qtd = $("#qtdPlanoAcao").val();
    var atividade = getWKNumState();

    $("#planoAcao___" + id).val(planoAcao);
    $("#responsavelAcao___" + id).val(responsavelAcao);
    $("#prazoAcao___" + id).val(prazoAcao);
    $("#statusAcao___" + id).val(statusAcao);
    
    qtd++
    $("#qtdPlanoAcao").val(qtd);
}

function adicionarItemGastos(acaoEficaz, responsavelEficacia, dataEficacia) {
    var id = wdkAddChild("tabledetailname4");
    var qtd = $("#qtdEficacia").val();
    var atividade = getWKNumState();

    $("#acaoEficaz___" + id).val(acaoEficaz);
    $("#responsavelEficacia___" + id).val(responsavelEficacia);
    $("#dataEficacia___" + id).val(dataEficacia);
    

    qtd++
    $("#qtdEficacia").val(qtd);
    
    
}



function formatarData(input){
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