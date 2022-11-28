   parent.$('#textActivity').hide();

   $('#tb_produtos').hide(); 
   $('#tb_novosProdutos').hide();         
   $('#labelProdutos').hide(); 
   $('#labelProdutosAdicionais').hide();
   var matriculaUsuario = $("#matriculaUsuario").val();
   
   
   //Eventos para não permitir o usuário a digitar ou apagar conteudo no input 
   var inputCentroCusto = document.getElementById("descricao");
   var inputEmpresa = document.getElementById("empresa");
   
   inputCentroCusto.addEventListener("keypress", function(event){
       event.preventDefault();
   });

   inputEmpresa.addEventListener("keypress", function(event){
       event.preventDefault();
   });

   inputCentroCusto.addEventListener('keydown', function(event) {
       const key = event.key;
       if (key === "Backspace" || key === "Delete") {
           event.preventDefault();
       }
   });

   inputEmpresa.addEventListener('keydown', function(event) {
       const key = event.key;
       if (key === "Backspace" || key === "Delete") {
           event.preventDefault();
       }
   });

	var dataAtual = new Date();

   var dataFormatada = ((dataAtual.getDate() )) + "/" + ((dataAtual.getMonth() + 1)) + "/" + dataAtual.getFullYear(); 

   //data juridico do panel panelProcessoContratacao
   var dataAberturaJuridico = FLUIGC.calendar('#dataAberturaJuridico');
   var dataEntregaJuridico = FLUIGC.calendar('#prazoJuridico');
   
   dataEntregaJuridico.setMinDate(dataAtual);

   //seto os valores para abrir um subprocesso do juridico   
   $("#dataAberturaJuridico").val(((dataAtual.getDate() )) + "/" + ((dataAtual.getMonth() + 1)) + "/" + dataAtual.getFullYear());
   $("#setorJuridico").val("Suprimentos");
   $("#classificacaoJuridico").val("Urgente");
   $("#tipoSolicitacaoJuridico").val("Validação de contrato");
   $("#objetivoJuridico").val("Validar contrato de empresa em anexo.");

   //esconde a obrigatoriedade dos campos do juridico
   $("#habilitaContatoObrigatoriedade").hide();
   $("#habilitaPrazoObrigatoriedade").hide();
   
   //GERENTES 
   
   var numState = $("#estado").val();
   
   $("#existeProdutoNovo").val(false);

   if(numState == "54"){
      parent.$("#workflowActions").hide();
   }
   
   if(numState == "342"){
      $("#existeProdutoNovo").val(true);
      $("#tb_novosProdutos").show();
   }
   
   if(numState == "4" || numState == "5" || numState == "54" || numState == "73" || numState == "90" || numState == "113" || 
	       numState == "119" || numState == "132" || numState == "171" || numState == "491" ||
	       numState == "422" || numState == "148" || numState == "464" || numState == "461" || numState == "475" || 
	       numState == "449" || numState == "388" || numState == "436" || numState == "435" || numState == "511" ||
	       numState == "433" || numState == "429" || numState == "426" || numState == "404" || numState == "514" ||
	       numState == "401" || numState == "360" || numState == "287" || numState == "172"){
	        	$("#tb_produtos").show();
   }
   
   
   var numeroProcesso = $("#processo").val();
   var dataEntrega = FLUIGC.calendar('#estimativaEntrega');
   var fornecedoresModal = null;//guarda fornecedores que serão exibidos na modal escolherProposta(idProposta)

   var produtos = [];
   var produtosNovos = [];
   
   var produtosInput = "";
   var produtosNovosInput = "";
   
   if(numState != "0"){
	   var produtosFormatados = $("#listaProdutos").val();
	   var produtosNovosFormatadosInput = $("#listaNovosProdutos").val();
	   
	   produtosInput = JSON.parse("["+produtosFormatados.replace(/[\[\]]/g, "")+"]");	   
	   produtosNovosInput = JSON.parse("["+produtosNovosFormatadosInput.replace(/[\[\]]/g, "")+"]");	  
   }

   var dia = dataAtual.getDate()+7;
   var mes = dataAtual.getMonth();
   var ano = dataAtual.getFullYear();
   
   if(dia<10){
      dia = "0"+dia;
   }
   
   if(mes<10){
      mes = "0"+mes;
   }
   
   dataEntrega.setMinDate(new Date(ano, mes, dia));
   
   function habilitaObrigatoriedade(){
      var validaProcesso = $("#validacaoJuridico").val();

      if (validaProcesso == "sim") {
         $("#habilitaContatoObrigatoriedade").show();
         $("#habilitaPrazoObrigatoriedade").show();   
      } else {
         $("#habilitaContatoObrigatoriedade").hide();
         $("#habilitaPrazoObrigatoriedade").hide();
      }      
   }

   function showValidarServico(){
      var servicos = JSON.parse($("#cotacoesInput").val());
      //var servicos =  JSON.parse('[{"codNumSc":"0001","codNumCotacao":"000168","loja":"01","filial":"0101","produto":"ACUPUNTURISTA (20H)","codProduto":"100000000000562","quantidade":"1","codArmazem":"01MZ01","fornecedores":[{"codItemCotacao":"0001","fornecedor":"000002","precoUnitario":"2.00","precoTotal":"2.00","taxaFrete":"0.00","ganhador":true,"prazoEntrega":"30 DIAS        ","codProduto":"100000000000562","nomeFornecedor":"SOS LIFE LTDA                                                                   ","lojaForn":"01"},{"codItemCotacao":"0001","fornecedor":"000001","precoUnitario":"3.00","precoTotal":"3.00","taxaFrete":"0.00","ganhador":false,"prazoEntrega":"30 DIAS","codProduto":"100000000000562","nomeFornecedor":"TESTE FORNECEDOR CNAB","lojaForn":"01"},{"codItemCotacao":"0001","fornecedor":"000006","precoUnitario":"3.00","precoTotal":"3.00","taxaFrete":"0.00","ganhador":false,"prazoEntrega":"30 DIAS        ","codProduto":"100000000000562","nomeFornecedor":"GLOBAL RADIOCOMUNICACAO LTDA                                                    ","lojaForn":"1 "}]},{"codNumSc":"0001","codNumCotacao":"000168","loja":"01","filial":"0101","produto":"ACUPUNTURISTA (20H)                                         ","codProduto":"100000000000562","quantidade":"1","codArmazem":"01MZ01","fornecedores":[{"codItemCotacao":"0001","fornecedor":"000002","precoUnitario":"2.00","precoTotal":"2.00","taxaFrete":"0.00","ganhador":false,"prazoEntrega":"30 DIAS        ","codProduto":"100000000000562","nomeFornecedor":"SOS LIFE LTDA                                                                   ","lojaForn":"01"},{"codItemCotacao":"0001","fornecedor":"000001","precoUnitario":"3.00","precoTotal":"3.00","taxaFrete":"0.00","ganhador":false,"prazoEntrega":"30 DIAS        ","codProduto":"100000000000562","nomeFornecedor":"TESTE FORNECEDOR CNAB                                                           ","lojaForn":"01"},{"codItemCotacao":"0001","fornecedor":"000006","precoUnitario":"3.00","precoTotal":"3.00","taxaFrete":"0.00","ganhador":true,"prazoEntrega":"30 DIAS        ","codProduto":"100000000000562","nomeFornecedor":"GLOBAL RADIOCOMUNICACAO LTDA","lojaForn":"1 "}]}]');

      var div = document.getElementById("montarInputServico");
      div.innerHTML = inputServicos(servicos);
      
      //setar o calendario no input e a data minima
      for (var countServico = 0; countServico < servicos.length; countServico++){
    	   this["dataInicioExecucaoServico_"+countServico] = FLUIGC.calendar('#dataInicioExecucaoServico_'+countServico);
    	   this["dataFimExecucaoServico_"+countServico] = FLUIGC.calendar('#dataFimExecucaoServico_'+countServico);
         
         this["dataInicioExecucaoServico_"+countServico].setMinDate(new Date());
         this["dataFimExecucaoServico_"+countServico].setMinDate(new Date());
      }
      
      //seta no input quantos servicos foram solicitados
      $("#countValidaInputServico").val(servicos.length);
   }

   function inputServicos(servicos){      
      var linhas = "";

      for (var countServico = 0; countServico < servicos.length; countServico++) {
         var fornecedores = servicos[countServico].fornecedores;         

         for (var countFornec = 0; countFornec < fornecedores.length; countFornec++) {
            if (fornecedores[countFornec].ganhador == true) {
               fornecedorGanhador = fornecedores[countFornec].nomeFornecedor;
            }            
         }         
        
         linhas +=   '<form name="formValidarServico">'+
         				 '<div class="row col-md-12" data-type="input"  data-field-name="panelValidaServico" >'+
				            '<div class="form-group col-sm-12">'+
				               '<label for="produto" class="col-sm-12">Serviço</label>'+
				               '<div class="col-sm-12">'+                                                                                                
				                  '<span>'+servicos[countServico].produto+'</span>'+
				               '</div>'+
				            '</div> '+         				 
         				 '</div>'+
				         '<div class="row col-md-12" data-type="input"  data-field-name="panelValidaServico" >'+
				            '<div class="form-group col-sm-4">'+
				               '<label for="dataExecucaoServico" class="col-sm-12">Fornecedor</label>'+
				               '<div class="col-sm-12">'+                                                                                                
				                  '<span>'+fornecedorGanhador+'</span>'+
				               '</div>'+
				            '</div> '+
				            '<div class="form-group col-sm-4">       '+
				               '<label for="dataExecucaoServico" class="col-sm-12">Data início de execução do servico<strong class="required text-danger"></strong></label>'+
				               '<div class="col-sm-12">'+
				                  '<input type="text" name="dataInicioExecucaoServico_'+countServico+'" id="dataInicioExecucaoServico_'+countServico+'" class="form-control" data-fluig-state-valid="511, 514" data-fluig-write="511, 514" placeholder="dd/mm/yyyy">'+
				               '</div>'+
				            '</div>'+
				            '<div class="form-group col-sm-4">'+
				               '<label for="dataExecucaoServico" class="col-sm-12">Data fim da execução do servico<strong class="required text-danger"></strong></label>'+
				               '<div class="col-sm-12">'+
				                  '<input type="text" name="dataFimExecucaoServico_'+countServico+'" id="dataFimExecucaoServico_'+countServico+'" class="form-control" data-fluig-state-valid="511, 514" data-fluig-write="511, 514" placeholder="dd/mm/yyyy">'+
				               '</div>'+
				            '</div>'+
				         '</div>'+
				     '</form> '
      }
      
      return linhas;

   }