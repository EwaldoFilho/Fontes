function enableFields(form) {
    var activity = getValue('WKNumState');
    var indexes = form.getChildrenIndexes("rateioCusto");

    
    if (activity == 0) {
        form.setEnabled('empresas', false);
        form.setEnabled('fornecedor', true);
        form.setEnabled('numerodocumento', true);
        form.setEnabled('dataemissao', true);
        form.setEnabled('datavencimento', true);
        form.setEnabled('valordocumento', false);
        form.setEnabled('quantidadeparce', true);
        form.setEnabled('formapagamento', false);
        form.setEnabled('centrocusto', false);
        form.setEnabled('codCentroCustoForn___', false);
        form.setEnabled('descricaoForn___', false);
    }
    if (activity == 5) {
        form.setEnabled('empresas', false);
        form.setEnabled('fornecedor', false);
        form.setEnabled('numerodocumento', true);
        form.setEnabled('dataemissao', false);
        form.setEnabled('datavencimento', false);
        form.setEnabled('valordocumento', false);
        form.setEnabled('quantidadeparce', true);
        form.setEnabled('formapagamento', false);
        form.setEnabled('centrocusto', false);
        form.setEnabled('grupoBotao', false);
        for (var i = 0; i < indexes.length; i++) {

            form.setEnabled("codCentroCustoForn___"+ indexes[i], false);

            form.setEnabled("descricaoForn___"+ indexes[i], false);

            form.setEnabled("valor___"+ indexes[i], false);

            }
    }
    if (activity == 6) {
        form.setEnabled('empresas', false);
        form.setEnabled('fornecedor', false);
        form.setEnabled('numerodocumento', false);
        form.setEnabled('dataemissao', false);
        form.setEnabled('datavencimento', false);
        form.setEnabled('valordocumento', false);
        form.setEnabled('quantidadeparce', false);
        form.setEnabled('formapagamento', false);
        form.setEnabled('centrocusto', false);
        form.setEnabled('natureza', false);
        for (var i = 0; i < indexes.length; i++) {

            form.setEnabled("codCentroCustoForn___"+ indexes[i], false);

            form.setEnabled("descricaoForn___"+ indexes[i], false);

            form.setEnabled("valor___"+ indexes[i], false);

            }
    }
    if (activity == 7) {
        form.setEnabled('empresas', false);
        form.setEnabled('fornecedor', false);
        form.setEnabled('numerodocumento', false);
        form.setEnabled('dataemissao', false);
        form.setEnabled('datavencimento', false);
        form.setEnabled('valordocumento', false);
        form.setEnabled('quantidadeparce', false);
        form.setEnabled('formapagamento', false);
        form.setEnabled('centrocusto', false);
        form.setEnabled('natureza', false);
        for (var i = 0; i < indexes.length; i++) {

            form.setEnabled("codCentroCustoForn___"+ indexes[i], false);

            form.setEnabled("descricaoForn___"+ indexes[i], false);

            form.setEnabled("valor___"+ indexes[i], false);

            }
    }
    if (activity == 8) {
        form.setEnabled('empresas', false);
        form.setEnabled('fornecedor', false);
        form.setEnabled('numerodocumento', false);
        form.setEnabled('dataemissao', false);
        form.setEnabled('datavencimento', false);
        form.setEnabled('valordocumento', false);
        form.setEnabled('quantidadeparce', false);
        form.setEnabled('formapagamento', false);
        form.setEnabled('centrocusto', false);
        form.setEnabled('natureza', false);
        for (var i = 0; i < indexes.length; i++) {

            form.setEnabled("codCentroCustoForn___"+ indexes[i], false);

            form.setEnabled("descricaoForn___"+ indexes[i], false);

            form.setEnabled("valor___"+ indexes[i], false);

            }
    }
    if (activity == 31) {
        form.setEnabled('empresas', false);
        form.setEnabled('fornecedor', false);
        form.setEnabled('numerodocumento', false);
        form.setEnabled('dataemissao', false);
        form.setEnabled('datavencimento', false);
        form.setEnabled('valordocumento', false);
        form.setEnabled('quantidadeparce', false);
        form.setEnabled('formapagamento', false);
        form.setEnabled('centrocusto', false);
        form.setEnabled('grupoBotao', false);
        for (var i = 0; i < indexes.length; i++) {

            form.setEnabled("codCentroCustoForn___"+ indexes[i], false);

            form.setEnabled("descricaoForn___"+ indexes[i], false);

            form.setEnabled("valor___"+ indexes[i], false);

            }
    }
}