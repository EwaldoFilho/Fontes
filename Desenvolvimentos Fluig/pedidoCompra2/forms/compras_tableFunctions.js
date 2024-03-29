

//Função para adicionar itens em uma tabela pai x filho.
function adicionarRateioCusto(CTT_CUSTO,CTT_DESC01) {
    var id = wdkAddChild("rateioCusto");
    var qtd = $("#baseRateio").val();
    var atividade = getWKNumState();

    $("#codCentroCustoForn___" + id).val(CTT_CUSTO);
    $("#descricaoForn___" + id).val(CTT_DESC01);
    $("#valor___" + id).mask('000.000.000.000.000,00', {reverse: true});
    qtd++
    $("#baseRateio").val(qtd);
    $("#codCentroCustoForn___" + id).attr('readonly', true);
    $("#descricaoForn___" + id).attr('readonly', true);
    
   
}



function somaValor(){

    var soma = 0;     
    var qtd = $("#baseRateio").val();
    
    $(":input[id^='valor___']").each(function (index, value) {
           soma = soma + parseFloat($(this).val().replaceAll('.', '').replace(',', '.'));          
                }
    );   
    
      $("#valorTotal").val(soma.toFixed(2).toString().replace('.', ',').replace(/\d(?=(\d{3})+,)/g, '$&.'));
      $("#valorTotal").mask("#.##0,00", {reverse: true});
      
 	 	
 }


function calcular(){
	
	var soma = $("#valorTotal").val();  
	var valor = 0;
    var qtd = $("#baseRateio").val();
    var porcento = 0;
    
    $(":input[id^='valor___']").each(function (index, value) {
        soma = soma + parseFloat($(this).val());   
       
    }
);
    porcento = (valor / soma) * 100; 
     
    $(":input[id^='percentual___']").val(porcento);

}

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