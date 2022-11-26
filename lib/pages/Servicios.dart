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
      // print(response.data['datos'][0]['nombre']);
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
                return BuildCard(index, data);
              },
            ),
          )
        ],
      ),
    );
  }
}


Widget BuildCard(int index, List datos) => Container(
  color: Colors.grey,
  width: double.infinity,
  height: 160,
  child: Center(child: Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(datos[index]['nombre'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
      Text(datos[index]['descripcion']),
      const Divider(
            height: 20,
            thickness: 5,
            endIndent: 0,
            color: Colors.white,
          ),
    ],
  )),
);