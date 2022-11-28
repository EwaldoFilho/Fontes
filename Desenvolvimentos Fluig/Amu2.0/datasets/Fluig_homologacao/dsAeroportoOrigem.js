function defineStructure() {

}
function onSync(lastSyncDate) {

}
function createDataset(fields, constraints, sortFields) {
	
var newDataset = DatasetBuilder.newDataset();
	
	newDataset.addColumn("codigo");
	newDataset.addColumn("Descr");
	
	newDataset.addRow(new Array("01","Aeroporto Aracaju"));
	newDataset.addRow(new Array("02","Aeroporto Navegantes"));
	newDataset.addRow(new Array("03","Aeroporto João Pessoa"));
	newDataset.addRow(new Array("04","Aeroporto de Cuiabá"));
	newDataset.addRow(new Array("05","Aeroporto de Petrolina "));
	newDataset.addRow(new Array("06","Aeroporto Florianópolis "));
	newDataset.addRow(new Array("07","Aeroporto Natal"));
	newDataset.addRow(new Array("08","Aeroporto Recife"));
	newDataset.addRow(new Array("09","Aeroporto Viracopos"));
	newDataset.addRow(new Array("10","Aeroporto Santos Dumont"));
	newDataset.addRow(new Array("11","Aeroporto Galeão"));
	newDataset.addRow(new Array("12","Aeroporto Congonhas"));
	newDataset.addRow(new Array("13","Aeroporto JK de Brasília"));
	newDataset.addRow(new Array("14","Aeroporto de Maceió "));
	newDataset.addRow(new Array("15","Aeroporto de Confins"));
	newDataset.addRow(new Array("16","Aeroporto Londrina"));
	newDataset.addRow(new Array("17","Aeroporto Teresina"));
	newDataset.addRow(new Array("18","Aeroporto Joinville"));
	newDataset.addRow(new Array("19","Aeroporto Imperatriz"));
	newDataset.addRow(new Array("20","Aeroporto Foz do Iguaçu"));
	newDataset.addRow(new Array("21","Aeroporto São Luís"));
	newDataset.addRow(new Array("22","Aeroporto Goiânia"));
	newDataset.addRow(new Array("23","Aeroporto Palmas"));
	newDataset.addRow(new Array("24","Aeroporto Curitiba"));

	
	
	return newDataset;

}function onMobileSync(user) {

}