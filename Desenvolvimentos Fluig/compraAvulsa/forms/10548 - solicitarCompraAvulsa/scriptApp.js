   $('#tb_produtos').hide();       
   $('#labelProdutosAdicionais').hide();
   parent.$('#textActivity').hide();
   
   var inputCentroCusto = document.getElementById("descricao");
   var inputEmpresa = document.getElementById("empresa");
   
   var produtos = [];
   var produtosNovos = [];
   
   var numeroProcesso = $("#processo").val();
   var numState = $("#estado").val();
   
   var produtosInput = "";

   console.log("Num estado: "+numState);
   
   //Eventos para não permitir o usuário a digitar ou apagar conteudo no input 
   inputCentroCusto.addEventListener("keypress", function(event){
       event.preventDefault();
   });

   inputEmpresa.addEventListener("keypress", function(event){
       event.preventDefault();
   });

   inputCentroCusto.addEventListener('keydown', function(event) {
       const key = event.key;
       if (key === "Backspace" || key === "Delete") {
           event.preventDefault();
       }
   });

   inputEmpresa.addEventListener('keydown', function(event) {
       const key = event.key;
       if (key === "Backspace" || key === "Delete") {
           event.preventDefault();
       }
   });
   
   if(numState != "0"){
	   var produtosFormatados = $("#listaProdutos").val();
	   produtosInput = JSON.parse("["+produtosFormatados.replace(/[\[\]]/g, "")+"]");	   
   }
   
   if(numState == "4" || numState == "54" ||numState == "433" || numState == "511" || numState == "515" || numState == "500" || numState == "132"){
	   $('#tb_produtos').show();
   }
   
   if(numState == "511"){
 	  showValidarServico();  
   }
   
   if(numState == "54"){
	      parent.$("#workflowActions").hide();
   }