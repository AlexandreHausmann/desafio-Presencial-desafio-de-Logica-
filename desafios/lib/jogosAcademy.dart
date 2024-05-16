import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: AppJogosAcademy(),
    ),
  );
}

class AppJogosAcademy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jogos Academy',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: Provider.of<ThemeProvider>(context).getThemeMode(),
      home: TelaInicial(),
    );
  }
}
class TelaInicial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Jogos Academy',
          style: TextStyle(fontSize: 24), // Título maior
        ),
        actions: [
          IconButton(
            onPressed: () {
              final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
              themeProvider.toggleTheme();
            },
            icon: Icon(Icons.brightness_4), // Ícone para alternar o tema
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200, // Defina a largura desejada para os botões
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TelaJogoDaVelha()), // Navega para o jogo da velha
                  );
                },
                child: Text('Jogo da Velha',
                style: TextStyle(
                  fontSize: 25
                ),),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 20), // Ajuste o padding conforme necessário
                  backgroundColor: Colors.blue, // Cor diferenciada
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 200, // Defina a mesma largura para todos os botões
              child: ElevatedButton(
                onPressed: () {
                  // Navegue para o jogo da forca
                },
                child: Text('Jogo da Forca',
                style: TextStyle(
                  fontSize: 25),),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 20), // Ajuste o padding conforme necessário
                  backgroundColor: Colors.blue, // Cor diferenciada
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 200, // Defina a mesma largura para todos os botões
              child: ElevatedButton(
                onPressed: () {
                  // Navegue para a página de termos
                },
                child: Text('Termo',style: TextStyle(
                  fontSize: 25),),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 20), // Ajuste o padding conforme necessário
                  backgroundColor: Colors.blue, // Cor diferenciada
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 200, // Defina a mesma largura para todos os botões
              child: ElevatedButton(
                onPressed: () {
                  // Navegue para a tela do Batalha Naval
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TelaBatalhaNaval()),
                  );
                },
                child: Text('Batalha Naval',style: TextStyle(
                  fontSize: 25),),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 20), // Ajuste o padding conforme necessário
                  backgroundColor: Colors.blue, // Cor diferenciada
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Jogo da Velha 

class TelaJogoDaVelha extends StatefulWidget {
  @override
  _TelaJogoDaVelhaState createState() => _TelaJogoDaVelhaState();
}

class _TelaJogoDaVelhaState extends State<TelaJogoDaVelha> {
  List<List<String>> _tabuleiro = List.generate(3, (_) => List.filled(3, ' '));
  bool _jogadorXVez = true; // Indica se é a vez do jogador X
  int _jogadasRealizadas = 0;
  int _vitoriasJogadorX = 0;
  int _vitoriasJogadorO = 0;
  int _empates = 0;

  void _realizarJogada(int linha, int coluna) {
    if (_tabuleiro[linha][coluna] == ' ') {
      setState(() {
        // Define o símbolo do jogador atual na célula clicada
        _tabuleiro[linha][coluna] = _jogadorXVez ? 'X' : 'O';
        // Verifica se houve um vencedor
        if (_verificarVencedor(linha, coluna)) {
          _mostrarResultado('Vitória do Jogador ' + (_jogadorXVez ? 'X' : 'O'));
          _atualizarContadorVitorias(_jogadorXVez);
          return;
        }
        // Incrementa o número de jogadas realizadas
        _jogadasRealizadas++;
        // Se chegou a 9 jogadas e não houve vencedor, deu velha
        if (_jogadasRealizadas == 9) {
          _mostrarResultado('Deu Velha!');
          _atualizarContadorEmpates();
          return;
        }
        // Alterna para o próximo jogador
        _jogadorXVez = !_jogadorXVez;
      });
    }
  }

  bool _verificarVencedor(int linha, int coluna) {
    String jogadorAtual = _tabuleiro[linha][coluna];
    // Verifica se há três símbolos iguais na linha
    if (_tabuleiro[linha].every((element) => element == jogadorAtual)) return true;
    // Verifica se há três símbolos iguais na coluna
    if (_tabuleiro.every((element) => element[coluna] == jogadorAtual)) return true;
    // Verifica se há três símbolos iguais na diagonal principal
    if (_tabuleiro.every((element) => element[_tabuleiro.indexOf(element)] == jogadorAtual)) return true;
    // Verifica se há três símbolos iguais na diagonal secundária
    if (_tabuleiro.every((element) => element[2 - _tabuleiro.indexOf(element)] == jogadorAtual)) return true;
    return false;
  }

  void _mostrarResultado(String resultado) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Resultado'),
          content: Text(resultado),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _resetarJogo();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _resetarJogo() {
    setState(() {
      _tabuleiro = List.generate(3, (_) => List.filled(3, ' '));
      _jogadorXVez = true;
      _jogadasRealizadas = 0;
    });
  }

  void _atualizarContadorVitorias(bool jogadorX) {
    setState(() {
      if (jogadorX) {
        _vitoriasJogadorX++;
      } else {
        _vitoriasJogadorO++;
      }
    });
  }

  void _atualizarContadorEmpates() {
    setState(() {
      _empates++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double tamanhoCelula = MediaQuery.of(context).size.width * 0.1;

    return Scaffold(
      appBar: AppBar(
        title: Text('Jogo da Velha'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              _jogadorXVez ? 'Vez do Jogador X' : 'Vez do Jogador O',
              style: TextStyle(
                fontSize: 20, 
                fontWeight: FontWeight.bold,
              color: _jogadorXVez ? Colors.redAccent : Colors.blueAccent),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (linha) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (coluna) {
                    return GestureDetector(
                      onTap: () {
                        _realizarJogada(linha, coluna);
                      },
                      child: Container(
                        width: tamanhoCelula,
                        height: tamanhoCelula,
                        margin: EdgeInsets.all(5), // Adiciona margem
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: _getCorCelula(linha, coluna),
                        ),
                        child: Center(
                          child: Text(
                            _tabuleiro[linha][coluna],
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    );
                  }),
                );
              }),
            ),
          ),
          SizedBox(height: 20),
          Text('Vitórias do jogador X = $_vitoriasJogadorX',
           style: TextStyle(
            color: Colors.red),),
          Text('Vitórias do jogador O = $_vitoriasJogadorO',
          style: TextStyle(
            color: Colors.blue),),
          Text('Empates = $_empates'),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _vitoriasJogadorX = 0;
                _vitoriasJogadorO = 0;
                _empates = 0;
              });
            },
            child: Text('Resetar placar'),
          ),
        ],
      ),
    );
  }

  Color _getCorCelula(int linha, int coluna) {
    if (_tabuleiro[linha][coluna] == 'X') {
      return Colors.red;
    } else if (_tabuleiro[linha][coluna] == 'O') {
      return Colors.blue;
    } else {
      return Colors.white;
    }
  }
}

//jogo da forca


//Termo







//Batalha Naval 
class TelaBatalhaNaval extends StatefulWidget {
  @override
  _TelaBatalhaNavalState createState() => _TelaBatalhaNavalState();
}

class _TelaBatalhaNavalState extends State<TelaBatalhaNaval> {
  final List<String> _dificuldades = ['Fácil', 'Médio', 'Difícil'];
  final Map<String, Map<String, int>> _numBarcos = {
    'Fácil': {'Pequenos': 5, 'Médios': 3, 'Grandes': 1},
    'Médio': {'Pequenos': 8, 'Médios': 5, 'Grandes': 2},
    'Difícil': {'Pequenos': 7, 'Médios': 2, 'Grandes': 3},
  };
  String _dificuldadeSelecionada = 'Fácil';
  late Tabuleiro _tabuleiro;
  int _jogadasRestantes = 0;
  List<String> _quadradosClicados = [];

  @override
  void initState() {
    super.initState();
    _iniciarJogo();
  }

  void _iniciarJogo() {
    setState(() {
      _tabuleiro = Tabuleiro(_numBarcos[_dificuldadeSelecionada]!);
      _jogadasRestantes = _tabuleiro.jogadasRestantes;
      _quadradosClicados.clear(); // Limpa a lista de quadrados clicados
    });
  }

  void _resetJogo() {
    _iniciarJogo();
  }

  void _clicarCelula(int linha, int coluna) {
    if (!_quadradosClicados.contains('$linha-$coluna')) {
      setState(() {
        _quadradosClicados.add('$linha-$coluna');
        _jogadasRestantes--;
        if (_tabuleiro.grid[linha][coluna] == 'B') {
          // Se acertou o navio
          _tabuleiro.grid[linha][coluna] = 'X'; // Marca a célula como acertada
        } else {
          // Se errou o navio
          _tabuleiro.grid[linha][coluna] = 'O'; // Marca a célula como errada
        }
      });
    }
  }

  Widget _buildTabuleiro() {
    final double tamanhoCelula = MediaQuery.of(context).size.width * 0.06;
    return Column(
      children: [
        // Linha para as letras de A a J
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(11, (index) {
            if (index == 0) {
              // Espaço vazio no canto superior esquerdo
              return Container(
                width: tamanhoCelula,
                height: tamanhoCelula,
                alignment: Alignment.center,
              );
            }
            return Container(
              width: tamanhoCelula,
              height: tamanhoCelula,
              alignment: Alignment.center,
              child: Text(
                String.fromCharCode('A'.codeUnitAt(0) + index - 1),
                style: TextStyle(fontSize: 12),
              ),
            );
          }),
        ),
        // Grid principal
        ...List.generate(10, (linhaIndex) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Números de 1 a 10 à esquerda
              Container(
                width: tamanhoCelula,
                height: tamanhoCelula,
                alignment: Alignment.center,
                child: Text(
                  '${linhaIndex + 1}',
                  style: TextStyle(fontSize: 12),
                ),
              ),
              // Células do tabuleiro
              ...List.generate(10, (colunaIndex) {
                return GestureDetector(
                  onTap: () {
                    _clicarCelula(linhaIndex, colunaIndex);
                  },
                  child: Container(
                    key: Key('$linhaIndex-$colunaIndex'),
                    width: tamanhoCelula,
                    height: tamanhoCelula,
                    margin: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: _getCorCelula(linhaIndex, colunaIndex),
                      border: Border.all(color: Colors.black),
                    ),
                  ),
                );
              }),
            ],
          );
        }),
      ],
    );
  }

  Color _getCorCelula(int linha, int coluna) {
    if (_tabuleiro.grid[linha][coluna] == 'X') {
      // Celula acertada
      return Colors.green;
    } else if (_tabuleiro.grid[linha][coluna] == 'O') {
      // Celula errada
      return Colors.red;
    } else {
      // Celula não clicada
      return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Batalha Naval'),
        actions: [
          IconButton(
            onPressed: _resetJogo,
            icon: Icon(Icons.refresh), // Ícone para resetar o jogo
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
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
    _grid = List.generate(10, (_) => List.filled(10, ' '));
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





class ThemeProvider with ChangeNotifier {
  late ThemeMode _themeMode;

  ThemeProvider() {
    _loadTheme();
  }

  ThemeMode getThemeMode() => _themeMode;

  void _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isDarkMode = prefs.getBool('isDarkMode');
    _themeMode = isDarkMode != null ? (isDarkMode ? ThemeMode.dark : ThemeMode.light) : ThemeMode.system;
    notifyListeners();
  }

  void _saveTheme(bool isDarkMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', isDarkMode);
  }
//inicia como dark
  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    _saveTheme(_themeMode == ThemeMode.dark);
    notifyListeners();
  }
}


//oque deve ser feito ainda 

//implementar o jogo da forca 
//implementar o termo 
//separar os jogos por arquivos 
//colocar imagens 
//corrigir bugs (jogo da velha quando aparece a notificação de vencedor ou empate se clicado fora buga a aplicação)
//melhorar o visual da tela de botões 
//
//