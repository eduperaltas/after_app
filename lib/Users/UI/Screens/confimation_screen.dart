import 'dart:async';

import 'package:after_app/Users/UI/Screens/walkthrought.dart';
import 'package:flutter/material.dart';

class ConfirmationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<ConfirmationScreen> {
  @override
  Widget build(BuildContext context) {
    return initScreen(context);
  }


  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() async {
    var duration = Duration(seconds: 4);
    return new Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => WalkThrough()
      )
    );
  }

  initScreen(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(8.0,),
                height: 155.0,
                width: 155,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/images/Servicio.jpg",
                        )
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.black38,
                          blurRadius: 25.0,
                          offset: Offset(0.0, 0.7))]
                )

            ),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            Text(
              "Gabriel se dirije a tu direccion",
              style: TextStyle(
                  fontSize: 28.0,
                  fontFamily: "Lato",
                  color: Colors.black
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            CircularProgressIndicator(
              backgroundColor: Colors.red,
              strokeWidth: 1,
            ),
            Padding(padding: EdgeInsets.only(top: 10.0)),
            Text(
              "lee nuestras recomendaciones",
              style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: "Lato",
                  color: Colors.black38
              ),
            ),
          ],
        ),
      ),
    );
  }
}