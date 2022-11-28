function enableFields(form) {
    var activity = getValue('WKNumState');
    
    if (activity == 0 || activity == 4 ) {
        form.setEnabled('panelDadoSolicitante', true);
        form.setEnabled('panelDadoSolicitacao', true);
        form.setEnabled('panelAgendamento', true);
               
    }
	if (activity == 5){
		form.setEnabled('cid10', false);
        form.setEnabled('dataAtestado', false);
        form.setEnabled('qtdDias', false);			
	}
	if (activity == 8){
		form.setEnabled('cid10', false);
        form.setEnabled('dataAtestado', false);
        form.setEnabled('qtdDias', false);			
	}
	if (activity == 10){
		form.setEnabled('cid10', false);
        form.setEnabled('dataAtestado', false);
        form.setEnabled('qtdDias', false);
        form.setEnabled('nomeClinica',false);
        form.setEnabled('endereco',false);
        form.setEnabled('dataHora',false);
        form.setEnabled('observacao',false);			
	}
	if (activity == 12){
		form.setEnabled('cid10', false);
        form.setEnabled('dataAtestado', false);
        form.setEnabled('qtdDias', false);
        form.setEnabled('nomeClinica',false);
        form.setEnabled('endereco',false);
        form.setEnabled('dataHora',false);
        form.setEnabled('observacao',false);			
	}
	
	if (activity == 14){
		form.setEnabled('cid10', false);
        form.setEnabled('dataAtestado', false);
        form.setEnabled('qtdDias', false);
        form.setEnabled('nomeClinica',false);
        form.setEnabled('endereco',false);
        form.setEnabled('dataHora',false);
        form.setEnabled('observacao',false);        
	}
	if (activity == 17){
		form.setEnabled('cid10', false);
        form.setEnabled('dataAtestado', false);
        form.setEnabled('qtdDias', false);	
        form.setEnabled('nomeClinica',false);
        form.setEnabled('endereco',false);
        form.setEnabled('dataHora',false);
        form.setEnabled('observacao',false); 
	}
	if (activity == 20){
		form.setEnabled('cid10', false);
        form.setEnabled('dataAtestado', false);
        form.setEnabled('qtdDias', false);
        form.setEnabled('nomeClinica',false);
        form.setEnabled('endereco',false);
        form.setEnabled('dataHora',false);
        form.setEnabled('observacao',false);
	}
}
