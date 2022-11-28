var gratidaoWidget = SuperWidget.extend({
	instanceId: null,
	
	bindings: {
		local: {
			
		},
		global: {
			
		}
	},

	init: function() {
        try {        	
            var datasetCGratidao = DatasetFactory.getDataset("dsGratidaoC", null, null, null);
            
            gratidaoOnline = datasetCGratidao.values;
            
            
            var table = document.getElementById("tb_gratidaoOnline");

            for (var count = 0; count < gratidaoOnline.length; count++) {

                var numOfRows = table.rows.length;
                var numOfCols = table.rows[numOfRows-1].cells.length;
                var newRow = table.insertRow(numOfRows);

                for (var j = 0; j < numOfCols; j++) {
                   // Insere uma coluna na nova linha 
                   newCell = newRow.insertCell(j);
                   var valor = "";
                   
                   if(j==0){
                	// valor = '<i class="flaticon flaticon-person fluigicon-md"></i>';
                	 valor ='<span>'+gratidaoOnline[count].solicitanteNome+'</span>';
                   }else if(j==1){
                  	 valor ='<span>'+gratidaoOnline[count].comentario+'</span>';
                   }
                   // Insere um conteúdo na coluna
                   newCell.innerHTML = ""+ valor ;
                  // newCell.style.border = "none";
                }
            }
            
            return datasetCGratidao;
                    
        } catch(erro) {
            //div.innerHTML = erro;
        	console.log(erro);
            return [];
        }	
	}

});

