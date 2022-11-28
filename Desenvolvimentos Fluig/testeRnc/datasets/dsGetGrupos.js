function createDataset(fields, constraints, sortFields) {
	 var dataset = DatasetBuilder.newDataset(); 
	
	 dataset.addColumn("Grupo");
	 dataset.addColumn("DescricaoGrupo");
	 
	 /*if(constraints == undefined || constraints == null){
		 
		 var CodCargo = "5804";
		 var CodNivel = "0";
		 var CodLotacao = "2320100000";
		 
	 }else{*/
		 
		 var CodCargo = String(constraints[0].initialValue);
		 var CodNivel = String(constraints[1].initialValue);
		 var CodLotacao = String(constraints[2].initialValue);
	// }
	var ds = DatasetFactory.getDataset("dsGetToken",null,null,null);
	var x = ds.getValue(0,'Token');
	
	try{
		var clientService = fluigAPI.getAuthorizeClientService();
		var data = {
	           companyId : ""+getValue('WKCompany')+"",
	           serviceCode : 'GetGrupos',
	           endpoint : '',
	           params : {		        	 
		        	  CodCargo:CodCargo,
		        	  CodNivel:CodNivel,
		        	  CodLotacao:CodLotacao },
	           method : 'post',
	           timeoutService: '100',
               headers: {
            	   Cookie: 'JOSSO_SESSIONID='+String(x)
               }
	    }
		log.info("DATA---:");
		log.info(JSON.stringify(data));
	    var vo = clientService.invoke(JSON.stringify(data));
		log.info("Result: ");
		var y = JSON.parse(vo.getResult());
		log.info(JSON.stringify(y))
		
		for(var i in y.items){
			dataset.addRow(new Array(y.items[i].grupo,y.items[i].descricao));
		}
	 }catch(e){
		 log.info(e);
	 }
	 return dataset
}