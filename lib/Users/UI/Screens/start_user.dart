import 'package:flutter/material.dart';

import '../../../router.dart';


class StartUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                  height: 250.0,
                  width: 450.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/videoprueba2.gif')
                      ),

                      shape: BoxShape.rectangle,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.black38,
                            blurRadius: 15.0,
                            offset: Offset(0.0, 0.7))]
                  )
              )
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Color(0xffF5F5F5),
              ),
              height: 170.0,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: GestureDetector(
                            child: Container(
                              margin: EdgeInsets.only(
                                top: 5.0,
                              ),
                              height: 30.0 ,
                              width: 180.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.0),
                                  color: Color(0xffAD8B19)
                              ),
                              child: Center(
                                child: Text(
                                  'Inicia Sesión',
                                  style: TextStyle(
                                      fontFamily: "BAHNSCHRIFT",
                                      fontSize: 18.0,
                                      color: Colors.white
                                  ),
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).pushNamed(LoginUserRoute)
                              ;},
                          )
                      ),
                      SizedBox(width: 40.0),
                      Expanded(
                          child: GestureDetector(
                            onTap: () { Navigator.of(context).pushNamed(RegisterUserRoute);},
                            child: Container(
                              margin: EdgeInsets.only(
                                top: 5.0,
                              ),
                              height: 30.0 ,
                              width: 180.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.0),
                                  color:Color(0xffAD8B19)
                              ),
                              child: Center(
                                child: Text(
                                  'Registro',
                                  style: TextStyle(
                                      fontFamily: "BAHNSCHRIFT",
                                      fontSize: 18.0,
                                      color: Colors.white
                                  ),
                                ),
                              ),
                            ),
                          )
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Divider(
                          color:  Color(0xff8F9BB3),
                        ),
                      ),
                      Container(
                        child: Text(
                          "Trabaja con nosotros", style: TextStyle(
                            color: Colors.black
                        ),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 15.0,
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Color(0xff8F9BB3),
                        ),
                      ),
                    ],

                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 15.0,
                    ),
                    height: 30.0 ,
                    width: 180.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: Color(0xffAD8B19)
                    ),
                    child: Center(
                      child: GestureDetector(
                        onTap: () { Navigator.of(context).pushNamed(StartBarberRoute);},
                        child: Container(
                          child: Text(
                            'Barbers',
                            style: TextStyle(
                                fontFamily: "BAHNSCHRIFT",
                                fontSize: 18.0,
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

