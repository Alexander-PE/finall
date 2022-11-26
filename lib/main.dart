import 'package:finall/pages/Historia.dart';
import 'package:finall/pages/Inicio.dart';
import 'package:finall/pages/Noticias.dart';
import 'package:finall/pages/Servicios.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  int page = 0;
  List paginas = const [
    Inicio(),
    Historia(),
    Servicios(),
    Noticias()
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Final"), centerTitle: true,),
        drawer: Drawer(
          child: ListView(
            padding: const EdgeInsets.only(top: 40),
            children:  [
              ListTile(title: const Text("Inicio"), onTap: (){
                setState(() {
                  page=0;
                });
              },),
              ListTile(title: const Text("Historia"), onTap: (){
                setState(() {
                  page=1;
                });
              },),
              ListTile(title: const Text("Servicios"), onTap: (){
                setState(() {
                  page=2;
                });
              },),
              ListTile(title: const Text("Noticias"), onTap: (){
                setState(() {
                  page=3;
                });
              },),
          ],),
        ),
        body: paginas[page],
      ),
    );
  }
}