function formatar(){

  
    var data = new Date();
    
    var valorFormatado = $("#valorTotal").val();
    
    v = valorFormatado.replace(/\D/g,''); 

    v = (v/100).toFixed(2) + '';
    v = v.replace(",", ".");
    v = v.replace(/(\d)(\d{3})(\d{3}),/g, "$1.$2.$3,");
    v = v.replace(/(\d)(\d{3}),/g, "$1.$2,");

    $("#valorFormatado").val(v);
    $("#dataFormatada").val(data.toLocaleDateString().split("/").reverse().join(""));
 	 	
 }


