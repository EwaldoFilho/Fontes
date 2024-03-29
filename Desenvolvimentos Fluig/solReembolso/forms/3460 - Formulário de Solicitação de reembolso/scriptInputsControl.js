// script para controlar os selects forma de pagamento, tipo pix  e aprovação CEO
$("#formaPagamento").change(function() {
    var formaPagamento = $("#formaPagamento").val();
    
    if(formaPagamento == "deposito"){
        // apresenta campos
        $("#formaDadosBanco").show();
        $("#formaPagamentoBanco").show();
        //oculta campos
        $("#formaPagamentoPix").hide();
    }else if(formaPagamento == "pix"){	    	    
        // apresenta campos
        $("#formaPagamentoPix").show();
        //oculta campos
        $("#formaDadosBanco").hide();
        $("#formaPagamentoBanco").hide();

    }else{
        $("#formaPagamentoPix").hide();
        $("#formaDadosBanco").hide();
        $("#formaPagamentoBanco").hide();   
    }
    
    //limpeza inputs
    $("#banco").val("");
    $("#tipoConta").val("");
    $("#agencia").val("");
    $("#agenciaDV").val("");
    $("#conta").val("");
    $("#contaDV").val("");
});

$("#chavePix").change(function() {
    var formaPagamentoPix = $("#chavePix").val();
        
    if(formaPagamentoPix == "cpf"){
        // apresenta campos
        $("#pixCpf").show();

        //oculta campos
        $("#pixCnpj").hide();
        $("#pixEmail").hide();
        $("#pixTelefone").hide();
        $("#pixChaveAleatoria").hide();
    }else if(formaPagamentoPix == "cnpj"){	    	    
        // apresenta campos
        $("#pixCnpj").show();

        //oculta campos
        $("#pixCpf").hide();
        $("#pixEmail").hide();
        $("#pixTelefone").hide();
        $("#pixChaveAleatoria").hide();
    }else if(formaPagamentoPix == "email"){	    	    
        // apresenta campos
        $("#pixEmail").show();
        //oculta campos
        $("#pixCpf").hide();
        $("#pixCnpj").hide();
        $("#pixTelefone").hide();
        $("#pixChaveAleatoria").hide();

    }else if(formaPagamentoPix == "telefone"){	
        //apresenta campos
        $("#pixTelefone").show();
        //oculta campos
        $("#pixCpf").hide();
        $("#pixCnpj").hide();
        $("#pixEmail").hide();
        $("#pixChaveAleatoria").hide();
    }else if(formaPagamentoPix == "chaveAleatoria"){	
        //apresenta campos 
        $("#pixChaveAleatoria").show();
        //oculta campos
        $("#pixCpf").hide();
        $("#pixCnpj").hide();
        $("#pixEmail").hide();
        $("#pixTelefone").hide();
    }else{
        $("#pixCpf").hide(); 
        $("#pixCnpj").hide();
        $("#pixEmail").hide();
        $("#pixTelefone").hide();            
        $("#pixChaveAleatoria").hide(); 
    }

        //limpeza inputs
        $("#cpf").val("");
        $("#cnpj").val("");
        $("#email").val("");
        $("#telefone").val("");
        $("#chaveAleatoria").val("");
});

$("#isAprovado").change(function() {
    var isAprovado = $("#isAprovado").val();

    if(isAprovado == "false"){
        // apresenta campos
        $("#justCEO").show();
    }else if(isAprovado == "true"){	    	    
        //oculta campos
        $("#justCEO").hide();

    }else{
        $("#justCEO").hide();
    }
    
    //limpeza do input
    $("#justificativaCEO").val("");
});