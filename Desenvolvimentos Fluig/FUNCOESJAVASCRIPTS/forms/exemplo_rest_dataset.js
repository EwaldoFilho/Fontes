//FUNÇÃO DE CHAMADA DE DATASET GENÊRICA
function getDatasetExterno(dataset, filtros, cb) {
        var retorno;
        var oauth = OAuth({
            consumer: {
                'key': '{consumerKey}', // nome do aplicativo que você criou
                'secret': '{consumerSecret}' // nome do aplicativo que você criou
            },
            signature_method: 'HMAC-SHA1',
            hash_function(base_string, key) {
                return CryptoJS.HmacSHA1(base_string, key).toString(CryptoJS.enc.Base64);
            },
            nonce_length: 6
        });

        var request_data = {
            url: WCMAPI.serverURL + '/api/public/ecm/dataset/datasets',
            method: 'POST'
        };
		
        //type of the constraint(1 - MUST, 2 - SHOULD, 3 - MUST_NOT)
        var data = {
            "name": dataset,
            "fields": [],
            "constraints": filtros,
            "order": []
        }

		var token = {
			'key': '{sua key}',
			'secret': '{seu secret}'
		}

        $.ajax({
            url: request_data.url,
            contentType: 'application/json',
            crossDomain: true,
            async: false,
            type: request_data.method,
            data: JSON.stringify(data),
            headers: oauth.toHeader(oauth.authorize(request_data, token))
        }).fail(function(e, f) {
            console.log("deu ruim!");
        }).success(function(f) {
            if (f.content.values.length > 0) {
                console.log(f.content.values);
				cb(f.content);
            } else {
               console.log("Deu ruim tambem!");
            }
        });
		
		
};		

//CONSUMO DA FUNÇÃO GENERICA		
var filtro = [{
	_field: "",
	_initialValue: "",
	_finalValue:"",
	_type: 1, //type of the constraint(1 - MUST, 2 - SHOULD, 3 - MUST_NOT)
	_likeSearch: false
}, {
	_field: "",
	_initialValue: "",
	_finalValue: "",
	_type: 1, //type of the constraint(1 - MUST, 2 - SHOULD, 3 - MUST_NOT)
	_likeSearch: false
}];
getDatasetExterno("colleague", filtro, function(data){
	console.log("EXECUTOU CALLBACK",data);
});