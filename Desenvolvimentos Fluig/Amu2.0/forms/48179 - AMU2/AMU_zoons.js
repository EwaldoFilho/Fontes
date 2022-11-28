function zoomnacionalidade(obj) {

    var type = $(obj).prev("input").attr("name");
    var filters = "";
    var searchby = "FILTRO";

    tdizoom.open(
        "dsPais", //Nome do Dataset
        "CODIGO,Código,PAIS,Descrição", //Campos a serem exibidos
        "CODIGO,PAIS", //Campos de retorno
        "Nacionalidade", //Titulo
        filters, //Filtros
        type, //Type (deve ser sempre o atributo name do campo)
        null, //likefield
        null, //likevalue
        searchby //Campo/Constraint que será buscado o conteudo digitado (Seachby)
    );

}

function zoomAeroportoOrigem(obj) {

    var type = $(obj).prev("input").attr("name");
    var filters = "";
    var searchby = "FILTRO";

    tdizoom.open(
        "dsAeroportoOrigem", //Nome do Dataset
        "Descr,Descrição", //Campos a serem exibidos
        "codigo,Descr", //Campos de retorno
        "Aeroporto de Origem", //Titulo
        filters, //Filtros
        type, //Type (deve ser sempre o atributo name do campo)
        null, //likefield
        null, //likevalue
        searchby //Campo/Constraint que será buscado o conteudo digitado (Seachby)
    );

}

function zoomCompanhiaAerea(obj) {

    var type = $(obj).prev("input").attr("name");
    var filters = "";
    var searchby = "FILTRO";

    tdizoom.open(
        "dsCompanhiaAeria", //Nome do Dataset
        "Descr,Descrição", //Campos a serem exibidos
        "codigo,Descr", //Campos de retorno
        "Companhia Aerea", //Titulo
        filters, //Filtros
        type, //Type (deve ser sempre o atributo name do campo)
        null, //likefield
        null, //likevalue
        searchby //Campo/Constraint que será buscado o conteudo digitado (Seachby)
    );

}

function zoomGastos(obj) {

    var type = "gastos"
    var Local = $("#armazem").val();    
    var filters = "LOCAL," + Local;
    var searchby = "FILTRO";

    //FLUIGIP.TABLE.clearTable("itensGastos")
    $("#qtdGastos").val(0);

    tdizoomCheck.open(
        "dsProdutosAmu", //Nome do Dataset
        "codGasto,Codigo,descrGasto,Descrição,unidadeDesc,Unidade,SALDO_LT,Saldo", //Campos a serem exibidos
        "codGasto,descrGasto,unidade", //Campos de retorno
        "Materiais/Medicamentos", //Titulo
        filters, //Filtros
        type, //Type (deve ser sempre o atributo name do campo)
        null, //likefield
        null, //likevalue
        searchby //Campo/Constraint que será buscado o conteudo digitado (Seachby)
    );

}

function zoomLote(obj) {

    var type = $(obj).prev("input").attr("name");
    var id = type.split("___")[1];
    var Local = $("#armazem").val();    
    var CodProd = $("#codGasto___" + id).val();
    var filters = "LOCAL," + Local + ",PRODUTO," + CodProd;
    var searchby = "FILTRO";

    tdizoom.open(
        "dsLoteProd", //Nome do Dataset
        "B8_LOTECTL,Lote,B8_SALDO,Saldo", //Campos a serem exibidos
        "B8_LOTECTL,B8_SALDO", //Campos de retorno
        "Lote", //Titulo
        filters, //Filtros
        type, //Type (deve ser sempre o atributo name do campo)
        null, //likefield
        null, //likevalue
        searchby //Campo/Constraint que será buscado o conteudo digitado (Seachby)
    );

}

function zoomTipoAtendimento(obj) {

    var type = "tipoAtendimento"
    var filters = "";
    var searchby = "FILTRO";

    //FLUIGIP.TABLE.clearTable("itensTipoAtendimento")
    $("#qtdTipoAtendimento").val(0);

    tdizoomCheck.open(
        "dsTipoAtendimento", //Nome do Dataset
        "Descr,Descrição", //Campos a serem exibidos
        "codigo,Descr", //Campos de retorno
        "Tipos de Procedimento", //Titulo
        filters, //Filtros
        type, //Type (deve ser sempre o atributo name do campo)
        null, //likefield
        null, //likevalue
        searchby //Campo/Constraint que será buscado o conteudo digitado (Seachby)
    );

}

function zoomClassCuidado(obj) {

    var type = "classCuidado"
    var filters = "";
    var searchby = "FILTRO";

    //FLUIGIP.TABLE.clearTable("itensClassCuidado")
    $("#qtdClassCuidado").val(0);

    tdizoomCheck.open(
        "dsClassCuidado", //Nome do Dataset
        "Descr,Descrição", //Campos a serem exibidos
        "Descr", //Campos de retorno
        "Classificação do Cuidado", //Titulo
        filters, //Filtros
        type, //Type (deve ser sempre o atributo name do campo)
        null, //likefield
        null, //likevalue
        searchby //Campo/Constraint que será buscado o conteudo digitado (Seachby)
    );

}

function zoomEmpresa(obj) {

    var type = $(obj).prev("input").attr("name");
    var filters = "";
    var searchby = "FILTRO";

    tdizoom.open(
        "dsEmpresa", //Nome do Dataset
        "Descr,Descrição", //Campos a serem exibidos
        "codigo,Descr", //Campos de retorno
        "Companhia Aeria", //Titulo
        filters, //Filtros
        type, //Type (deve ser sempre o atributo name do campo)
        null, //likefield
        null, //likevalue
        searchby //Campo/Constraint que será buscado o conteudo digitado (Seachby)
    );

}

function zoomTomador(obj) {

    var type = $(obj).prev("input").attr("name");
    var filters = "USER," + getWKUserLogin();
    var searchby = "FILTRO";

    tdizoom.open(
        "dsDadosContrato", //Nome do Dataset
        "ZZA_FILIAL,Filial,CTT_DESC01,Tomador,ZZA_CUSTO,Centro de Custo,ZZA_LOCAL,Local", //Campos a serem exibidos
        "ZZA_FILIAL,CTT_DESC01,ZZA_CUSTO,ZZA_LOCAL", //Campos de retorno
        "Tomador", //Titulo
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

    if (name == "nacionalidade") {

        $("#nacionalidade").val(selectedItem.PAIS);
        $("#nacionalidadeCodigo").val(selectedItem.CODIGO);
    } else if (name == "AeroportoOrigem") {
        $("#AeroportoOrigem").val(selectedItem.Descr);
        $("#declaracao1").val(selectedItem.Descr);
    } else if (name == "CompanhiaAerea") {
        $("#CompanhiaAerea").val(selectedItem.Descr);
    } else if (name == "empresa") {
        $("#empresa").val(selectedItem.Descr);
    } else if (name == "tipoAtendimento") {

        adicionarItemTipoAtendimento(selectedItem.codigo, selectedItem.Descr)
    } else if (name == "gastos") {

        adicionarItemGastos(selectedItem.codGasto, selectedItem.descrGasto, selectedItem.unidade)
    } else if (name == "classCuidado") {

        adicionarItemClassCuidado(selectedItem.Descr)
    } else if (name == "lote") {
        $("#lote___" + indice).val(selectedItem.B8_LOTECTL);
        $("#saldo___" + indice).val(selectedItem.B8_Saldo);
                
    } else if (name == "tomador") {
        $("#tomador").val(selectedItem.CTT_DESC01.trim());
        $("#codigoCentroCusto").val(selectedItem.ZZA_CUSTO.trim());
        $("#filial").val(selectedItem.ZZA_FILIAL.trim());
        $("#armazem").val(selectedItem.ZZA_LOCAL.trim());

        var data = new Date();
        $("#dataAmu").val(data.toLocaleDateString("pt-BR"));
        //$("#nomeAtendente").val(getWKUserName());
        ///$("#horarioInicialCadastro").val(data.getHours() + ":" + data.getMinutes())
    }
}


function removedZoomItem(selectedItem) {

    if (selectedItem == "nacionalidade") {

        $("#nacionalidade").val("");
        $("#nacionalidadeCodigo").val("");
    } else if (selectedItem == "AeroportoOrigem") {

        $("#AeroportoOrigem").val("")
    } else if (selectedItem == "CompanhiaAerea") {

        $("#CompanhiaAerea").val("")
    }

}