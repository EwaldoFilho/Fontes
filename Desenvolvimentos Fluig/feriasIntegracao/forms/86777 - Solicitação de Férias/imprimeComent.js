// Crie uma função para imprimir os comentários
function imprimirComentarios() {
  // Obtenha a lista de comentários do processo
  var comentarios = document.getElementById("comentarios");

  // Crie uma janela pop-up com os comentários
  var win = window.open("", "", "width=500,height=500");
  win.document.write("<h1>Comentários do processo</h1>");
  win.document.write(comentarios.innerHTML);

  // Adicione um botão de impressão à janela pop-up
  win.document.write("<button onclick='window.print()'>Imprimir</button>");
}