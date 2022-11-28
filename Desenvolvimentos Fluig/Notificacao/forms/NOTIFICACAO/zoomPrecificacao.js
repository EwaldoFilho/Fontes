function zoomTipoDocumento(obj) {

    var type = $(obj).prev("input").attr("name");
    var filters = "";
    var searchby = "FILTRO";

    tdizoom.open(
        "dsTipoDocumento", //Nome do Dataset
        "tipodocumento,Tipo do Documento,codigo, Codigo", //Campos a serem exibidos
        "codigo,tipodocumento", //Campos de retorno
        "Tipo de Documento", //Titulo
        filters, //Filtros
        type, //Type (deve ser sempre o atributo name do campo)
        null, //likefield
        null, //likevalue
        searchby //Campo/Constraint que será buscado o conteudo digitado (Seachby)
    );

}

function setSelectedZoomItem(selectedItem) {
    var name = selectedItem.type.split("___")[0];
    var indice = selectedItem.type.split("___")[1];

    if (name == "tipodocumento") {

        $("#tipodocumento___" + indice).val(selectedItem.tipodocumento);        
    } 
}

function removedZoomItem(selectedItem) {

    if (selectedItem == "tipodocumento") {

        $("#tipodocumento").val("");        
    } 

}