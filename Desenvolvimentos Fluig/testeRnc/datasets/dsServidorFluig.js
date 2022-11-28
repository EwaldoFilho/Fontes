function createDataset(fields, constraints, sortFields) {
	var newDataset = DatasetBuilder.newDataset();
	
	newDataset.addColumn("host");
	newDataset.addColumn("port");
	newDataset.addColumn("company");
	
	//http://fluig.cvism.com.br/webdesk/streamcontrol/?WDCompanyId=1&WDNrDocto=15406&WDNrVersao=6000
	var host    = "http://fluig.cvism.com.br";
	var port    = "80";
	var company = "1";
	
	
	
    newDataset.addRow(new Array(host, port, company));
	        	
    return newDataset;
	
}
