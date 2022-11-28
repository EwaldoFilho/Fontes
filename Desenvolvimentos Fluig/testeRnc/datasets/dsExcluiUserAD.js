function createDataset(fields, constraints, sortFields) {
	var dataset = DatasetBuilder.newDataset();
	dataset.addColumn("status");
	log.info('Entrou dataset Desativa Usuário');
	    //var nome = String(constraints[0].initialValue);
		var Matricula = String(constraints[0].initialValue);
		log.info(Matricula);

		try{
			log.info("Entrou try");
				var Provider = ServiceManager.getServiceInstance("ECMColleagueService");
				var ServiceLocator = Provider.instantiate("com.totvs.technology.ecm.foundation.ws.ECMColleagueServiceService");
				var Service = ServiceLocator.getColleagueServicePort();
				var colleagueDtoArray = Provider.instantiate("com.totvs.technology.ecm.foundation.ws.ColleagueDtoArray");
				var colleagueDto = Provider.instantiate("com.totvs.technology.ecm.foundation.ws.ColleagueDto");
				var wf = Provider.instantiate("com.totvs.technology.ecm.foundation.ws.WorkflowRoleDtoArray");
				var objectFactory = Provider.instantiate("com.totvs.technology.ecm.foundation.ws.ObjectFactory");
				
				log.info("##SERVIÇO desativar USER AD###");
				    
				/* colleagueDto.setColleagueId(Matricula);
				    colleagueDto.setColleagueName(nome);
				    //colleagueDto.setGroupId(empresa);
				    colleagueDto.setLogin(Usuario);
				    colleagueDto.setPasswd(senha);
				    colleagueDto.setMail(Usuario+"@cvi.com.br");
				    colleagueDto.setActive(true);
				    
				    var colleagues = objectFactory.createColleagueDtoArray();
				    colleagues.getItem().add(colleagueDto);*/
				    
				var dss = Service.removeColleague("adm", "Flui&Cvi01",1,Matricula);
				
				log.info("dss:"+dss);
				
				dataset.addRow(new Array('Usuário Desativado no Fluig.'));
				
				}catch (e) {
					log.info("Entrou catch");
					dataset.addRow(new Array(e.message));
					throw e.message;
				}
			
	return dataset;
}