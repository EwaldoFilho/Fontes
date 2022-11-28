   function habilitaObrigatoriedade(){
      var validaProcesso = $("#validacaoJuridico").val();

      if (validaProcesso == "sim") {
         $("#habilitaContatoObrigatoriedade").show();
         $("#habilitaPrazoObrigatoriedade").show();   
      } else {
         $("#habilitaContatoObrigatoriedade").hide();
         $("#habilitaPrazoObrigatoriedade").hide();
      }      
   }

   function showValidarServico(){
      var servicos = JSON.parse($("#cotacoesInput").val());
      //var servicos =  JSON.parse('[{"codNumSc":"0001","codNumCotacao":"000168","loja":"01","filial":"0101","produto":"ACUPUNTURISTA (20H)","codProduto":"100000000000562","quantidade":"1","codArmazem":"01MZ01","fornecedores":[{"codItemCotacao":"0001","fornecedor":"000002","precoUnitario":"2.00","precoTotal":"2.00","taxaFrete":"0.00","ganhador":true,"prazoEntrega":"30 DIAS        ","codProduto":"100000000000562","nomeFornecedor":"SOS LIFE LTDA                                                                   ","lojaForn":"01"},{"codItemCotacao":"0001","fornecedor":"000001","precoUnitario":"3.00","precoTotal":"3.00","taxaFrete":"0.00","ganhador":false,"prazoEntrega":"30 DIAS","codProduto":"100000000000562","nomeFornecedor":"TESTE FORNECEDOR CNAB","lojaForn":"01"},{"codItemCotacao":"0001","fornecedor":"000006","precoUnitario":"3.00","precoTotal":"3.00","taxaFrete":"0.00","ganhador":false,"prazoEntrega":"30 DIAS        ","codProduto":"100000000000562","nomeFornecedor":"GLOBAL RADIOCOMUNICACAO LTDA                                                    ","lojaForn":"1 "}]},{"codNumSc":"0001","codNumCotacao":"000168","loja":"01","filial":"0101","produto":"ACUPUNTURISTA (20H)                                         ","codProduto":"100000000000562","quantidade":"1","codArmazem":"01MZ01","fornecedores":[{"codItemCotacao":"0001","fornecedor":"000002","precoUnitario":"2.00","precoTotal":"2.00","taxaFrete":"0.00","ganhador":false,"prazoEntrega":"30 DIAS        ","codProduto":"100000000000562","nomeFornecedor":"SOS LIFE LTDA                                                                   ","lojaForn":"01"},{"codItemCotacao":"0001","fornecedor":"000001","precoUnitario":"3.00","precoTotal":"3.00","taxaFrete":"0.00","ganhador":false,"prazoEntrega":"30 DIAS        ","codProduto":"100000000000562","nomeFornecedor":"TESTE FORNECEDOR CNAB                                                           ","lojaForn":"01"},{"codItemCotacao":"0001","fornecedor":"000006","precoUnitario":"3.00","precoTotal":"3.00","taxaFrete":"0.00","ganhador":true,"prazoEntrega":"30 DIAS        ","codProduto":"100000000000562","nomeFornecedor":"GLOBAL RADIOCOMUNICACAO LTDA","lojaForn":"1 "}]}]');

      var div = document.getElementById("montarInputServico");
      div.innerHTML = inputServicos(servicos);
      
      //seta no input quantos servicos foram solicitados
      $("#countValidaInputServico").val(servicos.length);
   }

   function inputServicos(servicos){      
      var linhas = "";

      for (var countServico = 0; countServico < servicos.length; countServico++) {
    	 var produto = servicos[countServico].produto;
         var fornecedores = servicos[countServico].fornecedores;         

         for (var countFornec = 0; countFornec < fornecedores.length; countFornec++) {
            if (fornecedores[countFornec].ganhador == true) {
               fornecedorGanhador = fornecedores[countFornec].nomeFornecedor;
            }            
         }         
        
         linhas +=   '<form name="formValidarServico">'+
				         '<div class="row col-md-12" data-type="input"  data-field-name="panelValidaServico" >'+
				            '<div class="form-group col-sm-4">'+
				               '<label for="dataExecucaoServico" class="col-sm-12">Produto</label>'+
				               '<div class="col-sm-12">'+                                                                                                
				                  '<span>'+servicos[countServico].produto+'</span>'+
				               '</div>'+
				            '</div> '+
				            '<div class="form-group col-sm-4">'+
				               '<label for="dataExecucaoServico" class="col-sm-12">Fornecedor</label>'+
				               '<div class="col-sm-12">'+                                                                                                
				                  '<span>'+fornecedorGanhador+'</span>'+
				               '</div>'+
				            '</div> '+
				            '<div class="form-group col-sm-4">       '+
				               '<label for="dataExecucaoServico" class="col-sm-12">Quantidade</label>'+
				               '<div class="col-sm-12">'+
				               '<span>'+servicos[countServico].quantidade+'</span>'+
				               '</div>'+
				            '</div>'+
				         '</div>'+
				     '</form> '
      }
      
      return linhas;

   }
   
   if(numState == "433" || numState == "511"){
	  showValidarServico(); 
   }
   
