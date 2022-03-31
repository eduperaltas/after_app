import 'package:after_app/Widgets/sidebar/navigation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:after_app/Users/UI/Widgets/ride_card.dart';
import 'package:after_app/Users/UI/Widgets/ride_cards.dart';

class UserResume extends StatelessWidget with NavigationStates {
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
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
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Text(
              "Servicios",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height*0.05,
                fontFamily:"The Foregen Rough One",
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Expanded(
              child: DefaultTabController(
                length: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TabBar(
                      unselectedLabelColor: Colors.grey,
                      labelColor: Color(0xffAD8B19),
                      labelStyle: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "BAHNSCHRIFT",
                      ),
                      indicatorColor: Color(0xffAD8B19),
                      tabs: <Widget>[
                        Tab(
                          text: "RESERVADOS",
                        ),
                        Tab(
                          text: "COMPLETADOS",
                        ),
                        Tab(
                          text: "CANCELADOS",
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Expanded(
                      child: TabBarView(
                        children: <Widget>[
                          Container(
                            child: RideCard("Hoy 10:30 AM","Clásico","s/ 50","Yair Campos","Casa"),
                          ),
                          SingleChildScrollView(
                            child: RideCards(),
                          ),
                          SingleChildScrollView(
                            child: RideCards(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}