var datasetReturned = DatasetFactory.getDataset("dsItensChecklist", null, null, constraint);
var records = datasetReturned.values;
mydata = [];
for (var index in records) {
    var record = records[index];
    mydata.push({
        campocodigo: record.campo1,
        campoDescr: record.campo2,
        noResults: false
    });
}

var myTable = FLUIGC.datatable('#target', {
    dataRequest: mydata,
    renderContent: ['codigo', 'Descr'],
    header: [
        {'title': 'Código'},
        {'title': 'Nome'}        
    ]
}, function(err, data) {
    // DO SOMETHING (error or success)
});