 function validacaoEmail(field) {
            usuario = field.value.substring(0, field.value.indexOf("@"));
            dominio = field.value.substring(field.value.indexOf("@")+ 1, field.value.length);
            
            if ((usuario.length >=1) &&
                (dominio.length >=3) &&
                (usuario.search("@")==-1) &&
                (dominio.search("@")==-1) &&
                (usuario.search(" ")==-1) &&
                (dominio.search(" ")==-1) &&
                (dominio.search(".")!=-1) &&
                (dominio.indexOf(".") >=1)&&
                (dominio.lastIndexOf(".") < dominio.length - 1)) {
            document.getElementById("msgemail").innerHTML="E-mail válido";
            alert("E-mail valido");
            }
            else{
            document.getElementById("msgemail").innerHTML="<font color='red'>E-mail inválido </font>";
            alert("E-mail invalido");
            }
}
 
 
 
 function adicionarCandidato() {
	    var id = wdkAddChild("adicionarCandidato");
	    var qtd = $("#qtdCandidato").val();
	    var atividade = getWKNumState();   
	   
	    qtd++
	    $("#qtdCandidato").val(qtd);
	    
	    
	   
	}
 
 
 function Concatena()
 {
   //atribui a variável nome o valor do input cujo id = nome
   var numero = document.getElementById('RA_LOGRNUM').value;  
   
   //concatena 
   document.getElementById('RA_NUMENDE').value=numero;
 }
 function ConcatenaLog()
 {
   //atribui a variável nome o valor do input cujo id = nome
   var tLog = document.getElementById('RA_LOGRTP').value;
   var descLog = document.getElementById('RA_LOGRDSC').value;
 
   $("#RA_ENDEREC").val(tLog+". " +descLog);
 }
 
 function HorasDia()
 {
   //atribui a variável nome o valor do input cujo id = nome
   var hMes = document.getElementById('RA_HRSMES').value;
   var x = "".maxLength = "12";
   var y = parseInt(hMes);
   var z = "";

    x = hMes/30;
    z = hMes/5;
    
   $("#RA_HRSDIA").val(x.toFixed(4));
   $("#RA_HRSEMAN").val(z.toFixed(2));
   
   if(hMes > 220){
	   $("#RA_HRSMES").val("");
	   $("#RA_HRSDIA").val("");
	   $("#RA_HRSEMAN").val("");
	   Swal.fire({
           icon: 'warning',
           title: 'Carga horária máxima mensal até 220 horas'})           
   }else{
	   $("#RA_HRSMES").val(y.toFixed(2));
   }
   
 }
  
 function salarioInput()
 {
   //atribui a variável nome o valor do input cujo id = nome
   var salario = document.getElementById('RA_SALARIO').value;
   var x = "".maxLength = "12";
   var y = (salario, typeof n) 
    
   $("#RA_SALARIO").val(y.toFixed(2));
   $("#RA_SALARIO").mask("####,##", {reverse: true});
        
 }
 
 function formatar(){

	 var valid = document.getElementById('RA_ADMISSA').value;
	    
	 if(valid == ""){
		 Swal.fire({
	           icon: 'warning',
	           title: 'Favor Informar data de admissão.'})
	   
	 }else{		 
	        var data = new Date();		    
		    var valorFormatado = $("#RA_SALARIO").val();
		    var dataFormatada = $("#RA_ADMISSA").val();
		    
		    v = valorFormatado.replace(/\D/g,''); 

		    v = (v/100).toFixed(2) + '';
		    v = v.replace(",", ".");
		    v = v.replace(/(\d)(\d{3})(\d{3}),/g, "$1.$2.$3,");
		    v = v.replace(/(\d)(\d{3}),/g, "$1.$2,");

		    $("#valorFormatado").val(v);
		    $("#dataFormatada").val(dataFormatada.split("-").join(""));
		    $("#RA_OPCAO").val(dataFormatada.split("-").join(""));	
	 }


 }
 