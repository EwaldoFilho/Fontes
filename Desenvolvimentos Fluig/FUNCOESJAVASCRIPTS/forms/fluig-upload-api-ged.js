FLUIGC.utilities.parseInputFile("#uploadImageContato");


var settings = {
        action: WCMAPI.getServerURL() +"/ecm/upload",
        onComplete: function(filename, response) { 
 
        	var json = JSON.parse(response.replace("<pre>", "").replace("</pre>", "")); 
    
    		var dados = {"description" : json.files[0].name, "parentId" : "4989", "attachments" : [{'fileName' : json.files[0].name}]};
			$.ajax({
			  	method: "POST",
			  	url: WCMAPI.getServerURL() +"/api/public/ecm/document/createDocument",
			  	data: JSON.stringify(dados),
			  	contentType: "application/json", 
			  	async: false,
			  	error: function(x, e) {
			  		if (x.status == 500) {
			  			alert("Erro Interno do Servidor: entre em contato com o Administrador.");
			  		}
			     },
			     beforeSend: function(){
			    	 
			     },
			     success:function(model) {
		     	    $.ajax({
					  	method: "GET",
					  	url: WCMAPI.getServerURL() +"/api/public/ecm/document/downloadURL/"+ model.content.id,
					  	contentType: "application/json", 
					  	async: false,
					  	error: function(x, e) {
					  		if (x.status == 500) {
					  			alert("Erro Interno do Servidor: entre em contato com o Administrador.");
					  		}
					     },
					     beforeSend: function(){
					    	 
					     },
					     success:function(model) {
					     	$("#prevCapa").attr("src", model.content).show();
					     	$("#urlCapa").val(model.content);
						
					     }
					});

			     }
			 });
          
        },
        onSubmit:function(filename){}
    };

	FLUIGC.utilities.uploadFileForIE('#uploadImageContato', settings);