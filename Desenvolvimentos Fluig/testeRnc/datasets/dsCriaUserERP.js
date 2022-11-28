function createDataset(fields, constraints, sortFields) {
	
	log.info("Entrou DSCRIAERP");
	var dataset = DatasetBuilder.newDataset(); 
	dataset.addColumn("Mensagem");
	dataset.addColumn("Codigo");

	var usuario = String(constraints[0].initialValue);
	var CodCargo = String(constraints[1].initialValue);
	var CodNivel = String(constraints[2].initialValue);
	var CodGrupo = String(constraints[3].initialValue);
	var Matricula = String(constraints[4].initialValue);
	var Tipo =  String(constraints[5].initialValue);
	var Email =  String(constraints[6].initialValue);
	var senha =  String(constraints[7].initialValue);
	
	var ds = DatasetFactory.getDataset("dsGetToken",null,null,null);
	var x = ds.getValue(0,'Token');
	
try {	
	//--------------------------------------------------------------------------------------------------		
	var clientService = fluigAPI.getAuthorizeClientService();
	log.info("POSTSOLICITACAO");
	var data = {
	          companyId : ""+getValue('WKCompany')+"",
	          serviceCode : 'IncluiUser',
	          endpoint : "",
	          method : 'post',
	          params : {
	        	  Usuario:usuario,
	        	  CodCargo:CodCargo,
	        	  CodNivel:CodNivel,
	        	  CodGrupo:CodGrupo,
	        	  CodMatricula:Matricula,
	        	  Tipo:Tipo,
	        	  Email:Email,
	        	  senha:senha},
	          timeoutService: '10000',
	          headers: {
           	   Cookie: 'JOSSO_SESSIONID='+String(x)
              }
	 }
	
	//log.info("DATA");	
	//log.info(data);	
	log.info("DATA stringify");
	log.info(JSON.stringify(data));
	
	var vo = clientService.invoke(JSON.stringify(data));
	log.info(vo);
	var x = JSON.parse(vo.getResult());
	log.info("Valor de X: " + JSON.stringify(x));
	
	for(var i in x){
	
		log.info("Valor de message: " + x.message);
		log.info("Valor de message: " + x.code);
		dataset.addRow(new Array(x.message, x.code));	
	}	 
	
	}catch(err){
		
		log.info(err);
	}
	
	return dataset
} 