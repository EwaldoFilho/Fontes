function afterProcessCreate(processId){
	
	var data =  new Date();
	var dataAtual = data.getDate() + "/" + data.getMonth() + "/" + data.getFullYear();
	
	hAPI.setCardValue("AMUnumero", processId);
}