function calculaAviso() {
	var state = $("#estado").val();
	var programa1 = $("#programado1").val();
	var programa2 = $("#programado2").val();
	var qDias1 = $("#qtDias1").val();
	var qDias2 = $("#qtDias2").val();
	var data1 = new Date();
	var data2 = new Date();
	var dt1programacao =  $("#dt1programacao").val();
	var dt2programacao = $("#dt2programacao").val();
	var dt1programaf =  dt1programacao.toLocaleDateString().split("/").reverse().join("");
	var dt2programaf =  dt2programacao.val(dt2programacao.toLocaleDateString().split("/").reverse().join(""));
	var dataGozo1 = dt1programacao.setDate(dt1programacao.getDate()+ qDias1);
	var dataGozo2 = dt2programacao.setDate(dt2programacao.getDate()+ qDias2);	
    if (state != 32) {

        if (programa1 == null || programa1 == 'nao' && programa2 == 'nao' || programa2 == null) {
            $("#panelDadosSolicitacao").hide();
            $("#panelDadosSolicitante").hide();
            $("#panelAvisoFerias1").show();
            $("#panelAvisoFerias2").show();
            $("#PERIODODEGOZOIMP1").val(dt1programacao);
            $("#PERIODODEGOZOIMP2").val(dt2programacao);
            $("#RETORNOTRABALHO1").val(dataGozo1);
            $("#RETORNOTRABALHO2").val(dataGozo2);            
            
        }else if(programa1 == 'sim') {
            $("#panelDadosSolicitacao").hide();
            $("#panelDadosSolicitante").hide();
            $("#panelAvisoFerias1").hide();
            $("#panelAvisoFerias2").show();
            $("#PERIODODEGOZOIMP2").val(dt2programacao);
            $("#RETORNOTRABALHO2").val(dataGozo2);  

        }else if(programa2 == 'sim'){
            $("#panelDadosSolicitacao").hide();
            $("#panelDadosSolicitante").hide();
            $("#panelAvisoFerias1").show();
            $("#panelAvisoFerias2").hide();
            $("#PERIODODEGOZOIMP1").val(dt1programacao);
            $("#RETORNOTRABALHO1").val(dataGozo1);
        }
    }
}