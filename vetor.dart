import 'dart:io';
import 'dart:math';

// Função para criar um vetor com números aleatórios
void createRandomVector() {
  stdout.write('Digite o tamanho do vetor: ');
  try {
    int size = int.parse(stdin.readLineSync()!);
    List<int> vector = List.generate(size, (index) => Random().nextInt(100));
    print('Vetor gerado: $vector');
  } catch (_) {
    print('Por favor, insira um número inteiro válido.');
  }
}

// Função para criar um vetor inserindo manualmente
void createManualVector() {
  stdout.write('Digite o tamanho do vetor: ');
  try {
    int size = int.parse(stdin.readLineSync()!);
    List<int> vector = [];
    print('Digite os elementos do vetor:');
    for (int i = 0; i < size; i++) {
      stdout.write('Elemento $i: ');
      vector.add(int.parse(stdin.readLineSync()!));
    }
    print('Vetor inserido: $vector');
  } catch (_) {
    print('Por favor, insira apenas números inteiros.');
  }
}

// Função para criar vetores com base nos valores inseridos pelo usuário e somá-los
void createVectors() {
  stdout.write('Digite o tamanho dos vetores: ');
  try {
    int size = int.parse(stdin.readLineSync()!);
    List<int> v1 = [];
    List<int> v2 = List.generate(size, (index) => Random().nextInt(100));
    List<int> v3 = [];

    print('Digite os elementos do vetor v1:');
    for (int i = 0; i < size; i++) {
      stdout.write('Elemento $i: ');
      v1.add(int.parse(stdin.readLineSync()!));
    }

    for (int i = 0; i < size; i++) {
      v3.add(v1[i] + v2[i]);
    }

    print('v1: $v1');
    print('v2: $v2');
    print('v3: $v3');
  } catch (_) {
    print('Por favor, insira apenas números inteiros.');
  }
}

void main() {
  while (true) {
    // Exibe o menu de opções para o usuário
    print('\nEscolha uma opção:');
    print('1. Criar vetor com números aleatórios');
    print('2. Criar vetor inserindo manualmente');
    print('3. Criar vetores e somar');
    print('4. Sair');

    stdout.write('Opção: ');
    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        createRandomVector();
        break;
      case '2':
        createManualVector();
        break;
      case '3':
        createVectors();
        break;
      case '4':
        print('Saindo do programa.');
        return;
      default:
        print('Opção inválida. Por favor, escolha uma opção válida.');
        break;
    }
  }
}