function validateTel() {
	var ntel = $("#telContato").val();
	var state = $("#ativAtual").val();
		
	if(state == null || state == 0 || state == 4 || state == '')
    {
		if(ntel.length < 21){
			FLUIGC.message.alert({
			    message: 'Informe o número de Telefone + Ramal para contato do colaborador completo.',
			    title: 'Alerta',
			    label: 'OK'
			})
		}
	
	}
	
};

function validateCel() {
	var ncel = $("#celContato").val();
	var state = $("#ativAtual").val();
	
	if(state == null || state == 0 || state == 4 || state == '')
    {
		if(ncel.length < 15){
			FLUIGC.message.alert({
			    message: 'Informe o número de Celular para contato do colaborador completo.',
			    title: 'Alerta',
			    label: 'OK'
			})
		}
	
	}
}

