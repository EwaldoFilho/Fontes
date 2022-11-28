function enableFields(form) {
    var activity = getValue('WKNumState');
    var indexes = form.getChildrenIndexes("rateioCusto");

    
    if (activity > 4){
    	
    	form.setEnabled('codFilial', false);
    	form.setEnabled('empresa', false);
    	form.setEnabled('codCentroCusto', false);
    	form.setEnabled('descricao', false);
    	form.setEnabled('codFilialBen', false);
        form.setEnabled('nomeBen', false);
        form.setEnabled('cpfBen', true);
        form.setEnabled('dataDespesa', false);
        form.setEnabled('datavencimento', false);
        form.setEnabled('historicodescri', false);
        form.setEnabled('valorTotal', false);
        form.setEnabled('chavePix', true);
        form.setEnabled('formaPagamento', false);
        form.setEnabled('cpf', false);
        form.setEnabled('cnpj', false);
        form.setEnabled('email', false);
        form.setEnabled('telefone', false);
        form.setEnabled('chaveAleatoria', false);
        form.setEnabled('tipoConta', false);
        form.setEnabled('banco', false);
        form.setEnabled('agencia', false);
        form.setEnabled('agenciaDV', false);
        form.setEnabled('conta', false);
        form.setEnabled('contaDV', false);
        form.setEnabled('grupoBotao', false);
        for (var i = 0; i < indexes.length; i++) {

            form.setEnabled("codCentroCustoBen___"+ indexes[i], false);

            form.setEnabled("descricaoBen___"+ indexes[i], false);

            form.setEnabled("valor___"+ indexes[i], false);

            }
    }
}