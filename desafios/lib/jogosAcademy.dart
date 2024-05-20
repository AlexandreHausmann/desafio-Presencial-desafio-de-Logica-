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
      routes: {
        '/velha':(context) => TelaJogoDaVelha(),
        '/forca': (context) => TelaJogoDaForca(),
        '/termo': (context) => TermoHomePage(),
        '/naval':(context) =>  TelaBatalhaNaval(),
      },
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
          style: TextStyle(fontSize: 24), 
        ),
        actions: [
          IconButton(
            onPressed: () {
              final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
              themeProvider.toggleTheme();
            },
            icon: Icon(Icons.brightness_4), 
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200, 
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TelaJogoDaVelha()), 
                  );
                },
                child: Text('Jogo da Velha',
                  style: TextStyle(
                    fontSize: 25
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 20), 
                  backgroundColor: Colors.blue, 
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 200, 
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/forca'); 
                },
                child: Text('Jogo da Forca',
                  style: TextStyle(
                    fontSize: 25
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 20), 
                  backgroundColor: Colors.blue, 
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 200, 
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/termo'); 
                },
                child: Text('Termo',
                  style: TextStyle(
                    fontSize: 25
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 20), 
                  backgroundColor: Colors.blue, 
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 200, 
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TelaBatalhaNaval()),
                  ); 
                },
                child: Text('Batalha Naval',
                  style: TextStyle(
                    fontSize: 25
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 20), 
                  backgroundColor: Colors.blue, 
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
  bool _jogadorXVez = true; 
  int _jogadasRealizadas = 0;
  int _vitoriasJogadorX = 0;
  int _vitoriasJogadorO = 0;
  int _empates = 0;

  void _realizarJogada(int linha, int coluna) {
    if (_tabuleiro[linha][coluna] == ' ') {
      setState(() {
        _tabuleiro[linha][coluna] = _jogadorXVez ? 'X' : 'O';
        if (_verificarVencedor(linha, coluna)) {
          _mostrarResultado('Vitória do Jogador ' + (_jogadorXVez ? 'X' : 'O'));
          _atualizarContadorVitorias(_jogadorXVez);
          return;
        }
        _jogadasRealizadas++;
        if (_jogadasRealizadas == 9) {
          _mostrarResultado('Deu Velha!');
          _atualizarContadorEmpates();
          return;
        }
        _jogadorXVez = !_jogadorXVez;
      });
    }
  }

  bool _verificarVencedor(int linha, int coluna) {
    String jogadorAtual = _tabuleiro[linha][coluna];
    if (_tabuleiro[linha].every((element) => element == jogadorAtual)) return true;
    if (_tabuleiro.every((element) => element[coluna] == jogadorAtual)) return true;
    if (_tabuleiro.every((element) => element[_tabuleiro.indexOf(element)] == jogadorAtual)) return true;
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
class TelaJogoDaForca extends StatefulWidget {
  @override
  _TelaJogoDaForcaState createState() => _TelaJogoDaForcaState();
}

class _TelaJogoDaForcaState extends State<TelaJogoDaForca> {
  final Map<String, String> _palavras = {
    'GATO': ' Animal doméstico de estimação que gosta de caçar ratos.',
    'SOL': 'Estrela ao redor da qual a Terra orbita.',
    'BOLA': 'Objeto esférico usado em diversos esportes, como futebol e basquete.',
    'AGUA': 'Substância líquida essencial para a vida, composta por hidrogênio e oxigênio.',
    'CASA': 'Lugar onde as pessoas moram, geralmente feito de tijolos, madeira ou concreto.',
    'LIVRO':'Objeto usado para ler e armazenar informações, geralmente composto por páginas de papel.',
    'RATO':'Pequeno roedor conhecido por sua capacidade de se reproduzir rapidamente.',
    'MESA':'Móvel com uma superfície plana e pernas, usado para apoiar objetos.',
    'CHUVA':'Precipitação atmosférica na forma de gotas de água que caem da nuvem para a superfície da Terra.',
    'FLOR':'Estrutura reprodutiva encontrada em plantas, muitas vezes colorida e perfumada.',
    'HIPOTENUSA':'No triângulo retângulo, é o lado oposto ao ângulo reto.',
    'PARADIGMA':'Modelo ou padrão que serve como exemplo ou referência em determinado contexto.',
    'ONIVORO':'Tipo de animal que se alimenta tanto de carne quanto de vegetais.',
    'FOTOSSINTESE':'Processo realizado pelas plantas para converter luz solar, dióxido de carbono e água em energia química.',
    'ANARQUIA':'Ausência de autoridade ou governo centralizado, baseada na liberdade individual e na autonomia dos grupos sociais.',
    'NEANDERTAL':'Espécie extinta de hominídeo que viveu na Europa e no Oriente Médio durante o Paleolítico Médio e Superior.',
    'EQUIDADE':' Princípio de justiça que busca tratar cada pessoa de acordo com suas necessidades específicas e peculiaridades.',
    'ESPLENDOR':' Brilho intenso e radiante; grandeza ou magnificência impressionante.',
    'QUILOMBO':'Assentamento habitado por escravos fugitivos no período colonial brasileiro, que buscavam liberdade e autonomia.',
    'EMBRIAGUEZ':' Estado de intoxicação causado pelo consumo excessivo de álcool ou substâncias psicoativas.'
   //Utilizado o ChatGPT para pegar as palavras com dicas, as 10 primeiras palavras são mais simples, enquanto as 10 ultimas mais complexas.

  };
  late String _palavraSelecionada;
  late String _dica;
  List<String> _letrasCorretas = [];
  List<String> _letrasErradas = [];
  int _tentativasRestantes = 6;

  @override
  void initState() {
    super.initState();
    _palavraSelecionada = _palavras.keys.toList()[Random().nextInt(_palavras.length)];
    _dica = _palavras[_palavraSelecionada]!;
    _letrasCorretas = List.filled(_palavraSelecionada.length, '_');
  }

  void _resetarJogo() {
    setState(() {
      _palavraSelecionada = _palavras.keys.toList()[Random().nextInt(_palavras.length)];
      _dica = _palavras[_palavraSelecionada]!;
      _letrasCorretas = List.filled(_palavraSelecionada.length, '_');
      _letrasErradas.clear();
      _tentativasRestantes = 6;
    });
  }

  void _adivinharLetra(String letra) {
    if (_palavraSelecionada.contains(letra)) {
      setState(() {
        for (int i = 0; i < _palavraSelecionada.length; i++) {
          if (_palavraSelecionada[i] == letra) {
            _letrasCorretas[i] = letra;
          }
        }
        if (!_letrasCorretas.contains('_')) {
          _mostrarResultado('Você venceu!');
        }
      });
    } else {
      setState(() {
        _letrasErradas.add(letra);
        _tentativasRestantes--;
        if (_tentativasRestantes == 0) {
          _mostrarResultado('Você perdeu! A palavra era $_palavraSelecionada.');
        }
      });
    }
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

 Widget _buildLetraButton(String letra) {
    return ElevatedButton(
      onPressed: _letrasCorretas.contains(letra) || _letrasErradas.contains(letra)
          ? null
          : () => _adivinharLetra(letra),
      child: Text(letra),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jogo da Forca'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Tentativas restantes: $_tentativasRestantes',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 20),
          Text(
            _letrasCorretas.join(' '),
            style: TextStyle(fontSize: 30, letterSpacing: 2),
          ),
          SizedBox(height: 20),
          Text(
            'Dica: $_dica', // dica das palavras 
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 20),
          Wrap(
            spacing: 5,
            children: 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('').map(_buildLetraButton).toList(),
          ),
          SizedBox(height: 20),
          Text(
            'Letras erradas: ${_letrasErradas.join(', ')}',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}


//Termo
class TermoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jogo Termo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TermoHomePage(),
    );
  }
}

class TermoHomePage extends StatefulWidget {
  @override
  _TermoHomePageState createState() => _TermoHomePageState();
}

class _TermoHomePageState extends State<TermoHomePage> {
  String palavraSecreta = _gerarPalavra(); // Palavra aleatória
  List<String> letrasSelecionadas = [];

  static String _gerarPalavra() {
    List<String> palavras = ['VENUS', 'CARRO', 'OSSOS', 'FLORE', 'AMIGO'];
    final rand = Random();
    return palavras[rand.nextInt(palavras.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jogo Termo'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Center(
                child: Text(
                  palavraSecreta,
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
          ),
          SizedBox(height: 16.0),
          _buildTeclado(),
        ],
      ),
    );
  }

  Widget _buildTeclado() {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Wrap(
        spacing: 4.0,
        runSpacing: 4.0,
        children: List.generate(
          26,
          (index) {
            final letra = String.fromCharCode('A'.codeUnitAt(0) + index);
            return GestureDetector(
              onTap: () {
                // Ação quando uma letra do teclado é clicada
                setState(() {
                  letrasSelecionadas.add(letra);
                });
              },
              child: Container(
                width: 40.0,
                height: 40.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: letrasSelecionadas.contains(letra)
                      ? Colors.green // Se a letra já foi selecionada, muda para verde
                      : Colors.white,
                  border: Border.all(color: Colors.black),
                ),
                child: Text(letra, style: TextStyle(fontSize: 20)),
              ),
            );
          },
        ),
      ),
    );
  }
}






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
      _quadradosClicados.clear(); 
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
          _tabuleiro.grid[linha][coluna] = 'X'; 
        } else {
          _tabuleiro.grid[linha][coluna] = 'O'; 
        }
      });
    }
  }

  Widget _buildTabuleiro() {
    final double tamanhoCelula = MediaQuery.of(context).size.width * 0.06;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(11, (index) {
            if (index == 0) {
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
        ...List.generate(10, (linhaIndex) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: tamanhoCelula,
                height: tamanhoCelula,
                alignment: Alignment.center,
                child: Text(
                  '${linhaIndex + 1}',
                  style: TextStyle(fontSize: 12),
                ),
              ),
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
      return Colors.green;
    } else if (_tabuleiro.grid[linha][coluna] == 'O') {
      return Colors.red;
    } else {
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
            icon: Icon(Icons.refresh), 
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

//implementar o termo 
//separar os jogos por arquivos 
//colocar imagens 
//corrigir bugs (jogo da velha quando aparece a notificação de vencedor ou empate se clicado fora buga a aplicação)
//melhorar o visual da tela de botões 
//
//fazer um banco de dados para guardar algumas coisas 
//se sobrar tempo acrecentar um jogo de caça palavras e alguns outros joguinhos
//refatorar todos os códigos e testar tudo um por um 