import 'dart:io';

void main() {
  final tabuleiro = Tabuleiro();

  var jogadas = 0;
  while (jogadas < 9) {
    tabuleiro.mostrarTabuleiro();
    var jogadorEmAndamento = jogadas.isEven ? CasaTabuleiro.X : CasaTabuleiro.O;

    print('Vez do jogador ${jogadorEmAndamento.print}');
    final jogada = stdin.readLineSync() ?? '';

    if (jogada.length != 2) {
      print('Digite uma jogada no formato válido, como A1, B2 etc...');
      continue;
    }

    final mensagem = tabuleiro.fazerJogada(
      linha: jogada[0],
      coluna: jogada[1],
      jogador: jogadorEmAndamento,
    );

    if (mensagem != null) {
      print(mensagem);
      continue;
    }

    final sucesso = tabuleiro.checarVencedor();

    if (sucesso) {
      tabuleiro.mostrarTabuleiro();
      print('Voce venceu!!!');
      return;
    }

    jogadas++;
  }
  if (jogadas == 9) {
    tabuleiro.mostrarTabuleiro();
    print('Deu velha!!!');
  }

}

enum CasaTabuleiro{
  vazio,
  X,
  O;

  String get print => switch (this) {
   vazio=>  ' ',
   X=>  'X',
   O=>  'O',
  };

}

class Tabuleiro{

  final matriz = [
    [CasaTabuleiro.vazio,CasaTabuleiro.vazio,CasaTabuleiro.vazio],
    [CasaTabuleiro.vazio,CasaTabuleiro.vazio,CasaTabuleiro.vazio],
    [CasaTabuleiro.vazio,CasaTabuleiro.vazio,CasaTabuleiro.vazio],
  ];

  //matriz[linha][coluna]
  bool checarVencedor() {
    // Checar horizontal
    for(var linha = 0; linha < matriz.length; linha++) {
      if (matriz[linha][0] == matriz[linha][1] && matriz[linha][1] == matriz[linha][2] && matriz[linha][1] != CasaTabuleiro.vazio) {
        return true;
      }
    }

    //Checar vertical
    for(var coluna = 0; coluna < 3; coluna++) {
      if (matriz[0][coluna] == matriz[1][coluna] && matriz[1][coluna] == matriz[2][coluna] && matriz[1][coluna]  != CasaTabuleiro.vazio) {
        return true;
      }
    }

    // Checar diagonal direita para esquerda
    if (matriz[0][0] == matriz[1][1] && matriz[1][1] == matriz[2][2] && matriz[1][1]  != CasaTabuleiro.vazio) {
      return true;
    }


    // Checar diagonal esquerda para direita
    if (matriz[0][2] == matriz[1][1] && matriz[1][1] == matriz[2][0] && matriz[1][1] != CasaTabuleiro.vazio) {
      return true;
    }

    return false;
  }

  String? fazerJogada({required String linha, required String coluna, required CasaTabuleiro jogador}) {

    var colunaIndice = int.tryParse(coluna);
    var linhaIndice = 0;

    switch(linha.toUpperCase()) {
      case 'A': linhaIndice = 0;
      case 'B': linhaIndice = 1;
      case 'C': linhaIndice = 2;
      default: return 'Digite uma linha valida';
    }

    if(colunaIndice == null) {
      return 'Digite uma coluna valida';
    }

    if (matriz[linhaIndice][colunaIndice - 1] == CasaTabuleiro.vazio) {
      matriz[linhaIndice][colunaIndice - 1] = jogador;
    } else {
      return 'Essa opção ja foi escolhida';
    }
    return null;
  }
void mostrarTabuleiro() {
  var tabuleiro = '     1   2   3  ';
  tabuleiro += '\n   _____________';

  for (var linha = 0; linha < matriz.length; linha++) {
    var itens = '';

    switch (linha) {
      case 0:
        itens = '\nA  |';
        break;
      case 1:
        itens = '\nB  |';
        break;
      case 2:
        itens = '\nC  |';
        break;
    }

    for (var coluna = 0; coluna < matriz[linha].length; coluna++) {
      itens += ' ${matriz[linha][coluna].print} |';
    }
    tabuleiro += itens;
    tabuleiro += '\n   |___|___|___|';
  }

  print(tabuleiro);
}
}
