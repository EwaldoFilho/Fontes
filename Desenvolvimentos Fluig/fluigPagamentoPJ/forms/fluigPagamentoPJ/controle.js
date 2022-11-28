$("#tipoRegime").change(function() {
    var tipoRegime = $("#tipoRegime").val();
        
    if(tipoRegime == "SimplesMei"){
        // apresenta campos
        $("#panelDadosMEI").show();
                //oculta campos
        $("#panelDadosPJ").hide();
    }else if(tipoRegime == "Outros"){	    	    
        // apresenta campos
        $("#panelDadosPJ").show();
        //oculta campos
        $("#panelDadosMEI").hide();
        
    }else if(tipoRegime == ""){	    	    
        // apresenta campos
        $("#panelDadosPJ").hide();
        //oculta campos
        $("#panelDadosMEI").hide();
        
    }
});
