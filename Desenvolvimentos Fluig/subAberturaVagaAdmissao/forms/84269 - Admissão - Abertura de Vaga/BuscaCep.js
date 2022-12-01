 $(document).ready(function() {

            function formulario_cep() {
                // Limpa valores do formulário de cep.          
                $("#RA_BAIRRO").val("");
                $("#RA_COMPLEM").val("");                
            }
            
            //Quando o campo cep perde o foco.
            $("#RA_CEP").blur(function() {

                //Nova variável "cep" somente com dígitos.
                var cep = $(this).val().replace(/\D/g, '');

                //Verifica se campo cep possui valor informado.
                if (cep != "") {

                    //Expressão regular para validar o CEP.
                    var validacep = /^[0-9]{8}$/;

                    //Valida o formato do CEP.
                    if(validacep.test(cep)) {

                        //Preenche os campos com "..." enquanto consulta webservice.                        
                        $("#RA_BAIRRO").val("...");
                        $("#RA_COMPLEM").val("...");                        

                        //Consulta o webservice viacep.com.br/
                        $.getJSON("https://viacep.com.br/ws/"+ cep +"/json/?callback=?", function(dados) {

                            if (!("erro" in dados)) {
                                //Atualiza os campos com os valores da consulta.                          
                                $("#RA_BAIRRO").val(dados.bairro);
                                $("#RA_COMPLEM").val(dados.localidade);                                
                            } //end if.
                            else {
                                //CEP pesquisado não foi encontrado.
                                formulario_cep();
                                alert("CEP não encontrado.");
                            }
                        });
                    } //end if.
                    else {
                        //cep é inválido.
                        formulario_cep();
                        alert("Formato de CEP inválido.");
                    }
                } //end if.
                else {
                    //cep sem valor, limpa formulário.
                    formulario_cep();
                }
            });
        });