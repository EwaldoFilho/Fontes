
function createDataset(fields, constraints, sortFields) {

	//var sigla = constraints[0].initialValue;
	var newDataset = DatasetBuilder.newDataset();
	newDataset.addColumn("nrFicha");
	newDataset.addColumn("cdOcorrencia");
	newDataset.addColumn("cdPlanoAcao");
	newDataset.addColumn("nmResponsavelPA");
	newDataset.addColumn("nmDataPA");
	newDataset.addColumn("nmAssunto");

	newDataset.addColumn("cdAtividadePA");
	
	log.info("Dataset xpto");
	
	var cdOcorrencia = "166";
	
	//Busca os planos de ação do registro de ocorrencia
	var c1 = DatasetFactory.createConstraint("cdOcorrencia", cdOcorrencia, cdOcorrencia, ConstraintType.MUST);
	var filtros = new Array(c1);
	//var campos  = new Array("nrFicha", "dtRegistro", "cdOcorrencia", "dtOcorrencia");
	var sorting = new Array("metadata#id"); 
    var dataset = DatasetFactory.getDataset("ecm_kgq_pa", null, filtros, sorting);
    log.info(dataset.rowsCount); 
    for(i=0;i<dataset.rowsCount;i++) {
    	
    	log.info("Plano: " + dataset.getValue(i, "cdPlanoAcao"));
    	
		//Busca as atividades do plano
		var c1 = DatasetFactory.createConstraint("cdPlanoAcao", dataset.getValue(i, "cdPlanoAcao"),dataset.getValue(i, "cdPlanoAcao"), ConstraintType.MUST);
		var filtros = new Array(c1);
		//var campos  = new Array("cdOcorrencia", "nmDataPA", "nmResponsavelPA", "nmAssunto");
		var sorting = new Array("metadata#id"); 
	    var datasetAPA = DatasetFactory.getDataset("ecm_kgq_atividadepa", null, filtros, sorting);
		
	    log.info("Quantidade encontrada");
		log.info(datasetAPA.values.length);

		for(j=0;j<datasetAPA.values.length; j++) {

	    	newDataset.addRow(new Array(dataset.getValue(i, "nrFicha"),
					dataset.getValue(i, "cdOcorrencia"),
					dataset.getValue(i, "cdPlanoAcao"),
					dataset.getValue(i, "nmResponsavelPA"),
					dataset.getValue(i, "nmDataPA"),
					dataset.getValue(i, "nmAssunto"),
					datasetAPA.getValue(j, "cdAtividadePA")));
			/*
			tabelaAPA += "<th class='fs-v-align-middle col-xs-1'>" + datasetAPA.values[j].cdAtividadePA 		+ "</th>";
			tabelaAPA += "<th class='fs-v-align-middle col-xs-1'>" + datasetAPA.values[j].cdPlanoAcao 			+ "</th>";
			tabelaAPA += "<th class='fs-v-align-middle col-xs-1'>" + datasetAPA.values[j].nmResponsavel 		+ "</th>";
			tabelaAPA += "<th class='fs-v-align-middle col-xs-1'>" + datasetAPA.values[j].nmOquCom 				+ "</th>";
			tabelaAPA += "<th class='fs-v-align-middle col-xs-1'>" + datasetAPA.values[j].nmPrazoDeConclusao 	+ "</th>";
			tabelaAPA += "<th class='fs-v-align-middle col-xs-4'>" + datasetAPA.values[j].dtConclusaoReal 		+ "</th>";
			tabelaAPA += "<th class='fs-v-align-middle col-xs-4'>" + datasetAPA.values[j].status 				+ "/th>";
			*/
		}
    	
    }

	return newDataset;
    
}


function buscaDataHora(tipo){
	
	var fullDate = new Date();
	var hora     = fullDate.getHours();
	var minuto   = fullDate.getMinutes();
	
	if (hora <= 9) {
		hora = "0" + hora;
	}
	
	if (minuto <= 9){	
		minuto = "0" + minuto;
	}
	
	var hrRetorno = hora + ":" + minuto;
	var dia = fullDate.getDate().toString();

	if(dia.length == 1){
		dia = "0" + dia;
	}
	var mes = (fullDate.getMonth()+1).toString();

	if(mes.length == 1){
		mes = "0" + mes;
	}
	
	var dtRetorno = dia + "/" + mes + "/" + fullDate.getFullYear();
	
	if (tipo == "data") {
		return dtRetorno;
	}
	if (tipo == "hora") {
		return hrRetorno;
	}
}