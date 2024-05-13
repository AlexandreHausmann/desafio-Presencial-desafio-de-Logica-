import 'dart:math';
import 'dart:io';

void main() {
  final List<String> palavras = ['TREM', 'CASA', 'BOI', 'BRASIL', 'OVO', 'CARRO', 'PLANETA', 'OSSO', 'CALDEIRA',
  'ORANGOTANGO', 'SELVA', 'BLUSA'];
  final Random random = Random();
  final String palavra = palavras[random.nextInt(palavras.length)];

  final List<String> letrasErradas = [];
  final List<String> letrasCertas = List.filled(palavra.length, '_');

  int erros = 0;
  const int maxErros = 6;

  while (true) {
    print('''
                ┌────────────────────────────────────────┐
   ┌──────┐     │ Letras erradas                         │
   │      ${erros >= 1 ? '@' : ' '}     │ ┌───┬───┬───┬───┬───┬───┬───┬───┐      │
   │     ${erros >= 3 ? '/':''}${erros >= 2 ? '|' : ' '}${erros >= 4 ? '\\':''}    │ │ ${letrasErradas.join(' │ ')} │      │
   │     ${erros >= 5 ? '/' : ' '} ${erros >= 6 ? '\\' : ' '}     │ └───┴───┴───┴───┴───┴───┴───┴───┘      │
   │            │ Palavra                                │
───┴────────────┘ ┌───┬───┬───┬───┬───┬───┐              │
                  │ ${letrasCertas.join(' │ ')} │              │
                  └───┴───┴───┴───┴───┴───┘              │
─────────────────────────────────────────────────────────┘
Próx. letra: _
    ''');

    if (erros == maxErros) {
      print('Você perdeu! A palavra era: $palavra');
      break;
    }

    if (!letrasCertas.contains('_')) {
      print('Parabéns! Você acertou a palavra: $palavra');
      break;
    }

    stdout.write('Informe uma letra: ');
    final letra = stdin.readLineSync()?.toUpperCase();

    if (letra == null || letra.isEmpty || letra.length != 1 || !letra.contains(RegExp(r'[A-Z]'))) {
      print('Por favor, informe uma única letra válida.');
      continue;
    }

    if (palavra.contains(letra)) {
      for (int i = 0; i < palavra.length; i++) {
        if (palavra[i] == letra) {
          letrasCertas[i] = letra;
        }
      }
    } else {
      letrasErradas.add(letra);
      erros++;
    }
  }
}