function beforeTaskSave(colleagueId,nextSequenceId,userList){

var state = getValue("WKNumState");
   var completTask = getValue("WKCompletTask");
   var rem = "manutencao";

log.info(">>>>> Envio de email customizado beforeTaskSave: state " + state);
log.info(">>>>> Envio de email customizado beforeTaskSave: completTask " + completTask);
   //if (completTask.equals("true")) {

       if (state == 4 || state == 0 ) {
    	   try{
    		    //Monta mapa com parâmetros do template
    		    var parametros = new java.util.HashMap();
    		    var email = "andre.longuini@medmais.com";
    		    parametros.put("NOME_USUARIO", "JOAO");
    		    parametros.put("CODIGO_USUARIO", "01");
    		 
    		    //Este parâmetro é obrigatório e representa o assunto do e-mail
    		    parametros.put("subject", "ASSUNTO");
    		 
    		    //Monta lista de destinatários
    		    var destinatarios = new java.util.ArrayList();
    		    destinatarios.add(email);
    		 
    		    //Envia e-mail
    		    notifier.notify("suporte.ti@medmais.com", "EMAIL_HOMOLOGACAO", parametros, destinatarios, "text/html");
    		 
    		} catch(e){
    		    log.info(e);
    		}
       }
}