function afterProcessFinish(processId){
	
	var data = new Date();
	
	hAPI.setCardValue("horarioFinalCadastro", data.getHours()+":"+data.getMinutes());
}