
   $(document).ready(function (){
        try {
        	var numeroProcesso = $("#processo").val();
        	var colaborador = "";
        	var uniforme = "";
        	var bota = "";
        	        	
        	
            var constraintNumProc = DatasetFactory.createConstraint("WKNumProces", numeroProcesso, numeroProcesso, ConstraintType.MUST);            
            var constraintsRecrutamento = new Array(constraintNumProc);      
        
            var datasetRecrutamento = DatasetFactory.getDataset("dsRecrutamento", null, constraintsRecrutamento, null);

           
            var returnFields = new Array("nomeColaborador", "uniformeSoa", "botaSoa");            

            for(var i = 0; i < datasetRecrutamento.values.length; i++) {

            	colaborador = datasetRecrutamento.values[i]["nomeColaborador"];
            	uniforme = datasetRecrutamento.values[i]["uniformeSoa"];
            	bota = datasetRecrutamento.values[i]["botaSoa"];            	            	

            	$("#nomeColaborador").val(colaborador);
            	$("#uniformeSoa").val(uniforme);
            	$("#botaSoa").val(bota);
            	
            	
            }
                    
        } catch(erro) {
            div.innerHTML = erro;
            return [];
        }
    });
    
    

