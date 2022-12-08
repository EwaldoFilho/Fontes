function showProdutos() {
   var numeroProcesso = $("#processoPai").val(); 
   console.log("Num processo: "+numeroProcesso);
    //Busca o dataset
   try {
      var div = document.getElementById("produtosView");
      var constraintNumProc = DatasetFactory.createConstraint("WKNumProces", numeroProcesso, numeroProcesso, ConstraintType.MUST);
      var constraintsNumProcesso = new Array(constraintNumProc);      
      var datasetProdutos = DatasetFactory.getDataset("testeMV", null, constraintsNumProcesso, null);
      
      if (datasetProdutos.values.length > 0) {               
         div.innerHTML = showDatasetProdutos(datasetProdutos);
         //$('#tb_cotacoes tr > *:nth-child(3)').hide();                  
      }        
   } catch(erro) {
      // div.innerHTML = erro;
   }
}

function showDatasetProdutos(dataset) {
   var tabela = '<table name="tb_produtos" id="tb_produtos" class="table table-bordered">';
   //Monta o cabeçalho
   tabela += '<tr>'+
               '<td colspan="7">'+
                  '<img src="img/logo_med.png" alt="logo medmais" width="250px" height="90px">'+
                  '<h2 style="display: inline-table;">Dados de produtos e serviços</h2>'+
               '</td>'+
            '</tr>'+
            '<tr>'+
               '<td>Código Produto</td>'+
               '<td>Produto</td>'+
               '<td>Quantidade pedida</td>'
            "</tr>";

            //Monta os registros   
            for (var x = 0; x < dataset.values.length; x++) {
               tabela += "<tr>";
               var row = dataset.values[x];
               for (var y = 0; y < dataset.columns.length; y++) {
                     tabela += "<td>" + row[dataset.columns[y]] + "</td>";
               }                
               tabela += "</tr>";
            }
            
   tabela += "</table>";

   return tabela;
}   

showProdutos();