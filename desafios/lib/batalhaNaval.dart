import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(BatalhaNavalApp());
}

class BatalhaNavalApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Batalha Naval',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BatalhaNavalScreen(),
    );
  }
}

class BatalhaNavalScreen extends StatefulWidget {
  @override
  _BatalhaNavalScreenState createState() => _BatalhaNavalScreenState();
}

class _BatalhaNavalScreenState extends State<BatalhaNavalScreen> {
  final List<String> _dificuldades = ['Fácil', 'Médio', 'Difícil'];
  final Map<String, Map<String, int>> _numBarcos = {
    'Fácil': {'Pequenos': 5, 'Médios': 3, 'Grandes': 1},
    'Médio': {'Pequenos': 8, 'Médios': 5, 'Grandes': 2},
    'Difícil': {'Pequenos': 7, 'Médios': 2, 'Grandes': 3},
  };
  String _dificuldadeSelecionada = 'Fácil';
  late Tabuleiro _tabuleiro;
  int _jogadasRestantes = 0;

  @override
  void initState() {
    super.initState();
    _iniciarJogo();
  }

  void _iniciarJogo() {
    setState(() {
      _tabuleiro = Tabuleiro(_numBarcos[_dificuldadeSelecionada]!);
      _jogadasRestantes = _tabuleiro.jogadasRestantes;
    });
  }

  Widget _buildTabuleiro() {
    final double tamanhoCelula = MediaQuery.of(context).size.width * 0.06;
    return Column(
      children: _tabuleiro.grid.asMap().entries.map((linhaEntry) {
        int linhaIndex = linhaEntry.key;
        List<String> linha = linhaEntry.value;
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: linha.asMap().entries.map((celulaEntry) {
            int colunaIndex = celulaEntry.key;
            String celula = celulaEntry.value;
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (celula == 'B') {
                    // Clicou em um barco
                    _tabuleiro.grid[linhaIndex][colunaIndex] = 'X';
                  } else {
                    // Clicou em uma posição vazia
                    _tabuleiro.grid[linhaIndex][colunaIndex] = 'O';
                  }
                  _jogadasRestantes--;
                });
              },
              child: Container(
                key: Key('$linhaIndex-$colunaIndex'),
                width: tamanhoCelula,
                height: tamanhoCelula,
                margin: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: celula == 'O' ? Colors.red : celula == 'X' ? Colors.green : Colors.blue,
                  border: Border.all(color: Colors.black),
                ),
              ),
            );
          }).toList(),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Batalha Naval'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<String>(
              value: _dificuldadeSelecionada,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _dificuldadeSelecionada = newValue;
                    _iniciarJogo();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Nível de dificuldade: $_dificuldadeSelecionada'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  });
                }
              },
              items: _dificuldades.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Jogadas restantes: $_jogadasRestantes'),
              ],
            ),
            SizedBox(height: 10),
            _tabuleiro != null ? _buildTabuleiro() : Container(), // Adiciona este condicional para evitar a renderização antes de iniciar o jogo
          ],
        ),
      ),
    );
  }
}

class Tabuleiro {
  late List<List<String>> _grid;
  late int _jogadasRestantes;

  Tabuleiro(Map<String, int> numBarcos) {
    _grid = List.generate(6, (_) => List.filled(14, ' '));
    _adicionarBarcos(numBarcos);
    _jogadasRestantes = _grid.length * _grid[0].length;
  }

  List<List<String>> get grid => _grid;
  int get jogadasRestantes => _jogadasRestantes;

  void _adicionarBarcos(Map<String, int> numBarcos) {
    numBarcos.forEach((tamanho, quantidade) {
      for (int i = 0; i < quantidade; i++) {
        _adicionarBarco(tamanho);
      }
    });
  }

  void _adicionarBarco(String tamanho) {
    bool adicionado = false;
    while (!adicionado) {
      int linha = _gerarNumeroAleatorio(0, _grid.length - 1);
      int coluna = _gerarNumeroAleatorio(0, _grid[0].length - 1);
      bool horizontal = _gerarNumeroAleatorio(0, 1) == 0;
      if (_podeAdicionarBarco(linha, coluna, tamanho, horizontal)) {
        _adicionarBarcoNaPosicao(linha, coluna, tamanho, horizontal);
        adicionado = true;
      }
    }
  }

  bool _podeAdicionarBarco(int linha, int coluna, String tamanho, bool horizontal) {
    int tamanhoBarco = tamanho == 'Pequenos'
        ? 2
        : tamanho == 'Médios'
            ? 3
            : 4;
    if (horizontal) {
      if (coluna + tamanhoBarco > _grid[0].length) {
        return false;
      }
      for (int i = coluna; i < coluna + tamanhoBarco; i++) {
        if (_grid[linha][i] != ' ') {
          return false;
        }
      }
    } else {
      if (linha + tamanhoBarco > _grid.length) {
        return false;
      }
      for (int i = linha; i < linha + tamanhoBarco; i++) {
        if (_grid[i][coluna] != ' ') {
          return false;
        }
      }
    }
    return true;
  }

  void _adicionarBarcoNaPosicao(int linha, int coluna, String tamanho, bool horizontal) {
    int tamanhoBarco = tamanho == 'Pequenos'
        ? 2
        : tamanho == 'Médios'
            ? 3
            : 4;
    if (horizontal) {
      for (int i = coluna; i < coluna + tamanhoBarco; i++) {
        _grid[linha][i] = 'B';
      }
    } else {
      for (int i = linha; i < linha + tamanhoBarco; i++) {
        _grid[i][coluna] = 'B';
      }
    }
  }

  int _gerarNumeroAleatorio(int min, int max) {
    final Random random = Random();
    return min + random.nextInt(max - min + 1);
  }
}

// falta fazer algumas validações apenas upando o código para acompanhamento do Academy