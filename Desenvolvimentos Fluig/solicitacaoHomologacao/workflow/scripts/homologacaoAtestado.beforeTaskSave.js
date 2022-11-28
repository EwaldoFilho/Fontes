function beforeTaskSave(colleagueId, nextSequenceId, userList) {


    function enviaemail() {

        var processo = getValue("WKNumProces").toString();
        var VerifEtapa = getValue('WKNumState');
        var Nome_Etapa = ""

        if (VerifEtapa == 0 || VerifEtapa == 4) {
            Nome_Etapa = "Inicio";
        }
        if (VerifEtapa == 8 || VerifEtapa == 10 || VerifEtapa == 12) {
            Nome_Etapa = "Diretoria Comercial";
        }
        if (VerifEtapa == 27) {
            Nome_Etapa = "Credito 1º Aprovador";
        }
        if (VerifEtapa == 29) {
            Nome_Etapa = "Credito 2º Aprovador";
        }
        if (VerifEtapa == 35) {
            Nome_Etapa = "Arquitetura";
        }
        if (VerifEtapa == 124 || VerifEtapa == 126 || VerifEtapa == 128) {
            Nome_Etapa = "Diretoria Comercial (Validação)";
        }
        if (VerifEtapa == 37) {
            Nome_Etapa = "Diretoria Financeira";
        }
        if (VerifEtapa == 43) {
            Nome_Etapa = "Arquitetura (Elaboração do Projeto)";
        }
        if (VerifEtapa == 45) {
            Nome_Etapa = "Financeiro";
        }
        if (VerifEtapa == 47) {
            Nome_Etapa = "Arquitetura (Acompanhamento e Conclusão)";
        }

        var tipo_sr = hAPI.getCardValue('tipo_sr');
        var etapa_do_processo = Nome_Etapa;
        var cidade = hAPI.getCardValue('cidade');
        var uf = hAPI.getCardValue('uf');
        var cnpj = hAPI.getCardValue('cnpj');
        var gerente = hAPI.getCardValue('gerente');
        var via_do_showroom = hAPI.getCardValue('via_do_showroom');

        try {

            // Monta mapa com parâmetros do Template
            // / Em seguida, crio uma lista java, chamada PARAMETROS.
            var parametros = new java.util.HasMap();

            // Nessa lista PARAMETROS, insiro as informações que eu preciso
            // passar para o template de email, utilizando o padrão (CHAVE,
            // VALOR)
            parametros.put("tipo_sr", tipo_sr);
            parametros.put("numero_solicitacao", processo);
            parametros.put("etapa_do_processo", etapa_do_processo);
            parametros.put("cidade", cidade);
            parametros.put("uf", uf);
            parametros.put("cnpj", cnpj);
            parametros.put("gerente", gerente);
            parametros.put("via_do_showroom", via_do_showroom);

            // Essa chave SUBJECT, em específico, é a responsável pelo assunto
            // do email.
            // Nesse exemplo, estou informando o pagamento de uma solicitação, e
            // concatenando algumas variáveis.
            parametros.put("subject", "Show Room (" + tipo_sr + ") nº ("
                    + numero_solicitacao + ") solicitado por (" + gerente
                    + ").");


            //Monta lista de destinatários
            var destinatarios = new java.util.ArrayList();
            destinatarios.add("laercio.junior;danilo.silva@embramaco.com.br;murilo.afonso;donato.oscar13@gmail.com");


            notifier.notify("oscar.donato", "TpAberAvancSR", parametros, destinatarios, "text/html");

        } catch (error) {

            log.info("##** Erro no envio de email");
            log.info(error);

        }


    }
}