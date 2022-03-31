// @dart=2.9
import 'package:after_app/Users/bloc/bloc_user.dart';
import 'package:after_app/Widgets/MyPreferences.dart';
import 'package:after_app/Widgets/sidebar/navigation_bloc.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:after_app/Widgets/styles/colors.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class FAQUsers extends StatelessWidget with NavigationStates{
  UserBloc userBloc;
  MyPreferences _myPreferences = MyPreferences();
  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBloc>(context);
    final ThemeData _theme = Theme.of(context);
    BubbleStyle styleSomebody = BubbleStyle(
      nip: BubbleNip.leftTop,
      color: Colors.white,
      padding: BubbleEdges.all(15.0),
      margin: BubbleEdges.only(top: 8.0, bottom: 12.0, right: 50.0),
      alignment: Alignment.topLeft,
    );
    BubbleStyle styleMe = BubbleStyle(
      nip: BubbleNip.rightTop,
      color: Colors.black,
      padding: BubbleEdges.all(15.0),
      margin: BubbleEdges.only(top: 8.0, bottom: 12.0, left: 50.0),
      alignment: Alignment.topRight,
    );

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
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Container(
              alignment: Alignment.center,
              height: 100.0,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: ListTile(
                contentPadding: EdgeInsets.only(right: 10.0),
                // leading: IconButton(
                //   icon: Icon(
                //     Icons.arrow_back_ios,
                //     color: Colors.black,
                //   ),
                //   onPressed: () {
                //     if (Navigator.of(context).canPop()) {
                //       Navigator.of(context).pop();
                //     }
                //   },
                // ),
                title: Container(
                  padding: EdgeInsets.only(
                    bottom: 2.0,
                  ),
                  child: Text(
                    "PREGUNTAS FRECUENTES",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "BAHNSCHRIFT",
                      color: dbasicDarkColor,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                subtitle: Text(
                  "Envianos tu consulta via email a: contacto@barbers.com",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                  ),
                ),
                trailing: CircleAvatar(
                  radius: 25.0,
                  backgroundImage:  AssetImage("assets/images/mail.png"),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    padding: EdgeInsets.all(
                      15.0,
                    ),
                    child: Column(
                      children: <Widget>[
                        Bubble(
                          style: styleMe,
                          child: Text(
                            "Puedo pagar con efectivo?",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Bubble(
                          style: styleSomebody,
                          child: Text(
                            "Actualemnte no contamos con ese metodo de pago.",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Bubble(
                          style: styleMe,
                          child: Text(
                            "Los barberos cumplen protocolos de covid",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Bubble(
                          style: styleSomebody,
                          child: Text(
                            "Nuestros barberos cuentan con todas las medidas de seguridad propuestas por el minsa.",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        GestureDetector(
                            onTap: () {
                              userBloc.signOut();

                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 35),
                              child: Icon(Icons.exit_to_app, color: Color(0xffEE4B45), size: 35,),
                            )
                        ),
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}