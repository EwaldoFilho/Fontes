function createDataset(fields, constraints, sortFields) {
	 var dataset = DatasetBuilder.newDataset(); 
	
	 dataset.addColumn("Cargo");
	 dataset.addColumn("descricao_cargo");
	 dataset.addColumn("Nivel");
	 dataset.addColumn("descricao_nivel");
	 	
	var ds = DatasetFactory.getDataset("dsGetToken",null,null,null);
	var x = ds.getValue(0,'Token');
	
	try{
		var clientService = fluigAPI.getAuthorizeClientService();
		var data = {
	           companyId : ""+getValue('WKCompany')+"",
	           serviceCode : 'BuscaCargoNivel',
	           endpoint : '',
	           method : 'get',
	           timeoutService: '100',
               headers: {
            	   Cookie: 'JOSSO_SESSIONID='+String(x)
               }
	    }
		log.info("DATA----X");
	    var vo = clientService.invoke(JSON.stringify(data));
		log.info("FFFFF")
		var y = JSON.parse(vo.getResult());
		log.info(JSON.stringify(y))
		
		for(var i in y.items){
			dataset.addRow(new Array(y.items[i].cargo,y.items[i].descricao_cargo,y.items[i].nivel,y.items[i].descricao_nivel));
		}
	 }catch(e){
		 log.info(e);
	 }
	 return dataset
}