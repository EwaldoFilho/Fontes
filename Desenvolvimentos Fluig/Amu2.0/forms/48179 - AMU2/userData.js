$.ajax({
        url : '/api/public/2.0/users/listAll',
        type : "GET",
    }).done(function(data) {
        for (i = 0; i < data.content.length; i++) {
            $.ajax({
                url : '/api/public/2.0/users/getUser/' + data.content[i].code,
                type : "GET",
            }).done(function(data) {
                debugger;
                if (data.content.isActive) {
                    var filial, codigoCentroCusto, armazem,tomador;

                    if (data.content.extData.filial) {
                        filial = data.content.extData.filial;
                    } else {
                        filial = "";
                    }
                    
                    if (data.content.extData.codigoCentroCusto) {
                    	codigoCentroCusto = data.content.extData.codigoCentroCusto;
                    } else {
                    	codigoCentroCusto = "";
                    }
                    
                    if (data.content.extData.armazem) {
                    	armazem = data.content.extData.armazem;
                    } else {
                    	armazem = "";
                    }
                    
                    if (data.content.extData.tomador) {
                    	tomador = data.content.extData.tomador;
                    } else {
                    	tomador = "";
                    }

                    t.row.add([ data.content.fullName, filial, codigoCentroCusto, armazem, tomador ]).draw(false); 
                // TESTE ADICIONAR O RESULTADO EM UM DATATABLE 
                // TESTAR POSTERIORMENTE fluigAPI.getUserService().listData(loginDoUsuario),    
                // PODE SER TESTADO PARA ADICIONAR EM DATASET
                }
            });

        }
    });