$(document).on("ready", function() {

    if (getMobile() == "true") {
        initiateFunction = setInterval(function() { initiate() }, 3000);
    } else {
        initiate()
    }

});

/*  INICIO bloqueio de inputs
** Bloqueia digitação dos inputs que estão com o campo Zoom
*/
var inputEmpresa = document.getElementById("empresa");
var inputNacionalidade = document.getElementById("nacionalidade");
var inputAeroportoOrigem = document.getElementById("AeroportoOrigem");
var inputCompanhiaAerea = document.getElementById("CompanhiaAerea");

inputEmpresa.addEventListener('keydown', function(event) {
const key = event.key;
if (key === "Backspace" || key === "Delete") {
	event.preventDefault();
}
});

inputEmpresa.addEventListener("keypress", function(event){
event.preventDefault();
});

inputNacionalidade.addEventListener('keydown', function(event) {
const key = event.key;
if (key === "Backspace" || key === "Delete") {
	event.preventDefault();
}
});

inputNacionalidade.addEventListener("keypress", function(event){
event.preventDefault();
});

inputAeroportoOrigem.addEventListener('keydown', function(event) {
const key = event.key;
if (key === "Backspace" || key === "Delete") {
	event.preventDefault();
}
});

inputAeroportoOrigem.addEventListener("keypress", function(event){
event.preventDefault(); 
});

inputCompanhiaAerea.addEventListener('keydown', function(event) {
const key = event.key;
if (key === "Backspace" || key === "Delete") {
	event.preventDefault();
}
});

inputCompanhiaAerea.addEventListener("keypress", function(event){
event.preventDefault();
});


//FIM bloqueio inputs