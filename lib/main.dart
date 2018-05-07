import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

List _dados;

void main() async{

  _dados = await getJson();

  runApp(new MaterialApp(
    home: new Scaffold(
      appBar: new AppBar(
        title: new Text('Tratando JSON'),
        backgroundColor: Colors.orangeAccent,
        centerTitle: true,
      ),
      body: new Center(
        child: new ListView.builder(
          itemCount: _dados.length,
          padding: const EdgeInsets.all(16.0),

          itemBuilder: (BuildContext contexto, int posicao){


            return constroiListView(contexto, posicao);
          },
        ),
      ),
    ),
  ));
}

Widget constroiListView(BuildContext contexto,int posicao) {

  var children = <Widget>[
    new Padding(padding: new EdgeInsets.all(10.0), child: retornaListTile(contexto, posicao)),
    new Divider(height: 5.0),
  ];

  return new Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: children,
  );

}

ListTile retornaListTile(BuildContext contexto, int posicao) {
  return new ListTile(

    title: new Text(
      "${_dados[posicao]['title']}",
      style: new TextStyle(fontSize: 18.9),

    ),
    subtitle: new Text(
      "${_dados[posicao]['body']}",
      style: new TextStyle(
          fontSize: 13.4,
          color: Colors.grey,
          fontStyle: FontStyle.italic
      ),
    ),
    leading: new CircleAvatar(
      //backgroundColor: Colors.green,
      //backgroundImage: new NetworkImage('imagens/cartao.png'),
      child: new Image(image: new AssetImage('imagens/cartao.png')),
      /*child: new Text(
        "${_dados[posicao]['title'][0].toString().toUpperCase()}",
        style: new TextStyle(
            color: Colors.orangeAccent
        ),
      ),*/
    ),
    onTap: () { _mostraMenssagemAoEncostar(contexto, "${_dados[posicao]['id']}","${_dados[posicao]['title']}");},
  );
}

// Esse metodo async, todos os metodos que chamarem ele, tambem deve ser async
Future<List> getJson() async {
  String apiUrl = 'http://jsonplaceholder.typicode.com/posts';

  http.Response response = await http.get(apiUrl); // o await vai pausar a execução

  return json.decode(response.body); // Returna uma lista (List)
}

void _mostraMenssagemAoEncostar(BuildContext contexto, String id, String mensagem){

  var alerta = new AlertDialog(
    title: new Text(id),
    content: new Text(mensagem),
    actions: <Widget>[
      new FlatButton(
          onPressed: (){Navigator.pop(contexto);},
          child: new Text('Ok'))
    ],
  );
  //showDialog(context: contexto, child: alerta);
  showDialog(context: contexto, builder: (contexto) => alerta );
}