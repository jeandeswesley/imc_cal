import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Cria os controllers
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  //Declarando chave global para validação de formulario
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  //final formKey = GlobalKey<FormState>();

  //Variavel que informa o teste de informação abaixo do botão calcular
  String _infoText = "Informe seus dados!";

  //Cria função que realiza o reset do botão na appBar
  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seu peso e altura";
      formKey = GlobalKey<FormState>();
    });
  }

  //Função que realiza o calculo do IMC
  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);

      if (imc < 18.6) {
        _infoText = "Abaixo do Peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Peso Ideal (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = "Levemente acima do peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 40) {
        _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //Implementa a AppBar (barra do topo do app)
        appBar: AppBar(
            title: Text('BORA DEV!!'), //Informa um texto na barra
            centerTitle: true, //Centraliza o texto na barra
            backgroundColor: Colors.blueGrey, //Coloca a cor na barra
            //Implementa o botâo de refresh no canto da barra
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: _resetFields,
              ),
            ]),
        backgroundColor: Colors.white, //Coloca cor no corpo da página
        //Cria um body em forma de coluna
        body: SingleChildScrollView(
          //Insere o scroll na tela
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0,
              0.0), //Coloca borda(padding) entre o texto e botões
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(
                  Icons.person_outline,
                  size: 120.0,
                  color: Colors.blueGrey,
                ),

                //Input Peso
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Peso (kg)",
                    labelStyle: TextStyle(color: Colors.blueGrey),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blueGrey, fontSize: 24.0),

                  controller: weightController, //Chama o controller

                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Insira um Peso";
                    }
                  },
                ),

                //Input Altura
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Altura (cm)",
                    labelStyle: TextStyle(color: Colors.blueGrey),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blueGrey, fontSize: 24.0),

                  controller: heightController, //Chama o controller

                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Insira uma altura";
                    }
                  },
                ),

                //Button Calcular
                Padding(
                  padding: EdgeInsets.only(
                      top: 10.0,
                      bottom:
                          10.0), //Insere um padding entre a linha do campo altura e o botão
                  child: Container(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        formKey.currentState?.validate();
                        _calculate();
                      },

                      child: Text(
                        "Calcular",
                        style: TextStyle(color: Colors.white, fontSize: 24.0),
                      ),
                      //Cor do botão
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blueGrey,
                      ),
                    ),
                  ),
                ),
                //Texto informativo abaixo do botão calcular
                Text(
                  _infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blueGrey, fontSize: 24.0),
                )
              ],
            ),
          ),
        ));
  }
}
