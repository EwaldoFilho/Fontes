function createDataset(fields, constraints, sortFields) {
	var dataset = DatasetBuilder.newDataset();
	dataset.addColumn("status");
	dataset.addColumn("data");
	
	    var nome = String(constraints[0].initialValue);
		var Matricula = String(constraints[1].initialValue);
		var Usuario = String(constraints[2].initialValue);
		var senha = String(constraints[3].initialValue);

		try{
				var Provider = ServiceManager.getServiceInstance("ECMColleagueService");
				var ServiceLocator = Provider.instantiate("com.totvs.technology.ecm.foundation.ws.ECMColleagueServiceService");
				var Service = ServiceLocator.getColleagueServicePort();
				var colleagueDtoArray = Provider.instantiate("com.totvs.technology.ecm.foundation.ws.ColleagueDtoArray");
				var colleagueDto = Provider.instantiate("com.totvs.technology.ecm.foundation.ws.ColleagueDto");
				var wf = Provider.instantiate("com.totvs.technology.ecm.foundation.ws.WorkflowRoleDtoArray");
				var objectFactory = Provider.instantiate("com.totvs.technology.ecm.foundation.ws.ObjectFactory");
				
				log.info("###SERVIÇO USER AD###");
				    
//					groupDto.setGroupId(empresa);
//					groupDto2.setGroupId(filial);
//					groupDto3.setGroupId(uorg);
				    colleagueDto.setColleagueId(Matricula);
				    colleagueDto.setColleagueName(nome);
				    //colleagueDto.setGroupId(empresa);
				    colleagueDto.setLogin(Usuario);
				    colleagueDto.setPasswd(senha);
				    colleagueDto.setMail(Usuario+"@cvi.com.br");
				    colleagueDto.setActive(true);
				    
				    var colleagues = objectFactory.createColleagueDtoArray();
				    colleagues.getItem().add(colleagueDto);
				    
				    /*var groupProvider = ServiceManager.getServiceInstance("ECMGroupService");
				    var groupServiceLocator = groupProvider.instantiate("com.totvs.technology.ecm.foundation.ws.ECMGroupServiceServiceLocator");
				    var groupService = groupServiceLocator.getGroupServicePort();
				    var groupDtoArray = groupProvider.instantiate("com.totvs.technology.ecm.foundation.ws.GroupDtoArray");

				    var group1 = groupService.getGroup("administrator_fluig", "marcopolo",1,empresa);
				    var group2 = groupService.getGroup("administrator_fluig", "marcopolo",1,filial);
				    var group3 = groupService.getGroup("administrator_fluig", "marcopolo",1,uorg);
				
				var grupits1 = group1.getItem();
				var grupits2 = group2.getItem();
				var grupits3 = group3.getItem();
				
				groupDtoArray.setItem(grupits1);
				groupDtoArray.setItem(grupits2);
				groupDtoArray.setItem(grupits3);*/
				
				var dss = Service.createColleague("adm", "Flui&Cvi01",1,colleagues);
				
				log.info("dss:"+dss);
				
				if(dss=="ok"){
					
					dataset.addRow(new Array('Usuário criado no AD'));
					dataset.addRow(new Array(dss));
				}
				else
				{
					dataset.addRow(new Array(dss));
					dataset.addRow(new Array(dss));
					//throw dss;
				}
				
				}catch (e) {
					
					dataset.addRow(new Array(dss));
					throw e.message;
				}
			
	return dataset;
}