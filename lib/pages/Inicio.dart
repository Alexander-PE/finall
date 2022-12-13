import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Inicio extends StatefulWidget {
  const Inicio({super.key});

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  List imagenes = [
    "assets/images/accion1.jpg", 
    "assets/images/accion2.jpg",
    "assets/images/accion3.jpg",
    "assets/images/accion4.jpg",
  ];
  
  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (context) {
          final double height = MediaQuery.of(context).size.height;
          return CarouselSlider(
            options: CarouselOptions(
              height: height,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              // autoPlay: false,
            ),
            items: imagenes
                .map((item) => Container(
                      child: Center(
                          child: Image.asset(
                          item,
                          fit: BoxFit.cover,
                          height: height,
                      )),
                    ))
                .toList(),
          );
        },
      );
  }
}