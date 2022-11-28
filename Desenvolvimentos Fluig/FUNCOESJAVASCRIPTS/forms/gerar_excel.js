// Monta o 'corpo' do arquivo CSV
function geraCSV( dataset ){

    var dados = dataset.values;
    var colunas = dataset.columns;
    console.log(colunas);

    var array = typeof dados != 'object' ? JSON.parse(dados) : dados;
    var str = '';
    var lin = '';

    for (var c = 0; c < colunas.length; c++) {
        lin += colunas[c] + ",";
    }
    str += lin + '\r\n';

    for (var i = 0; i < array.length; i++) {
        var line = '';
        for (var c=0; c<colunas.length; c++) {
            if (line != '') line += ','

            line += array[i][colunas[c]];
        }

        str += line + '\r\n';
    }

    return str;
}

// Consulta o dataset e gera um link para download do arquivo CSV montado pela geraCSV
function exportCSV(){
    var ds = DatasetFactory.getDataset("colleague",null,null,null);

    var a         = document.createElement('a');
    a.href        = 'data:attachment/csv,' +  encodeURIComponent( geraCSV(ds) );
    a.target      = '_blank';
    a.innerText   ="CLIQUE PARA EXPORTAR O CSV";
    a.download    = 'meuDataset.csv';
    $("#MINHA_DIV").append(a);

    return true;

}