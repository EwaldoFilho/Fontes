var signaturePad

var myLoading2 = FLUIGC.loading(window, {
    textMessage: "Aguarde..."
});

function setSignatureFunctions() {

    var formMode = getFormMode();

    if (formMode == "VIEW") {

        $(".assinarButton").hide();
    }
}

function SignatureButtonClear() {

    signaturePad.clear();
}

function SignatureButtonConfirm() {

    $.ajax({
        url: '',
        beforeSend: function() {
            myLoading2.show();
        },
        complete: function() {

            var dataURL = signaturePad.toDataURL();
            var actualSignatureData = $("#atualSignature").val().split(",");

            document.getElementById(actualSignatureData[3]).src = dataURL;
            $("#" + actualSignatureData[0]).val(dataURL.replace("data:image/png;base64,", ""));

            $(".MainFormAMU").show();
            $(".SignatureScreen").hide();

            $([document.documentElement, document.body]).animate({
                scrollTop: $("#" + actualSignatureData[4]).offset().top
            }, 1000);

            $("#atualSignature").val("");
            myLoading2.hide();
        },
        error: {}
    });

}

function SignatureButtonDraw() {

    $(".SignatureButtonDraw").removeClass("btn-primary");
    $(".SignatureButtonDraw").addClass("btn-warning");

    $(".SignatureButtonErase").removeClass("btn-warning");
    $(".SignatureButtonErase").addClass("btn-primary");

    signaturePad.maxWidth = 2.5;

    var canvas = document.querySelector("#SignatureCanvas");
    var ctx = canvas.getContext('2d');
    ctx.globalCompositeOperation = 'source-over';
}

function SignatureButtonErase() {

    $(".SignatureButtonDraw").removeClass("btn-warning");
    $(".SignatureButtonDraw").addClass("btn-primary");

    $(".SignatureButtonErase").removeClass("btn-primary");
    $(".SignatureButtonErase").addClass("btn-warning");

    signaturePad.maxWidth = 20;

    var canvas = document.querySelector("#SignatureCanvas");
    var ctx = canvas.getContext('2d');
    ctx.globalCompositeOperation = 'destination-out';
}

function SignatureButtonBack() {

    $(".MainFormAMU").show();
    $(".SignatureScreen").hide(500);

    var actualSignatureData = $("#atualSignature").val().split(",");

    $([document.documentElement, document.body]).animate({
        scrollTop: $("#" + actualSignatureData[4]).offset().top
    }, 1000);

    $("#atualSignature").val("");
    signaturePad = null;
}

function SignatureButton(idAtualSignature) {

    if (idAtualSignature == '1') {
        $("#atualSignature").val("signatureImageData1,MedicoSME.png,Assinatura Medico SME,signatureImage1,hipoteseDeDiagnostico");
    } else if (idAtualSignature == '2') {
        $("#atualSignature").val("signatureImageData2,AssinaturaDeclaracao.png,Assinatura Declaração,signatureImage2,declaracao8");
    } else if (idAtualSignature == '3') {
        $("#atualSignature").val("signatureImageData3,AssinaturaTermoRecusa.png,Assinatura Termo Recusa,signatureImage3,AssinaturaTermoRecusa");
    }else if (idAtualSignature == '4') {
        $("#atualSignature").val("signatureImageData4,Assinatura.png,Assinatura,signatureImage4,Assinatura");
    }else if (idAtualSignature == '5') {
        $("#atualSignature").val("signatureImageData5,AssinaturaPaciente.png,Assinatura Paciente,signatureImage5,assinaturaPaciente");
    }else if (idAtualSignature == '6') {
        $("#atualSignature").val("signatureImageData6,AssinaturaRecusaRemocao.png,Assinatura ,signatureImage6,AssinaturaRecusaRemocao");
    }

    $(".MainFormAMU").hide(200, function() {
        $(".SignatureScreen").show(600);
    });

    var canvas = document.querySelector("#SignatureCanvas");
    signaturePad = new SignaturePad(canvas);
    signaturePad.maxWidth = 2.5;

}

function DownloadSignature(idAtualSignature) {

    var ImageBase64 = ""
    var nameFile = ""

    if (idAtualSignature == '1') {

        ImageBase64 = $("#signatureImageData1").val()
        nameFile = "Medico SME Assinatura.png"
    } else if (idAtualSignature == '2') {

        ImageBase64 = $("#signatureImageData2").val()
        nameFile = "Declaração Assinatura.png"
    } else if (idAtualSignature == '3') {
        ImageBase64 = $("#signatureImageData3").val()
        nameFile = "Termo Recusa Assinatura.png"
    } else if (idAtualSignature == '4') {
        ImageBase64 = $("#signatureImageData4").val()
        nameFile = "Assinatura.png"
    } else if (idAtualSignature == '5') {
        ImageBase64 = $("#signatureImageData5").val()
        nameFile = "Assinatura Paciente.png"
    }else if (idAtualSignature == '6') {
        ImageBase64 = $("#signatureImageData6").val()
        nameFile = "Assinatura Recusado.png"
    }

    if (ImageBase64 != "" && ImageBase64 != undefined) {

        var a = document.createElement("a");
        a.href = "data:image/png;base64," + ImageBase64;
        a.download = nameFile;
        a.click();
    }

}