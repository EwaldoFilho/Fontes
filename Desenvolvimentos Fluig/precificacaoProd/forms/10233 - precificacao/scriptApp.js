		$("#dados_recursos_humanos").hide();
        $("#dados_financeiro").hide();
	    $("#dados_uniformes_epi").hide();
        $("#dados_avaliacoes").hide();
        $("#dadosSuprimentos").hide();
        $("#dadosExames").hide();
        $("#dadosLocacao").hide();
        $("#dadosTreinamento").hide();
        $("#dadosImpugnacao").hide();
        $("#dadosCotacao").hide();
        $("#dadosDocumentos").hide();
        $("#dadosTecnologia").hide();
        $("#dadosAREATECNICA").hide();
        
   
   var numState = getValue("WKNumState");           
        
        if(numState == "20" || numState == "54" ||numState == "433" || numState == "511" || numState == "515" || numState == "500" || numState == "132"){
     	   $('#dados_recursos_humanos').show();
        }