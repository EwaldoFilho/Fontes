if(numState == "124" || numState == "136" || numState == "472" || numState == "190" || numState == "475" || numState == "192"){
	var listaProdutosFormatados = $("#listaProdutos").val();
	var produtosInputEditar = JSON.parse("["+listaProdutosFormatados.replace(/[\[\]]/g, "")+"]");	
	  
    montarTabelaProdutos(produtosInputEditar);

    function montarTabelaProdutos(produtos){      
            
        var table = document.getElementById("tb_orcamento");
        var totalOrcamento = "0.0";

          for (var count = 0; count < produtos.length; count++) {

              var numOfRows = table.rows.length;
              var numOfCols = table.rows[numOfRows-1].cells.length;
              var newRow = table.insertRow(numOfRows);

              totalOrcamento = parseFloat((produtos[count].cvalororcamentario.replace(".", "")).replace(",",".")) + parseFloat(totalOrcamento);
              
               
              
              for (var j = 0; j < numOfCols; j++) {
                // Insere uma coluna na nova linha 
                newCell = newRow.insertCell(j);
                var valor = "";
                if(j==0){
                  valor = produtos[count].produto;
                }else if(j==1){
                    valor = produtos[count].cquantidade; 
                }else if(j==2){
                  valor = "R$"+produtos[count].cvalororcamentario; 
                }else if(j==3){
                  valor = produtos[count].cespecificacaoTecnica; 
                }
                // Insere um conteúdo na coluna
                newCell.innerHTML = ""+ valor ;
              }


          }
          $("#totalOrcamento").text("R$"+totalOrcamento.toFixed(2).toString().replace(".", ","));
          

    }
}