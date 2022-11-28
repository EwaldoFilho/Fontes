if(numState == "119"){
	var listaProdutosFormatados = $("#listaProdutos").val();
	var produtosInputEditar = JSON.parse("["+listaProdutosFormatados.replace(/[\[\]]/g, "")+"]");	
	  
    montarTabelaProdutos(produtosInputEditar);

    function montarTabelaProdutos(produtos){      
            
        var table = document.getElementById("tb_produtos");

          for (var count = 0; count < produtos.length; count++) {

              var numOfRows = table.rows.length;
              var numOfCols = table.rows[numOfRows-1].cells.length;
              var newRow = table.insertRow(numOfRows);

              for (var j = 0; j < numOfCols; j++) {
                // Insere uma coluna na nova linha 
                newCell = newRow.insertCell(j);
                var valor = "";
                if(j==0){
                  valor = produtos[count].cidProduto;
                }else if(j==1){
                    valor = produtos[count].produto; 
                }else if(j==2){
                  valor = produtos[count].cquantidade; 
                }else if(j==3){
                  valor = produtos[count].cobs; 
                }else if(j==4){
                  valor = '<i class="flaticon flaticon-trash icon-md remover"></i>'; 
                }
                // Insere um conteúdo na coluna
                newCell.innerHTML = ""+ valor ;
              }
          }
          //oculta a coluna fornecedor
          //$('#tb_produtos tr > *:nth-child(1)').hide(); 

    }
}