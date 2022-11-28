$("#tb_produtos").on("click", ".remover", function(e){
    $(this).closest('tr').remove();
    
      var tableData = $(this).closest("tr").find("td:not(:last-child)").map(function(){
          return $(this).text().trim();
       }).get();
      
      var listaProd = "";
      var listaProdAtualizada = [];
      
       var produtosFormatados = $("#listaProdutos").val();
       listaProd = JSON.parse("["+produtosFormatados.replace(/[\[\]]/g, "")+"]");	  
            
      for(var count=0; count < listaProd.length; count++){
          if(tableData[0] != listaProd[count].cidProduto){
              listaProdAtualizada.push(listaProd[count]);
          }
      }
      
      $("#listaProdutos").val(JSON.stringify(listaProdAtualizada));               
       
    if ($('#tb_produtos tr').length == 1) {
       $('#tb_produtos').hide();
       $('#labelProdutosAdicionais').hide();
       $("#listaProdutos").val("");
       produtos = [];
    }
 });

$("#modalBuscarProduto").click(function () {
      var myModal = FLUIGC.modal({
         title: 'Buscar produtos',
         content: '<form name="formModal" style="background-image: url(http://portal.medmais.com:8007/portal/api/servlet/image/0101001/custom/abstrato-branco-3d.jpg);" onsubmit="return false;">'+
			         '<div>'+
			         '<div class="row">'+
			            '<div class="form-group col-sm-12 ms-left">'+
			               '<div class="input-group col-sm-12">'+
			                     '<div class="alert alert-danger hidden" id="aviso" role="alert">'+
			                        'Preencha os campos obrigatórios'+
			                     '</div>'+
			                     '<div class="alert alert-danger hidden" id="avisoProdutoInvalido" role="alert">'+
			                        '<span>Informe um produto válido.</span>'+
			                     '</div>'+
			                     '<div class="alert alert-danger hidden" id="avisoQtdLimitProdInvalido" role="alert">'+
			                        '<span>Só é permitido cadastrar 50 itens.</span>'+
			                     '</div>'+
			                  '</div>'+
			            '</div>'+
			         '</div>'+
			         ''+
			         '<div class="row">'+
			            '<div class="form-group col-sm-12 ms-left"> '+
			            	  '<label for="produto">Produto<strong class="required text-danger"></strong></label>'+
			                  '<div class="input-group col-sm-12">  '+
			                     '<input type="hidden" id="codigoProdutoModal" name="codigoProdutoModal">'+
			                     '<input type="text" class="form-control" name="produtoModal" id="produtoModal" readonly="readonly" placeholder="Clique na lupa para selecionar o produto" required="required">'+
			                     '<div class="input-group-addon zoom-tdi" onclick="zoomProdutoModal(this)" data-toggle="tooltip" data-placement="bottom" title="Pesquisar produto">'+
			                        '<i class="flaticon flaticon-search icon-sm"></i>'+
			                     '</div>'+
			                  '</div>'+
			           '</div>'+
			         '</div>'+
			         ''+
			         '<div class="row">'+
			            '<div class="form-group col-sm-12 ms-left" style="display: flex !important;">'+ 
			               '<div class="input-group col-sm-6">'+  
			                     '<label for="quantidade">Quantidade<strong class="required text-danger"></strong></label>'+
			                     '<input type="number" class="form-control" name="quantidadeModal" id="quantidadeModal"  data-fluig-state-valid="0,4" data-fluig-write="0,4" required="required" min="0">'+
			                  '</div>'+
			                  '<div class="input-group col-sm-6" style="margin-left: 1%;">'+
			                     '<label for="valorOrcamento">Orçamento Disponível no Contrato<strong class="required text-danger"></strong></label>'+
			                     '<input type="text" class="form-control" name="valorOrcamentoModal" id="valorOrcamentoModal"  data-fluig-state-valid="0,4" data-fluig-write="0,4" required="required" mask="#00.000.000.000.000,00">'+
			                  '</div>'+
			            '</div>'+
			         '</div>'+
			         ''+
			         '<div class="row">'+
			            '<div class="form-group col-sm-12 ms-left">'+ 
			               '<div class="input-group col-sm-12">'+
			                     '<label for="especificacaoTecnica">Especificação técnica<strong class="required text-danger"></strong></label>'+
			                     '<textarea class="form-control" rows="5" name="especificacaoTecnicaModal" id="especificacaoTecnicaModal" onpaste="return false" data-fluig-state-valid="0,4" data-fluig-write="0,4" required="required"></textarea>'+                  
			                  '</div>'+
			            '</div>'+
			         '</div>'+
			         ''+			         
			      '</div>'+                  
			    '</form>',
         id: 'fluig-modal',
         size: 'full',
         actions: [{
            'label': 'Adicionar',
            'bind' : "data-search-modal",
         },{
            'label': 'Cancelar',
            'autoClose': true
         }]
      }, function() {
         function maskCharacters() {  
            var regex = new RegExp('[^ }{,.^?~=+\-_\/*\-+.\ 0-9a-zA-Zàèìòùáéíóúâêîôûãõ\b@,.]', 'g');       
            $(this).val($(this).val().replace(regex, ''));
         }
         
         function validarQuantidadeProduto(){
        	 var quantidadeProd = $(this).val();
        	 if	(quantidadeProd < 0){
        		 $(this).val("");	 
        	 }
         }
         
         function formatarInput() {
             var atual = $("#valorOrcamentoModal").val();
             
             v = atual.replace(/\D/g,''); 

             v = (v/100).toFixed(2) + '';
             v = v.replace(".", ",");
             v = v.replace(/(\d)(\d{3})(\d{3}),/g, "$1.$2.$3,");
             v = v.replace(/(\d)(\d{3}),/g, "$1.$2,");

             $("#valorOrcamentoModal").val(v);
         }
         
         $("#valorOrcamentoModal").keyup(formatarInput);
         
         $("#quantidadeModal").keyup(validarQuantidadeProduto);        
        
      
         $("#fluig-modal").find("button[data-search-modal]").on("click", function() {                  
            var table = document.getElementById("tb_produtos");
            var row = table.insertRow($('#tb_produtos tr').length);   
            
            if (document.querySelector("#codigoProdutoModal").value == "" || document.querySelector("#codigoProdutoModal").value == null) {
               $("#avisoProdutoInvalido").removeClass("hidden");                     
            } else if(document.querySelector("#produtoModal").value=="" || document.querySelector("#produtoModal").value == null ||
               document.querySelector("#quantidadeModal").value=="" || document.querySelector("#quantidadeModal").value == null ||
               document.querySelector("#valorOrcamentoModal").value=="" || document.querySelector("#valorOrcamentoModal").value == null  ||
               document.querySelector("#especificacaoTecnicaModal").value=="" || document.querySelector("#especificacaoTecnicaModal").value == null ){     
                  $("#avisoProdutoInvalido").addClass("hidden");                      
                  $("#aviso").removeClass("hidden");
               }else{
            	  var produtosValidar = JSON.parse("["+$('#listaProdutos').val()+"]");
            	  
            	  if(produtosValidar.length < 50){
	                      row.innerHTML = '<tr>'+
		                      '<td>'+document.querySelector("#codigoProdutoModal").value+'</td>'+
		                      '<td>'+document.querySelector("#produtoModal").value+'</td>'+
		                      '<td>'+document.querySelector("#quantidadeModal").value+'</td>'+
		                      '<td>'+document.querySelector("#valorOrcamentoModal").value+'</td>'+
		                      '<td>'+document.querySelector("#especificacaoTecnicaModal").value+'</td>'+		                                                        
		                      '<td class="text-center"><i class="flaticon flaticon-trash icon-md remover"></i></td>'+
	                      '</tr>';
	                      produtos.push("{"+'"cidProduto":"'+document.querySelector("#codigoProdutoModal").value+'", "produto":"'+document.querySelector("#produtoModal").value+'", "cquantidade":"'+document.querySelector("#quantidadeModal").value+'", "cvalororcamentario":"'+document.querySelector("#valorOrcamentoModal").value+'", "cespecificacaoTecnica":"'+document.querySelector("#especificacaoTecnicaModal").value+'"}');
			          $('#tb_produtos').show();
			          $('#labelProdutosAdicionais').show();                        
			          myModal.remove();            		  
            	  }else{
            		  $("#avisoQtdLimitProdInvalido").removeClass("hidden"); 
            	  }
               }
               $("#listaProdutos").val(produtos);
         });
      });        
   });