import 'package:finall/pages/Cambiar.dart';
import 'package:finall/pages/Noticias.dart';
import 'package:finall/pages/Reportar.dart';
import 'package:finall/pages/Situaciones.dart';
import 'package:flutter/material.dart';

class Sesion extends StatefulWidget {
  final data;
  const Sesion({super.key, this.data});

  @override
  State<Sesion> createState() => _SesionState();
}

class _SesionState extends State<Sesion> {
  int page = 0;
  List paginas = [
    Noticias(),
    Reportar(),
    Cambiar(),
    Situaciones()
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text(widget.data['nombre']),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.only(top: 40),
          children: [
            ListTile(
              title: const Text("Noticias"),
              onTap: () {
                setState(() {
                  page = 0;
                });
              },
            ),
            ListTile(
              title: const Text("Reportar"),
              onTap: () {
                setState(() {
                  paginas = [
                    Noticias(),
                    Reportar(token: widget.data['token'])
                  ];
                  page = 1;
                });
              },
            ),
            ListTile(
              title: const Text("Cambiar Clave"),
              onTap: () {
                setState(() {
                  paginas = [
                    Noticias(),
                    Reportar(token: widget.data['token']),
                    Cambiar(token: widget.data['token'])
                  ];
                  page = 2;
                });
              },
            ),
            ListTile(
              title: const Text("Situaciones"),
              onTap: () {
                setState(() {
                  paginas = [
                    Noticias(),
                    Reportar(token: widget.data['token']),
                    Cambiar(token: widget.data['token']),
                    Situaciones(token: widget.data['token'])
                  ];
                  page = 3;
                });
              },
            ),
          ],
        ),
      ),
      body: paginas[page],
    ));
  }
}
