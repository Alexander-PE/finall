import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:io';

class Situaciones extends StatefulWidget {
  final token;
  const Situaciones({super.key, this.token});

  @override
  State<Situaciones> createState() => _SituacionesState();
}

class _SituacionesState extends State<Situaciones> {

  var data = [];
  var cant = 0;

  Future<void> getSituaciones() async { 
      try {
        var formdat = FormData.fromMap({
          'token': widget.token
        });

        Response response = await Dio().post('https://adamix.net/defensa_civil/def/situaciones.php', data: formdat);
        data = response.data['datos'];
        cant = response.data['datos'].length;

        print(response.data.toString());
      } catch (e) {
        print(e);
      }
  }

  @override
  Widget build(BuildContext context){
    getSituaciones();
    return ListView.builder(
              itemCount: cant,
              itemBuilder: (context, index){
                return BuildCard(index, data, context, );
              },
            );
  }
}


Widget BuildCard(int index, List data, context) => Container(
  color: Colors.grey,
  width: double.infinity,
  height: 100,
  child: Center(child: Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(data[index]['titulo'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
      InkWell(
        child: const Text("VER", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Situacion( codigo: data[index]["id"], fecha: data[index]["fecha"], titulo: data[index]['titulo'], desc: data[index]['descripcion'], estado: data[index]['estado']))),
      ),
      const Divider(
            height: 20,
            thickness: 5,
            endIndent: 0,
            color: Colors.white,
          ),
    ],
  )),
);



class Situacion extends StatelessWidget {
  final String codigo;
  final String fecha;
  final String titulo;
  final String desc;
  // final String foto;
  final String estado;

  const Situacion({super.key,  required this.codigo, required this.fecha, required this.titulo, required this.desc, required this.estado});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titulo),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Codigo: $codigo', style: const TextStyle(fontSize: 25),),
              Text('Descripcion: $desc', style: const TextStyle(fontSize: 25),),
              Text('Fecha: $fecha', style: const TextStyle(fontSize: 23),),
              Text('Estado: $estado', style: const TextStyle(fontSize: 25),),
              // Image.file(img, width: 200, height: 200,)
              // Image.memory(foto)
          ]),
        ),
      ),
    );
  }
}
