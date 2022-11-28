/*
 * Necessário criar um serviço SOAP no Fluig (Painel de controle -> Desenvolvimento -> Serviços)
 * com o nome ECMDocumentService apontando para o /webdesk/ECMDocumentService?wsdl
 *
 * Mais informações: https://tdn.totvs.com/pages/releaseview.action?pageId=73084007
 */

/**
 * Cria o PDF do formulário
 *
 * @param {number} attempt Número da tentativa
 * @param {string} message Última mensagem de erro da atividade
 * @returns {boolean} True se executou
 * @throws {string} Exceção com a mensagem de erro
 */
function servicetask112(attempt, message) {
    var FOLDER_FORM_PDF = 5; // ID da pasta onde salvará o PDF
    var serviceHelper = ServiceManager.getService("ECMDocumentService").getBean();
    var service = serviceHelper
        .instantiate("com.totvs.technology.ecm.dm.ws.ECMDocumentServiceService")
        .getDocumentServicePort();

    if (service == null) {
        log.error("Erro ao carregar ECMDocumentService");
        throw "Erro ao gerar PDF do formulário";
    }

    try {
        var fileName = "nome-do-pdf-" + getValue("WKNumProces") + ".pdf";
        var attachment = serviceHelper.instantiate("com.totvs.technology.ecm.dm.ws.Attachment");
        attachment.setFileName(fileName);
        attachment.setFileSize(1);
        attachment.setAttach(true);
        attachment.setEditing(false);
        attachment.setPrincipal(true);

        // Faz o download do conteúdo do PDF usando o serviço externo
        attachment.setFilecontent(downloadProcessFormAsPdf());

        var attachmentArray = serviceHelper.instantiate("com.totvs.technology.ecm.dm.ws.AttachmentArray");
        attachmentArray.getItem().add(attachment);

        var fluigCredentials = getFluigWebServiceUser();

        var result = service.createSimpleDocument(
            fluigCredentials.username,
            fluigCredentials.password,
            1,
            FOLDER_FORM_PDF,
            "admin",
            fileName,
            attachmentArray
        );

        hAPI.attachDocument(result.getItem().get(0).getDocumentId());
    } catch (err) {
        log.error(err);
        throw "Erro ao gerar PDF do formulário";
    }

    return true;
}

/**
 * Efetua o download do formulário do processo em formato PDF
 *
 * O PDF é gerado por um serviço externo que lê os dados do formulário
 * através do WS do Fluig e então cria o PDF.
 *Fluig: exemplo de como utilizar um serviço externo para gerar um PDF e então anexá-lo ao processo em uma atividade de serviço
 * @returns {byte[]} Array de Bytes (Java) para enviar ao WS do Fluig
 */
function downloadProcessFormAsPdf() {
    var urlDownload = new java.net.URL(FluigPdfURL + "/endpoint.php?"
        + "user=usuario"
        + "&password=senha"
        + "&processId=" + getValue("WKNumProces")
    );

    var is = urlDownload.openStream();
    var bytesBuffer = java.lang.reflect.Array.newInstance(java.lang.Byte.TYPE, 8192);
    var baos = new java.io.ByteArrayOutputStream();
    var len = 0;

    while ((len = is.read(bytesBuffer, 0, bytesBuffer.length)) != -1) {
        baos.write(bytesBuffer, 0, len);
    }

    var fileContents = baos.toByteArray();
    baos.close();
    return fileContents;
}