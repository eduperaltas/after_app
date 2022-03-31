// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:after_app/Users/UI/Screens/services_detail.dart';

import 'home_page_user.dart';
class Inmediato extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InmediatePage (),
    );
  }
}

class InmediatePage extends StatefulWidget {
  @override
  _InmediatePageState createState() => _InmediatePageState();
  final star_full = Container(
      margin: EdgeInsets.only(
          top:  320.0,
          right : 3.0
      ),
      child: Icon(
          Icons.star,
          color: Color(0xFFf2C611)
      )
  );
}

class MySuperHero2 {
  final String img;
  final String title;
  final String body;
  final int Stars;


  MySuperHero2(this.img, this.title, this.body, this.Stars);
}


class _InmediatePageState extends State<InmediatePage> {
  List<MySuperHero2> items = new List<MySuperHero2>();
  _InmediatePageState() {
    items.add(new MySuperHero2("assets/images/cortesbarbero.jpg", "Corte simple",
        "No te compliques, escoge entre cualquiera de nuestros barberos aleatoriamente y agenda un corte inmediatamente ",5));
    items.add(new MySuperHero2("assets/images/CorteClasico.jpg", "Corte clasico",
        "Escoge al barbero de tu preferencia y agenda unn corte con inmediatamente ",5));
    items.add(new MySuperHero2("assets/images/EspecialBarbers.jpg", "Especial Barbers",
        "Reserva tu servicio para una fecha especifica y sigue su estado en el area de programadas dentro de tu perfil",5));
  }


  Widget SuperHeroCell(BuildContext ctx, int index) {
    final ThemeData _theme = Theme.of(context);
    return GestureDetector(
        onTap: () {
          final snackBar = SnackBar(content: Text("Tap"));
          Navigator.push(context, PageTransition(child: MyDetailPageInmediate (items[index]), type: PageTransitionType.rightToLeft));
          //Navigator.push(context, MaterialPageRoute(builder: (context) => MyDetailPageInmediate (items[index])));
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white
          ),
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Hero(
                      tag: items[index],
                      child: Container(
                          margin: EdgeInsets.only(
                            top: 8.0,),
                          height: 250.0,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(items[index].img,
                                  )
                              ),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.black38,
                                    blurRadius: 15.0,
                                    offset: Offset(0.0, 0.7))]
                          )
                      )
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Container(
                    height: 35.0 ,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Color(0xffAD8B19)

                    ),
                    child: Center(
                      child: Text(items[index].title,style: TextStyle(
                        color: Colors.white,
                        fontFamily: "BAHNSCHRIFT",
                        fontWeight: FontWeight.bold,
                        fontSize:   18,
                      ),
                      ),

                    ),
                  )
                ],
              ),
            ],
          ),
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar:  AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: true,
          elevation: 0.0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child:Image.asset(
                  'assets/images/Barba.png',
                  height: 70,
                ),),
              Flexible(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text('BARBERS  HOME', style:
                  TextStyle(
                    color: Color(0xff222B45),
                    fontWeight: FontWeight.w900,
                    fontFamily: "The Foregen Rough One",
                    fontSize: 40.0,
                  ),
                  ),
                ),
              )
            ],
          ),),
        body:
        Center(
          child: Container(
            child: Stack(
              children: <Widget>[
                ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) => SuperHeroCell(context, index),
                ),
              ],
            ),
          ),
        )

    );
  }}