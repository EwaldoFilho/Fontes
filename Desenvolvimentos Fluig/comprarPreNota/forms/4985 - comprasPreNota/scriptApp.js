function showProdutos() {   
   var div = document.getElementById("produtosView");
   try {
   //    var constraintNumProc = DatasetFactory.createConstraint("WKNumProces", "123"", "123", ConstraintType.MUST);
   //    var constraintsCotacoes = new Array(constraintNumProc);      
      var datasetNotas = DatasetFactory.getDataset("dsPreNota", null, null, null);
      
      if (datasetNotas.values.length > 0) {               
         div.innerHTML = showDatasetPreNota(datasetNotas);                             
      }      
              
   } catch(erro) {
      div.innerHTML = erro;
   }
}

function showDatasetPreNota(dataset) {
   var tabela = [];
   for (var i = 0; i < dataset.values.length; i++) {
	   tabela.push(montartabela(row = dataset.values[i], i, dataset));
   }
   return tabela;
}

function montartabela(row, count, dataset) {
    var tabela = '<table name="tb_produtos'+count+'" id="tb_produtos'+count+'" class="table table-bordered">';
   //Monta o cabeçalho
   tabela +='<tr>';
            for (var i = 0; i < dataset.columns.length; i++) {
               tabela += "<th>" + dataset.columns[i] + "</th>";
            }
            tabela += "</tr>";
            //Monta os registros   
               tabela += "<tr>";
               for (var y = 0; y < dataset.columns.length; y++) {            	 
            		   tabela += "<td>" + row[dataset.columns[y]] + "</td>";                   
               }                
               tabela += "</tr>";
            
   tabela += "</table>";

   return tabela;
}  

showProdutos();