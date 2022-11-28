function createDataset(fields, constraints, sortFields) {

	var newDataset = DatasetBuilder.newDataset();

	newDataset.addColumn("server");
	newDataset.addColumn("port");

	newDataset.addRow(new Array('192.168.0.81', '8180'));
	
	return newDataset;

}