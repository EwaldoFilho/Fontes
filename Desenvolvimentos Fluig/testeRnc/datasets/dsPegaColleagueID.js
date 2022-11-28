function createDataset(fields, constraints, sortFields) {
	var dataset = DatasetBuilder.newDataset();

    dataset.addColumn("matricula");
    dataset.addColumn("nome");
    dataset.addColumn("mail");
    dataset.addColumn("login");
    dataset.addColumn("active");
    
    var MAIL = String(constraints[0].initialValue);

        //Filtros usuario
        var companyUserFilter = DatasetFactory.createConstraint("colleaguePK.companyId", getValue("WKCompany"), getValue("WKCompany"), ConstraintType.MUST);
        var userFilter = DatasetFactory.createConstraint("mail", MAIL, MAIL, ConstraintType.MUST);
        var constraintsUser = new Array(companyUserFilter, userFilter);
        
        //Consulta usuários
        var colleagues = DatasetFactory.getDataset("colleague", [], constraintsUser, []);
        
        dataset.addRow(new Array(
                colleagues.getValue(0, "colleaguePK.colleagueId"),
                colleagues.getValue(0, "colleagueName"),
                colleagues.getValue(0, "mail"),
                colleagues.getValue(0, "login"),
                colleagues.getValue(0, "active")));

    return dataset;
}