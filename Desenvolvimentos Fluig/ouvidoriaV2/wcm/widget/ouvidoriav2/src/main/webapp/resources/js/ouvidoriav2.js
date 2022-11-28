var MyWidget = SuperWidget.extend({
    //variáveis da widget
    variavelNumerica: null,
    variavelCaracter: null,

    //método iniciado quando a widget é carregada
    init: function() {
    },
  
    //BIND de eventos
    bindings: {
        local: {
            'execute': ['click_executeAction']
        },
        global: {}
    },
 
    executeAction: function(htmlElement, event) {
    }

});
function enviar(){

    var constraints = []
    var constraint  = new Object();
    //var qtdeItensTabela = parseInt($("#qtdeTable").val())
if($("#tipoOuvidoria").val() == ""  ){
	
	 FLUIGC.toast({
		 title: 'Atenção: ',
	 	 message: 'Preencher o formulário para poder enviar',
	 	 type: 'warning'
	 });
	 return
}


    var url = decodeURI(window.location.href.toString());
    url = url.split("8007")[0];
    url = url + "8007/"

    constraint  = new Object();
    constraint._field  = "tipoOuvidoria"
    constraint._initialValue= $("#tipoOuvidoria").val()
    constraint._finalValue = $("#tipoOuvidoria").val()
    constraint._type= 0 
    constraint._likeSearch= false
    constraints.push(constraint)
    constraint  = new Object();
    constraint._field  = "dataemissao"
    constraint._initialValue= $("#dataemissao").val()
    constraint._finalValue = $("#dataemissao").val()
    constraint._type= 0 
    constraint._likeSearch= false
    constraints.push(constraint)
    constraint  = new Object();
    constraint._field  = "lugar"
    constraint._initialValue= $("#lugar").val()
    constraint._finalValue = $("#lugar").val()
    constraint._type= 0 
    constraint._likeSearch= false
    constraints.push(constraint)
    constraint  = new Object();
    constraint._field  = "hora"
    constraint._initialValue= $("#hora").val()
    constraint._finalValue = $("#hora").val()
    constraint._type= 0 
    constraint._likeSearch= false
    constraints.push(constraint)
    constraint  = new Object();
    constraint._field  = "tipoEnvolvido"
    constraint._initialValue= $("#tipoEnvolvido").val()
    constraint._finalValue = $("#tipoEnvolvido").val()
    constraint._type= 0 
    constraint._likeSearch= false
    constraints.push(constraint)
    constraint  = new Object();
    constraint._field  = "pessoalEnvolvido"
    constraint._initialValue= $("#pessoalEnvolvido").val()
    constraint._finalValue = $("#pessoalEnvolvido").val()
    constraint._type= 0 
    constraint._likeSearch= false
    constraints.push(constraint)
    constraint  = new Object();
    constraint._field  = "situacao"
    constraint._initialValue= $("#situacao").val()
    constraint._finalValue = $("#situacao").val()
    constraint._type= 0 
    constraint._likeSearch= false
    constraints.push(constraint)
    constraint  = new Object();
    constraint._field  = "relator"
    constraint._initialValue= $("#relator").val()
    constraint._finalValue = $("#relator").val()
    constraint._type= 0 
    constraint._likeSearch= false
    constraints.push(constraint)
    constraint  = new Object();
    constraint._field  = "email"
    constraint._initialValue= $("#email").val()
    constraint._finalValue = $("#email").val()
    constraint._type= 0 
    constraint._likeSearch= false
    constraints.push(constraint)
    
    
    
    
    var token = {
            key: 'c1a01253-2aaf-4f33-b71d-711d12923025',
            secret: '38721ebf-161a-4d11-965f-30c33de13ae6bd36aa6f-50ed-49a0-9d90-002b2122a80e'
        };

    var request_data = {
        url: url+'api/public/ecm/dataset/datasets', 
        method: 'POST',
        ajaxData: JSON.stringify(
            { name : "FLUIGOUVIDORIA2",
            fields : [], 
            constraints : constraints,
            order : []
            }),
        data: {}	
    };

    var oauth = OAuth({
        consumer: {
            key: 'medmaisouvidoria',
            secret: 'medmaisouvidoria'
        },
        signature_method: 'HMAC-SHA1',
        hash_function: function(base_string, key) {
            return CryptoJS.HmacSHA1(base_string, key).toString(CryptoJS.enc.Base64);
        },
        nonce_length: 6
    });
        
    // Tokens do usuário aplicativo para o Oauth APP cadastrado
   

    $.ajax({
        url: request_data.url,
        type: request_data.method,
        data: request_data.ajaxData,
        contentType: "application/json",
        timeout:3000,
        async: false,
        headers: oauth.toHeader(oauth.authorize(request_data, token))
    })
    .then(function(data){
    			
        if (data.content.values){
            if (data.content.values.length > 0){
                status = data.content.values[0].STATUS;
            }
        }
        
        if(status == "success"){
        	var processo = data.content.values[0].IPROCESS
        	$("#dados_Inicial").hide();
        	$("#confirmacao").show();
        	$("#numSolicitacao").val(processo);
        	
            console.log(data);
            console.log("Sucesso na requisição " + data.content.values[0].IPROCESS)
            FLUIGC.toast({
                title: '',
                message: "Solicitação iniciada com sucesso: " + data.content.values[0].IPROCESS,
                type: 'success'
            });
        }else{
            console.log(data);
            console.log("Erro na requisição ")
            FLUIGC.toast({
                title: '',
                message: "Erro." + data.content.values[0].MESSAGE,
                type: 'danger'
            });
        }
    })
    .error(function(data){
        console.log(data);
        console.log("Erro na requisição ")
        FLUIGC.toast({
            title: '',
            message: "Erro.",
            type: 'danger'
        });
    })
}

//function addTable(row){

  //  var newrow = $("<tr>");

    //if(row == null){
		//var linha = $("#qtdeTable").val();
		//if(linha == 0){
		//	linha = 1;
	//	}
		//else{
		//	linha++;
        //}
        	
       // var cols = '<td class="bpm-mobile-trash-column"><span class="fluig-style-guide fs-display-block fs-md-space"><i class="fluigicon fluigicon-trash fluigicon-md" onclick="Javascript:fnCustomDeleteContato(this)" style="cursor:pointer"></i></span></td><td><div class="form-group"><input type="hidden" class="form-control" id="sequencia___' + linha + '" name="sequencia___' + linha + '" readonly><div class="input-group"><input type="text" name="codigoProduto___' + linha + '" id="codigoProduto___' + linha + '" class="form-control"><td><div class="form-group"><input type="text" name="produto___' + linha + '" id="produto___' + linha + '" class="form-control"/></div></td><td><div class="form-group">';

		//newrow.append(cols);
	//	$("#itens").append(newrow);
      //  $("#sequencia___" + linha).val(linha);
		//$("#qtdeTable").val(linha);
	//}
	//else{
      //  var linha = row["sequencia"];
        
       // var cols = '<td class="bpm-mobile-trash-column"><span class="fluig-style-guide fs-display-block fs-md-space"><i class="fluigicon fluigicon-trash fluigicon-md" onclick="Javascript:fnCustomDeleteContato(this)" style="cursor:pointer"></i></span></td><td><div class="form-group"><input type="hidden" class="form-control" id="sequencia___' + linha + '" name="sequencia___' + linha + '" readonly><div class="input-group"><input type="text" name="codigoProduto___' + linha + '" id="codigoProduto___' + linha + '" class="form-control"><td><div class="form-group"><input type="text" name="produto___' + linha + '" id="produto___' + linha + '" class="form-control"/></div></td><td><div class="form-group">';

		//newrow.append(cols);
		//$("#tabContato").append(newrow);
		//$("#sequencia___" + linha).val(row["sequencia"]);
		//$("#codigoProduto___" + linha).val(row["codigoProduto"]);
        //$("#produto___" + linha).val(row["produto"]);
       
	//}

//}
