import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Miembros extends StatefulWidget {
  const Miembros({super.key});

  @override
  State<Miembros> createState() => _MiembrosState();
}

class _MiembrosState extends State<Miembros> {

  var data = [];
  var cant = 0;

  Future<void> getMiembros() async {
    try {
      var response = await Dio().get('https://adamix.net/defensa_civil/def/miembros.php');
      data = response.data['datos'];
      cant = response.data['datos'].length;
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    getMiembros();
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cant,
              itemBuilder: (context, index){
                return Column(
                  children: [
                    Text("${data[index]['nombre']} - ${data[index]['cargo']}", style: const TextStyle(fontSize: 25),),
                    Image(image: NetworkImage(data[index]['foto']), width: 400, height: 400,),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}



