// @dart=2.9
import 'package:after_app/Users/UI/Screens/select_card.dart';
import 'package:after_app/Users/UI/Widgets/maps/search/search_place.dart';
import 'package:after_app/Widgets/sidebar/navigation_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'FirstView_User.dart';
import 'SeleccionReserva.dart';
import 'SeleccionaBarberos.dart';
import 'cut_types.dart';
class UserServices extends StatefulWidget with NavigationStates {
  @override

  State createState() {
    return _UserServices();
  }
}
class _UserServices extends State<UserServices> with NavigationStates{
  String image1="assets/images/servicios1.jpg";
  String image2="assets/images/servicios2.jpg";
  String image3="assets/images/servicios3.jpg";
  String buttonText1="Inmediato";
  String buttonText2="Reserva tu servicio";
  String buttonText3="Escoger barbero";
  String dropdownValue = 'Ahora';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(margin: EdgeInsets.only(left: 30),
              child:Image.asset(
                'assets/images/Barba.png',
                height: MediaQuery.of(context).size.height*0.09,
              ),),
            Container(
              child: Text('BARBERS  HOME', style:
              TextStyle(
                color: Color(0xff222B45),
                fontWeight: FontWeight.w900,
                fontFamily: "The Foregen Rough One",
                fontSize: MediaQuery.of(context).size.height*0.05,
              ),
              ),
            ),
          ],
        ),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height*0.25,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(top: 30),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Color(0xffAD8B19),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.black38,
                            blurRadius: 15.0,
                            offset: Offset(0.0, 0.7))]
                  ),

                ),
                Container(
                  height:  MediaQuery.of(context).size.height*0.05,
                  width: MediaQuery.of(context).size.width*0.7,
                  margin: EdgeInsets.only(top: 70, left: 30),
                  child: Text("¿Necesitas un corte?",style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.height*0.027,
                      fontFamily: "BAHNSCHRIFT"
                    )
                    ,),
                ),
                Container(
                  height:  MediaQuery.of(context).size.height*0.08,
                  width: MediaQuery.of(context).size.width*0.7,
                  margin: EdgeInsets.only(top: 120, left: 30),
                  child: Text("Tú decides dónde y como quieres el corte. Nuestros barberos estan dispuestos a atenderte.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.white,
                        fontSize: MediaQuery.of(context).size.height*0.023,
                      fontFamily: "BAHNSCHRIFT"
                  )
                    ,),
                ),

              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height*0.02,
            ),
            Container(
              color: Color(0xffeeeeee),
              height:  MediaQuery.of(context).size.height*0.08,
              width: MediaQuery.of(context).size.width*0.9,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, PageTransition(child: const SearchMap(editFav: false,), type: PageTransitionType.rightToLeft));
                      },
                      child: Container(
                        height:  MediaQuery.of(context).size.height*0.05,
                        width: MediaQuery.of(context).size.width*0.5,
                        child: Center(
                          child: Text("¿A dónde vamos?",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: MediaQuery.of(context).size.height*0.027,
                                fontFamily: "BAHNSCHRIFT"
                            )
                            ,),
                        ),
                      ),
                    ),
                    Container(
                      height:  MediaQuery.of(context).size.height*0.05,
                      width: MediaQuery.of(context).size.width*0.002,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.03,
                    ),
                    Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height*0.05,
                          width: MediaQuery.of(context).size.width*0.3,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white,
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.black38,
                                    blurRadius: 15.0,
                                    offset: Offset(0.0, 0.7))]
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height*0.05,
                          width: MediaQuery.of(context).size.width*0.3,
                          child: Center(
                            child: DropdownButton<String>(
                              value: dropdownValue,
                              icon: const Icon(Icons.arrow_downward),
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(color: Colors.black),
                              onChanged: (newValue) {
                                setState(() {
                                  dropdownValue = newValue;
                                });
                                switch(newValue){
                                  case 'Ahora' :
                                    Navigator.push(context, PageTransition(child: FirstView(), type: PageTransitionType.rightToLeft));

                                    break;
                                  case 'Reserva' :
                                    Navigator.push(context, PageTransition(child: SeleccionReserva(), type: PageTransitionType.rightToLeft));

                                    break;
                                  case 'Barberos' :
                                    Navigator.push(context, PageTransition(child: SeleccionBarberos(), type: PageTransitionType.rightToLeft));

                                break;
                                }
                              },
                              items: <String>['Ahora', 'Reserva', 'Barberos',]
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          )
                        ),
                      ],
                    ),
                ],
              ),
            ),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.1,
                ),
                Container(
                    height: MediaQuery.of(context).size.height*0.1,
                    width: MediaQuery.of(context).size.width*0.05,
                    child: Icon(Icons.stars, color: Colors.black,size: 30,)
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.05,
                ),
                Container(
                  height: MediaQuery.of(context).size.height*0.1,
                  width: MediaQuery.of(context).size.width*0.7,
                  child: Center(
                    child: Text("Elegir ubicación guardada",
                    style: TextStyle(
                      fontFamily: "BAHNSCHRIFT",
                      fontSize: 20
                        ),),
                  ),
                )

              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width*0.7,
              height: 45.0,
              child: FlatButton(
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
                color: Color(0xffAD8B19),
                onPressed: () async {
                  Navigator.push(context, PageTransition(child: Inmediato(), type: PageTransitionType.rightToLeft));
                },
                child: Text(
                  "Escoje tu corte",
                  style: TextStyle(color: Colors.white, fontSize: 16.0,
                      fontFamily: "BAHNSCHRIFT"),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Container(
                        margin: EdgeInsets.only(
                          top: 8.0,),
                        height: 125.0,
                        width: MediaQuery.of(context).size.width*0.5,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("assets/images/cortesbarbero.jpg",
                                )
                            ),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Colors.black38,
                                  blurRadius: 15.0,
                                  offset: Offset(0.0, 0.7))]
                        )
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 125,),
                      height: 30.0 ,
                      width: MediaQuery.of(context).size.width*0.5,
                      decoration: BoxDecoration(
                          color: Color(0xffAD8B19)

                      ),
                      child: Center(
                        child: Text("Corte simple",style: TextStyle(
                          color: Colors.white,
                          fontFamily: "BAHNSCHRIFT",
                          fontWeight: FontWeight.bold,
                          fontSize:   15,
                        ),
                        ),

                      ),
                    )

                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 30,
                        child: Center(
                          child: Text("Servicio:",style: TextStyle(
                            color: Colors.black,
                            fontFamily: "BAHNSCHRIFT",
                            fontWeight: FontWeight.bold,
                            fontSize:   15,
                          ),
                          ),
                        ),
                      ),
                      Container(
                        height: 30,
                        child: Center(
                          child: Text("Barbero: Juan Lopez",style: TextStyle(
                            color: Colors.black,
                            fontFamily: "BAHNSCHRIFT",
                            fontSize:   15,
                          ),
                          ),
                        ),
                      ),
                      Container(
                        height: 30,
                        child: Center(
                          child: Text("Tipo: Inmediato",style: TextStyle(
                            color: Colors.black,
                            fontFamily: "BAHNSCHRIFT",
                            fontSize:   15,
                          ),
                          ),
                        ),
                      ),
                      Container(
                        height: 30,
                        child: Center(
                          child: Text("Costo: s/35",style: TextStyle(
                            color: Colors.black,
                            fontFamily: "BAHNSCHRIFT",
                            fontSize:   15,
                          ),
                          ),
                        ),
                      )
                    ],

                  ),

              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width*0.7,
              height: 35.0,
              child: FlatButton(
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
                color: Color(0xffAD8B19),
                onPressed: () async {
                  Navigator.push(context, PageTransition(child: SelectCard(), type: PageTransitionType.rightToLeft));
                },
                child: Text(
                  "ACEPTAR",
                  style: TextStyle(color: Colors.white, fontSize: 16.0,
                      fontFamily: "BAHNSCHRIFT"),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),

          ],
        ),
      )
    );
  }

}