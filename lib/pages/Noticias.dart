import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:url_launcher/url_launcher.dart';


class Noticias extends StatefulWidget {
  const Noticias({super.key});

  @override
  State<Noticias> createState() => _NoticiasState();
}

class _NoticiasState extends State<Noticias> {
  var data = [];
  var cant = 0;

  Future<void> getNoticias() async {
    try {
      var response = await Dio().get('https://adamix.net/defensa_civil/def/noticias.php');
      data = response.data['datos'];
      cant = response.data['datos'].length;
      setState(() {});
      // print(response.data['datos'][0]['nombre']);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    getNoticias();
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cant,
              itemBuilder: (context, index){
                return BuildCard(index, data, context);
              },
            ),
          )
        ],
      ),
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
      Text(data[index]['titulo'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
      InkWell(
        child: const Text("VER", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Noticia(titulo: data[index]["titulo"], desc: data[index]["contenido"]))),
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


class Noticia extends StatelessWidget {
  final String titulo;
  final String desc;

  const Noticia({super.key, required this.titulo, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titulo),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(children: [
          Text(
            desc,
            style: const TextStyle(fontSize: 13),
          ),
        ]),
      ),
    );
  }
}
