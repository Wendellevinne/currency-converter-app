import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

final Uri api = Uri.parse("https://api.hgbrasil.com/finance?key=fd3a84f4");

void main() async {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

Future<Map> getData() async {
  http.Response response = await http.get(api);
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "\$ Conversor \$",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(
                child: Text(
                  "Carregando...",
                  style: TextStyle(color: Colors.amber, fontSize: 25),
                  textAlign: TextAlign.center,
                ),
              );
            default:
              if (snapshot.hasError) {
                return const Center(
                  child: Text(
                    "Não foi possível carregar os dados",
                    style: TextStyle(color: Colors.amber, fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                return Container(
                  color: Colors.green,
                );
              }
          }
        },
      ),
    );
  }
}
