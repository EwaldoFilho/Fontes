if(numState == "342"){
    var listaProdutosNovosFormatados = $("#listaNovosProdutos").val();
    var produtosNovosVisualizar = JSON.parse("["+listaProdutosNovosFormatados.replace(/[\[\]]/g, "")+"]");	   

    montarTabelaProdutos(produtosNovosVisualizar);

    function montarTabelaProdutos(produtos){      
            
        var table = document.getElementById("tb_novosProdutos");

          for (var count = 0; count < produtos.length; count++) {

              var numOfRows = table.rows.length;
              var numOfCols = table.rows[numOfRows-1].cells.length;
              var newRow = table.insertRow(numOfRows);

              for (var j = 0; j < numOfCols; j++) {
                // Insere uma coluna na nova linha 
                newCell = newRow.insertCell(j);
                var valor = "";
                if(j==0){
                  valor = produtos[count].descricao;
                }else if(j==1){
                    valor = produtos[count].observacao; 
                }
                // Insere um conteúdo na coluna
                newCell.innerHTML = ""+ valor ;
              }
          }
          //oculta a coluna fornecedor
          $('#tb_novosProdutos tr > *:nth-child(3)').hide(); 

    }
}