/*
//
//
//
//arquivo destinado apenas a estudo e refazer o curso do decola em flutter (ao termino sera excluido)
//https://m3.material.io/develop/flutter
//
//
import 'package:flutter/material.dart';  //import = importM + tab

// void main(){
//   int valor = 0;
//   runApp(MyApp(title: 'Ap ola mundo', valor: valor)
//     /*
//     MaterialApp(
//       home:Scaffold(  //andaime -> appBar e body
//         appBar:AppBar (
//         title:Text('ap ola mundo',style: TextStyle(fontSize: 40,color: Colors.redAccent.shade700),), // titulo
//         ),
//       body: //corpo
//       Center(
//         child:Text ('olá mundo', style: TextStyle(fontSize: 40, color: Colors.greenAccent.shade700)),
//       ),
//     ),
//     ),
//     */
//   );
//   valor++;
// }



// //estrutura basica do Flutter 
// class MyApp extends StatelessWidget { //statelassW + tab  (statelassW é para uma tela estatica)
// //são widgets que não mudao o estado da interface do usuario, 
// //mantendo a caracteristica do inicio ao fim da aplicação
// //tendo apenas um objeto um widget

// 


// final String title; //parametro para titulo
// final int valor;
//   const MyApp({Key? key, this.title = '', this.valor = 0}): super(key:key); // atenção nessa parte //parametro setado

//   @override
//   Widget build(BuildContext context) { // variaveis de contexto
//     return MaterialApp(
//       home:Scaffold(  //andaime -> appBar e body
//         appBar:AppBar (
//         title:Text(this.title,style: TextStyle(fontSize: 40,color: Colors.redAccent.shade700),), // titulo
//         ),
//       body: //corpo
//       Center(
//         child:Text ('olá mundo o valor é = ' + this.valor.toString(), style: TextStyle(fontSize: 40, color: Colors.greenAccent.shade700)),
//       ),
//     ),
//     );
//   }
// }

void main(){
  runApp(MyApp(nome: 'Pedro'));

}

class MyApp extends StatefulWidget {//Ja o stateful Widget, eles mudam o
// estado da interface durante a aplicação 
// //neste caso vai ter dois objetos 
final String nome;   //<-------------   nome aqui
   const MyApp({Key? key, this.nome = ''}): super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
   int salario = 5000;

void aumentaSlaraio(int valor){
  setState(() {
    this.salario = this.salario +valor;
  });
}
void diminuiSlaraio(int valor){
  setState(() {
    this.salario = this.salario +valor;
  });
}

  @override
  Widget build(BuildContext context) {
    return Center(// aqui pode ser Container ou Material neste caso é Center para Centralizar o Texto
      child: GestureDetector(//vai detectar intereções na tela 
      onTap: (){
        aumentaSlaraio(2000);
       
        // setState((){//para atualizar na tela 
        //      salario = salario +100;
             
        // });
      },
        child: Text( //antes do "Text" apertar Ctrl + . para abrir um menu (Wrap whith widget)
        // vai adicionar uma estrutura de Widget
          'alguma coisa ${widget.nome} é $salario',textDirection: TextDirection.ltr,),
      ), 
      // para referenciar o nome precisa puxar o Widget 
      // ja o salario por estar dentro da mesma classe pode ser puxado sem o widget
      //tambem foi dado o TextDirection para direcionar o texto 
    );
  }
}
*/

// import 'package:flutter/material.dart';
// // primarySwatch: Colors.blue, é basicamente o tema do App

// void main(){
//   runApp(MyApp());
// }
// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}): super(key: key);

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Titulo App'),
//         ),
//         body: Center(
//           child:Column( //Colunm é tudo na coluna
//            mainAxisAlignment: MainAxisAlignment.spaceAround,
//           //  Row( //Row é tudo na mesma linha
//           //   mainAxisAlignment: MainAxisAlignment.spaceAround, //alinhamento do Row
//             children: [
//               Center(
//               child:Text(
//                 'Texto 1',
//                 style: TextStyle(
//                   fontSize: 25),
//                   ),
//               ),
//                Center(
//               child:Text(
//                 'Texto 2',
//                 style: TextStyle(
//                   fontSize: 25),
//                   ),
//               ),
//                Center(
//               child:Text(
//                 'Texto 3',
//                 style: TextStyle(
//                   fontSize: 25),
//                   ),
//               ),
//             ]
//           )),
//         ),
//     );
//   }
// }

// import 'package:flutter/material.dart';

// void main(){
//   runApp(Myapp());
// }

// class Myapp extends StatelessWidget {
//   const Myapp({Key? key}): super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         child: Center(
//           child: Text(
//             'texto',
//           textDirection: TextDirection.ltr,
//           style: TextStyle(
//             fontSize: 50,
//             fontWeight: FontWeight.normal,
//             color: Colors.yellowAccent.shade700,
//           ),
//           ),
//           ),
//         );
// //   }
// // }
// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   List<String> listaProdutos = [];

//   @override
//   void initState() {
//     super.initState();
//     for (int i = 1; i <= 100; i++) {
//       listaProdutos.add('P $i');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('List View'),
//         ),
//         body: ListView.builder(
//           reverse: false, //deixar a lista invertida caso true  
//           itemCount: listaProdutos.length,
//           itemBuilder: (context, indice) {
//             return ListTile(
//               title: Text('${listaProdutos[indice]}'),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
///Text fild 
///
///
import 'package:flutter/material.dart';

enum Genero{
  Masculino,
  Feminino,
  Outro
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String email = '';
  String senha = '';
  bool termos = false;
  Genero genero = Genero.Masculino;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Página de cadastro'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(40.0), // antes do Column foi dado um CTRL + . para criar a padding 
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch, // estica o Botão para a tela inteira 
            children: [
              Text(
                'Insira seus dados',
                style: TextStyle(fontSize: 20),
              ),
              // TextField(), // aqui para escrever na tela 
              // Text('Email'),
              TextField(
                decoration: InputDecoration(
                  labelText: 'E-mail' // a escrita email fica dentro 
                ),
                onChanged: (text) {
                  if (text.contains('@')) {
                    email = text; // armazenar o email
                  }
                },
              ),
              // Text('Senha'),
              TextField(
                obscureText: true, // formulário de senha não mostra a senha 
                decoration: InputDecoration(
                  labelText: 'Senha',
                ),
                onChanged: (text) {
                  senha = text; // armazenar a senha
                },
              ),

                // Radio(value: genero,
                //  groupValue: genero,
                //   onChanged: (Genero generoSelecionado){
                //     setState((){
                //       genero = generoSelecionado; 
                //     });
                //   },
                //   ),





              Row(
                children: [
                  Checkbox(
                    value: termos, // checkbox
                    onChanged: (checked) {
                      setState(() {
                        termos = checked ?? false; // atualizar termos
                      });
                    },
                  ),
                  Text('Concordo'),
                ],
              ),
              // Text('esqueceu a senha ?'),
              ElevatedButton(
                onPressed: () {
                  if (termos && email.isNotEmpty && senha.isNotEmpty) {
                    // lógica para o botão Entrar
                    print('Email: $email, Senha: $senha');
                  } else {
                    // lógica de validação
                    print('Preencha todos os campos e aceite os termos.');
                  }
                },
                child: Text('Entrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// assistir com calma sobre o Radio 

//!!!!!
//aula | | |
//     V V V
//Fluter Navegação com rotas 
