
function createDataset(fields, constraints, sortFields) {
   try {
      // Utiliza o ServiceManager para obter uma referencia ao servico.
      var serviceProvider = ServiceManager.getService('WSEXECBO');
      var serviceLocator = 
          serviceProvider.instantiate('com.totvs.framework.ws.execbo.service.WebServiceExecBO');
      var service = serviceLocator.getWebServiceExecBOPort();
      
      
      var newDataset = DatasetBuilder.newDataset();
      newDataset.addColumn("response");
      
      var dataRow = new Array();
      
      // Faz login e recebe o token de autenticacao
      var token = service.userLogin("13", "MTM=");
      
      //log.info("Token: " + token);
      
      var programName = new String(constraintInitialValue(constraints, "programName"));
      var procedureName = new String(constraintInitialValue(constraints, "procedureName"));
      var jsonParams = new String(constraintInitialValue(constraints, "json"));
      
      // Chama a procedure passando os parametros e o token de autenticacao.
      var resp = service.callProcedureWithToken(token, programName, procedureName, jsonParams);
  
      // Converte o resultado para um objeto
      //var respObj = JSON.parse(resp);
  
      // Apresenta o resultado no log.
      log.info(">>> Resposta da procedure:");
      log.info(resp);
      
      dataRow[0] = resp;
      
      // Cria os registros
      newDataset.addRow(dataRow);
      return newDataset;
 
   } catch (e) {
       log.error(e.message);
       
       var errDataset = DatasetBuilder.newDataset();
       errDataset.addColumn("Erro");
       errDataset.addRow(new Array(e.message));
       return errDataset;
   }
}

function constraintInitialValue(constraints, campo) {
    for (var cons = 0; cons < constraints.length; cons++) {
        var constraint = constraints[cons];
        
        if (constraint.getFieldName().equals(campo)) {
            return constraint.getInitialValue();
        }
    }
    
    return "";
}
