	var produtos = [];
	var state = $("#estado1").val();
	var produtosInput = "";
   
   console.log("Estado::"+state);

   if ($("#listaProdutos").val() != "") {
	  if(state == "4" || state == "6"){ 
        var prodInput = $("#listaProdutos").val();
		  produtosInput = "["+prodInput.replace("[","").replace("]","")+"]";
	      $("#listaProdutos").val(produtosInput);
	  }else{
		  produtosInput = $("#listaProdutos").val();
	      $("#listaProdutos").val(produtosInput);
	  }
      
      showTabelaProdutos(JSON.parse(produtosInput));
   }
   
   $('#tb_produtos').hide();
   
   if(state == "12" || state == "16"){
	   var table = document.getElementById("tb_produtos");
	   
	   produtosInput = JSON.parse($("#listaProdutos").val());

       for (var count = 0; count < produtosInput.length; count++) {

           var numOfRows = table.rows.length;
           var numOfCols = table.rows[numOfRows-1].cells.length;
           var newRow = table.insertRow(numOfRows);

           for (var j = 0; j < numOfCols; j++) {
             // Insere uma coluna na nova linha 
             newCell = newRow.insertCell(j);
             var valor = "";
             if(j==0){
               valor = produtosInput[count].cidProduto;
             }else if(j==1){
                 valor = produtosInput[count].produto; 
             }else if(j==2){
               valor = produtosInput[count].cquantidade; 
             }else if(j==3){
               valor = produtosInput[count].cobs; 
             }else if(j==4){
               valor = '<i class="flaticon flaticon-trash icon-md remover"></i>'; 
             }
             // Insere um conteúdo na coluna
             newCell.innerHTML = ""+ valor ;
           }
       }
       
       $('#tb_produtos').show();
       $('#produtosView').hide();
   }


   parent.$('#textActivity').hide();//oculta a descrição da atividade

   $("#modalBuscarProduto").click(function () {
      var myModal = FLUIGC.modal({
         title: 'Buscar produtos',
         content: '<form name="formModal" onsubmit="return false;">'+
            ' <div class="form-group col-sm-12">'+
               '<div class="alert alert-danger hidden" id="aviso" role="alert">'+
               'Preencha os campos obrigatórios'+
               '</div>'+
               '<div class="alert alert-danger hidden" id="avisoProdutoInvalido" role="alert">'+
                  '<span>Informe um produto válido.</span>'+
               '</div>'+
                  '<label for="produto" class="col-sm-12">Produto<strong class="required text-danger"></strong></label>'+
                  '<div class="input-group col-sm-12">'+
                     '<input type="hidden" id="codigoProdutoModal" name="codigoProdutoModal">'+
                     ' <input type="text" class="form-control" name="produtoModal" id="produtoModal" data-fluig-state-valid="0,4" data-fluig-write="0,4" required="required">'+
                     ' <div class="input-group-addon zoom-tdi" onclick="zoomProdutoModal(this)" data-toggle="tooltip" data-placement="bottom" title="Pesquisar produto"><i class="flaticon flaticon-search icon-sm"></i></div>'+
                  '</div>'+
               '</div>'+
               '<div class="form-group col-sm-12">'+
                  '<div class="input-group col-sm-12">'+               
                     '<label for="quantidade" class="col-sm-12">Quantidade<strong class="required text-danger"></strong></label>'+
                     '<input type="number" class="form-control" name="quantidadeModal" id="quantidadeModal"  data-fluig-state-valid="0,4" data-fluig-write="0,4" required="required">'+                  
                  '</div>'+
               '</div>'+
               '<div class="form-group col-sm-12">'+
                  '<div class="input-group col-sm-12">'+            
                     '<label for="observacao" class="col-sm-12">Observação<strong class="required text-danger"></strong></label>'+
                        '<textarea class="form-control" rows="5" name="observacaoModal" id="observacaoModal" data-fluig-state-valid="0,4" data-fluig-write="0,4" required="required"></textarea>'+
                  '</div>'+
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
         
         $("#observacaoModal").keyup(maskCharacters);
      
         $("#fluig-modal").find("button[data-search-modal]").on("click", function() {                  
            var table = document.getElementById("tb_produtos");
            var row = table.insertRow($('#tb_produtos tr').length);
            
            if (document.querySelector("#codigoProdutoModal").value == "" || document.querySelector("#codigoProdutoModal").value == null) {
               $("#avisoProdutoInvalido").removeClass("hidden");                     
            } else if(document.querySelector("#produtoModal").value=="" || document.querySelector("#produtoModal").value == null ||
               document.querySelector("#quantidadeModal").value=="" || document.querySelector("#quantidadeModal").value == null ||
               document.querySelector("#observacaoModal").value=="" || document.querySelector("#observacaoModal").value == null){     
                  $("#avisoProdutoInvalido").addClass("hidden");                      
                  $("#aviso").removeClass("hidden");
               }else{
                  row.innerHTML = '<tr>'+
                              '<td id="numeroProduto"> <span id="teste" name="teste">'+document.querySelector("#codigoProdutoModal").value+'</span></td>'+
                              '<td>'+document.querySelector("#produtoModal").value+'</td>'+
                              '<td>'+document.querySelector("#quantidadeModal").value+'</td>'+
                              '<td>'+document.querySelector("#observacaoModal").value+'</td>'+                                    
                              '<td class="text-center"><i class="flaticon flaticon-trash icon-md remover"></i></td>'+
                           '</tr>';
                  produtos.push("{"+'"cidProduto":"'+document.querySelector("#codigoProdutoModal").value+'", "produto":"'+document.querySelector("#produtoModal").value+'", "cquantidade":"'+document.querySelector("#quantidadeModal").value+'", "precoUnitario":"", "precoTotal":"", "formaPagamento":"", "fornecedor":"", "cobs":"'+document.querySelector("#observacaoModal").value+'"}');
                  $('#tb_produtos').show();
                  $('#labelProdutosAdicionais').show();                        
                  myModal.remove();
               }
               
               if ($("#listaProdutos").val() != "") {
                  var produtosInput = JSON.parse($("#listaProdutos").val());
               
                  if (produtosInput.length > 0) {
                     for (var countProd = 0; countProd < produtosInput.length; countProd++) {
                        produtos.push(JSON.stringify(produtosInput[countProd]));
                     }
                  }                  
               }

               if(produtos.length === 0){
            	   $("#listaProdutos").val("["+produtos+produtosString+"]");            	   
               }else{
            	   $("#listaProdutos").val(produtos);
               }
              
         });
      });        
   });

   $("#tb_produtos").on("click", ".remover", function(e){
	   $(this).closest('tr').remove();//remove a linha da tabela
	   
	   //pega os valores da tr
	   var infoProduto = $(this).closest("tr").find("td:not(:last-child)").map(function(){
		      return $(this).text().trim();
		   }).get();

	   var codProduto = infoProduto[0];
	   var produtos = JSON.parse($("#listaProdutos").val());
	   var produtosFiltrados = "";
	   
	   //retira o produto removido na tr
	   produtosFiltrados = produtos.filter(function(produto){
		    return produto.cidProduto != codProduto;
		});
	   
	   //atualiza input
	   $("#listaProdutos").val(JSON.stringify(produtosFiltrados));
         
      if ($('#tb_produtos tr').length === 1) {
         $('#tb_produtos').hide();
         $('#labelProdutosAdicionais').hide();   
         $("#listaProdutos").val([]);
      }
   });
   
   function showTabelaProdutos(produtosInput){
	   if (produtosInput.length > 0) {
	         var tabelaNovosProdutos = FLUIGC.datatable('#produtosView', {
	            dataRequest: produtosInput,
	            renderContent: ['produto', 'cquantidade', 'cobs'],
	            header: [
	               {'title': 'Produto'},
	               {'title': 'Quantidade'},
	               {'title': 'Observação'}
	            ],
	            tableStyle: 'table-bordered table-striped ',
	            search: {
	               enabled: false
	            },
	            scroll: {               
	               enabled: false
	            },
	            actions: {
	               enabled: false
	            },
	            navButtons: {
	               enabled: false
	            },
	            }, function(err, data) {               
	         });
	      }
   }

   function showCotacoes(){
         var produtos = JSON.parse($("#listaProdutos").val());

         if (produtos.length != 0) {
            var div = document.getElementById("montarInputCotacao");
            div.innerHTML = montarInputCotacoes(produtos);	      

            //seleciona o selected
            for (var countServico = 0; countServico < produtos.length; countServico++) {
               var select = document.getElementById('formaPagamento_'+countServico);
               var options = select.options;
               
               for (var index = 0; index < options.length; index++) {
                  if(options[index].value == produtos[countServico].formaPagamento){
                     select.options.selectedIndex = index;
                  }
                  
               }

            }
         }
         $("#countValidaInputProdutos").val(produtos.length);
   }

   function showAprovarCotacao(){
      var produtos = JSON.parse($("#listaProdutos").val());

      if (produtos.length != 0) {
         var div = document.getElementById("montarAprovacaoCotacao");
         div.innerHTML = montarLabelsCotacoes(produtos);	      
      }   
   }

   function montarLabelsCotacoes(produtos){      
      var linhas = "";

      for (var countServico = 0; countServico < produtos.length; countServico++) {
      var produto = produtos[countServico];
      
      var precoUnitario = produto.precoUnitario;      
      var precoTotal = parseInt(produto.cquantidade)*parseFloat(precoUnitario.replace("," , "."))
      
      linhas +=   '<form name="formValidarServico'+countServico+'">'+
                        '<div class="row col-md-12" data-type="input"  data-field-name="panelValidaServico" >'+
                           '<div class="form-group col-sm-4">'+
                              '<label for="produto" class="col-sm-12">Produto</label>'+
                              '<div class="col-sm-12">'+                                                                                                
                                 '<span>'+produto.produto+'</span>'+
                              '</div>'+
                           '</div> '+                      
                           '<div class="form-group col-sm-4">       '+
	                           '<label for="formaPagamento" class="col-sm-12">Forma de Pagamento<strong class="required text-danger"></strong></label>'+
	                           '<div class="col-sm-12">'+
		                           '<span>'+produto.formaPagamento+'</span>'+
		                           '</div>'+
	                           '</div>'+
	                           '<div class="form-group col-sm-4">'+
	                              '<label for="dataExecucaoServico" class="col-sm-12">Quantidade</label>'+
	                              '<div class="col-sm-12">'+                                                                                                
	                                 '<span>'+produto.cquantidade+'</span>'+   
	                              '</div>'+
	                           '</div> '+
	                        '</div>'+
	                        '<div class="row col-md-12" data-type="input"  data-field-name="panelValidaServico" >'+
	                           '<div class="form-group col-sm-4">'+
	                              '<label for="dataExecucaoServico" class="col-sm-12"></label>'+
	                              '<div class="col-sm-12">'+                                                                                                
	                                 '<span></span>'+   
	                              '</div>'+
	                           '</div> '+
	                           '<div class="form-group col-sm-4">       '+
	                              '<label for="dataExecucaoServico" class="col-sm-12">Valor unitário<strong class="required text-danger"></strong></label>'+
	                              '<div class="col-sm-12">'+
	                              '<span>R$'+produto.precoUnitario+'</span>'+
	                              '</div>'+
	                           '</div>'+
	                           '<div class="form-group col-sm-4">'+
	                           '<label for="dataExecucaoServico" class="col-sm-12">Valor total<strong class="required text-danger"></strong></label>'+
	                           '<div class="col-sm-12">'+
	                           '<span>R$'+precoTotal+'</span>'+
	                           '</div>'+
	                        '</div>'+
	                        '<div class="row col-md-12" data-type="input"  data-field-name="panelValidaServico" >'+
	                        	'<hr>'+
	                        '</div>'+
                        '</div>'+
                     '</form> '
                     
      }

   return linhas;

   }


   function montarInputCotacoes(produtos){      
      var linhas = "";

      for (var countServico = 0; countServico < produtos.length; countServico++) {
      var produto = produtos[countServico];
      
      linhas +=   '<form name="formValidarServico'+countServico+'">'+
                        '<div class="row col-md-12" data-type="input"  data-field-name="panelValidaServico" >'+
                           '<div class="form-group col-sm-6">'+
                              '<label for="produto" class="col-sm-12">Produto</label>'+
                              '<div class="col-sm-12">'+                                                                                                
                                 '<span>'+produto.produto+'</span>'+
                              '</div>'+
                           '</div> '+
                           '<div class="form-group col-sm-6">       '+
                           '<label for="formaPagamento" class="col-sm-12">Forma de Pagamento<strong class="required text-danger"></strong></label>'+
                           '<div class="col-sm-12">'+
                              '<select class="form-control"  name="formaPagamento_'+countServico+'" id="formaPagamento_'+countServico+'" data-fluig-state-valid="6" data-fluig-write="6" analytics="true" gooddataid="2" onchange="atualizarCotacoes()">'+
                              '<option value="" data-fluig-state-valid="6" data-fluig-write="6"></option>'+
                              '<option value="Boleto bancário a prazo" data-fluig-state-valid="6" data-fluig-write="6">Boleto bancário a prazo</option>		'+
                              ' <option value="Boleto bancário a vista" data-fluig-state-valid="6" data-fluig-write="6">Boleto bancário a vista</option>'+
                              ' <option value="Transferência bancária a prazo" data-fluig-state-valid="6" data-fluig-write="6">Transferência bancária a prazo</option>'+
                              ' <option value="Transferência bancária a vista " data-fluig-state-valid="6" data-fluig-write="6">Transferência bancária a vista </option>'+
                              ' <option value="Cartão de crédito parcelado" data-fluig-state-valid="6" data-fluig-write="6">Cartão de crédito parcelado</option>'+
                              ' <option value="Cartão de crédito 1x" data-fluig-state-valid="6" data-fluig-write="6">Cartão de crédito 1x</option>'+
                              '</select> '+
                           '</div>'+
                           '</div>'+                             				 
                        '</div>'+
                        '<div class="row col-md-12" data-type="input"  data-field-name="panelValidaServico" >'+
                        	'<div class="form-group col-sm-6">       '+
		                   		'<label for="dataExecucaoServico" class="col-sm-12">Quantidade</label>'+
		                        '<div class="col-sm-12">'+                                                                                                
		                          '<span>'+produto.cquantidade+'</span>'+   
		                        '</div>'+
		                   '</div>'+
                           '<div class="form-group col-sm-6">       '+
                              '<label for="dataExecucaoServico" class="col-sm-12">Valor unitário<strong class="required text-danger"></strong></label>'+
                              '<div class="col-sm-12">'+
                                 '<input type="text" name="precoUnitario_'+countServico+'" id="precoUnitario_'+countServico+'" class="form-control" data-fluig-state-valid="6" data-fluig-write="6" onblur="atualizarCotacoes()" value="'+produto.precoUnitario+'" mask="#00.000.000.000.000,00" >'+
                              '</div>'+
                           '</div>'+
                        '</div>'+
                        '<div class="row col-md-12" data-type="input"  data-field-name="panelValidaServico" >'+
	                    	'<hr>'+
	                    '</div>'+
                     '</form> '
      }

   return linhas;

   }

   function atualizarCotacoes(){
      var count = 0;

      var listaProdutos = JSON.parse($("#listaProdutos").val());

      do{
         var valorTotal = "";

         if ($("#precoUnitario_"+count).val() != "") {
            valorTotal = parseFloat($("#precoUnitario_"+count).val()) * parseFloat(listaProdutos[count].cquantidade);
         
            listaProdutos[count].precoUnitario = $("#precoUnitario_"+count).val();
            listaProdutos[count].formaPagamento = $("#formaPagamento_"+count).val();
            listaProdutos[count].fornecedor = $("#fornecedor_"+count).val();
            listaProdutos[count].precoTotal = valorTotal.toString();
         }
         count++;
      }while (count < listaProdutos.length);

      
      $("#listaProdutos").val(JSON.stringify(listaProdutos));
      
      console.log(listaProdutos);
      montarInputCotacoes(listaProdutos);
   }
   if(state == "6"){ 
      showCotacoes();
   } 

   if(state == "8"){ 
      showAprovarCotacao();
   } 

   if (state == "10") {
      var prodInput = $("#listaProdutos").val();
      showTabelaProdutos(JSON.parse(prodInput));

       $('#produtosView').show();
       
   }
