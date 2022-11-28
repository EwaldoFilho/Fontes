function fnCustomDeleteItReqMat(oElement){
	var state = $("#processo").val();
	
	if (state=="0") {
    FLUIGC.message.confirm({
        message: 'Deseja remover o centro de custo? \n' +
                 'No ato da eliminação todos os rateios relacionados ao item serão eliminados.',
        title: 'Remoção de Item da Solicitação',
        labelYes: 'Remover',
        labelNo: 'Cancelar'
    }, function(result, el, ev) {

        if (result){            
            /*Elimina linha da Tabela (Itens Requisicao)*/
            fnWdkRemoveChild(oElement);                

            /*Percorre todos "SEQITEM"(Tabela Rateio Itens Requisicao)*/
            $("input[id^='descricaoForn___']").each(function(index, value){

                /*Identifica "SEQUENCIA"(Tabela Itens solicitação) inexistente e elimina registro*/
                if ( typeof $("#descricaoForn___" + $(this).val()).val() === "undefined" ) {
                    $(this).parents("tr").remove();
                    $("#valorTotal").val("");
                }
            })    
        }
    });
}

}



