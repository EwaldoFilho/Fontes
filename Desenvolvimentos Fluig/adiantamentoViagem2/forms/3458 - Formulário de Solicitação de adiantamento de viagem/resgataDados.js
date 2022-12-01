
   $(document).ready(function (){
        try {
        	var MATRICULA = $("#solicitanteCode").val();
        	var numProcesso = "";
        	
        	var state = $("#etapa").val();        	
        	
            var constraintMat = DatasetFactory.createConstraint("MATRICULA", MATRICULA, MATRICULA, ConstraintType.MUST);            
            var constraintsMatricula = new Array(constraintMat);      
        
            var datasetMatricula = DatasetFactory.getDataset("dsIniciarSolicitacao", null, constraintsMatricula, null);   
            
            for(var i = 0; i < datasetMatricula.values.length; i++) {
            	
            	numProcesso = datasetMatricula.values[i]["TAR_PROCES_NUM_PROCES"];
            	var linkProcess = "http://portal.medmais.com:8007/portal/p/0101001/pageworkflowview?app_ecm_workflowview_detailsProcessInstanceID="+numProcesso+"";   
            	var a = document.getElementById("url");
            	  a.href = linkProcess;
            	if((numProcesso != "" || numProcesso != null)&& (state == '0')){            		
            		$("#panelDadosSolicitante").hide();
            		$("#panelDadosSolicitacao").hide();
            		$("#confirmacao").show();    
            		$("#numSolicitacao").val(numProcesso); 
            		window.parent.$('button[data-send]').hide();
            		window.parent.$('button[data-toggle]').hide();
            		window.parent.$("#processTabs").find("li").last().hide();
            		
            	}else{
            		$("#numSolicitacao").val(numProcesso);            		
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
    
    
   
