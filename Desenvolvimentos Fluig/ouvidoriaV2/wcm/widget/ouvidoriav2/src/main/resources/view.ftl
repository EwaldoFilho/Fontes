<html>

<head>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
        crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"
        integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB"
        crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"
        integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13"
        crossorigin="anonymous"></script>
    <script type="text/javascript" src="/webdesk/vcXMLRPC.js"></script>
</head>
<style type="text/css">
    .form-all {
        margin: 0px auto;
        padding-top: 0px;
        width: 690px;
        color: #555 !important;
        font-family: 'Arial';
        font-size: 14px;
        border: none;

    }


    .bg_video {
        position: fixed;
        right: 0;
        bottom: 0;
        min-width: 100%;
        min-height: 100%;
        width: auto;
        height: auto;
        z-index: -1000;
        background: url(images/torre.jpg) no-repeat;
        background-size: cover;
    }
</style>
<div id="MyWidget_${instanceId}" class="super-widget wcm-widget-class fluig-style-guide"
    data-params="MyWidget.instance()">

    <body class="form-all">
        <form style="padding-left: 10px; padding-right: 10px;border: none;opacity: 0.9">
            <video autoplay loop poster="http://portal.medmais.com:8007/portal/api/servlet/image/0101001/custom/abstrato-branco-3d.jpg"
                class="bg_video">
                <source src="https://www.medmais.com/wp-content/themes/medmais/video/Medmais_Institucional_Site_2.mp4"
                    type="video/webm">
            </video>
            <div style="text-align: center;" margin-bottom="20px">
                <img src="http://portal.medmais.com:8007/portal/api/servlet/image/0101001/custom/logo_image.png"
                    class="img-fluid" alt="Imagem responsiva" style="max-width: 50%; margin-top: 20px">
            </div>
            <br>
            <!--INICIO PANEL - GERAL --->
            <div class="panel panel-primary" id="dados_Inicial" name="dados_Inicial" style="
                margin-right: 300px;
                margin-left: 300px;
                        ">
                <div class="panel-heading"
                    style="background-image: linear-gradient(to right, rgba(255,0,0,0), rgba(255,0,0,1));">
                    <h3 class="panel-title">
                        <i class="flaticon flaticon-speaker-notes icon-md"></i>OUVIDORIA ONLINE
                    </h3>
                </div>
                <!--FIM PANEL - HEADING --->
                <!-- INICIO PANEL - Geral -->
                <div class="panel-body">
                    <div class="row">

                        <div class="form-group col-md-12" line-height="4.5em" font-size="4.071em"
                            style="text-align:justify">
                            De acordo com Política de apuração de denúncias e ouvidoria, baseada no Código de Ética
                            e cultura, este relato (ou parte dele) será utilizado para formalização de elogios,
                            sugestões, reclamações e apuração de condutas que resultem em denúncias de
                            irregularidades ou violação . Este relato não precisa ser identificado. Caso o relator
                            se identifique, o mesmo será informado sobre as medidas adotadas e terá sua identidade
                            preservada conforme previsto na Política de não-retaliação a denunciantes. Realize o
                            preenchimento com o maior número de informações que possuir e anote seu protocolo gerado
                            após o envio do relato para acompanhamento futuro.
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col-md-6">
                            <label class="control-label">Tipo de Solicitação:</label>
                            <select type="text" class="form-control" id="tipoOuvidoria" name="tipoOuvidoria">
                                <option value=""> </option>
                                <option value="Elogio"> Elogio </option>
                                <option value="Sugestão"> Sugestão </option>
                                <option value="Reclamação"> Reclamação </option>
                                <option value="Denúncia de irregularidade/violação"> Denúncia de irregularidade/violação
                                </option>
                            </select>
                        </div>
                        <div class="form-group col-md-6">
                            <div class="form-group">
                                <label class="control-label">Data do Fato</label>
                                <input id="dataemissao" type="date" class="form-control" name="dataemissao">
                            </div>
                        </div>
                    </div>
                    <div class="row">

                        <div class="form-group col-md-6">
                            <label class="control-label">Onde Ocorreu o Fato?</label>
                            <input type="text" class="form-control" id="lugar" name="lugar">
                        </div>
                        <div class="form-group col-md-6">
                            <div class="form-group">
                                <label class="control-label">Hora</label>
                                <input id="hora" type="time" class="form-control" name="hora">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col-md-6">
                            <label class="control-label">A Ocorrência Envolveu</label>
                            <input placeholder="Pessoa, Equipamento, Atendimento ou Outros" type="text"
                                class="form-control" id="tipoEnvolvido" name="tipoEnvolvido">
                        </div>
                        <div class="form-group col-md-6">
                            <div class="form-group">
                                <label class="control-label">Pessoal Envolvido</label>
                                <input id="pessoalEnvolvido" type="text" class="form-control" name="pessoalEnvolvido">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col-md-6">
                            <label class="control-label">Email</label>
                            <input placeholder="Não é necessário se Identificar" type="text" class="form-control"
                                id="email" name="email" onblur="validacaoEmail(f1.email)" maxlength="60" size='65'>
                        </div>
                        <div class="form-group col-md-6">
                            <div class="form-group">
                                <label class="control-label">Nome do Relator</label>
                                <input placeholder="Não é necessário se Identificar" id="relator" type="text"
                                    class="form-control" name="relator">
                            </div>
                        </div>
                    </div>
                    <div class="row">

                        <div class="form-group col-md-12">
                            <label class="control-label">Situação:</label>
                            <textarea
                                placeholder="Relate o fato. Quanto mais informações inseridas, mais assertividade e agilidade teremos na apuração da sua ocorrência."
                                type="text" class="form-control" id="situacao" name="situacao"
                                style="overflow:auto; margin: 0px px 0px 0px; height: 376px; width: 500px;text-align:center;"></textarea>
                        </div>

                        <br><br><br><br>
                    </div>
                    <div class="row">
                        <div class="form-group col-md-5"></div>
                        <div class="form-group col-md-2" style="text-align:center">
                            <input type="file" name="my_files[]" multiple /></input>
                        </div>
                        <div class="form-group col-md-5"></div>
                        <br><br><br><br>
                    </div>
                    <div class="row">
                        <div class="form-group col-md-5"></div>
                        <div class="form-group col-md-2" style="text-align:center">
                            <button type="button" class="btn btn-danger float-right"
                                style="margin-top:25px; width: 100%; height:100%; background-color:#d70b2d;text-align:center; "
                                onclick="enviar(this)">Enviar</button>
                        </div>
                        <div class="form-group col-md-5"></div>
                        <br><br><br><br>
                    </div>


                </div>
            </div>
            <div class="panel panel-primary" id="confirmacao" name="confirmacao" style="
                                                            margin-right: 300px;
                                                            margin-left: 300px;
                                                                    ">

                <div class="panel-heading"
                    style="background-image: linear-gradient(to right, rgba(255,0,0,0), rgba(255,0,0,1));">
                    <h3 class="panel-title">
                        <i class="flaticon flaticon-speaker-notes icon-md"></i>Solicitação Iniciada
                    </h3>
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="form-group col-md-5"></div>
                        <div align="center" class="alignment" style="line-height:10px"><img alt="Main Image"
                                src="https://s8.gifyu.com/images/selo-15-anos.gif"
                                style="display: block; height: auto; border: 0; width: 232px; max-width: 100%;"
                                title="Main Image" width="232" />
                        </div>
                        <div class="form-group col-md-5"></div>
                        <br><br><br><br>
                    </div>
                    <div class="row">
                        <div class="form-group col-md-12">
                            <td class="pad"
                                style="padding-bottom:40px;padding-left:25px;padding-right:25px;padding-top:10px;">
                                <div style="font-family: sans-serif">
                                    <div class="txtTinyMce-wrapper"
                                        style="font-size: 14px; mso-line-height-alt: 21px; color: #000000; line-height: 1.5; font-family: Varela Round, Trebuchet MS, Helvetica, sans-serif;">
                                        <p style="margin: 0; font-size: 14px; text-align: center;">
                                            <strong>Sua solicitação foi registrada com sucesso</strong>
                                        </p>
                                        <p style="margin: 0; font-size: 14px; text-align: center;">
                                            E gerou o protocolo abaixo</p>
                                    </div>
                                </div>
                            </td>
                        </div>
                    </div>
                    <div class="row">

                        <div class="form-group col-md-12">
                            <input readonly id="numSolicitacao" type="text" class="form-control" name="numSolicitacao"
                                style="padding-left:25px;padding-right:25px;font-size:15px;display:inline-block;letter-spacing:normal;text-align: center;">
                        </div>


                        <br><br><br><br>
                    </div>

                    <div align="center" class="form-group col-md-12">
                        <!--[if mso]><v:roundrect xmlns:v="urn:schemas-microsoft-com:vml" xmlns:w="urn:schemas-microsoft-com:office:word" href="http://www.example.com/" style="height:40px;width:197px;v-text-anchor:middle;" arcsize="60%" stroke="false" fillcolor="#ffffff"><w:anchorlock/><v:textbox inset="0px,0px,0px,0px"><center style="color:#091548; font-family:sans-serif; font-size:15px"><![endif]--><a
                            href="https://www.medmais.com/"
                            style="text-decoration:none;display:inline-block;color:#091548;background-color:#ffffff;border-radius:24px;width:auto;border-top:1px solid #ffffff;font-weight:undefined;border-right:1px solid #ffffff;border-bottom:1px solid #ffffff;border-left:1px solid #ffffff;padding-top:5px;padding-bottom:5px;font-family:Varela Round, Trebuchet MS, Helvetica, sans-serif;text-align:center;mso-border-alt:none;word-break:keep-all;"
                            target="_blank"><span
                                style="padding-left:25px;padding-right:25px;font-size:15px;display:inline-block;letter-spacing:normal;text-align: center;"><span
                                    style="word-break: break-word;"><span data-mce-style=""
                                        style="line-height: 30px;"><strong>CLIQUE AQUI PARA VOLTAR AO
                                            SITE.</strong></span></span></span></a>
                        <!--[if mso]></center></v:textbox></v:roundrect><![endif]-->
                    </div>

                    <br><br><br><br>
                </div>


            </div>

        </form>

        <script language="Javascript">
            $("#confirmacao").hide();

            const fileInput = document.querySelector("input");
            fileInput.addEventListener("change", (e) => {
                const file = e.target.files[0];
                const reader = new FileReader();
                reader.onloadend = () => {
                    const base64String = reader.result.replace("data:", "").replace(/^.+,/, "");
                    document.getElementById("attachment").value = base64String;

                };
                reader.readAsDataURL(file);
            });



            function validacaoEmail(field) {
                usuario = field.value.substring(0, field.value.indexOf("@"));
                dominio = field.value.substring(field.value.indexOf("@") + 1, field.value.length);

                if ((usuario.length >= 1) &&
                    (dominio.length >= 3) &&
                    (usuario.search("@") == -1) &&
                    (dominio.search("@") == -1) &&
                    (usuario.search(" ") == -1) &&
                    (dominio.search(" ") == -1) &&
                    (dominio.search(".") != -1) &&
                    (dominio.indexOf(".") >= 1) &&
                    (dominio.lastIndexOf(".") < dominio.length - 1)) {
                    document.getElementById("msgemail").innerHTML = "E-mail válido";
                    alert("E-mail valido");
                }
                else {
                    document.getElementById("msgemail").innerHTML = "<font color='red'>E-mail inválido </font>";
                    alert("E-mail invalido");
                }
            }
        </script>
    </body>
</div>

</html>