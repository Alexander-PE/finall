import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Servicios extends StatefulWidget {
  const Servicios({super.key});

  @override
  State<Servicios> createState() => _ServiciosState();
}

class _ServiciosState extends State<Servicios> {


  var data = [];
  var cant = 0;

  Future<void> getServicios() async {
    try {
      var response = await Dio().get('https://adamix.net/defensa_civil/def/servicios.php');
      data = response.data['datos'];
      cant = response.data['datos'].length;
      setState(() {});
    } catch (e) {
      print(e);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    getServicios();
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
      Text(data[index]['nombre'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
      InkWell(
        child: const Text("VER", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Servicio(titulo: data[index]["nombre"], desc: data[index]["descripcion"]))),
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


class Servicio extends StatelessWidget {
  final String titulo;
  final String desc;

  const Servicio({super.key, required this.titulo, required this.desc});

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
              Text(
                desc,
                style: const TextStyle(fontSize: 20),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}


