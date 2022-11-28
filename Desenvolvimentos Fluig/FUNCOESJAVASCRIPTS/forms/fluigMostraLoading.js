/*
* @function mostraLoading Show loading and execute any function.
* @param {Object} loading referência a variavel de loading que será utilizada
* @param {Function} anyFunction function to execute while loading shows.
*/
function mostraLoading(loading, anyFunction, ...anyParam) {
    loading.show();
    setTimeout(function () {
        anyFunction(...anyParam);
        loading.hide();
    }, 300);
}