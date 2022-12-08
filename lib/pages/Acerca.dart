import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class Acerca extends StatelessWidget {
  const Acerca({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Alexander Perez", style: TextStyle(fontSize: 25),),
            const Text("2020-10039", style: TextStyle(fontSize: 25)),
            const Text("alexander.pereze02@gmail.com", style: TextStyle(fontSize: 25)),
            const Text(""),
            Image.asset("assets/images/foto.jpg", width: 250, height: 250,),
            const Text(""),
            InkWell(
              child: const Text("Contacto", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
              onTap: () => launch('https://t.me/+hRZE1V-AE5w4ZGJh')
            ),

          ],
        ),
      ),
    );
  }
}