$(document).ready(function() {
    $.ajax({
        url: "https://gist.githubusercontent.com/antoniopresto/d73888dab087ae35a7cf41a61d8a3cbc/raw/43c94b305367afa82734f6fb4480f55e77e08a6e/banco_codigo.json"
    }).then(function(data) {
        this.bancos = JSON.parse(data);

        $.each(this.bancos, function (i, banco) {
            $("#banco").append($('<option>', {
                value: banco.label,
                text: banco.label
            }));
        })
    });
});