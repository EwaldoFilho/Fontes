function inicializaCamposZoom() {
    if (typeof window['filial'].setValue != 'function') {
        setTimeout(inicializaCamposZoom, 500);
    } else {
        // Seu código aqui...
        // disableZoom('filial')
        // prepareReload('motivo', 'tipoRequisicao', '4')
    }
}