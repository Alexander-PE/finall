import 'package:finall/pages/Acerca.dart';
import 'package:finall/pages/Albergues.dart';
import 'package:finall/pages/Historia.dart';
import 'package:finall/pages/Inicio.dart';
import 'package:finall/pages/Login.dart';
import 'package:finall/pages/Medidas.dart';
import 'package:finall/pages/Miembros.dart';
import 'package:finall/pages/Noticias.dart';
import 'package:finall/pages/Registrar.dart';
import 'package:finall/pages/Servicios.dart';
import 'package:finall/pages/Videos.dart';
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
    Noticias(),
    Videos(),
    Albergues(),
    Medidas(),
    Miembros(),
    Registrar(),
    Acerca(),
    LoginPage()
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
              ListTile(title: const Text("Videos"), onTap: (){
                setState(() {
                  page=4;
                });
              },),
              ListTile(title: const Text("Albergues"), onTap: (){
                setState(() {
                  page=5;
                });
              },),
              ListTile(title: const Text("Medidas"), onTap: (){
                setState(() {
                  page=6;
                });
              },),
              ListTile(title: const Text("Miembros"), onTap: (){
                setState(() {
                  page=7;
                });
              },),
              ListTile(title: const Text("Registrar"), onTap: (){
                setState(() {
                  page=8;
                });
              },),
              ListTile(title: const Text("Login"), onTap: (){
                setState(() {
                  page=10;
                });
              },),
              ListTile(title: const Text("Acerca"), onTap: (){
                setState(() {
                  page=9;
                });
              },),
          ],),
        ),
        body: paginas[page],
      ),
    );
  }
}
