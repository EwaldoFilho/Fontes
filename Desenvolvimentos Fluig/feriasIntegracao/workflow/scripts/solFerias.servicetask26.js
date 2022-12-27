function servicetask26(attempt, message) {
	log.info("### Inclusão da integração de Programação de Férias TOTVS Protheus - servicetask26 - INICIO ###");

	var controle1 = hAPI.getCardValue("programado1");
	var controle2 = hAPI.getCardValue("programado2");
	var CFILIAL = '"' + hAPI.getCardValue("filialColab") + '"';
	var cMatricula = '"' + hAPI.getCardValue("matColaborador") + '"';
	var dBaseIni = '"' + hAPI.getCardValue("dtBaseIni") + '"';
	var dBaseFim = '"' + hAPI.getCardValue("dtBaseFim") + '"';
	var cFluig = '"' + hAPI.getCardValue("processo") + '"';
	log.info("antes 1" + dBaseIni);
	log.info("antes 1" + dBaseFim);

	log.info("CONTROLADOR 1" + controle1);
	log.info("CONTROLADOR 1" + controle2);
	log.info("CONTROLADOR 1" + CFILIAL);
	log.info("CONTROLADOR 1" + cMatricula);
	log.info("depois 1" + dBaseIni);
	log.info("depois 1" + dBaseFim);
	log.info("CONTROLADOR 1" + cFluig);
	log.info("#############################  PROGRAMACAO DE FERIAS     ###########################################");

	if (controle1 == 'sim') {
		var RF_DATAINI = '"' + hAPI.getCardValue("dtFormatado2") + '"';
		var RF_DFEPRO1 = '"' + hAPI.getCardValue("qtDias2") + '"';
		var RF_DABPRO1 = '"' + hAPI.getCardValue("qtAbono2") + '"';
		var PERPROG = '2';
		var objBackEnd = JSON.parse('{"CFILIAL":' + CFILIAL + ',"cMatricula":'
				+ cMatricula + ',"dBaseIni": ' + dBaseIni + ',"dBaseFim": '
				+ dBaseFim + ', "cFluig":' + cFluig
				+ ',"Periodo1":[{"RF_DATAINI":' + RF_DATAINI + ',"RF_DFEPRO1":'
				+ RF_DFEPRO1 + ',"RF_DABPRO1":' + RF_DABPRO1 + ',"PERPROG":'
				+ PERPROG + '}]}');

		log.info("SEGUNDA PROGRAMACAO FERIAS::::" + JSON.stringify(objBackEnd));

		var clientService = fluigAPI.getAuthorizeClientService();
		var compID = getValue("WKCompany");

		var data = {
			companyId : compID + "",
			serviceCode : "WSRESTPROTHEUS",
			endpoint : "/WSAPIFERIAS",
			method : "post",
			timeoutService : "200",
			params : objBackEnd,
			options : {
				encoding : "iso-8859-1",
				mediaType : "application/json"
			}
		}

		var vo = clientService.invoke(JSONUtil.toJSON(data));
		if (vo.getResult() == null || vo.getResult().isEmpty()) {
			throw "integração de Programação de Férias";
		} else {
			log.info("### integração de Programação de Férias - servicetask26 - response - "
							+ vo.getResult());
			var response = JSON.parse(vo.getResult());
			if (response.STATUS == undefined || response.STATUS == null) {
				throw "Erro de comunicação com o Protheus";
			} else {
				if (response.STATUS == false) {
					throw response.MESSAGE;
				} else {

				}
			}
		}
		log.info("### Finalização da integração de Programação de Férias TOTVS Protheus - servicetask26 - FIM ###");
	} else if (controle2 == 'sim') {
		var RF_DATAINI = '"' + hAPI.getCardValue("dtFormatado1") + '"';
		var RF_DFEPRO1 = '"' + hAPI.getCardValue("qtDias1") + '"';
		var RF_DABPRO1 = '"' + hAPI.getCardValue("qtAbono1") + '"';
		var PERPROG = '1';
		var objBackEnd = JSON.parse('{"CFILIAL":' + CFILIAL + ',"cMatricula":'
				+ cMatricula + ',"dBaseIni": ' + dBaseIni + ',"dBaseFim": '
				+ dBaseFim + ', "cFluig":' + cFluig
				+ ',"Periodo1":[{"RF_DATAINI":' + RF_DATAINI + ',"RF_DFEPRO1":'
				+ RF_DFEPRO1 + ',"RF_DABPRO1":' + RF_DABPRO1 + ',"PERPROG":'
				+ PERPROG + '}]}');

		log.info("PRIMEIRA PROGRAMACAO FERIAS::::"+ JSON.stringify(objBackEnd));

		var clientService = fluigAPI.getAuthorizeClientService();
		var compID = getValue("WKCompany");

		var data = {
			companyId : compID + "",
			serviceCode : "WSRESTPROTHEUS",
			endpoint : "/WSAPIFERIAS",
			method : "post",
			timeoutService : "200",
			params : objBackEnd,
			options : {
				encoding : "iso-8859-1",
				mediaType : "application/json"
			}
		}

		var vo = clientService.invoke(JSONUtil.toJSON(data));
		if (vo.getResult() == null || vo.getResult().isEmpty()) {
			throw "integração de Programação de Férias";
		} else {
			log.info("### integração de Programação de Férias - servicetask26 - response - "
							+ vo.getResult());
			var response = JSON.parse(vo.getResult());
			if (response.STATUS == undefined || response.STATUS == null) {
				throw "Erro de comunicação com o Protheus";
			} else {
				if (response.STATUS == false) {
					throw response.MESSAGE;
				} else {

				}
			}
		}

		log.info("### Finalização da integração de Programação de Férias TOTVS Protheus - servicetask26 - FIM ###");
	} else if (controle1 == 'nao' && controle2 == 'nao') {

		var RF_DATAINI1 = '"' + hAPI.getCardValue("dtFormatado1") + '"';
		var RF_DFEPRO1 = '"' + hAPI.getCardValue("qtDias1") + '"';
		var RF_DABPRO1 = '"' + hAPI.getCardValue("qtAbono1") + '"';
		var PERPROG1 = '1';
		var RF_DATAINI2 = '"' + hAPI.getCardValue("dtFormatado2") + '"';
		var RF_DFEPRO2 = '"' + hAPI.getCardValue("qtDias2") + '"';
		var RF_DABPRO2 = '"' + hAPI.getCardValue("qtAbono2") + '"';
		var PERPROG2 = '2';
		log.info("SOCORRO DEUS "+ RF_DFEPRO1);
		log.info("SOCORRO DEUS "+ RF_DFEPRO2);
		if (RF_DFEPRO1 != "") {
			var objBackEnd1 = JSON.parse('{"CFILIAL":' + CFILIAL
					+ ',"cMatricula":' + cMatricula + ',"dBaseIni": '
					+ dBaseIni + ',"dBaseFim": ' + dBaseFim + ', "cFluig":'
					+ cFluig + ',"Periodo1":[{"RF_DATAINI":' + RF_DATAINI1
					+ ',"RF_DFEPRO1":' + RF_DFEPRO1 + ',"RF_DABPRO1":'
					+ RF_DABPRO1 + ',"PERPROG":' + PERPROG1 + '}]}');

			log.info("PROGRAMACAO COMPLETA FERIAS PRIMEIRA PROGRAMACAO::::"
					+ JSON.stringify(objBackEnd1));

			var clientService = fluigAPI.getAuthorizeClientService();
			var compID = getValue("WKCompany");

			var data = {
				companyId : compID + "",
				serviceCode : "WSRESTPROTHEUS",
				endpoint : "/WSAPIFERIAS",
				method : "post",
				timeoutService : "200",
				params : objBackEnd1,
				options : {
					encoding : "iso-8859-1",
					mediaType : "application/json"
				}
			}

			var vo = clientService.invoke(JSONUtil.toJSON(data));
			if (vo.getResult() == null || vo.getResult().isEmpty()) {
				throw "integração de Programação de Férias";
			} else {
				log.info("### integração de Programação de Férias - servicetask26 - response - "
								+ vo.getResult());
				var response = JSON.parse(vo.getResult());
				if (response.STATUS == undefined || response.STATUS == null) {
					throw "Erro de comunicação com o Protheus";
				} else {
					if (response.STATUS == false) {
						throw response.MESSAGE;
					} else {

					}
				}
			}
		}
		if (RF_DFEPRO2 != "") {
			var objBackEnd2 = JSON.parse('{"CFILIAL":' + CFILIAL
					+ ',"cMatricula":' + cMatricula + ',"dBaseIni": '
					+ dBaseIni + ',"dBaseFim": ' + dBaseFim + ', "cFluig":'
					+ cFluig + ',"Periodo2":[{"RF_DATAINI":' + RF_DATAINI2
					+ ',"RF_DFEPRO1":' + RF_DFEPRO2 + ',"RF_DABPRO1":'
					+ RF_DABPRO2 + ',"PERPROG":' + PERPROG2 + '}]}');
			log.info("PROGRAMACAO COMPLETA FERIAS SEGUNDA PROGRAMAÇÃO::::"+ JSON.stringify(objBackEnd2));

			var clientService = fluigAPI.getAuthorizeClientService();
			var compID = getValue("WKCompany");

			var data = {
				companyId : compID + "",
				serviceCode : "WSRESTPROTHEUS",
				endpoint : "/WSAPIFERIAS",
				method : "post",
				timeoutService : "200",
				params : objBackEnd2,
				options : {
					encoding : "iso-8859-1",
					mediaType : "application/json"
				}
			}

			var vo = clientService.invoke(JSONUtil.toJSON(data));
			if (vo.getResult() == null || vo.getResult().isEmpty()) {
				throw "integração de Programação de Férias";
			} else {
				log.info("### integração de Programação de Férias - servicetask26 - response - "+ vo.getResult());
				var response = JSON.parse(vo.getResult());
				if (response.STATUS == undefined || response.STATUS == null) {
					throw "Erro de comunicação com o Protheus";
				} else {
					if (response.STATUS == false) {
						throw response.MESSAGE;
					} else {

					}
				}
			}
		}
	}
	log.info("### Finalização da integração de Programação de Férias TOTVS Protheus - servicetask26 - FIM ###");

}