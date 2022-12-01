
   $(document).ready(function (){
	   window.parent.$('button[data-send]').hide();
        try {
        	var numeroProcesso = $("#processo").val();
        	var colaborador = "";
        	var email = "";
        	var telefone = "";
        	var cpf = "";
        	var rg = "";
        	var nascimento = "";
        	var uniforme = "";
        	var bota = "";
        	        	
        	
            var constraintNumProc = DatasetFactory.createConstraint("WKNumProces", numeroProcesso, numeroProcesso, ConstraintType.MUST);            
            var constraintsRecrutamento = new Array(constraintNumProc);      
        
            var datasetRecrutamento = DatasetFactory.getDataset("dsRecrutamento", null, constraintsRecrutamento, null);

           
            var returnFields = new Array("nomeColaborador", "uniformeSoa", "botaSoa");            

            for(var i = 0; i < datasetRecrutamento.values.length; i++) {

            	colaborador = datasetRecrutamento.values[i]["nomeColaborador"];
            	email = datasetRecrutamento.values[i]["emalColaborador"];
            	telefone = datasetRecrutamento.values[i]["telCandidato"];
            	cpf = datasetRecrutamento.values[i]["cpfAso"];
            	rg = datasetRecrutamento.values[i]["rgAso"];
            	nascimento = datasetRecrutamento.values[i]["dtNascimentoAso"];
            	uniforme = datasetRecrutamento.values[i]["uniformeSoa"];
            	bota = datasetRecrutamento.values[i]["botaSoa"];            	            	

            	$("#nomeColaborador").val(colaborador);
            	$("#emalColaborador").val(email);
            	$("#telCandidato").val(telefone);
            	$("#cpfAso").val(cpf);
            	$("#rgAso").val(rg);
            	$("#dtNascimentoAso").val(nascimento);
            	$("#uniformeSoa").val(uniforme);
            	$("#botaSoa").val(bota);
            	
            	
            }
                    
        } catch(erro) {
        	Swal.fire({
                icon: 'warning',
                title: ''+erro+''
            })
            div.innerHTML = erro;
            return [];
        }
    });
    
    

