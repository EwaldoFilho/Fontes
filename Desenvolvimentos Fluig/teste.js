// Cria uma nova solicitação HTTP
var request = new XMLHttpRequest();

// Configura a solicitação para enviar uma solicitação GET para o endereço do site de jornal
request.open('GET', 'https://g1.globo.com/df/distrito-federal/', true);

// Quando a resposta for recebida, executa a função de processamento
request.onload = function() {
  // Verifica se a resposta foi bem-sucedida
  if (request.status >= 200 && request.status < 400) {
    // Converte a resposta em texto
    var data = request.responseText;

    // Processa os dados usando a função de processamento de DOM
    var noticias = processarNoticias(data);

    // Faz algo com os dados das notícias aqui
  } else {
    // Exibe uma mensagem de erro se a resposta não foi bem-sucedida
    console.log('Erro ao carregar dados do site de jornal');
  }
};

// Envia a solicitação
request.send();

// Função de processamento de DOM para extrair os dados das notícias do site de jornal
function processarNoticias(data) {
  // Cria um novo parser de DOM
  var parser = new DOMParser();

  // Converte a resposta em um documento DOM
  var doc = parser.parseFromString(data, 'text/html');

  // Procura por todos os elementos de notícia no documento
  var noticias = doc.querySelectorAll('.noticia');

  // Cria um array vazio para armazenar os dados das notícias
  var resultado = [];

  // Loop pelos elementos de notícia
  for (var i = 0; i < noticias.length; i++) {
    // Cria um objeto de notícia vazio
    var noticia = {};

    // Pega o título da notícia
    noticia.titulo = noticias[i].querySelector('.titulo').textContent;

    // Pega a data da notícia
    noticia.data = noticias[i].querySelector('.data').textContent;

    // Pega o corpo da notícia
    noticia.corpo = noticias[i].querySelector('.corpo').textContent;

    // Adiciona a notícia ao array de resultados
    resultado}}
