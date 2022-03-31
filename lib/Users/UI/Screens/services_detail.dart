// @dart=2.9
import 'package:after_app/Widgets/MyPreferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:page_transition/page_transition.dart';
import 'package:after_app/Users/UI/Screens/cut_types.dart';

import 'FirstView_User.dart';

class MyDetailPageInmediate extends StatefulWidget {
  MySuperHero2 _superHero2;
  InmediatePage _InmediatePage;

  MyDetailPageInmediate(MySuperHero2 superHero2) {
    _superHero2 = superHero2;
  }

  @override
  _MyDetailPageInmediate createState() => _MyDetailPageInmediate(_superHero2);
}

class _MyDetailPageInmediate extends State<MyDetailPageInmediate> {
  MySuperHero2 superHero2;
  MyPreferences _myPreferences = MyPreferences();

  _MyDetailPageInmediate(MySuperHero2 superHero2) {
    this.superHero2 = superHero2;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final ThemeData _theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child:Image.asset(
                'assets/images/Barba.png',
                height: 90,
              ),),
            Flexible(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Text(superHero2.title, style:
                TextStyle(
                  color: Color(0xff222B45),
                  fontWeight: FontWeight.w900,
                  fontFamily: "The Foregen Rough One",
                  fontSize: 27.0,
                ),
                ),
              ),
            )
          ],
        ),),
      body: Center(
          child: SingleChildScrollView(
              child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Hero(
                        transitionOnUserGestures: true,
                        tag: superHero2,
                        child: Transform.scale(
                            scale: 2.0,
                            child: Container(
                                height: 260.0,
                                width: 300,
                                margin: EdgeInsets.only(top: 30.0),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(superHero2.img)
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular((10.0))),
                                    shape: BoxShape.rectangle,
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                          color: Colors.black38,
                                          blurRadius: 15.0,
                                          offset: Offset(0.0, 0.7))]
                                )
                            )
                        ),
                      ),

                      Card(
                          elevation: 8,
                          margin: EdgeInsets.all(16),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(16),
                                child: Text(superHero2.body,
                                    style: TextStyle(
                                        fontFamily: "BAHNSCHRIFT",
                                        fontSize: 18.0
                                    )),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _myPreferences.corte = superHero2.title;
                                  Navigator.push(
                                      context,
                                      PageTransition(child: FirstView(), type: PageTransitionType.rightToLeft));
                                },
                                child: Container(
                                  margin: EdgeInsets.all(30
                                  ),
                                  height: 50.0 ,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.0),
                                      color: Color(0xffAD8B19)
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Continuar",
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontFamily: "BAHNSCHRIFT",
                                          color: Colors.white
                                      ),

                                    ),

                                  ),
                                ),)
                            ],//Container(
                            //padding: EdgeInsets.all(16),
                            //child: Text(superHero.body),
                          )
                      )
                    ],
                  )))),
    );
  }
}