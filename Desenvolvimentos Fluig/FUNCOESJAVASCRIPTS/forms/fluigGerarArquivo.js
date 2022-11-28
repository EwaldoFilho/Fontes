function gerarArquivo(conteudo, pastaDestinoId, nomeDocumento) {
  var docDto = docAPI.newDocumentDto();
  docDto.setDocumentId(0);
  docDto.setDocumentTypeId("");
  docDto.setDocumentDescription(nomeDocumento);
  docDto.setParentDocumentId(parseInt(pastaDestinoId));

  var attachArray = new java.util.ArrayList();
  var mainAttach = docAPI.newAttachment();

  mainAttach.setFileName(nomeDocumento);
  mainAttach.setPrincipal(true);
  mainAttach.setAttach(false);
  mainAttach.setFilecontent(new java.lang.String(conteudo).getBytes("UTF-8"));
  attachArray.add(mainAttach);

  var doc = docAPI.createDocument(docDto, attachArray, null, null, null);

  return doc.getDocumentId();
}