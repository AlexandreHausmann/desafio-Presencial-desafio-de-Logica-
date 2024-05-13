import 'dart:io';

void main() {
  // Solicita as dimensões da matriz
  print('Digite o número de linhas da matriz:');
  int linhasMatriz = int.parse(stdin.readLineSync()!);

  print('Digite o número de colunas da matriz:');
  int colunasMatriz = int.parse(stdin.readLineSync()!);

  // Cria a matriz vazia
  List<List<double>> matriz = criarMatriz(linhasMatriz, colunasMatriz);

  // Preenche a matriz com os valores fornecidos pelo usuário
  preencherMatriz(matriz);

  // Imprime a matriz original
  print('Matriz original:');
  imprimirMatriz(matriz);

  // Solicita um número real para o usuário
  print('Digite um número real para multiplicar a matriz:');
  double multiplicador = double.parse(stdin.readLineSync()!);

  // Multiplica a matriz pelo número real
  List<List<double>> matrizMultiplicada = multiplicarMatriz(matriz, multiplicador);

  // Imprime a matriz multiplicada
  print('Matriz multiplicada:');
  imprimirMatriz(matrizMultiplicada);

  // Solicita as dimensões da primeira matriz
  print('Digite o número de linhas da primeira matriz:');
  int linhasMatriz1 = int.parse(stdin.readLineSync()!);

  print('Digite o número de colunas da primeira matriz:');
  int colunasMatriz1 = int.parse(stdin.readLineSync()!);

  // Solicita as dimensões da segunda matriz
  print('Digite o número de linhas da segunda matriz:');
  int linhasMatriz2 = int.parse(stdin.readLineSync()!);

  print('Digite o número de colunas da segunda matriz:');
  int colunasMatriz2 = int.parse(stdin.readLineSync()!);

  // Verifica se as dimensões são compatíveis para multiplicação de matriz
  if (colunasMatriz1 != linhasMatriz2) {
    print('Erro: O número de colunas da primeira matriz deve ser igual ao número de linhas da segunda matriz para multiplicação.');
    return;
  }

  // Cria e preenche a primeira matriz
  List<List<double>> primeiraMatriz = criarMatriz(linhasMatriz1, colunasMatriz1);
  print('Digite os valores da primeira matriz:');
  preencherMatriz(primeiraMatriz);

  // Cria e preenche a segunda matriz
  List<List<double>> segundaMatriz = criarMatriz(linhasMatriz2, colunasMatriz2);
  print('Digite os valores da segunda matriz:');
  preencherMatriz(segundaMatriz);

  // Calcula o produto das matrizes
  List<List<double>> produtoMatrizes = multiplicarMatrizes(primeiraMatriz, segundaMatriz);

  // Imprime as matrizes originais e a matriz produto
  print('\nPrimeira matriz:');
  imprimirMatriz(primeiraMatriz);
  print('\nSegunda matriz:');
  imprimirMatriz(segundaMatriz);
  print('\nProduto das matrizes:');
  imprimirMatriz(produtoMatrizes);
}

List<List<double>> criarMatriz(int linhas, int colunas) {
  return List.generate(linhas, (_) => List.filled(colunas, 0));
}

void preencherMatriz(List<List<double>> matriz) {
  for (int i = 0; i < matriz.length; i++) {
    for (int j = 0; j < matriz[i].length; j++) {
      print('Digite o valor para a posição ($i, $j):');
      matriz[i][j] = double.parse(stdin.readLineSync()!);
    }
  }
}

void imprimirMatriz(List<List<double>> matriz) {
  for (int i = 0; i < matriz.length; i++) {
    for (int j = 0; j < matriz[i].length; j++) {
      stdout.write('${matriz[i][j]}\t');
    }
    stdout.write('\n');
  }
}

List<List<double>> multiplicarMatriz(List<List<double>> matriz, double multiplicador) {
  List<List<double>> matrizMultiplicada = List.generate(matriz.length, (i) => List.filled(matriz[i].length, 0.0));

  for (int i = 0; i < matriz.length; i++) {
    for (int j = 0; j < matriz[i].length; j++) {
      matrizMultiplicada[i][j] = matriz[i][j] * multiplicador;
    }
  }

  return matrizMultiplicada;
}

List<List<double>> multiplicarMatrizes(List<List<double>> primeiraMatriz, List<List<double>> segundaMatriz) {
  int linhasPrimeiraMatriz = primeiraMatriz.length;
  int colunasPrimeiraMatriz = primeiraMatriz[0].length;
  int linhasSegundaMatriz = segundaMatriz.length;
  int colunasSegundaMatriz = segundaMatriz[0].length;

  List<List<double>> produtoMatrizes = List.generate(linhasPrimeiraMatriz, (_) => List.filled(colunasSegundaMatriz, 0));

  for (int i = 0; i < linhasPrimeiraMatriz; i++) {
    for (int j = 0; j < colunasSegundaMatriz; j++) {
      double soma = 0;
      for (int k = 0; k < colunasPrimeiraMatriz; k++) {
        soma += primeiraMatriz[i][k] * segundaMatriz[k][j];
      }
      produtoMatrizes[i][j] = soma;
    }
  }

  return produtoMatrizes;
}

// falta refatorara alguams coisas apenas upando o código para acompanhamento do Academy