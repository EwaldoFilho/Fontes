function validateForm(form){
	var activity = getValue('WKNumState');
	var state    = getValue("WKNumState");
	
	if (form.getValue("centroCusto") == null || form.getValue("centroCusto") == "") {
		throw "Informe o centro de custo.";
	}
	
	if (form.getValue("periodo") == null || form.getValue("periodo") == "") {
		throw "Informe o Período de Atuação: DIURNO OU NOTURNO";
	}
	
	if (form.getValue("conforme1") == null || form.getValue("conforme1") == "") {
		throw "Informe se o Material AGUA está conforme ou não";
	}
	

	
	if (form.getValue("qtdItem1") == null || form.getValue("qtdItem1") == "") {
	throw "Informe a quantidade existente do Material AGUA";
	}

	
	if (form.getValue("conforme2") == null || form.getValue("conforme2") == "") {
		throw "Informe se o Material AR CONDICIONADO está conforme ou não";
	}
	
	if (form.getValue("qtdItem2") == null || form.getValue("qtdItem2") == "") {
		throw "Informe a quantidade existente do Material  AR CONDICIONADO";	
	}
	
	
	if (form.getValue("conforme3") == null || form.getValue("conforme3") == "") {
		throw "Informe se o Material CABINE está conforme ou não";
	}
	
	if (form.getValue("qtdItem3") == null || form.getValue("qtdItem3") == "") {
		throw "Informe a quantidade existente do Material CABINE";
	}
	
	if (form.getValue("conforme4") == null || form.getValue("conforme4") == "") {
		throw "Informe se o Material CHAVES está conforme ou não";
	}
	
	if (form.getValue("qtdItem4") == null || form.getValue("qtdItem4") == "") {
		throw "Informe a quantidade existente do Material CHAVES";
	}
	
	
	if (form.getValue("conforme5") == null || form.getValue("conforme5") == "") {
		throw "Informe se o Material CONES está conforme ou não";
	}
	
	if (form.getValue("qtdItem5") == null || form.getValue("qtdItem5") == "") {
		throw "Informe a quantidade existente do Material CONES";
	}
	
	
	/* INÍCIO */
	if (form.getValue("conforme6") == null || form.getValue("conforme5") == "") {
		throw "Informe se o Material CORDAS está conforme ou não";
	}
	
	if (form.getValue("qtdItem6") == null || form.getValue("qtdItem6") == "") {
		throw "Informe a quantidade existente do Material CORDAS";
	}
	

	
	/*FIM */
	
	/* INÍCIO */
	if (form.getValue("conforme7") == null || form.getValue("conforme7") == "") {
		throw "Informe se o Material ESTEPE está conforme ou não";
	}
	
	if (form.getValue("qtdItem7") == null || form.getValue("qtdItem7") == "") {
		throw "Informe a quantidade existente do Material ESTEPE";
	}
	

	
	/*FIM */
	/* INÍCIO */
	if (form.getValue("conforme8") == null || form.getValue("conforme8") == "") {
		throw "Informe se o Material EXTENSAO está conforme ou não";
	}
	
	if (form.getValue("qtdItem8") == null || form.getValue("qtdItem8") == "") {
		throw "Informe a quantidade existente do Material EXTENSAO";
	}
	
	
	
	/*FIM */
	/* INÍCIO */
	if (form.getValue("conforme9") == null || form.getValue("conforme9") == "") {
		throw "Informe se o Material EXTINTOR DA VTR está conforme ou não";
	}
	
	if (form.getValue("qtdItem9") == null || form.getValue("qtdItem9") == "") {
		throw "Informe a quantidade existente do Material EXTINTOR DA VTR";
	}
	
	
	
	/*FIM */
	/* INÍCIO */
	if (form.getValue("conforme10") == null || form.getValue("conforme10") == "") {
		throw "Informe se o Material EXTINTOR DE CO2 está conforme ou não";
	}
	
	if (form.getValue("qtdItem10") == null || form.getValue("qtdItem10") == "") {
		throw "Informe a quantidade existente do Material EXTINTOR DE CO2";
	}
	

	/*FIM */
	/* INÍCIO */
	if (form.getValue("conforme11") == null || form.getValue("conforme11") == "") {
		throw "Informe se o Material EXTINTOR DE PO QUIMICO está conforme ou não";
	}
	
	if (form.getValue("qtdItem11") == null || form.getValue("qtdItem11") == "") {
		throw "Informe a quantidade existente do Material EXTINTOR DE PO QUIMICO";
	}
	
	
	
	/*FIM */
	/* INÍCIO */
	if (form.getValue("conforme12") == null || form.getValue("conforme12") == "") {
		throw "Informe se o Material FAROIS está conforme ou não";
	}
	
	if (form.getValue("qtdItem12") == null || form.getValue("qtdItem12") == "") {
		throw "Informe a quantidade existente do Material FAROIS";
	}
	

	/*FIM */
	/* INÍCIO */
	if (form.getValue("conforme13") == null || form.getValue("conforme13") == "") {
		throw "Informe se o Material GIROFLEX está conforme ou não";
	}
	
	if (form.getValue("qtdItem13") == null || form.getValue("qtdItem13") == "") {
		throw "Informe a quantidade existente do Material GIROFLEX";
	}
	

	
	/*FIM */
	/* INÍCIO */
	if (form.getValue("conforme14") == null || form.getValue("conforme14") == "") {
		throw "Informe se o Material LANTERNAS está conforme ou não";
	}
	
	if (form.getValue("qtdItem14") == null || form.getValue("qtdItem14") == "") {
		throw "Informe a quantidade existente do Material LANTERNAS";
	}
	
	
	/*FIM */
	/* INÍCIO */
	if (form.getValue("conforme15") == null || form.getValue("conforme15") == "") {
		throw "Informe se o Material LATARIA EXTERNA está conforme ou não";
	}
	
	if (form.getValue("qtdItem15") == null || form.getValue("qtdItem15") == "") {
		throw "Informe a quantidade existente do Material LATARIA EXTERNA";
	}

	
	/*FIM */
	/* INÍCIO */
	if (form.getValue("conforme16") == null || form.getValue("conforme16") == "") {
		throw "Informe se o Material MACACO está conforme ou não";
	}
	
	if (form.getValue("qtdItem16") == null || form.getValue("qtdItem16") == "") {
		throw "Informe a quantidade existente do Material MACACO";
	}
	

	
	/*FIM */
	/* INÍCIO */
	if (form.getValue("conforme17") == null || form.getValue("conforme17") == "") {
		throw "Informe se o Material MAPA DE GRADE está conforme ou não";
	}
	
	if (form.getValue("qtdItem17") == null || form.getValue("qtdItem17") == "") {
		throw "Informe a quantidade existente do Material MAPA DE GRADE";
	}

	
	/*FIM */
	
	/* INÍCIO */
	if (form.getValue("conforme30") == null || form.getValue("conforme30") == "") {
		throw "Informe se o Material OLEO está conforme ou não";
	}
	
	if (form.getValue("qtdItem30") == null || form.getValue("qtdItem30") == "") {
		throw "Informe a quantidade existente do Material OLEO";
	}
	

	
	/*FIM */

	/* INÍCIO */
	if (form.getValue("conforme31") == null || form.getValue("conforme31") == "") {
		throw "Informe se o Material PAINEL DE INSTRUMENTOS está conforme ou não";
	}
	
	if (form.getValue("qtdItem31") == null || form.getValue("qtdItem31") == "") {
		throw "Informe a quantidade existente do Material PAINEL DE INSTRUMENTOS";
	}
	

	
	/*FIM */
	
	/* INÍCIO */
	if (form.getValue("conforme32") == null || form.getValue("conforme32") == "") {
		throw "Informe se o Material PE DE CABRA está conforme ou não";
	}
	
	if (form.getValue("qtdItem32") == null || form.getValue("qtdItem32") == "") {
		throw "Informe a quantidade existente do Material PE DE CABRA";
	}
	
	
	/*FIM */

	/* INÍCIO */
	if (form.getValue("conforme33") == null || form.getValue("conforme33") == "") {
		throw "Informe se o Material PNEUS está conforme ou não";
	}
	
	if (form.getValue("qtdItem33") == null || form.getValue("qtdItem33") == "") {
		throw "Informe a quantidade existente do Material PNEUS";
	}
	

	
	/*FIM */

	/* INÍCIO */
	if (form.getValue("conforme34") == null || form.getValue("conforme34") == "") {
		throw "Informe se o Material PRANCHETA está conforme ou não";
	}
	
	if (form.getValue("qtdItem34") == null || form.getValue("qtdItem34") == "") {
		throw "Informe a quantidade existente do Material PRANCHETA";
	}
	

	
	/*FIM */

	/* INÍCIO */
	if (form.getValue("conforme35") == null || form.getValue("conforme35") == "") {
		throw "Informe se o Material RADIO FIXO 01 UNID está conforme ou não";
	}
	
	if (form.getValue("qtdItem35") == null || form.getValue("qtdItem35") == "") {
		throw "Informe a quantidade existente do Material RADIO FIXO 01 UNID";
	}

	/*FIM */

	/* INÍCIO */
	if (form.getValue("conforme36") == null || form.getValue("conforme36") == "") {
		throw "Informe se o Material RÉ UNID está conforme ou não";
	}
	
	if (form.getValue("qtdItem36") == null || form.getValue("qtdItem36") == "") {
		throw "Informe a quantidade existente do Material RÉ";
	}
	

	/*FIM */

	/* INÍCIO */
	if (form.getValue("conforme37") == null || form.getValue("conforme37") == "") {
		throw "Informe se o Material SETAS está conforme ou não";
	}
	
	if (form.getValue("qtdItem37") == null || form.getValue("qtdItem37") == "") {
		throw "Informe a quantidade existente do Material SETAS";
	}
	

	/*FIM */

	/* INÍCIO */
	if (form.getValue("conforme38") == null || form.getValue("conforme38") == "") {
		throw "Informe se o Material PRANCHA está conforme ou não";
	}
	
	if (form.getValue("qtdItem38") == null || form.getValue("qtdItem38") == "") {
		throw "Informe a quantidade existente do Material PRANCHA";
	}
	

	
	/*FIM */

	/* INÍCIO */
	if (form.getValue("conforme39") == null || form.getValue("conforme39") == "") {
		throw "Informe se o Material SIRENE está conforme ou não";
	}
	
	if (form.getValue("qtdItem39") == null || form.getValue("qtdItem39") == "") {
		throw "Informe a quantidade existente do Material SIRENE";
	}
	

	
	/*FIM */

	/* INÍCIO */
	if (form.getValue("conforme40") == null || form.getValue("conforme40") == "") {
		throw "Informe se o Material TRIANGULO está conforme ou não";
	}
	
	if (form.getValue("qtdItem40") == null || form.getValue("qtdItem40") == "") {
		throw "Informe a quantidade existente do Material TRIANGULO";
	}
	

	/*FIM */

	/* INÍCIO */
	if (form.getValue("conforme41") == null || form.getValue("conforme41") == "") {
		throw "Informe se o Material VIDROS está conforme ou não";
	}
	
	if (form.getValue("qtdItem41") == null || form.getValue("qtdItem41") == "") {
		throw "Informe a quantidade existente do Material VIDROS";
	}
	

	
	/*FIM */

	/* INÍCIO */
	if (form.getValue("conforme42") == null || form.getValue("conforme42") == "") {
		throw "Informe se o Material CABO TRASF ENERGIA está conforme ou não";
	}
	
	if (form.getValue("qtdItem42") == null || form.getValue("qtdItem42") == "") {
		throw "Informe a quantidade existente do Material CABO TRASF ENERGIA";
	}
	

	
	/*FIM */

	
	
	/*FIM */
	/* INÍCIO */
	if (form.getValue("conforme1") == "NAO"
			|| form.getValue("conforme2") == "NAO"
			|| form.getValue("conforme3") == "NAO"
			|| form.getValue("conforme4") == "NAO"
			|| form.getValue("conforme5") == "NAO"
			|| form.getValue("conforme6") == "NAO"
			|| form.getValue("conforme7") == "NAO"
			|| form.getValue("conforme8") == "NAO"
			|| form.getValue("conforme9") == "NAO"
			|| form.getValue("conforme10") == "NAO"
			|| form.getValue("conforme11") == "NAO"
			|| form.getValue("conforme12") == "NAO"
			|| form.getValue("conforme13") == "NAO"
			|| form.getValue("conforme14") == "NAO"
			|| form.getValue("conforme15") == "NAO"
			|| form.getValue("conforme16") == "NAO"
			|| form.getValue("conforme17") == "NAO"			
			|| form.getValue("conforme30") == "NAO"
			|| form.getValue("conforme31") == "NAO"
			|| form.getValue("conforme32") == "NAO"
			|| form.getValue("conforme33") == "NAO"
			|| form.getValue("conforme34") == "NAO"
			|| form.getValue("conforme35") == "NAO"
			|| form.getValue("conforme36") == "NAO"
			|| form.getValue("conforme37") == "NAO"
			|| form.getValue("conforme38") == "NAO"
			|| form.getValue("conforme39") == "NAO"
			|| form.getValue("conforme40") == "NAO"
			|| form.getValue("conforme41") == "NAO"
			|| form.getValue("conforme42") == "NAO") 
	{
        if (form.getValue("planoAcao") == null || form.getValue("planoAcao") == "") {
            throw "Informe um Plano de Ação para o(s) item(ns) não conforme(s)";
        }
	}
		
	/*FIM*/
}