import 'dart:io'; // Importa a biblioteca padrão de entrada e saída
import 'dart:math'; // Importa a biblioteca matemática para cálculos

void main() {
  bool sair = false; // Variável para controlar se o usuário deseja sair 

  while (!sair) { // Loop principal do programa, variavel not null 
    // Exibe o menu de opções para o usuário
    print('\nEscolha uma opção:');///n pula linha 
    print('1 - Calcular maior lado de um triângulo retângulo');
    print('2 - Converter número decimal para binário, octal e hexadecimal');
    print('3 - Calcular raízes usando a fórmula de Bhaskara');
    print('0 - Sair');

    String? entrada = stdin.readLineSync(); // Lê a entrada do usuário que pode ser nulo por conta do '?'
    if (entrada == null) { // Verifica se a entrada é nula 
      print('Entrada inválida!'); // Informa ao usuário que a entrada é inválida
      continue; // Volta para o início do loop
    }

    int opcao = int.tryParse(entrada) ?? -1; // Converte a entrada para um número inteiro, -1 se não for um número

    if (opcao == 0) { // Se a opção escolhida for 0, define a variável 'sair' como verdadeira
      sair = true;
    } else if (opcao == 1) { // Se a opção escolhida for 1, calcula o maior lado de um triângulo retângulo
      print('Digite o comprimento dos dois catetos:');
      double? cateto1 = double.tryParse(stdin.readLineSync()!); // Lê o primeiro cateto
      double? cateto2 = double.tryParse(stdin.readLineSync()!); // Lê o segundo cateto
      if (cateto1 == null || cateto2 == null) { // Verifica se alguma entrada é inválida
        print('Entrada inválida!');
        continue;
      }
      double maiorLado = sqrt(pow(cateto1, 2) + pow(cateto2, 2)); // Calcula o maior lado do triângulo
      print('O comprimento do maior lado do triângulo é: $maiorLado'); // Exibe o resultado
    } else if (opcao == 2) { // Se a opção escolhida for 2, converte um número decimal para binário, octal e hexadecimal
      print('Digite um número decimal:');
      int? numeroDecimal = int.tryParse(stdin.readLineSync()!); // Lê o número decimal
      if (numeroDecimal == null) { // Verifica se a entrada é inválida
        print('Entrada inválida!');
        continue;
      }
      // Converte o número para binário, octal e hexadecimal e exibe os resultados
      print('Decimal: $numeroDecimal');
      print('Binário: ${numeroDecimal.toRadixString(2)}');
      print('Octal: ${numeroDecimal.toRadixString(8)}');
      print('Hexadecimal: ${numeroDecimal.toRadixString(16)}');
    } else if (opcao == 3) { // Se a opção escolhida for 3, calcula as raízes usando a fórmula de Bhaskara
      print('Digite os coeficientes (a, b e c) da equação quadrática:');
      double? a = double.tryParse(stdin.readLineSync()!); // Lê o coeficiente 'a'
      double? b = double.tryParse(stdin.readLineSync()!); // Lê o coeficiente 'b'
      double? c = double.tryParse(stdin.readLineSync()!); // Lê o coeficiente 'c'
      if (a == null || b == null || c == null) { // Verifica se alguma entrada é inválida
        print('Entrada inválida!');
        continue;
      }
      double delta = pow(b, 2) - 4 * a * c; // Calcula o delta
      if (delta < 0) { // Verifica se não existem raízes reais
        print('Não existem raízes reais.');
      } else if (delta == 0) { // Verifica se existe uma raiz real
        double x = -b / (2 * a);
        print('A única raiz real é: $x');
      } else { // Caso contrário, calcula as duas raízes reais
        double x1 = (-b + sqrt(delta)) / (2 * a);
        double x2 = (-b - sqrt(delta)) / (2 * a);
        print('As raízes reais são: $x1 e $x2');
      }
    } else { // Se a opção escolhida não for válida
      print('Opção inválida. Escolha uma opção válida.');
    }
  }
}