function validateForm(form) {
    var activity = getValue('WKNumState');
    var state = getValue("WKNumState");

    if (form.getValue("centroCusto") == null || form.getValue("centroCusto") == "") {
        throw "Informe o centro de custo.";
    }

    if (form.getValue("periodo") == null || form.getValue("periodo") == "") {
        throw "Informe o Período de Atuação: DIURNO OU NOTURNO";
    }

    if (form.getValue("conforme1") == null || form.getValue("conforme1") == "") {
        throw "Informe se o Material ABAIXADOR LINGUA PALITO está conforme ou não";
    }



    if (form.getValue("qtdItem1") == null || form.getValue("qtdItem1") == "") {
        throw "Informe a quantidade existente do Material ABAIXADOR LINGUA PALITO";
    }


    if (form.getValue("conforme2") == null || form.getValue("conforme2") == "") {
        throw "Informe se o Material AGUA DESTILADA 250 ML está conforme ou não";
    }

    if (form.getValue("qtdItem2") == null || form.getValue("qtdItem2") == "") {
        throw "Informe a quantidade existente do Material  AGUA DESTILADA 250 ML";
    }


    if (form.getValue("conforme3") == null || form.getValue("conforme3") == "") {
        throw "Informe se o Material ALCOOL 70 está conforme ou não";
    }

    if (form.getValue("qtdItem3") == null || form.getValue("qtdItem3") == "") {
        throw "Informe a quantidade existente do Material ALCOOL 70";
    }

    if (form.getValue("conforme4") == null || form.getValue("conforme4") == "") {
        throw "Informe se o Material APARELHO TRICOTOMIA está conforme ou não";
    }

    if (form.getValue("qtdItem4") == null || form.getValue("qtdItem4") == "") {
        throw "Informe a quantidade existente do Material APARELHO TRICOTOMIA";
    }


    if (form.getValue("conforme5") == null || form.getValue("conforme5") == "") {
        throw "Informe se o Material GARROTE está conforme ou não";
    }

    if (form.getValue("qtdItem5") == null || form.getValue("qtdItem5") == "") {
        throw "Informe a quantidade existente do Material GARROTE";
    }


    /* INÍCIO */
    if (form.getValue("conforme6") == null || form.getValue("conforme5") == "") {
        throw "Informe se o Material CATETER OXIGENIO está conforme ou não";
    }

    if (form.getValue("qtdItem6") == null || form.getValue("qtdItem6") == "") {
        throw "Informe a quantidade existente do Material CATETER OXIGENIO";
    }



    /*FIM */

    /* INÍCIO */
    if (form.getValue("conforme7") == null || form.getValue("conforme7") == "") {
        throw "Informe se o Material ELETRODOS está conforme ou não";
    }

    if (form.getValue("qtdItem7") == null || form.getValue("qtdItem7") == "") {
        throw "Informe a quantidade existente do Material ELETRODOS";
    }



    /*FIM */
    /* INÍCIO */
    if (form.getValue("conforme8") == null || form.getValue("conforme8") == "") {
        throw "Informe se o Material ESPARADRAPO está conforme ou não";
    }

    if (form.getValue("qtdItem8") == null || form.getValue("qtdItem8") == "") {
        throw "Informe a quantidade existente do Material ESPARADRAPO";
    }



    /*FIM */
    /* INÍCIO */
    if (form.getValue("conforme9") == null || form.getValue("conforme9") == "") {
        throw "Informe se o Material FERULA está conforme ou não";
    }

    if (form.getValue("qtdItem9") == null || form.getValue("qtdItem9") == "") {
        throw "Informe a quantidade existente do Material FERULA";
    }



    /*FIM */
    /* INÍCIO */
    if (form.getValue("conforme10") == null || form.getValue("conforme10") == "") {
        throw "Informe se o Material GLICOSE 5% 250 ML está conforme ou não";
    }

    if (form.getValue("qtdItem10") == null || form.getValue("qtdItem10") == "") {
        throw "Informe a quantidade existente do Material GLICOSE 5% 250 ML";
    }


    /*FIM */
    /* INÍCIO */
    if (form.getValue("conforme11") == null || form.getValue("conforme11") == "") {
        throw "Informe se o Material GLICOSE 5% 500 ML está conforme ou não";
    }

    if (form.getValue("qtdItem11") == null || form.getValue("qtdItem11") == "") {
        throw "Informe a quantidade existente do Material GLICOSE 5% 500 ML";
    }



    /*FIM */
    /* INÍCIO */
    if (form.getValue("conforme12") == null || form.getValue("conforme12") == "") {
        throw "Informe se o Material S.F 0,9 % 100 ML está conforme ou não";
    }

    if (form.getValue("qtdItem12") == null || form.getValue("qtdItem12") == "") {
        throw "Informe a quantidade existente do Material S.F 0,9 % 100 ML";
    }


    /*FIM */
    /* INÍCIO */
    if (form.getValue("conforme13") == null || form.getValue("conforme13") == "") {
        throw "Informe se o Material S.F 0,9 % 250 ML está conforme ou não";
    }

    if (form.getValue("qtdItem13") == null || form.getValue("qtdItem13") == "") {
        throw "Informe a quantidade existente do Material S.F 0,9 % 250 ML";
    }



    /*FIM */
    /* INÍCIO */
    if (form.getValue("conforme14") == null || form.getValue("conforme14") == "") {
        throw "Informe se o Material S.F 0,9 % 500 ML está conforme ou não";
    }

    if (form.getValue("qtdItem14") == null || form.getValue("qtdItem14") == "") {
        throw "Informe a quantidade existente do Material S.F 0,9 % 500 ML";
    }


    /*FIM */
    /* INÍCIO */
    if (form.getValue("conforme15") == null || form.getValue("conforme15") == "") {
        throw "Informe se o Material RINGER LACTATO 500 ML está conforme ou não";
    }

    if (form.getValue("qtdItem15") == null || form.getValue("qtdItem15") == "") {
        throw "Informe a quantidade existente do Material RINGER LACTATO 500 ML";
    }


    /*FIM */
    /* INÍCIO */
    if (form.getValue("conforme16") == null || form.getValue("conforme16") == "") {
        throw "Informe se o Material S. GLICOFISIOLÓGICO 500 ML está conforme ou não";
    }

    if (form.getValue("qtdItem16") == null || form.getValue("qtdItem16") == "") {
        throw "Informe a quantidade existente do Material S. GLICOFISIOLÓGICO 500 ML";
    }



    /*FIM */
    /* INÍCIO */
    if (form.getValue("conforme17") == null || form.getValue("conforme17") == "") {
        throw "Informe se o Material MANTA TERMICA está conforme ou não";
    }

    if (form.getValue("qtdItem17") == null || form.getValue("qtdItem17") == "") {
        throw "Informe a quantidade existente do Material MANTA TERMICA";
    }


    /*FIM */
    /* INÍCIO */
    if (form.getValue("conforme18") == null || form.getValue("conforme18") == "") {
        throw "Informe se o Material MASCARA PACOTE está conforme ou não";
    }

    if (form.getValue("qtdItem18") == null || form.getValue("qtdItem18") == "") {
        throw "Informe a quantidade existente do Material MASCARA PACOTE";
    }



    /*FIM */
    /* INÍCIO */
    if (form.getValue("conforme19") == null || form.getValue("conforme19") == "") {
        throw "Informe se o Material MICROPORE está conforme ou não";
    }

    if (form.getValue("qtdItem19") == null || form.getValue("qtdItem19") == "") {
        throw "Informe a quantidade existente do Material MICROPORE";
    }



    /*FIM */
    /* INÍCIO */
    if (form.getValue("conforme20") == null || form.getValue("conforme20") == "") {
        throw "Informe se o Material OCULOS DE PROTECAO está conforme ou não";
    }

    if (form.getValue("qtdItem20") == null || form.getValue("qtdItem20") == "") {
        throw "Informe a quantidade existente do Material OCULOS DE PROTECAO";
    }


    /*FIM */
    /* INÍCIO */
    if (form.getValue("conforme21") == null || form.getValue("conforme21") == "") {
        throw "Informe se o Material ROLO - LENCOL HOSPITALAR está conforme ou não";
    }

    if (form.getValue("qtdItem21") == null || form.getValue("qtdItem21") == "") {
        throw "Informe a quantidade existente do Material ROLO - LENCOL HOSPITALAR";
    }



    /*FIM */
    /* INÍCIO */
    if (form.getValue("conforme22") == null || form.getValue("conforme22") == "") {
        throw "Informe se o Material AMBU ADULTO está conforme ou não";
    }

    if (form.getValue("qtdItem22") == null || form.getValue("qtdItem22") == "") {
        throw "Informe a quantidade existente do Material AMBU ADULTO";
    }


    /*FIM */

    /* INÍCIO */
    if (form.getValue("conforme23") == null || form.getValue("conforme23") == "") {
        throw "Informe se o Material AMBU NEO está conforme ou não";
    }

    if (form.getValue("qtdItem23") == null || form.getValue("qtdItem23") == "") {
        throw "Informe a quantidade existente do Material AMBU NEO";
    }



    /*FIM */


    /* INÍCIO */
    if (form.getValue("conforme24") == null || form.getValue("conforme24") == "") {
        throw "Informe se o Material AMBU INFANTIL está conforme ou não";
    }

    if (form.getValue("qtdItem24") == null || form.getValue("qtdItem24") == "") {
        throw "Informe a quantidade existente do Material AMBU INFANTIL";
    }


    /*FIM */

    /* INÍCIO */
    if (form.getValue("conforme25") == null || form.getValue("conforme25") == "") {
        throw "Informe se o Material CAIXA LUVA RESERVA está conforme ou não";
    }

    if (form.getValue("qtdItem25") == null || form.getValue("qtdItem25") == "") {
        throw "Informe a quantidade existente do Material CAIXA LUVA RESERVA";
    }


    /*FIM */

    /* INÍCIO */
    if (form.getValue("conforme26") == null || form.getValue("conforme26") == "") {
        throw "Informe se o Material CAPACETE DE SEGURANÇA está conforme ou não";
    }

    if (form.getValue("qtdItem26") == null || form.getValue("qtdItem26") == "") {
        throw "Informe a quantidade existente do Material CAPACETE DE SEGURANÇA";
    }


    /*FIM */

    /* INÍCIO */
    if (form.getValue("conforme27") == null || form.getValue("conforme27") == "") {
        throw "Informe se o Material GEL PARA ECG está conforme ou não";
    }

    if (form.getValue("qtdItem27") == null || form.getValue("qtdItem27") == "") {
        throw "Informe a quantidade existente do Material GEL PARA ECG";
    }


    /*FIM */

    /* INÍCIO */
    if (form.getValue("conforme28") == null || form.getValue("conforme28") == "") {
        throw "Informe se o Material PROTETOR AURICULAR está conforme ou não";
    }

    if (form.getValue("qtdItem28") == null || form.getValue("qtdItem28") == "") {
        throw "Informe a quantidade existente do Material PROTETOR AURICULAR";
    }



    /*FIM */

    /* INÍCIO */
    if (form.getValue("conforme29") == null || form.getValue("conforme29") == "") {
        throw "Informe se o Material SACO CADAVERICO está conforme ou não";
    }

    if (form.getValue("qtdItem29") == null || form.getValue("qtdItem29") == "") {
        throw "Informe a quantidade existente do Material SACO CADAVERICO";
    }


    /*FIM */

    /* INÍCIO */
    if (form.getValue("conforme30") == null || form.getValue("conforme30") == "") {
        throw "Informe se o Material BANDAGEM TRIANGULAR está conforme ou não";
    }

    if (form.getValue("qtdItem30") == null || form.getValue("qtdItem30") == "") {
        throw "Informe a quantidade existente do Material BANDAGEM TRIANGULAR";
    }



    /*FIM */

    /* INÍCIO */
    if (form.getValue("conforme31") == null || form.getValue("conforme31") == "") {
        throw "Informe se o Material FERULA está conforme ou não";
    }

    if (form.getValue("qtdItem31") == null || form.getValue("qtdItem31") == "") {
        throw "Informe a quantidade existente do Material FERULA";
    }



    /*FIM */

    /* INÍCIO */
    if (form.getValue("conforme32") == null || form.getValue("conforme32") == "") {
        throw "Informe se o Material GAZE ESTERIL está conforme ou não";
    }

    if (form.getValue("qtdItem32") == null || form.getValue("qtdItem32") == "") {
        throw "Informe a quantidade existente do Material GAZE ESTERIL";
    }


    /*FIM */

    /* INÍCIO */
    if (form.getValue("conforme33") == null || form.getValue("conforme33") == "") {
        throw "Informe se o Material CINTO ARANHA está conforme ou não";
    }

    if (form.getValue("qtdItem33") == null || form.getValue("qtdItem33") == "") {
        throw "Informe a quantidade existente do Material CINTO ARANHA";
    }



    /*FIM */

    /* INÍCIO */
    if (form.getValue("conforme34") == null || form.getValue("conforme34") == "") {
        throw "Informe se o Material COMPRESSA N ESTERIL (Pct) está conforme ou não";
    }

    if (form.getValue("qtdItem34") == null || form.getValue("qtdItem34") == "") {
        throw "Informe a quantidade existente do Material COMPRESSA N ESTERIL (Pct)";
    }



    /*FIM */

    /* INÍCIO */
    if (form.getValue("conforme35") == null || form.getValue("conforme35") == "") {
        throw "Informe se o Material BASE HEAD BLOCK está conforme ou não";
    }

    if (form.getValue("qtdItem35") == null || form.getValue("qtdItem35") == "") {
        throw "Informe a quantidade existente do Material BASE HEAD BLOCK";
    }

    /*FIM */

    /* INÍCIO */
    if (form.getValue("conforme36") == null || form.getValue("conforme36") == "") {
        throw "Informe se o Material HEAD BLOCK (PAR) está conforme ou não";
    }

    if (form.getValue("qtdItem36") == null || form.getValue("qtdItem36") == "") {
        throw "Informe a quantidade existente do Material HEAD BLOCK (PAR)";
    }


    /*FIM */

    /* INÍCIO */
    if (form.getValue("conforme37") == null || form.getValue("conforme37") == "") {
        throw "Informe se o Material KED está conforme ou não";
    }

    if (form.getValue("qtdItem37") == null || form.getValue("qtdItem37") == "") {
        throw "Informe a quantidade existente do Material KED";
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
        throw "Informe se o Material TALA FLEXIVEL está conforme ou não";
    }

    if (form.getValue("qtdItem39") == null || form.getValue("qtdItem39") == "") {
        throw "Informe a quantidade existente do Material TALA FLEXIVEL";
    }



    /*FIM */

    /* INÍCIO */
    if (form.getValue("conforme40") == null || form.getValue("conforme40") == "") {
        throw "Informe se o Material TALA RIGIDA está conforme ou não";
    }

    if (form.getValue("qtdItem40") == null || form.getValue("qtdItem40") == "") {
        throw "Informe a quantidade existente do Material TALA RIGIDA";
    }


    /*FIM */

    /* INÍCIO */
    if (form.getValue("conforme41") == null || form.getValue("conforme41") == "") {
        throw "Informe se o Material TIRANTE RESERVA está conforme ou não";
    }

    if (form.getValue("qtdItem41") == null || form.getValue("qtdItem41") == "") {
        throw "Informe a quantidade existente do Material TIRANTE RESERVA";
    }



    /*FIM */

    /* INÍCIO */
    if (form.getValue("conforme42") == null || form.getValue("conforme42") == "") {
        throw "Informe se o Material COLAR ESPUMA está conforme ou não";
    }

    if (form.getValue("qtdItem42") == null || form.getValue("qtdItem42") == "") {
        throw "Informe a quantidade existente do Material COLAR ESPUMA";
    }



    /*FIM */

    /* INÍCIO */
    if (form.getValue("conforme43") == null || form.getValue("conforme43") == "") {
        throw "Informe se o Material COLAR (PP,P,M,G,NEO) está conforme ou não";
    }

    if (form.getValue("qtdItem43") == null || form.getValue("qtdItem43") == "") {
        throw "Informe a quantidade existente do Material COLAR (PP,P,M,G,NEO)";
    }



    /*FIM */

    /* INÍCIO */
    if (form.getValue("conforme44") == null || form.getValue("conforme44") == "") {
        throw "Informe se o Aparelho ASPIRADOR C LATEX está conforme ou não";
    }

    if (form.getValue("qtdItem44") == null || form.getValue("qtdItem44") == "") {
        throw "Informe a quantidade existente do Aparelho ASPIRADOR C LATEX";
    }



    /*FIM */

    /* INÍCIO */
    if (form.getValue("conforme45") == null || form.getValue("conforme45") == "") {
        throw "Informe se o Aparelho DESFIBRILADOR está conforme ou não";
    }

    if (form.getValue("qtdItem45") == null || form.getValue("qtdItem45") == "") {
        throw "Informe a quantidade existente do Aparelho DESFIBRILADOR";
    }


    /*FIM */

    /* INÍCIO */
    if (form.getValue("conforme46") == null || form.getValue("conforme46") == "") {
        throw "Informe se o Aparelho MONITOR CARD está conforme ou não";
    }

    if (form.getValue("qtdItem46") == null || form.getValue("qtdItem46") == "") {
        throw "Informe a quantidade existente do Aparelho MONITOR CARD";
    }



    /*FIM */

    /* INÍCIO */
    if (form.getValue("conforme47") == null || form.getValue("conforme47") == "") {
        throw "Informe se o Aparelho RESPIRADOR está conforme ou não";
    }

    if (form.getValue("qtdItem47") == null || form.getValue("qtdItem47") == "") {
        throw "Informe a quantidade existente do Aparelho RESPIRADOR";
    }


    /*FIM */

    /* INÍCIO */
    if (form.getValue("conforme48") == null || form.getValue("conforme48") == "") {
        throw "Informe se o Aparelho DEA está conforme ou não";
    }

    if (form.getValue("qtdItem48") == null || form.getValue("qtdItem48") == "") {
        throw "Informe a quantidade existente do Aparelho DEA";
    }


    /*FIM */

    /* INÍCIO */
    if (form.getValue("conforme49") == null || form.getValue("conforme49") == "") {
        throw "Informe se o Aparelho CIRC. RESPIRATORIO ADULTO está conforme ou não";
    }

    if (form.getValue("qtdItem49") == null || form.getValue("qtdItem49") == "") {
        throw "Informe a quantidade existente do Aparelho CIRC. RESPIRATORIO ADULTO";
    }

    /*FIM */

    /* INÍCIO */
    if (form.getValue("conforme50") == null || form.getValue("conforme50") == "") {
        throw "Informe se o Aparelho CIRC. RESPIRATORIO INFANTIL está conforme ou não";
    }

    if (form.getValue("qtdItem50") == null || form.getValue("qtdItem50") == "") {
        throw "Informe a quantidade existente do Aparelho CIRC. RESPIRATORIO INFANTIL";
    }


    /*FIM */

    /* INÍCIO */
    if (form.getValue("conforme51") == null || form.getValue("conforme51") == "") {
        throw "Informe se o KIT CANULA GUEDEL está conforme ou não";
    }

    if (form.getValue("qtdItem51") == null || form.getValue("qtdItem51") == "") {
        throw "Informe a quantidade existente do KIT CANULA GUEDEL";
    }


    /*FIM */

    /* INÍCIO */
    if (form.getValue("conforme52") == null || form.getValue("conforme52") == "") {
        throw "Informe se o KIT LUVA ESTERIL está conforme ou não";
    }

    if (form.getValue("qtdItem52") == null || form.getValue("qtdItem52") == "") {
        throw "Informe a quantidade existente do KIT LUVA ESTERIL";
    }

    /*FIM */

    /* INÍCIO */
    if (form.getValue("conforme53") == null || form.getValue("conforme53") == "") {
        throw "Informe se o KIT EQUIPO está conforme ou não";
    }

    if (form.getValue("qtdItem53") == null || form.getValue("qtdItem53") == "") {
        throw "Informe a quantidade existente do KIT EQUIPO";
    }



    /*FIM */


    /* INÍCIO */
    if (form.getValue("conforme54") == null || form.getValue("conforme54") == "") {
        throw "Informe se o KIT ABOCATH está conforme ou não";
    }

    if (form.getValue("qtdItem54") == null || form.getValue("qtdItem54") == "") {
        throw "Informe a quantidade existente do KIT ABOCATH";
    }



    /*FIM */


    /* INÍCIO */
    if (form.getValue("conforme55") == null || form.getValue("conforme55") == "") {
        throw "Informe se o KIT AGULHA está conforme ou não";
    }

    if (form.getValue("qtdItem55") == null || form.getValue("qtdItem55") == "") {
        throw "Informe a quantidade existente do KIT AGULHA";
    }



    /*FIM */

    /* INÍCIO */
    if (form.getValue("conforme56") == null || form.getValue("conforme56") == "") {
        throw "Informe se o KIT MASCARA LARINGEA está conforme ou não";
    }

    if (form.getValue("qtdItem56") == null || form.getValue("qtdItem56") == "") {
        throw "Informe a quantidade existente do KIT MASCARA LARINGEA";
    }



    /*FIM */

    /* INÍCIO */
    if (form.getValue("conforme57") == null || form.getValue("conforme57") == "") {
        throw "Informe se o KIT SCALP está conforme ou não";
    }

    if (form.getValue("qtdItem57") == null || form.getValue("qtdItem57") == "") {
        throw "Informe a quantidade existente do KIT SCALP";
    }


    /*FIM */

    /* INÍCIO */
    if (form.getValue("conforme58") == null || form.getValue("conforme58") == "") {
        throw "Informe se o KIT SERINGA está conforme ou não";
    }

    if (form.getValue("qtdItem58") == null || form.getValue("qtdItem58") == "") {
        throw "Informe a quantidade existente do KIT SERINGA";
    }



    /*FIM */

    /* INÍCIO */
    if (form.getValue("conforme59") == null || form.getValue("conforme59") == "") {
        throw "Informe se o KIT SONDA ASPIRACAO está conforme ou não";
    }

    if (form.getValue("qtdItem59") == null || form.getValue("qtdItem59") == "") {
        throw "Informe a quantidade existente do KIT SONDA ASPIRACAO";
    }


    /*FIM */

    /* INÍCIO */
    if (form.getValue("conforme60") == null || form.getValue("conforme60") == "") {
        throw "Informe se o KIT SONDA NASOGASTRICA está conforme ou não";
    }

    if (form.getValue("qtdItem60") == null || form.getValue("qtdItem60") == "") {
        throw "Informe a quantidade existente do KIT SONDA NASOGASTRICA";
    }


    /*FIM */

    /* INÍCIO */
    if (form.getValue("conforme61") == null || form.getValue("conforme61") == "") {
        throw "Informe se o KIT SONDA URETRAL está conforme ou não";
    }

    if (form.getValue("qtdItem61") == null || form.getValue("qtdItem61") == "") {
        throw "Informe a quantidade existente do KIT SONDA URETRAL";
    }


    /*FIM */

    /* INÍCIO */
    if (form.getValue("conforme62") == null || form.getValue("conforme62") == "") {
        throw "Informe se o KIT ASPIRACAO está conforme ou não";
    }

    if (form.getValue("qtdItem62") == null || form.getValue("qtdItem62") == "") {
        throw "Informe a quantidade existente do KIT ASPIRACAO";
    }



    /*FIM */

    /* INÍCIO */
    if (form.getValue("conforme63") == null || form.getValue("conforme63") == "") {
        throw "Informe se o KIT CURATIVO está conforme ou não";
    }

    if (form.getValue("qtdItem63") == null || form.getValue("qtdItem63") == "") {
        throw "Informe a quantidade existente do KIT CURATIVO";
    }



    /*FIM */

    /* INÍCIO */
    if (form.getValue("conforme64") == null || form.getValue("conforme64") == "") {
        throw "Informe se o KIT INALACAO está conforme ou não";
    }

    if (form.getValue("qtdItem64") == null || form.getValue("qtdItem64") == "") {
        throw "Informe a quantidade existente do KIT INALACAO";
    }


    /*FIM */

    /* INÍCIO */
    if (form.getValue("conforme65") == null || form.getValue("conforme65") == "") {
        throw "Informe se o KIT PUNCAO VENOSA está conforme ou não";
    }

    if (form.getValue("qtdItem65") == null || form.getValue("qtdItem65") == "") {
        throw "Informe a quantidade existente do KIT PUNCAO VENOSA";
    }


    /*FIM */

    /* INÍCIO */
    if (form.getValue("conforme66") == null || form.getValue("conforme66") == "") {
        throw "Informe se o KIT SNG está conforme ou não";
    }

    if (form.getValue("qtdItem66") == null || form.getValue("qtdItem66") == "") {
        throw "Informe a quantidade existente do KIT SNG";
    }


    /*FIM */

    /* INÍCIO */
    if (form.getValue("conforme67") == null || form.getValue("conforme67") == "") {
        throw "Informe se o KIT UMIDIFICACAO está conforme ou não";
    }

    if (form.getValue("qtdItem67") == null || form.getValue("qtdItem67") == "") {
        throw "Informe a quantidade existente do KIT UMIDIFICACAO";
    }



    /*FIM */

    /* INÍCIO */
    if (form.getValue("conforme68") == null || form.getValue("conforme68") == "") {
        throw "Informe se o KIT PARTO está conforme ou não";
    }

    if (form.getValue("qtdItem68") == null || form.getValue("qtdItem68") == "") {
        throw "Informe a quantidade existente do KIT PARTO";
    }


    /*FIM */

    /* INÍCIO */
    if (form.getValue("conforme69") == null || form.getValue("conforme69") == "") {
        throw "Informe se o KIT ISOLAMENTO está conforme ou não";
    }

    if (form.getValue("qtdItem69") == null || form.getValue("qtdItem69") == "") {
        throw "Informe a quantidade existente do KIT ISOLAMENTO";
    }


    /*FIM */

    /* INÍCIO */
    if (form.getValue("conforme70") == null || form.getValue("conforme70") == "") {
        throw "Informe se o KIT MASCARA VENTURI está conforme ou não";
    }

    if (form.getValue("qtdItem70") == null || form.getValue("qtdItem70") == "") {
        throw "Informe a quantidade existente do KIT MASCARA VENTURI";
    }


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
        || form.getValue("conforme18") == "NAO"
        || form.getValue("conforme19") == "NAO"
        || form.getValue("conforme20") == "NAO"
        || form.getValue("conforme21") == "NAO"
        || form.getValue("conforme22") == "NAO"
        || form.getValue("conforme23") == "NAO"
        || form.getValue("conforme24") == "NAO"
        || form.getValue("conforme25") == "NAO"
        || form.getValue("conforme26") == "NAO"
        || form.getValue("conforme27") == "NAO"
        || form.getValue("conforme28") == "NAO"
        || form.getValue("conforme29") == "NAO"
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
        || form.getValue("conforme42") == "NAO"
        || form.getValue("conforme43") == "NAO"
        || form.getValue("conforme44") == "NAO"
        || form.getValue("conforme45") == "NAO"
        || form.getValue("conforme46") == "NAO"
        || form.getValue("conforme47") == "NAO"
        || form.getValue("conforme48") == "NAO"
        || form.getValue("conforme49") == "NAO"
        || form.getValue("conforme50") == "NAO"
        || form.getValue("conforme51") == "NAO"
        || form.getValue("conforme52") == "NAO"
        || form.getValue("conforme53") == "NAO"
        || form.getValue("conforme54") == "NAO"
        || form.getValue("conforme55") == "NAO"
        || form.getValue("conforme56") == "NAO"
        || form.getValue("conforme57") == "NAO"
        || form.getValue("conforme58") == "NAO"
        || form.getValue("conforme59") == "NAO"
        || form.getValue("conforme60") == "NAO"
        || form.getValue("conforme61") == "NAO"
        || form.getValue("conforme62") == "NAO"
        || form.getValue("conforme63") == "NAO"
        || form.getValue("conforme64") == "NAO"
        || form.getValue("conforme65") == "NAO"
        || form.getValue("conforme66") == "NAO"
        || form.getValue("conforme67") == "NAO"
        || form.getValue("conforme68") == "NAO"
        || form.getValue("conforme69") == "NAO"
        || form.getValue("conforme70") == "NAO") {
        if (form.getValue("planoAcao") == null || form.getValue("planoAcao") == "") {
            throw "Informe um Plano de Ação para o(s) item(ns) não conforme(s)";
        }
    }
}