$.ajax({
    url: '/api/public/2.0/users/getCurrent', 
    type: "GET",
}).then(function(data) {
    //seta o gerente responsavel
    var isGerente = data.content.extData.isGerente;
    var codResponsavel  = data.content.extData.codResponsavel;

    if (isGerente == "true") {
        $("#isGerente").val(isGerente);
        $("#responsavelAtendimento").val($("#matriculaUsuario").val());
    }else{
        $("#responsavelAtendimento").val(codResponsavel);
    }
});