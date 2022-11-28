var numState = $("#estado").val();

parent.$('#textActivity').hide();

console.log("State::"+numState);

if(numState == 5 || numState == 8){
	$('#tb_produtos tr > *:nth-child(1)').hide();
	$('#btnAdicionar').hide();
}