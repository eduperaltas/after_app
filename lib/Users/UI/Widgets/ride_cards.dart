import 'package:flutter/material.dart';
import 'package:after_app/Users/UI/Widgets/ride_card.dart';

class RideCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RideCard("26/06/2020"," Basico","/s 45","Juan Perez","Casa"),
        RideCard("28/06/2020"," Clasico","/s 31","Tapir 590","Trabajo"),
        RideCard("21/06/2020"," Barba","/s 29","Faraon Love Shady","Av.Caminos del Inca"),
      ],
    );
  }
}
