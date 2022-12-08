import 'package:dio/dio.dart';
import 'package:finall/main.dart';
import 'package:flutter/material.dart';

class Registrar extends StatefulWidget {
  const Registrar({super.key});

  @override
  State<Registrar> createState() => _RegistrarState();
}

class _RegistrarState extends State<Registrar> {
  final cedula = TextEditingController();
  final nombre = TextEditingController();
  final apellido = TextEditingController();
  final passwd = TextEditingController();
  final correo = TextEditingController();
  final telefono = TextEditingController();


  Future<void> register(String cedula, String nombre, String apellido, String passwd, String correo, String telefono) async {
    try {
      var formdat = FormData.fromMap({
        'cedula':cedula, 
        'nombre':nombre, 
        'apellido':apellido, 
        'clave':passwd, 
        'correo':correo, 
        'telefono':telefono 
      });

      // print(cedula);
      // print(nombre);

      Response response = await Dio().post('https://adamix.net/defensa_civil/def/registro.php', data: formdat);
      print(response.data.toString());
    } catch (e) {
      print(e);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: cedula,
              decoration: const InputDecoration(hintText: 'Inserte su cedula' ,border: OutlineInputBorder())
            ),
            const Text(""),
            TextField(
              controller: nombre,
              decoration: const InputDecoration(hintText: 'Inserte su nombre' ,border: OutlineInputBorder())
            ),
            const Text(""),
            TextField(
              controller: apellido,
              decoration: const InputDecoration(hintText: 'Inserte su apellido' ,border: OutlineInputBorder())
            ),
            const Text(""),
            TextField(
              controller: passwd,
              decoration: const InputDecoration(hintText: 'Inserte su clave' ,border: OutlineInputBorder())
            ),
            const Text(""),
            TextField(
              controller: correo,
              decoration: const InputDecoration(hintText: 'Inserte su correo' ,border: OutlineInputBorder())
            ),
            const Text(""),
            TextField(
              controller: telefono,
              decoration: const InputDecoration(hintText: 'Inserte su telefono' ,border: OutlineInputBorder())
            ),
            const Text(""),
            MaterialButton(
              onPressed: () async{
                // await getGender(_textController.text);
                await register(cedula.text, nombre.text, apellido.text, passwd.text, correo.text, telefono.text);
                setState(() {});
              },
              color: Colors.blue,
              child: const Text("Identificar", style: TextStyle(color: Colors.white),),
            )
          ],
        ),
      ),
    );
  }
}