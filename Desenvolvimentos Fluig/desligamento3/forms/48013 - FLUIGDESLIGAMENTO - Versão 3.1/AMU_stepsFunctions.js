function nextStep() {

    var actualPage = $("#actualPage").val();
    var toPage = ""
    var tagActualPage = ""
    var tagToPage = ""

    if (actualPage == "1") {

        if (validIdentificacao()) {
            var recusado = $("#recusado").val()
            $(".has-error-table").removeClass("has-error-table");

            if (recusado == "SIM") {

                toPage = "2";
                $(".btPrev").show(600);
                tagActualPage = "identificacao";
                tagToPage = "termoRecusa";
                $(".btNext").hide(600);
            } else {
                toPage = "2";
                $(".btPrev").show(600);
                tagActualPage = "identificacao";
                tagToPage = "Atendimento";
            }
        } else {
            FLUIGIP.USEFUL.showWarning("Preencha os campos marcados em vermelho!");
            return
        }

    } else if (actualPage == "2") {

        if (validAtendimento()) {

            $(".has-error-table").removeClass("has-error-table");

            toPage = "3";
            $(".btPrev").show(600);
            $(".btNext").hide(600);
            tagActualPage = "Atendimento";
            tagToPage = "diagnostico";
        } else {
            FLUIGIP.USEFUL.showWarning("Preencha os campos marcados em vermelho!");
            return
        }

    }

    $(".pageTitle" + actualPage).animate({
        "color": "#B81331 !important",
        "background-color": "transparent"
    }, 600, function() {
        $(".pageTitle" + actualPage).removeClass("actual");
    });

    $(".pageTitle" + toPage).animate({
        "color": "#fff !important",
        "background-color": "#B81331"
    }, 600, function() {
        $(".pageTitle" + toPage).addClass("actual");
    });

    $("#" + tagActualPage).hide();
    $("#" + tagToPage).show(600);

    $("#actualPage").val(toPage);
}

function previousStep() {

    var actualPage = $("#actualPage").val();
    var toPage = ""
    var tagActualPage = ""
    var tagToPage = ""

    if (actualPage == "2") {

        toPage = "1";
        $(".btPrev").hide(600);
        $(".btNext").show(600);
        tagActualPage = "Atendimento";
        tagToPage = "identificacao";
        $("#termoRecusa").hide();
    } else if (actualPage == "3") {
        toPage = "2";
        $(".btPrev").show(600);
        $(".btNext").show(600);
        tagActualPage = "diagnostico";
        tagToPage = "Atendimento";
    }

    $(".pageTitle" + actualPage).animate({
        "color": "#B81331 !important",
        "background-color": "transparent"
    }, 600, function() {
        $(".pageTitle" + actualPage).removeClass("actual");
    });

    $(".pageTitle" + toPage).animate({
        "color": "#fff !important",
        "background-color": "#B81331"
    }, 600, function() {
        $(".pageTitle" + toPage).addClass("actual");
    });

    $("#" + tagActualPage).hide();
    $("#" + tagToPage).show(600);

    $("#actualPage").val(toPage);
}

function validIdentificacao() {

    var validado = false;

    FLUIGIP.VALID.validateForm()

    var extraFields = validExtraFields1();

    if ($("#identificacao .has-error-table")[0] == undefined && extraFields) {
        validado = true;
    }

    if (getFormMode() == "VIEW") {
        validado = true;
    }

    return validado;
}

function validAtendimento() {

    var validado = false;

    FLUIGIP.VALID.validateForm()

    if ($("#Atendimento .has-error-table")[0] == undefined) {
        validado = true;
    }

    if (getFormMode() == "VIEW") {
        validado = true;
    }

    return validado;
}

function validateLiberacaoPassiente() {

    var libPassiente = $("#libPassiente").val();

    if (libPassiente == "REMOVIDO") {
        $("#removidoParaLine").show(600);
    } else {
        $("#removidoParaLine").hide(600);
    }
}

function validExtraFields1() {

    var valided = false;

    //Field 1:
    var auxValided1 = false;
    if ($("#AtendimentoPacienteSim:checked").val() == "on") {
        auxValided1 = true;
    }
    if ($("#AtendimentoPacienteNao:checked").val() == "on") {
        auxValided1 = true;
    }
    if ($("#AtendimentoOutroNaoAplicavel:checked").val() == "on") {
        auxValided1 = true;
    }

    if (!auxValided1) {
        $("#AtendimentoPacienteSim").closest("td").css("color", "#a94442");
    } else {
        $("#AtendimentoPacienteSim").closest("td").css("color", "#58595b");
    }

    //Field 2:
    var auxValided2 = false;
    if ($("#PacienteLugar1:checked").val() == "on") {

        if ($("#PacienteLugar1Comp").val() != "" && $("#PacienteLugar1Comp").val() != undefined) {
            auxValided2 = true;
        }
    }
    if ($("#PacienteLugar2:checked").val() == "on") {
        auxValided2 = true;
    }
    if ($("#PacienteLugar3:checked").val() == "on") {

        if ($("#PacienteLugar3Desloc").val() != "" && $("#PacienteLugar3Desloc").val() != undefined) {
            auxValided2 = true;
        }
    }
    if ($("#PacienteLugar4:checked").val() == "on") {
        auxValided2 = true;
    }

    if (!auxValided2) {
        $("#PacienteLugar1").closest("td").css("color", "#a94442");
    } else {
        $("#PacienteLugar1").closest("td").css("color", "#58595b");
    }

    //Field 3:
    var auxValided3 = false;
    if ($("#outrosDados1:checked").val() == "on") {

        auxValided3 = true;
    }
    if ($("#outrosDados2:checked").val() == "on") {

        auxValided3 = true;
    }
    if ($("#outrosDados3:checked").val() == "on") {

        auxValided3 = true;
    }
    if ($("#outrosDados4:checked").val() == "on") {

        auxValided3 = true;
    }
    if ($("#outrosDados5:checked").val() == "on") {

        auxValided3 = true;
    }
    if ($("#outrosDados6:checked").val() == "on") {

        auxValided3 = true;
    }

    if (!auxValided3) {
        $("#outrosDados1").closest("td").css("color", "#a94442");
    } else {
        $("#outrosDados1").closest("td").css("color", "#58595b");
    }

    //Field 4:
    var aceitaColeta = $("#aceitaColeta:checked").val();
    
    if (aceitaColeta == "on") {
	    var auxValided4 = false;
	    if ($("#Sexo1:checked").val() == "on") {
	
	        auxValided4 = true;
	    }
	    if ($("#Sexo2:checked").val() == "on") {
	
	        auxValided4 = true;
	    }
	
	    if (!auxValided4) {
	        $("#Sexo1").closest("td").css("color", "#a94442");
	    } else {
	        $("#Sexo1").closest("td").css("color", "#58595b");
	    }
    }else{
    	auxValided4 = true;
    }

    //Field 5:
    var auxValided5 = false;
    if ($("#ladoAr:checked").val() == "on") {

        auxValided5 = true;
    }
    if ($("#ladoTerra:checked").val() == "on") {

        auxValided5 = true;
    }

    if (!auxValided5) {
        $("#ladoAr").closest("td").css("color", "#a94442");
    } else {
        $("#ladoAr").closest("td").css("color", "#58595b");
    }

    if (auxValided1 && auxValided2 && auxValided3 && auxValided4 && auxValided5) {
        valided = true;
    }

    return valided;
}