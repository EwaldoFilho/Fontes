var state = $("#estado").val();
var programa1 = $("#programado1").val();
var programa2 = $("#programado2").val();
$(document).ready(function () {
    if (state == 32) {

        if (programa1 == null || programa1 == 'nao' && programa2 == 'nao' || programa2 == null) {
            $("#panelDadosSolicitacao").hide();
            $("#panelDadosSolicitante").hide();
            $("#panelAvisoFerias1").show();
            $("#panelAvisoFerias2").show();
        }else if(programa1 == 'sim') {
            $("#panelDadosSolicitacao").hide();
            $("#panelDadosSolicitante").hide();
            $("#panelAvisoFerias1").hide();
            $("#panelAvisoFerias2").show();

        }else if(programa2 == 'sim'){
            $("#panelDadosSolicitacao").hide();
            $("#panelDadosSolicitante").hide();
            $("#panelAvisoFerias1").show();
            $("#panelAvisoFerias2").hide();
        }
    }
})