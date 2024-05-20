import 'dart:io';
import 'dart:math';

void main() {
  jogoTermo();
}

void jogoTermo() {
  final List<String> dicionario = ['ALPES', 'ARVOS', 'CABRA', 'BOMBO', 'GRUPO', 
   'PATOS', 'BANHO', 'ALVAR', 'SESCO'];
  final Random random = Random();
  final String palavraSecreta = dicionario[random.nextInt(dicionario.length)];

  final Stopwatch stopwatch = Stopwatch();
  stopwatch.start();

  print('Bem-vindo ao jogo Termo!');
  print('Tente adivinhar a palavra secreta de 5 letras.');

  int rodadasRestantes = 6;
  while (rodadasRestantes > 0) {
    print('');
    print('Rodada ${7 - rodadasRestantes} de 6');
    stdout.write('Informe uma palavra de 5 letras: ');
    final palavra = stdin.readLineSync()?.toUpperCase();

    if (palavra == null || palavra.length != 5 || !palavra.contains(RegExp(r'^[A-Z]*$'))) {
      print('Por favor, informe uma palavra válida com 5 letras.');
      continue;
    }

    List<String> letrasCorretas = [];
    List<String> letrasErradas = [];
    List<String> letrasCertas = List.filled(5, ' ');

    for (int i = 0; i < 5; i++) {
      if (palavra[i] == palavraSecreta[i]) {
        letrasCorretas.add(palavra[i]);
        letrasCertas[i] = '\x1B[32m${palavra[i]}\x1B[0m'; // Verde
      } else if (palavraSecreta.contains(palavra[i])) {
        letrasErradas.add(palavra[i]);
        letrasCertas[i] = '\x1B[33m${palavra[i]}\x1B[0m'; // Amarelo
      } else {
        letrasCertas[i] = '\x1B[31m${palavra[i]}\x1B[0m'; // Vermelho
      }
    }

    print('');
    print('Palavra informada:');
    print('┌───┬───┬───┬───┬───┐');
    print('│ ${letrasCertas[0]} │ ${letrasCertas[1]} │ ${letrasCertas[2]} │ ${letrasCertas[3]} │ ${letrasCertas[4]} │');
    print('├───┼───┼───┼───┼───┤');
    print('│ ${letrasCorretas.join(" ")} │');
    print('├───┼───┼───┼───┼───┤');
    print('│ ${letrasErradas.join(" ")} │');
    print('└───┴───┴───┴───┴───┘');

    if (letrasCorretas.length == 5) {
      stopwatch.stop();
      print('');
      print('Parabéns! Você acertou a palavra secreta: $palavraSecreta');
      print('Tempo de duração: ${stopwatch.elapsed}');
      return;
    }

    rodadasRestantes--;
  }

  print('');
  print('Você não conseguiu adivinhar a palavra secreta: $palavraSecreta');
  stopwatch.stop();
  print('Tempo de duração: ${stopwatch.elapsed}');
}

//falta puxar um Json com palavras mas vou fazer essa implementação quando for para flutter