    var div = document.getElementById("dsCotacoes");
    var numeroProcesso = $("#processo").val();



    function carregarCotacao(){
      if(numState != "0" && numState != "54"){
         var cotacoes = getDadosCotacoes();
         var cotacoesColumns = cotacoes.columns;
         var cotacoesValues = cotacoes.values;
         
         if(cotacoesValues.length > 0){
            var produtosFormatados = formatarProdutos(cotacoesValues);
            
            montarTabelaCotacoes(produtosFormatados);
            atualizarPrecoCotacao(JSON.stringify(produtosFormatados));
            
            $("#cotacoesInput").val(JSON.stringify(produtosFormatados));
            
            $('#tb_cotacoes').show(); 
            $('#labelTotalCompra').show(); 
            $('#erroCotacao').hide();  
         }else{
        	 $('#tb_cotacoes').hide();  
        	 $('#labelTotalCompra').hide();  
        	 $('#erroCotacao').show();
             console.log("sem retorno");
         }
      }
    }

    function getDadosCotacoes(){
        try {
            var constraintNumProc = DatasetFactory.createConstraint("WKNumProces", numeroProcesso, numeroProcesso, ConstraintType.MUST);
            var constraintsCotacoes = new Array(constraintNumProc);      
        
            var datasetCotacoes = DatasetFactory.getDataset("compras_buscar_cotacao", null, constraintsCotacoes, null);

            return datasetCotacoes;
                    
        } catch(erro) {
            div.innerHTML = erro;
            return [];
        }
    }
    
    function atualizarPrecoCotacao(produtos){
    	var produtosFormatos = JSON.parse(produtos);
    	var totalSolicitacaoCompra  = "0.0";      
        var precoUnitario = "0.0";
        var totalDespesa = "0.0";
        var totalDescontos = "0.0";
        var totalSeguro = "0.0";
        var taxaFrete = "0.0";
        
        for(var countProduto=0; countProduto<produtosFormatos.length; countProduto++){
            var fornecedores = produtosFormatos[countProduto].fornecedores;
            
            fornecedores = fornecedores.map(function(x,y){
                x.precoUnitario = x.precoUnitario.replace(",",".");
                x.precoTotalFormatado = x.precoTotalFormatado.replace(",", ".");
                x.totalDespesas = x.totalDespesas.replace(",",".");
                x.totalDescontos = x.totalDescontos.replace(",",".");
                x.totalSeguro = x.totalSeguro.replace(",",".");
                x.taxaFrete = x.taxaFrete.replace(",",".");
                return x;
            })

            for(var countFornecedor=0; countFornecedor<fornecedores.length; countFornecedor++){
                if(fornecedores[countFornecedor].ganhador == true){
                precoUnitario = parseFloat(precoUnitario) + parseFloat(fornecedores[countFornecedor].precoUnitario);
                totalDespesa  = parseFloat(totalDespesa) + parseFloat(fornecedores[countFornecedor].totalDespesas) +  parseFloat(fornecedores[countFornecedor].totalSeguro);
                totalDescontos = parseFloat(totalDescontos) + parseFloat(fornecedores[countFornecedor].totalDescontos);
                totalSeguro   = parseFloat(totalSeguro) + parseFloat(fornecedores[countFornecedor].totalSeguro);
                taxaFrete     = parseFloat(taxaFrete) + parseFloat(fornecedores[countFornecedor].taxaFrete);

                totalSolicitacaoCompra = parseFloat(totalSolicitacaoCompra) +  parseFloat(fornecedores[countFornecedor].precoTotalFormatado) ;
                }
            }    		
    	}
    	
      $("#valorMercadoria").text("R$"+precoUnitario.toFixed(2).toString().replace(".", ","));
      $("#valorDespesas").text("R$"+totalDespesa.toFixed(2).toString().replace(".", ","));
      $("#valorFrete").text("R$"+taxaFrete.toFixed(2).toString().replace(".", ","));
      $("#valorDescontos").text("R$"+totalDescontos.toFixed(2).toString().replace(".", ","));
      $("#valorTotalCompra").text("R$"+totalSolicitacaoCompra.toFixed(2).toString().replace(".", ","));
      
    }
    
    function formatarProdutos(cotacoesValues){
        var produtosFormatado = [];
        
        //monta lista de produtos
        for (var countProduto = 0; countProduto < cotacoesValues.length; countProduto++) {
            produto = JSON.parse('{"codProduto":"'+cotacoesValues[countProduto].C8_PRODUTO+'","produto":"'+cotacoesValues[countProduto].B1_DESC+'", "quantidade":"'+parseInt(cotacoesValues[countProduto].C8_QUANT)+'", "codArmazem":"'+cotacoesValues[countProduto].C1_LOCAL+'", "lojaForn":"'+cotacoesValues[countProduto].C8_LOJA+'", "filial":"'+cotacoesValues[countProduto].C8_FILIAL+'", "codNumCotacao":"'+cotacoesValues[countProduto].C8_NUM+'", "codNumSc":"'+cotacoesValues[countProduto].C8_ITEMSC+'", "fornecedor":[], "fornecedores":[], "ganhador":false}');
            produtosFormatado.push(produto);
        }
        
        produtosFormatado = produtosFormatado.filter(function(item){
        	return !this[item.codProduto] && (this[item.codProduto] = true);
        });
        
        var produtos = formatarFornecedores(cotacoesValues, produtosFormatado);
        
        return produtos;
    }
    
    function formatarFornecedores(cotacoesValues, produtosFormatado){    	
    	for (var countFornecedor = 0; countFornecedor <  cotacoesValues.length; countFornecedor++) {        
            for (var countProduto2 = 0; countProduto2 < produtosFormatado.length; countProduto2++) {
            	 var precoUnitario  = parseFloat(cotacoesValues[countFornecedor].C8_TOTAL);
                 var totalDespesa   = parseFloat(cotacoesValues[countFornecedor].C8_DESPESA);
                 var totalDesconto  = parseFloat(cotacoesValues[countFornecedor].C8_VLDESC);
                 var totalSeguro    = parseFloat(cotacoesValues[countFornecedor].C8_SEGURO);
                 var taxaFrete      = parseFloat(cotacoesValues[countFornecedor].C8_TOTFRE);
                 
                 var precoTotalFornecedor = (precoUnitario + totalDespesa + totalSeguro + taxaFrete) - totalDesconto;
            	
                if(produtosFormatado[countProduto2].fornecedor.length === 0){
                    fornecedor = JSON.parse("{"+'"codItemCotacao":"'+cotacoesValues[countFornecedor].C8_ITEM+'", "fornecedor":"'+cotacoesValues[countFornecedor].C8_FORNECE+'", "precoUnitario":"'+parseFloat(cotacoesValues[countFornecedor].C8_PRECO).toFixed(2)+'","precoTotal":"'+parseFloat(cotacoesValues[countFornecedor].C8_TOTAL).toFixed(2)+'","precoTotalFormatado":"'+precoTotalFornecedor.toFixed(2).toString().replace(".", ",")+'", "totalDespesas":"'+totalDespesa.toFixed(2).toString().replace(".", ",")+'", "totalDescontos":"'+totalDesconto.toFixed(2).toString().replace(".", ",")+'", "totalSeguro":"'+totalSeguro.toFixed(2).toString().replace(".", ",")+'","taxaFrete":"'+taxaFrete.toFixed(2).toString().replace(".", ",")+'", "ganhador":false, "prazoEntrega":"'+cotacoesValues[countFornecedor].E4_DESCRI+'", "codProduto":"'+cotacoesValues[countFornecedor].C8_PRODUTO+'", "nomeFornecedor":"'+cotacoesValues[countFornecedor].C8_FORNOME+'", "condPagamento":"'+cotacoesValues[countFornecedor].C8_COND+'", "lojaForn":"'+cotacoesValues[countFornecedor].C8_LOJA+'"}');
                    
                }else{
                    fornecedor = JSON.parse("{"+'"codItemCotacao":"'+cotacoesValues[countFornecedor].C8_ITEM+'", "fornecedor":"'+cotacoesValues[countFornecedor].C8_FORNECE+'", "precoUnitario":"'+parseFloat(cotacoesValues[countFornecedor].C8_PRECO).toFixed(2)+'","precoTotal":"'+parseFloat(cotacoesValues[countFornecedor].C8_TOTAL).toFixed(2)+'","precoTotalFormatado":"'+precoTotalFornecedor.toFixed(2).toString().replace(".", ",")+'", "totalDespesas":"'+totalDespesa.toFixed(2).toString().replace(".", ",")+'", "totalDescontos":"'+totalDesconto.toFixed(2).toString().replace(".", ",")+'", "totalSeguro":"'+totalSeguro.toFixed(2).toString().replace(".", ",")+'","taxaFrete":"'+taxaFrete.toFixed(2).toString().replace(".", ",")+'", "ganhador":false, "prazoEntrega":"'+cotacoesValues[countFornecedor].E4_DESCRI+'", "codProduto":"'+cotacoesValues[countFornecedor].C8_PRODUTO+'", "nomeFornecedor":"'+cotacoesValues[countFornecedor].C8_FORNOME+'", "condPagamento":"'+cotacoesValues[countFornecedor].C8_COND+'", "lojaForn":"'+cotacoesValues[countFornecedor].C8_LOJA+'"}');
                }
                
                if (produtosFormatado[countProduto2].codProduto == cotacoesValues[countFornecedor].C8_PRODUTO) {
                	produtosFormatado[countProduto2].fornecedor.push(fornecedor);
                	produtosFormatado[countProduto2].fornecedores.push(fornecedor);
                }
            } 
        }

    	var produtos = escolherMenorFornecedor(produtosFormatado);

        return produtos;
    }
    
    function escolherMenorFornecedor(produtos){
        for (var countProduto = 0; countProduto <  produtos.length; countProduto++) {
           var fornecedor = produtos[countProduto].fornecedor;
           var fornecedores = produtos[countProduto].fornecedores;

           //ordena os arrays
           var fornecedorFormatado = fornecedor.sort(function(x,y){
              return x.precoTotalFormatado  - y.precoTotalFormatado;
          })

           var fornecedoresFormatado = fornecedores.sort(function(x,y){
              return x.precoTotalFormatado  - y.precoTotalFormatado;
          })

           fornecedorFormatado[0].ganhador = true;
           fornecedoresFormatado[0].ganhador = true;

           produtos[countProduto].fornecedor = fornecedorFormatado;
           produtos[countProduto].fornecedores = fornecedoresFormatado;

        }
         return produtos;
      }
    
    function montarTabelaCotacoes(produtos){      
        
      var table = document.getElementById("tb_cotacoes");

        for (var count = 0; count < produtos.length; count++) {

            var numOfRows = table.rows.length;
            var numOfCols = table.rows[numOfRows-1].cells.length;
            var newRow = table.insertRow(numOfRows);

            for (var j = 0; j < numOfCols; j++) {
               // Insere uma coluna na nova linha 
               newCell = newRow.insertCell(j);
               var valor = "";
               if(j==0){
            	 valor = produtos[count].produto;
               }else if(j==1){
            	   valor = produtos[count].quantidade; 
               }else if(j==2){
            	   valor = JSON.stringify(produtos[count].fornecedor); 
               }else if(j==3){
            	   valor = '<button type="button" class="btn btn-info" data-toggle="tooltip" data-placement="bottom" title="Visualizar fornecedores" onclick="modalFornecedores()">'+
			                   '<i class="flaticon flaticon-search icon-sm"></i>'+
			               ' </button>'
               }
               // Insere um conteúdo na coluna
               newCell.innerHTML = ""+ valor ;
            }
        }
        //oculta a coluna fornecedor
        $('#tb_cotacoes tr > *:nth-child(3)').hide(); 

    }

    function escolherProposta(idProposta){
            
        var tabela = document.getElementById("tb_cotacoes");
        var coluna = $(this).parent().children().index($(this));
        var linha = parseInt(localStorage.getItem('linhaTabelaFornecedor'));
        

        
        var id = parseInt(idProposta.replace(/[^0-9]/g,''));
        
        for (var count = 0; count < fornecedoresModal.length; count++) {
           if(count == id){
              document.getElementById("iconWinner"+[count]).style.display = 'inline';             
              fornecedoresModal[count].ganhador = true    
           }else{
              document.getElementById("iconWinner"+[count]).style.display = 'none';
              fornecedoresModal[count].ganhador = false;
           }
        }

        //Atualiza a cotação no input 
        var cotacoesAtualizadasJson = [];
        var cotacoesFormatJson = [];
        var lojaForn = "";
        
        for (var x = 0; x < fornecedoresModal.length; x++) {            
           var row = fornecedoresModal[x];
           
           cotacoesAtualizadasJson.push(JSON.parse("{"+'"codItemCotacao":"'+row.codItemCotacao+'", "codProduto":"'+row.codProduto+'","fornecedor":"'+row.fornecedor+'","ganhador":'+row.ganhador+',"nomeFornecedor":"'+row.nomeFornecedor+'","prazoEntrega":"'+row.prazoEntrega+'", "precoTotal":"'+row.precoTotal+'", "precoTotalFormatado":"'+row.precoTotalFormatado+'", "precoUnitario":"'+row.precoUnitario+'", "totalDespesas":"'+row.totalDespesas+'", "totalDescontos":"'+row.totalDescontos+'", "totalSeguro":"'+row.totalSeguro+'","taxaFrete":"'+row.taxaFrete+'","precoTotalFormatado":"'+row.precoTotalFormatado+'", "condPagamento":"'+row.condPagamento+'", "lojaForn":"'+row.lojaForn+'"}'));
           cotacoesFormatJson.push("{"+'"codItemCotacao":"'+row.codItemCotacao+'", "codProduto":"'+row.codProduto+'","fornecedor":"'+row.fornecedor+'","ganhador":'+row.ganhador+',"nomeFornecedor":"'+row.nomeFornecedor+'","prazoEntrega":"'+row.prazoEntrega+'", "precoTotal":"'+row.precoTotal+'", "precoTotalFormatado":"'+row.precoTotalFormatado+'", "precoUnitario":"'+row.precoUnitario+'", "totalDespesas":"'+row.totalDespesas+'", "totalDescontos":"'+row.totalDescontos+'", "totalSeguro":"'+row.totalSeguro+'","taxaFrete":"'+row.taxaFrete+'","precoTotalFormatado":"'+row.precoTotalFormatado+'", "condPagamento":"'+row.condPagamento+'", "lojaForn":"'+row.lojaForn+'"}');
        }

        var produtosAtualizados  =  JSON.parse($("#cotacoesInput").val());

        if(!Array.isArray(produtosAtualizados)){
           produtosAtualizados  =  JSON.parse("["+$("#cotacoesInput").val()+"]");
        }
    
       //atualiza fornecedor ganhador no input
       for(var countPA=0; countPA < produtosAtualizados.length; countPA++){
           for(var countCJ=0; countCJ < cotacoesAtualizadasJson.length; countCJ++){
                   if(produtosAtualizados[countPA].codProduto == cotacoesAtualizadasJson[countCJ].codProduto){
                       produtosAtualizados[countPA].fornecedores = cotacoesAtualizadasJson;	           		            		
                   }	           		
           }
       }

        //atualiza fornecedor ganhador na coluna 3 na tabela
        for (var i = 0, row; row = tabela.rows[i]; i++) {                       
           if (linha === i) {                              
              for (var j = 0, coluna; coluna = row.cells[j]; j++) {                         
                 if(j === 2){                                                 
                    coluna.textContent = "["+cotacoesFormatJson+"]";
                 }                                        
              }
           }
        }


        var prodFormated = JSON.stringify(produtosAtualizados);        
        atualizarPrecoCotacao(JSON.stringify(produtosAtualizados));
        $("#cotacoesInput").val(prodFormated);//atualiza input que será usado na serviceTask130
     }

     function panelFornecedores(fornecedores){           
    	 var panels = "";
         var fornecedor = "";

         for (var count = 0; count < fornecedores.length; count++) {
            fornecedor = fornecedores[count];
            panels += '<div class="panel panel-success">'+
                          ' <div class="panel-heading">'+
                           '<p class="panel-title">'+                                    
                                 '<i id="iconWinner'+count+'" class="flaticon flaticon-star-circle icon-lg fs-md-margin-left"></i>'+
                                 '<strong class="fs-xs-margin-left">'+(count+1)+'° Proposta</strong>'+                                    
                           '</p>'+
                       ' </div>'+
                        '<div class="panel-body">'+
                           '<div class="form-group col-sm-12">'+                                    
                                 '<div class="input-group col-sm-12">'+
                                    '<h4 class="card-text font-weight-bold">Fornecedor   </h4>'+
                                    '<span>'+fornecedores[count].nomeFornecedor+'</span>'+                                                                              
                                    '<h4 class="card-text font-weight-bold">Valor Unitário   </h4>'+
                                ' </div>'+
                                '<div class="input-group col-sm-12">'+
                                 '  <span>R$'+fornecedores[count].precoUnitario+'</span>'+                                                                                                                  
                                    '<h4 class="card-text font-weight-bold">Taxa frete   </h4>'+
                                    '<span id="taxaFrete"'+count+'">R$'+fornecedores[count].taxaFrete+'</span>'+
                                    '<h4 class="card-text font-weight-bold">Taxa de seguro   </h4>'+
                                    '<span id="taxaSeguro"'+count+'">R$'+fornecedores[count].totalSeguro+'</span>'+
                                    '<h4 class="card-text font-weight-bold">Total de despesas   </h4>'+
                                    '<span id="taxaDespesas"'+count+'">R$'+fornecedores[count].totalDespesas+'</span>'+
                                    '<h4 class="card-text font-weight-bold">Total de descontos   </h4>'+
                                    '<span id="totalDescontos"'+count+'">R$'+fornecedores[count].totalDescontos+'</span>'+
                                    '<h4 class="card-text font-weight-bold">Valor Total   </h4>'+
                                    '<span>R$'+fornecedores[count].precoTotalFormatado+'</span>'+   
                                 '</div>'+

                                 '<div class="input-group col-sm-12">'+
                                    '<h4 class="card-text font-weight-bold"> Forma de pagamento</h4>'+
                                    '<span>'+fornecedores[count].prazoEntrega+'</span>'+                                       
                                ' </div>'+
                                 '<div class="input-group col-sm-12 fs-md-margin-top text-center">'+
                                   /* '<button id="escolherProposta'+count+'" name="escolherPropostaBtn" class="btn btn-info btn-lg" onclick="escolherProposta(this.id)">Escolher proposta</button>'+ */
                                 '</div>'+
                          ' </div>'+
                       ' </div>'+
                     '</div>';
         }
         return panels;
     }

    function modalFornecedores(){            
        $('td').click(function(){
        	
          var tabela = document.getElementById("tb_cotacoes");
          var coluna = $(this).parent().children().index($(this));
          var linha = $(this).parent().parent().children().index($(this).parent());
          var fornecedores = [];

          localStorage.setItem('linhaTabelaFornecedor', linha);
          
          var div = document.getElementById("montarCards");

          for (var i = 0, row; row = tabela.rows[i]; i++) {                  
             if (linha === i) {                    
                for (var j = 0, coluna; coluna = row.cells[j]; j++) {  
                   if(j === 2){                         
                      fornecedores = JSON.parse(coluna.innerHTML); //envia fornecedores para Modal
                      fornecedoresModal = fornecedores;
                   }                                        
                }      
                if(fornecedores.length > 0){
                   div.innerHTML = panelFornecedores(fornecedores);
                   // Deixa o icone de ganhador somente no primeiro da lista
                   for (var count = 0; count < fornecedoresModal.length; count++) {

                      if (fornecedoresModal[count].ganhador == true) {
                         document.getElementById("iconWinner"+[count]).style.display = 'inline';     
                      }else{
                         document.getElementById("iconWinner"+[count]).style.display = 'none';     
                      }         
                   }
                }
             }  
          }               
       });

       var modalVisualizarCotacao = FLUIGC.modal({
            title: 'Visualizar cotação',
            content: '<div id="montarCards"></div>',
            id: 'fluig-modal-add-produto',
            size: 'large',
            actions: [{
               'label': 'Fechar',
               'autoClose': true
            }]
         }, function() {
      }); 

    }
    carregarCotacao();

