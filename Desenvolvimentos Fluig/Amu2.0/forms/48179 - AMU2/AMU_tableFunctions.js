//Função para adicionar itens em uma tabela pai x filho.
function adicionarItemTipoAtendimento(codigo, Descr) {
    var id = wdkAddChild("itensTipoAtendimento");
    var qtd = $("#qtdTipoAtendimento").val();
    var atividade = getWKNumState();

    $("#codigo___" + id).val(codigo);
    $("#descr___" + id).val(Descr);

    qtd++
    $("#qtdTipoAtendimento").val(qtd);
}

function adicionarItemGastos(codigo, Descr, unidade) {
    var id = wdkAddChild("itensGastos");
    var qtd = $("#qtdGastos").val();
    var atividade = getWKNumState();

    $("#codGasto___" + id).val(codigo);
    $("#descrGasto___" + id).val(Descr);
    $("#unidade___" + id).val(unidade);

    qtd++
    $("#qtdTipoAtendimento").val(qtd);
}

function adicionarItemClassCuidado(Descr) {

    var id = wdkAddChild("itensClassCuidado");
    var qtd = $("#qtdClassCuidado").val();

    $("#classCuidadoDescr___" + id).val(Descr);

    qtd++
    $("#qtdClassCuidado").val(qtd);
}

