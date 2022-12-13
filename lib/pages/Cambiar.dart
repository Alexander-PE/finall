import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

class Cambiar extends StatefulWidget {
  final token;
  const Cambiar({super.key, this.token});

  @override
  State<Cambiar> createState() => _CambiarState();
}

class _CambiarState extends State<Cambiar> {
  final claveant = TextEditingController();
  final clavenew = TextEditingController();
  late AlertDialog alert;

  Future<void> setClave(String claveant, String clavenew) async {
    if (claveant == '' || clavenew == '') {
      alert = const AlertDialog( 
        title: Text("Formulario"),
        content: Text("Complete el formulario"),
      );
    } else {
      try {
        var formdat = FormData.fromMap({
          'token': widget.token,
          'clave_anterior': claveant,
          'clave_nueva': clavenew,
        });

        Response response = await Dio().post('https://adamix.net/defensa_civil/def/cambiar_clave.php', data: formdat);
        alert = AlertDialog(
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
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
                controller: claveant,
                decoration: const InputDecoration(
                    hintText: 'Clave Anterior', border: OutlineInputBorder())),
            const Text(""),
            TextField(
                controller: clavenew,
                decoration: const InputDecoration(
                    hintText: 'Clave Nueva', border: OutlineInputBorder())),
            
      
            MaterialButton(
                onPressed: () async {
                  await setClave(claveant.text, clavenew.text);
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
                  "Cambiar",
                  style: TextStyle(color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
