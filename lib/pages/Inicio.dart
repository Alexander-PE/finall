import 'package:flutter/material.dart';

class Inicio extends StatelessWidget {
  const Inicio({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SingleChildScrollView(
        child: Column(
          children: const [
            Text("La Defensa Civil tiene por objetivo principal asegurar que los operativos del país sean adecuados para los perjuicios que se originen por los desastres causados por inundación, terremoto, tormenta, huracán, fuego, escasez o distribución deficiente de suministro de materiales, u otros motivos similares, y en general para proveer el orden, salud y bienestar económico, seguridad pública prevención de la vida y de la propiedad en tales circunstancias.", style: TextStyle(fontSize: 20),),
            Text(""),
            Text("Tiene como mision Dirigir las acciones de coordinación, preparación y operación de todas las funciones de emergencias ante la ocurrencia de un evento natural o antrópico en una forma eficiente y eficaz, garantizando un control adecuado de las operaciones para resguardar la vida y la propiedad de los habitantes de República Dominicana.", style: TextStyle(fontSize: 20))
          ],
        ),
      ),
    );
  }
}