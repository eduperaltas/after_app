// @dart=2.9
import 'package:after_app/Users/model/barbers.dart';
import 'package:after_app/Users/repository/cloud_firestore_api.dart';
import 'package:after_app/Widgets/MyPreferences.dart';
import 'package:after_app/Widgets/imagecardview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:after_app/Users/UI/Widgets/reviewlist.dart';
import 'package:page_transition/page_transition.dart';
import 'SeleccionaBarberos.dart';

class MyDetailPage1 extends StatefulWidget {
  BarbersProfile _superHero1;
  MyDetailPage1(BarbersProfile superHero1) {
    _superHero1 = superHero1;
  }
  @override
  _MyDetailPageState1 createState() => _MyDetailPageState1(_superHero1);
}

class _MyDetailPageState1 extends State<MyDetailPage1> {
  BarbersProfile superHero1;
  String coment;
  MyPreferences _myPreferences = MyPreferences();
  double estrellas;
  _MyDetailPageState1(BarbersProfile superHero1) {
    this.superHero1 = superHero1;
  }
  final starfull = Container(
      margin: EdgeInsets.only(left: 3.0),
      child: Icon(Icons.star, color: Color(0xffAD8B19)));

  get checkBoxValue => null;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        elevation: 0.0,
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Image.asset(
                  'assets/images/Navaja.png',
                  height: 70,
                ),
              ),
              Flexible(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    superHero1.title,
                    style: TextStyle(
                      color: Color(0xff222B45),
                      fontWeight: FontWeight.w900,
                      fontFamily: "The Foregen Rough One",
                      fontSize: 24.0,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          Hero(
            transitionOnUserGestures: true,
            tag: superHero1,
            child: Transform.scale(
                scale: 2.0,
                child: Container(
                    height: 100,
                    width: 100,
                    margin: EdgeInsets.only(top: 30.0),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(superHero1.img)),
                        shape: BoxShape.circle,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Color(0xffAD8B19),
                              blurRadius: 15.0,
                              offset: Offset(0.0, 0.7))
                        ]))),
          ),
          SizedBox(
            height: 70,
          ),

          Container(
            child: Text(
              superHero1.nameofbarber,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: "Lato",
                  fontSize: 22),
            ),
          ),
          Container(
            margin: EdgeInsets.all(19),
            child: Row(
              children: <Widget>[
                starfull,
                starfull,
                starfull,
                starfull,
                starfull
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(19),
                child: Text(
                  "Estudios: " + superHero1.estudiosbarber,
                  style: TextStyle(fontFamily: "Lato", fontSize: 18),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.all(19),
                  child: Text(
                    "Trabajo: " + superHero1.trabajobarber,
                    style: TextStyle(fontFamily: "Lato", fontSize: 18),
                  )),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.all(19),
                  child: Flexible(
                    child: Container(
                      child: Text(
                        "Direccion: " + superHero1.direccionbarber,
                        style: TextStyle(fontFamily: "Lato", fontSize: 18),
                      ),
                    ),
                  )),
            ],
          ),
          Row(
            children: <Widget>[
              new Expanded(
                child: new Container(
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(border: Border.all(width: 0.25)),
                ),
              ),
              Text(
                "Descripcion",
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              new Expanded(
                child: new Container(
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(border: Border.all(width: 0.25)),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: Text(superHero1.body,
                style: TextStyle(fontFamily: "Lato", fontSize: 18.0)),
          ),
          Row(
            children: <Widget>[
              new Expanded(
                child: new Container(
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(border: Border.all(width: 0.25)),
                ),
              ),
              Text(
                "Algunos cortes",
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              new Expanded(
                child: new Container(
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(border: Border.all(width: 0.20)),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(26),
            height: 260,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                ImageCardView(superHero1.image1),
                ImageCardView(superHero1.image2),
                ImageCardView(superHero1.image3)
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            children: <Widget>[
              new Expanded(
                child: new Container(
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(border: Border.all(width: 0.25)),
                ),
              ),
              Text(
                "Comentarios",
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              new Expanded(
                child: new Container(
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(border: Border.all(width: 0.25)),
                ),
              ),
            ],
          ),
          ReviewList(
            barberuid: superHero1.barberuid,
          ),
          SizedBox(
            height: 16,
          ),
          //Row(
          //  children: <Widget>[
          //    new Expanded(
          //      child: new Container(
          //        margin: EdgeInsets.all(8.0),
          //        decoration:
          //        BoxDecoration(border: Border.all(width: 0.25)),
          //      ),
          //    ),
          //    Text(
          //      "Tipos de corte",
          //      style: TextStyle(
          //        color: Colors.grey,
          //        fontWeight: FontWeight.bold,
          //      ),
          //    ),
          //    new Expanded(
          //      child: new Container(
          //        margin: EdgeInsets.all(8.0),
          //        decoration:
          //        BoxDecoration(border: Border.all(width: 0.25)),
          //      ),
          //    ),
          //  ],
          //),
          //MyStatefulWidget("Corte Clasico","descripcion"),
          //MyStatefulWidget("Corte Basico","descripcion"),
          //MyStatefulWidget("Especial Barbers","descripcion"),
          GestureDetector(
            onTap: () {
              _myPreferences.barber = superHero1.barberuid;
              _myPreferences.commit();
              Navigator.push(
                  context,
                  PageTransition(
                      child: SeleccionBarberos(),
                      type: PageTransitionType.rightToLeft));
            },
            child: Container(
              height: 50.0,
              width: 210.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Color(0xffAD8B19)),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Seleccionar",
                        style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: "Lato",
                            color: Colors.white,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                    Image.asset(
                      'assets/images/Máquina de Afeitar.png',
                      height: 45,
                      width: 41,
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          FloatingActionButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      elevation: 10,
                      backgroundColor: Colors.white,
                      child: Container(
                        height: 380.0,
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text(
                                      'Califica el servicio',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                        height: 100,
                                        width: 100,
                                        margin: EdgeInsets.only(
                                            top: 10.0, bottom: 10.0),
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image:
                                                  NetworkImage(superHero1.img)),
                                          shape: BoxShape.circle,
                                        )),
                                    Text(
                                      superHero1.nameofbarber,
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Color(0xffAD8B19),
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12))),
                            ),
                            SizedBox(
                              height: 5,
                            ),

                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 10, left: 16),
                              child: Text(
                                'Calidad del servicio:',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                            ),

                            RatingBar(
                              initialRating: 0,
                              glowColor: Colors.amber,
                              // borderColor: Colors.amber.withAlpha(50),
                              allowHalfRating: true,
                              onRatingUpdate: (rating) {
                                print(rating);
                                setState(() {
                                  estrellas = rating;
                                });
                              },
                            ),

                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              margin: const EdgeInsets.only(
                                  left: 20, top: 2, right: 20),
                              child: TextFormField(
                                cursorColor: Color(0xffAD8B19),
                                style: TextStyle(
                                    //color: Color(0xffAD8B19),
                                    ),
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Comentario',
                                    hintText:
                                        'Comentanos que tal te parecio el servicio'),
                                keyboardType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.next,
                                onChanged: (input) {
                                  setState(() => coment = input);
                                },
                              ),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(right: 10, left: 16),
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.end,
                            //     children: <Widget>[
                            //       RaisedButton(onPressed: (){
                            //             CloudFirestoreAPI().createBarberReview(superHero1.barberuid, coment, estrellas);
                            //             print('comentario:' + coment + 'Estrellas: '+ estrellas.toString()); //funciona

                            //         return Navigator.of(context).pop(true);
                            //       }, child: Text('Calificar'), color: Colors.white, textColor:Color(0xffAD8B19),)
                            //     ],
                            //   ),
                            // )
                          ],
                        ),
                      ),
                    );
                  });
            },
            tooltip: 'Dialog',
            backgroundColor: Color(0xffAD8B19),
            child: Icon(Icons.notifications),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      )),
    );
  }
}
