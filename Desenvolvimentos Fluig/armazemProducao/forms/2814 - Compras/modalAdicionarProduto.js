var produtosNovos = [];

$("#tb_novosProdutos").on("click", ".remover", function(e){
    $(this).closest('tr').remove(); 
    
        var tableData = $(this).closest("tr").find("td:not(:last-child)").map(function(){
          return $(this).text().trim();
       }).get();
  
      var listaProd = "";
      var listaProdAtualizada = [];
      
       var produtosFormatados = $("#listaNovosProdutos").val();
       listaProd = JSON.parse("["+produtosFormatados.replace(/[\[\]]/g, "")+"]");	  
            
      for(var count=0; count < listaProd.length; count++){
          if(tableData[0] != listaProd[count].descricao){
              listaProdAtualizada.push(listaProd[count]);
          }
      }
      
      $("#listaNovosProdutos").val(JSON.stringify(listaProdAtualizada));  
    
       
    if ($('#tb_novosProdutos tr').length === 1) {
          $("#existeProdutoNovo").val(false);
          $('#tb_novosProdutos').hide();
          $('#labelProdutos').hide();
          $("#listaNovosProdutos").val([]);     
    }
 });

$("#modalAdicionarProduto").click(function () {
    var modalAddProduto = FLUIGC.modal({
       title: 'Adicionar produto',
       content: '<form name="formModalAddProduto"">'+          
              '<div class="alert alert-danger hidden" id="avisoAddProduto" role="alert">'+
                   '<span>Preencha os campos obrigatórios</span>'+
                '</div>'+  
                 '<div class="row">'+
                      '<div class="form-group col-sm-12">'+
                         '<div class="input-group col-sm-12">'+               
                            '<label for="descricaoAdd" class="col-sm-12">Produto<strong class="required text-danger"></strong></label>'+
                            '<input type="text" class="form-control" name="descricaoAdd" id="descricaoAdd"  data-fluig-state-valid="0,4" data-fluig-write="0,4" required="required">'+                  
                         '</div>'+
                      '</div>'+
                      '<div class="form-group col-sm-12">'+
                         '<div class="input-group col-sm-12">'+               
                            '<label for="observacao" class="col-sm-12">Observação<strong class="required text-danger"></strong></label>'+
                                  '<textarea class="form-control" rows="5" name="observacao" id="observacao" data-fluig-state-valid="0,4" data-fluig-write="0,4" required="required"></textarea>'+
                         '</div>'+
                      '</div>'+                           
                   '</div>'+
                '</form>',
       id: 'fluig-modal-add-produto',
       size: 'full',
       actions: [{
          'label': 'Adicionar',
          'bind' : "data-add-produto",
       },{
          'label': 'Cancelar',
          'autoClose': true
       }]
    }, function() {
       var table = document.getElementById("tb_novosProdutos");
       var row = table.insertRow($('#tb_novosProdutos tr').length);
       
      function maskCharacters() {  
           var regex = new RegExp('[^ }{,.^?~=+\-_\/*\-+.\ 0-9a-zA-Zàèìòùáéíóúâêîôûãõ\b@,.]', 'g');       
            $(this).val($(this).val().replace(regex, ''));
      }
          
      $("#observacao").keyup(maskCharacters);                     

       $("#fluig-modal-add-produto").find("button[data-add-produto]").on("click", function() {     
          
          if(document.querySelector("#descricaoAdd").value=="" || document.querySelector("#descricaoAdd").value == null ||
             document.querySelector("#observacao").value=="" || document.querySelector("#observacao").value == null){                        
                $("#avisoAddProduto").removeClass("hidden");
             }else{
                var descricaoAdd = document.querySelector("#descricaoAdd").value;
                var observacao = document.querySelector("#observacao").value;

                row.innerHTML = '<tr>'+
                                  '<td>'+document.querySelector("#descricaoAdd").value+'</td>'+
                                  '<td>'+document.querySelector("#observacao").value+'</td>'+                               
                                  '<td class="text-center"><i class="flaticon flaticon-trash icon-md remover"></i></td>'+
                               '</tr>';
                produtosNovos.push('{'+'"descricao":"'+document.querySelector("#descricaoAdd").value+'", "observacao":"'+document.querySelector("#observacao").value+'"}');
                $('#tb_novosProdutos').show();                       
                $('#labelProdutos').show(); 
                modalAddProduto.remove();
             }
             $("#listaNovosProdutos").val(produtosNovos); 
             $("#existeProdutoNovo").val(true);
       });
    });        
 });

