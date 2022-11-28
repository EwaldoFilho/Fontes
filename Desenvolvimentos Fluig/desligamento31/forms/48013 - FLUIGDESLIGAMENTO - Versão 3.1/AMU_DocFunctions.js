function saveDocument(Anexo, content) {

    var objFile = {
        documentDescription: Anexo[2],
        fileName: Anexo[1],
        fileContent: content,
        indice: "AnexoAMU"
    };

    try {

        var numSolicitacao = $("#numero_solicitacao").val();
        var documentList = [objFile]
        var aFilter = [];

        aFilter.push(DatasetFactory.createConstraint("PARENTDOCUMENTID", "3178", "3178", ConstraintType.MUST));
        aFilter.push(DatasetFactory.createConstraint("FOLDERDESCRIPTION", numSolicitacao.toString(), numSolicitacao.toString(), ConstraintType.MUST));
        aFilter.push(DatasetFactory.createConstraint("JSONFILES", JSON.stringify(documentList), JSON.stringify(documentList), ConstraintType.MUST));

        var dataset = DatasetFactory.getDataset("dsCreateDocumentAndFolderCredenciamento", null, aFilter, null);

        for (var i = 0; i < dataset.values.length; i++) {

            var obj = dataset.values[i]

            if (obj.DocumentId == "0") {
                FLUIGC.toast({
                    title: 'ATENÇÃO: ',
                    message: 'Erro ao Salvar Anexo ' + obj.content[i].Message,
                    type: 'danger'
                });
            } else {
                $("#JuridicoAttachmentDocID").val(obj.DocumentId)

                myLoading2.hide();
                FLUIGC.toast({
                    title: 'ATENÇÃO: ',
                    message: 'Documento Inserido!',
                    type: 'success'
                });
            }
        }
    } catch (err) {

        FLUIGC.toast({
            title: 'ATENÇÃO: ',
            message: 'Erro ao salvar o Documento: ' + err,
            type: 'danger'
        });
        myLoading2.hide();
    }
}