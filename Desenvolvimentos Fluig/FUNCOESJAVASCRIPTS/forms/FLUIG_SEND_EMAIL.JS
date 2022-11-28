/*
 * Super contribuição do vinny.silveira no fórum Fluiggers
 * URL: https://fluiggers.com.br/t/envio-de-e-mail-com-anexos/545
 */

/**
 * Método para enviar os anexos de uma solicitação anexadas em um e-mail
 * 
 * @param {string} assunto Assunto do e-mail
 * @param {string} conteudo Corpo do e-mail escrito em HTML
 * @param {string} to Destinatário principal
 * @param {string[]} cc Array com as cópias
 * @param {string[]} cco Array com as cópias ocultas
 * 
 * @returns {void}
 */
function sendMail(assunto, conteudo, to, cc, cco) {

    // configurar com o servidor de e-mail
    var username = "login@email.com";
    var nameuser = 'Nome Completo';
    var password = "senha";
    var host = "smtp.office365.com";
    var port = "587";

    var props = new java.util.Properties();
    props.put("mail.transport.protocol", "smtp");
    props.put("mail.smtp.auth", "true");
    props.put("mail.smtp.starttls.enable", "true");
    props.put("mail.smtp.host", host);
    props.put("mail.smtp.port", port);
  
    var docService = fluigAPI.getDocumentService();
    var tmpHtml = org.jsoup.Jsoup.parse(conteudo);

    var attachments = hAPI.listAttachments();
    var session = javax.mail.Session.getDefaultInstance(props);
    var message = new javax.mail.internet.MimeMessage(session);
    var messageBodyPart = new javax.mail.internet.MimeBodyPart();
    var multipart = new javax.mail.internet.MimeMultipart("mixed");
    var transport = session.getTransport();

    message.setFrom(new javax.mail.internet.InternetAddress(username, nameuser));
    message.setSubject(assunto);

    message.addRecipient(
        javax.mail.Message.RecipientType.TO,
        new javax.mail.internet.InternetAddress(to)
    );

    if (cc && cc.length) {
        for (var i in cc) {
            message.addRecipient(
                javax.mail.Message.RecipientType.CC,
                new javax.mail.internet.InternetAddress(cc[i])
            );
        }
    }

    if (cco && cco.length) {
        for (var j in cco) {
            message.addRecipient(
                javax.mail.Message.RecipientType.BCC,
                new javax.mail.internet.InternetAddress(cco[j])
            );
        }
    }

    for (var i = 0; i < attachments.size(); i++) {
        var anexo = attachments.get(i);
        var publicUrl = docService.getDownloadURL(anexo.getDocumentId());

        var attachment = new javax.mail.internet.MimeBodyPart();
        attachment.setDataHandler(new javax.activation.DataHandler(new java.net.URL(publicUrl)));
        attachment.setDisposition(javax.mail.internet.MimeBodyPart.ATTACHMENT);
        attachment.setFileName(anexo.getDocumentDescription());

        multipart.addBodyPart(attachment);
    }

    messageBodyPart.setContent(tmpHtml.toString(), "text/html; charset=utf-8");
    multipart.addBodyPart(messageBodyPart);

    message.setContent(multipart);

    transport.connect(username, password);
    transport.sendMessage(message, message.getAllRecipients());
}

// Exemplo de chamada:

var cc = ["email_um@email.com", "email_dois@email.com"]
var cco = ["email_tres@email.com", "email_quatro@email.com"]
var corpoHtml = "<h1>Hello e-mail com anexos!</h1>"

try {
    sendMail("Assunto aqui", corpoHtml, "teste@email.com", cc, cco);
} catch (error) {
    log.info("Falha no envio!!");
    log.error(e);
}