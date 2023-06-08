import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController txtcep = new TextEditingController();
  var resultado;

  _consultaCep() async {
    // Peguei o cep digitado no campo de texto
    String cep = txtcep.text;
    // Configurando a url
    String url = "https://viacep.com.br/ws/${cep}/json/";
    // Criando uma requisição
    http.Response response;
    response = await http.get(Uri.parse(url));

    // dicionário de dados
    Map<String, dynamic> retorno = json.decode(response.body);

    String logradouro = retorno["logradouro"];
    String cidade = retorno["localidade"];
    String bairro = retorno["bairro"];
    String uf = retorno["uf"];

    // atualizar os dados na tela
    setState(() {
      resultado = "${logradouro}, ${bairro}, ${cidade}, ${uf}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consultando um CEP via API"),
        backgroundColor: Colors.blue,
      ),
      body: Container(
          padding: EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Digite o Cep ex: 1833400",
                ),
                style: TextStyle(fontSize: 15),
                controller: txtcep,
              ),
              Text(
                "Resultado: ${resultado}",
                style: TextStyle(fontSize: 25),
              ),
              ElevatedButton(
                child: Text(
                  "Consultar",
                  style: TextStyle(fontSize: 15),
                ),
                onPressed: _consultaCep,
              ),
            ],
          )),
    );
  }
}
