import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';

class Reportar extends StatefulWidget {
  final token;
  const Reportar({super.key, this.token});

  @override
  State<Reportar> createState() => _ReportarState();
}

class _ReportarState extends State<Reportar> {
  final titulo = TextEditingController();
  final descripcion = TextEditingController();
  File? _image;
  String imagen = "";
  var img64;
  final latitud = TextEditingController();
  final longitud = TextEditingController();
  late AlertDialog alert;

  Future getImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    // final imageTemp = File(image.path);
    final imgPerm = await saveFile(image.path);

    setState(() {
      this._image = imgPerm;
      this.imagen = image.path;
    });
  }

  Future<File> saveFile(String path) async{
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(path);
    final image = File('${directory.path}/$name');
    return File(path).copy(image.path);
  }


  Future<void> saveReport(String titulo, String descripcion, var img, String lat, String long, String path, context) async {
    if (titulo == '' || descripcion == '' || lat == '' || long == '' || img == null) {
      alert = const AlertDialog( 
        title: Text("Formulario"),
        content: Text("Complete el formulario"),
      );
    } else {
      try {
        img64 = File(img).readAsBytesSync();
        img64 = base64Encode(img64);

        var formdat = FormData.fromMap({
          'titulo': titulo,
          'descripcion': descripcion,
          'foto': img64,
          'latitud':lat,
          'longitud':long,
          'token': widget.token
        });

        Response response = await Dio().post('https://adamix.net/defensa_civil/def/nueva_situacion.php', data: formdat);
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
                controller: titulo,
                decoration: const InputDecoration(
                    hintText: 'Titulo', border: OutlineInputBorder())),
            const Text(""),
            TextField(
                controller: descripcion,
                decoration: const InputDecoration(
                    hintText: 'Descripcion', border: OutlineInputBorder())),
            const Text(""),
            TextField(
                controller: latitud,
                decoration: const InputDecoration(
                    hintText: 'Latitud', border: OutlineInputBorder())),
            const Text(""),
            TextField(
                controller: longitud,
                decoration: const InputDecoration(
                    hintText: 'Longitud', border: OutlineInputBorder())),
            const Text(""),
            CustomButton(
                title: "Toma una foto",
                icon: Icons.camera,
                onClick: () => getImage(ImageSource.camera)),
      
            MaterialButton(
                onPressed: () async {
                  await saveReport(titulo.text, descripcion.text, imagen, latitud.text, longitud.text, imagen, context);
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
                  "Guardar",
                  style: TextStyle(color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

Widget CustomButton(
    {required String title,
    required IconData icon,
    required VoidCallback onClick}) {
  return Container(
    width: 200,
    child: ElevatedButton(
      onPressed: onClick,
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(
            width: 20,
          ),
          Text(title)
        ],
      ),
    ),
  );
}
