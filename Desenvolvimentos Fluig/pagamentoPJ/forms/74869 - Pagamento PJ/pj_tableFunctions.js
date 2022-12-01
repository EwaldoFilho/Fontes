//Função para adicionar itens em uma tabela pai x filho.
function adicionarpj(A2_COD,A2_LOJA) {
    var id = wdkAddChild("tablePJ");
    var qtd = $("#tablePJ").val();
    var atividade = getWKNumState();

    $("#codFornecedor___" + id).val(A2_COD);   
    $("#codLoja___" + id).val(A2_LOJA);
    $("#codProduto___" + id).val("100000000002255");
    $("#descriProduto___" + id).val("SERVICOS ADMINISTRATIVOS                                    ");    
    $("#valor___" + id).mask('000.000.000.000.000,00', {reverse: true});
    qtd++
    $("#baseRateio").val(qtd);
    $("#codFornecedor___" + id).attr('readonly', true);
    $("#codLoja___" + id).attr('readonly', true);
    $("#descriProduto___" + id).attr('readonly', true);
    
   
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