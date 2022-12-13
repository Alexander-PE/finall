import 'package:dio/dio.dart';
import 'package:finall/pages/Sesion.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final cedula = TextEditingController();
  final clave = TextEditingController();
  late AlertDialog alert;

  Future<void> login(String cedula, String clave) async {
    if (cedula == '' || clave == '') {
      alert = const AlertDialog( 
        title: Text("Formulario"),
        content: Text("Complete el formulario"),
      );
    } else {
      try {
        var formdat = FormData.fromMap({
          'cedula': cedula,
          'clave': clave,
        });

        Response response = await Dio().post('https://adamix.net/defensa_civil/def/iniciar_sesion.php', data: formdat);
        alert = AlertDialog(
          title: const Text("Formulario"),
          content: Text(response.data['mensaje']),
        );

        if(response.data['exito'] == true){
          Navigator.push(context, MaterialPageRoute(builder: (context) => Sesion(data: response.data['datos'])));
        }
        print(response.data.toString());
      } catch (e) {
        print(e);
      }
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
                decoration: const InputDecoration( hintText: 'Inserte su cedula', border: OutlineInputBorder())),
            const Text(""),
            TextField(
                controller: clave,
                decoration: const InputDecoration( hintText: 'Inserte su clave', border: OutlineInputBorder())),
            const Text(""),
            MaterialButton(
              onPressed: () async {
                await login(cedula.text, clave.text);
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return alert;
                  },
                );
                setState(() {});
              },
              color: Colors.blue,
              child: const Text(
                "Login",
                style: TextStyle(color: Colors.white),
              ),
            ),
            InkWell(
              child: const Text("Recuperar contraseña", style: TextStyle(fontSize: 16)),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Recuperar())),
            ),
          ],
        ),
      ),
    );
  }
}


class Recuperar extends StatefulWidget {
  @override
  State<Recuperar> createState() => _RecuperarState();
}

class _RecuperarState extends State<Recuperar> {
  // final String edif;
  final cedula = TextEditingController();
  final correo = TextEditingController();
  late AlertDialog alerta;

  Future<void> restore(String cedula, String correo) async {
    if (cedula == '' || correo == '') {
      alerta = const AlertDialog( 
        title: Text("Formulario"),
        content: Text("Complete el formulario"),
      );
    } else {
      try {
        var formdat = FormData.fromMap({
          'cedula': cedula,
          'correo': correo,
        });

        Response response = await Dio().post('https://adamix.net/defensa_civil/def/recuperar_clave.php', data: formdat);
        alerta = AlertDialog(
          title: const Text("Formulario"),
          content: Text(response.data['mensaje']),
        );
        print(response.data.toString());
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recuperar contraseña"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            TextField(
                controller: cedula,
                decoration: const InputDecoration( hintText: 'Inserte su cedula', border: OutlineInputBorder())),
            const Text(""),
            TextField(
                controller: correo,
                decoration: const InputDecoration( hintText: 'Inserte su correo', border: OutlineInputBorder())),
            const Text(""),
            MaterialButton(
              onPressed: () async {
                await restore(cedula.text, correo.text);
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return alerta;
                  },
                );
                setState(() {});
              },
              color: Colors.blue,
              child: const Text(
                "Recuperar",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
