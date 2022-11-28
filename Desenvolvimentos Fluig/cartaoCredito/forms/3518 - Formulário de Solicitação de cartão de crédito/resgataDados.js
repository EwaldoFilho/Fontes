
   $(document).ready(function (){
        try {
        	var matricula = $("#solicitanteLogin").val();
        	var numProcesso = "";
        	var linkProcess = "http://portal.medmais.com:8007/portal/p/0101001/pageworkflowview?app_ecm_workflowview_detailsProcessInstanceID="+numProcesso;
        	var state = $("#etapa").val();        	
        	
            var constraintMat = DatasetFactory.createConstraint("matricula", matricula, matricula, ConstraintType.MUST);            
            var constraintsMatricula = new Array(constraintMat);      
        
            var datasetMatricula = DatasetFactory.getDataset("dsIniciarSolicitacao", null, constraintsMatricula, null);   

            for(var i = 0; i < datasetMatricula.values.length; i++) {

            	numProcesso = datasetMatricula.values[i]["TAR_PROCES_NUM_PROCES"];
            	         	            	
            	if((numProcesso != "" || numProcesso != null)&& (state == '0')){
            		document.getElementById("url").innerHTML = linkProcess
            		$("#panelDadosSolicitante").hide();
            		$("#panelDadosSolicitacao").hide();
            		$("#confirmacao").show();    
            		$("#numProcesso").val(numProcesso);
            	}else{
            		$("#numProcesso").val(numProcesso);
            		$("#panelDadosSolicitante").show();
            		$("#panelDadosSolicitacao").show();	
            		$("#confirmacao").hide();
            		
            	}
            	
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
    
    
   
