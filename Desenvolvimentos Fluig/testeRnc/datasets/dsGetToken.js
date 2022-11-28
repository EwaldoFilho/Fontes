function createDataset(fields, constraints, sortFields) {
	 var dataset = DatasetBuilder.newDataset(); 
	
	 dataset.addColumn("Token");
	 
	 try{
		var clientService = fluigAPI.getAuthorizeClientService();
		var data = {
	           companyId : ""+getValue('WKCompany')+"",
	           serviceCode : 'GeraToken',
	           endpoint : '',
	           method : 'get',
	           timeoutService: '100',
	    }
		log.info("DATA");
		log.info(JSON.stringify(data))

	    var vo = clientService.invoke(JSON.stringify(data));
		log.info(vo);
		var x = String(vo.getResult());
		log.info(x);
		
		dataset.addRow(new Array(x));
	 }catch(err){
			log.info(err);
	 }
	 return dataset
}