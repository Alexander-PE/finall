import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Albergues extends StatefulWidget {
  const Albergues({super.key});

  @override
  State<Albergues> createState() => _AlberguesState();
}

class _AlberguesState extends State<Albergues> {

  var data = [];
  var cant = 0;

  Future<void> getAlbergues() async {
    try {
      var response = await Dio().get('https://adamix.net/defensa_civil/def/albergues.php');
      data = response.data['datos'];
      cant = response.data['datos'].length;
      setState(() {});
    } catch (e) {
      print(e);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    getAlbergues();
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
      Text(data[index]['edificio'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
      InkWell(
        child: const Text("VER", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Albergue(edif: data[index]["edificio"], ciudad: data[index]["ciudad"], tel: data[index]['telefono'], cod: data[index]['codigo'], cord: data[index]['coordinador']))),
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


class Albergue extends StatelessWidget {
  final String edif;
  final String ciudad;
  final String tel;
  final String cod;
  final String cord;

  const Albergue({super.key, required this.edif, required this.ciudad, required this.tel, required this.cod, required this.cord});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(edif),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Text('Ciudad: $ciudad', style: const TextStyle(fontSize: 20),),
            Text('Telefono: $tel', style: const TextStyle(fontSize: 20),),
            Text('Codigo: $cod', style: const TextStyle(fontSize: 20),),
            Text('Coordinador: $cord', style: const TextStyle(fontSize: 20),),
          ]),
        ),
      ),
    );
  }
}
