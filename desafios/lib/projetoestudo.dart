import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Modelo de Produto
class Produto {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final Rating rating;

  Produto({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory Produto.fromJson(Map<String, dynamic> json) {
    return Produto(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      description: json['description'],
      category: json['category'],
      image: json['image'],
      rating: Rating.fromJson(json['rating']),
    );
  }
}

class Rating {
  final double rate;
  final int count;

  Rating({required this.rate, required this.count});

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rate: json['rate'].toDouble(),
      count: json['count'],
    );
  }
}

void main() {
  runApp(AppProdutos());
}

class AppProdutos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicativo de Produtos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TelaInicial(),
    );
  }
}

class TelaInicial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela Inicial'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TelaCarrinho()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('Ver Produtos'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TelaProdutos()),
                );
              },
            ),
            ElevatedButton(
              child: Text('Meu Carrinho'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TelaCarrinho()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TelaProdutos extends StatefulWidget {
  @override
  _TelaProdutosState createState() => _TelaProdutosState();
}

class _TelaProdutosState extends State<TelaProdutos> {
  List<Produto> produtos = [];

  Future<void> buscarProdutos() async {
    final resposta = await http.get(Uri.parse('https://fakestoreapi.com/products'));
    if (resposta.statusCode == 200) {
      setState(() {
        produtos = (json.decode(resposta.body) as List)
            .map((data) => Produto.fromJson(data))
            .toList();
      });
    } else {
      throw Exception('Falha ao carregar os produtos');
    }
  }

  @override
  void initState() {
    super.initState();
    buscarProdutos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Produtos'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TelaCarrinho()),
              );
            },
          ),
        ],
      ),
      body: produtos.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: produtos.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: Image.network(produtos[index].image, width: 50, height: 50),
                    title: Text(produtos[index].title),
                    subtitle: Text('Preço: \$${produtos[index].price}'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TelaDetalhesProduto(produto: produtos[index]),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}

class TelaDetalhesProduto extends StatelessWidget {
  final Produto produto;

  TelaDetalhesProduto({required this.produto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(produto.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Reduzindo o tamanho da imagem
            Center(
              child: Image.network(produto.image, width: 150, height: 150),
            ),
            SizedBox(height: 16),
            Text(produto.title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Preço: \$${produto.price}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 8),
            Text(produto.description),
            SizedBox(height: 8),
            Text('Avaliação: ${produto.rating.rate} (${produto.rating.count} avaliações)'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Carrinho.adicionarProduto(produto);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Produto adicionado ao carrinho')));
              },
              child: Text('Adicionar ao Carrinho'),
            ),
          ],
        ),
      ),
    );
  }
}

class Carrinho {
  static List<Produto> itens = [];

  static void adicionarProduto(Produto produto) {
    itens.add(produto);
  }

  static void removerProduto(Produto produto) {
    itens.remove(produto);
  }

  static List<Produto> obterItens() {
    return itens;
  }
}

class TelaCarrinho extends StatefulWidget {
  @override
  _TelaCarrinhoState createState() => _TelaCarrinhoState();
}

class _TelaCarrinhoState extends State<TelaCarrinho> {
  @override
  Widget build(BuildContext context) {
    var itensCarrinho = Carrinho.obterItens();

    return Scaffold(
      appBar: AppBar(
        title: Text('Meu Carrinho'),
      ),
      body: itensCarrinho.isEmpty
          ? Center(child: Text('Seu carrinho está vazio'))
          : ListView.builder(
              itemCount: itensCarrinho.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: Image.network(itensCarrinho[index].image, width: 50, height: 50),
                    title: Text(itensCarrinho[index].title),
                    subtitle: Text('Preço: \$${itensCarrinho[index].price}'),
                    trailing: IconButton(
                      icon: Icon(Icons.remove_circle_outline),
                      onPressed: () {
                        setState(() {
                          Carrinho.removerProduto(itensCarrinho[index]);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}