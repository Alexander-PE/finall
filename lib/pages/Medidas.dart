import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Medidas extends StatefulWidget {
  const Medidas({super.key});

  @override
  State<Medidas> createState() => _MedidasState();
}

class _MedidasState extends State<Medidas> {

  var data = [];
  var cant = 0;

  Future<void> getMedidas() async {
    try {
      var response = await Dio().get('https://adamix.net/defensa_civil/def/medidas_preventivas.php');
      data = response.data['datos'];
      cant = response.data['datos'].length;
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    getMedidas();
    setState(() {});
    return ListView.builder(
              itemCount: cant,
              itemBuilder: (context, index){
                return BuildCard(index, data, context);
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
      Text(data[index]['titulo'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
      InkWell(
        child: const Text("VER", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Medida(desc: data[index]["descripcion"], titulo: data[index]['titulo'],))),
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


class Medida extends StatelessWidget {
  final String titulo;
  final String desc;

  const Medida({super.key, required this.desc, required this.titulo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titulo),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(children: [
              Text(desc, style: const TextStyle(fontSize: 18),),
            ]),
          ),
        ),
      ),
    );
  }
}
