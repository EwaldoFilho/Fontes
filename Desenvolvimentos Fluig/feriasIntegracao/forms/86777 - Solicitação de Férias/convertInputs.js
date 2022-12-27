function formatar(){

    var abono1 = $("#abonoPecuniario1").val();
    var abono2 = $("#abonoPecuniario2").val();
    var data1 = $("#dt1programacao").val();  
    var data2 = $("#dt2programacao").val();   
    var dtBaseIni = $("#dataBaseIni").val(); 
    var dtBaseFim = $("#dataBaseFim").val(); 
    
    $("#dtFormatado1").val(data1.split("-").join(""));
    $("#dtFormatado2").val(data2.split("-").join(""));
    $("#dtBaseIni").val(dtBaseIni.split("/").reverse().join(""));
    $("#dtBaseFim").val(dtBaseFim.split("/").reverse().join(""));
 	 	
    if (abono1 == 'nao'){
        $("#qtAbono1").val("0");
    }else if(abono1 == 'sim'){
        $("#qtAbono1").val("10");
    }else if(abono1 == ''){
        $("#qtAbono1").val("0");
    }else if(abono1 == null){
        $("#qtAbono1").val("0");
    }
    if (abono2 == 'nao'){
        $("#qtAbono2").val("0");
    }else if(abono2 == 'sim'){
        $("#qtAbono2").val("10");
    }else if(abono2 == ''){
        $("#qtAbono2").val("0");
    }else if(abono2 == null){
        $("#qtAbono2").val("0");
    }
 }


