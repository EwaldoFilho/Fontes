$(document).on("ready", function() {

    if (getMobile() == "true") {
        initiateFunction = setInterval(function() { initiate() }, 3000);
    } else {
        initiate()
    }

});


function initiate() {
   
    $("#nomeAtendente").val(getWKUserName()); 
        
}
