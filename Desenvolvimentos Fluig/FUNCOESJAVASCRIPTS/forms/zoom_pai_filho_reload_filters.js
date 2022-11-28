/*
 * Tenho uma Pai Filho com os seguintes campos Zoom:
 * - ccProjeto
 * - ccAcao
 * - ccUnidade
 * 
 * Comportamento desejado:
 * 
 * - Quando houver uma seleção em ccProjeto o Zoom ccAcao recarregue usando o Projeto como filtro.
 * - Quando houver uma seleção em ccAcao o Zoom ccUnidade recarregue usando a Ação como filtro.
 * - Caso ccProjeto ou ccAcao sejam desmarcados todos os outros Zoom devem ser limpos também.
 */

 /**
 * Mapa das funções/callbacks chamadas em cada atualização do Zoom
 */
const zoomEvents = {
    ccProjeto: zoomProjetoUpdated
  , ccAcao: zoomAcaoUpdated
};

/**
* Chama a callback correta de acordo com o campo Zoom
*
* Por ser um Pai Filho os Zoom possuem um número sequencial
* que deve ser tratado.
*
* @param {object} item
*/
function executeZoomChangeEvent(item) {
    let inputName = item.inputName.split("___")[0];

    if (zoomEvents[inputName]) {
        zoomEvents[inputName].apply(null, [item]);
    }
}

/**
* Função executada sempre que um campo Zoom tem um item selecionado
*
* @param {object} selectedItem
*/
function setSelectedZoomItem(selectedItem) {
    executeZoomChangeEvent(selectedItem);
}

/**
* Função executada sempre que um campo Zoom tem um item desmarcado
*
* @param {object} removedItem
*/
function removedZoomItem(removedItem) {
    executeZoomChangeEvent(removedItem);
}

/**
 * Atualiza o filtro do Zoom da Ação quando há mudança no valor do Projeto
 *
 * @param {object} item
 */
function zoomProjetoUpdated(item) {
    // Recuperando o Zoom da Ação que é vinculado a esse Zom do Projeto
    let acao = "ccAcao___" + item.inputName.split("___")[1];

    // Limpando a atual seleção do Zoom Ação
    window[acao].clear();

    // Recarregando o Zoom com o novo filtro. Se o Projeto não estiver selecionado passa vazio como filtro
    reloadZoomFilterValues(acao, item.selected ? `CODPROJETO,${item.CODIGO}` : "");

    // Marca como não selecionado e dispara o evento do Zoom Ação (ele não dispara sozinho quando usamos reload filter)
    item.selected = false;
    zoomAcaoUpdated(item);
}

/**
 * Atualiza o filtro do Zoom da Unidade quando há mudança no valor da Ação
 *
 * @param {object} item
 */
function zoomAcaoUpdated(item) {
    // Recuperando o Zoom da Unidade que é vinculado a esse Zom da Ação
    let unidade = "ccUnidade___" + item.inputName.split("___")[1];

    // Limpando a atual seleção do Zoom Unidade
    window[unidade].clear();

    // Recarregando o Zoom com o novo filtro. Se a Ação não estiver selecionada passa vazio como filtro
    reloadZoomFilterValues(unidade, item.selected ? `CODPROJETO,${item.CODPROJETO},CODACAO,${item.CODIGO}` : "");
}