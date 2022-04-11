// @dart=2.9
import 'package:after_app/Users/model/user.dart';
import 'package:after_app/Users/repository/cloud_firestore_api.dart';
import 'package:after_app/Widgets/MyPreferences.dart';
import 'package:after_app/Widgets/sidebar/navigation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:after_app/Users/UI/Screens/user_profile_details.dart';
import 'package:after_app/Widgets/list_credit_card/credit_cards_page.dart';
import 'package:after_app/Users/UI/Screens/user_favorites.dart';


class UserProfile extends StatelessWidget with NavigationStates {
  final MyPreferences _myPreferences = MyPreferences();
  UserProfile({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return StreamBuilder<User>(
      stream: CloudFirestoreAPI().userData,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if (!snapshot.hasData) {
          return const Center(
              child:CircularProgressIndicator());
        }else{
          switch(snapshot.connectionState){
            case ConnectionState.waiting:
              return const Center(child:CircularProgressIndicator());
            case ConnectionState.none:
              return const Center(child:CircularProgressIndicator());
            case ConnectionState.active:
              User user = snapshot.data;
              return showProfileData(snapshot,context,user);
            case ConnectionState.done:
              User user = snapshot.data;
              return showProfileData(snapshot,context,user);
          }
          return null;
        }
      },
    );
  }

  Widget showProfileData(AsyncSnapshot snapshot,BuildContext context, User user){
    if (!snapshot.hasData || snapshot.hasError){
      print("No logeado");
    }
    else {
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
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Hola " + user.name, style: TextStyle(
                    color: Color(0xff222B45),
                    fontWeight: FontWeight.w900,
                    fontFamily: "The Foregen Rough One",
                    fontSize: MediaQuery.of(context).size.height*0.05,
                  ),
                  ),
                  CircleAvatar(
                      radius: 25.0,
                      backgroundImage:
                      NetworkImage(user.photoURL)
                  )
                ],
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
                          fontFamily: "BAHNSCHRIFT",
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                        indicatorColor: Color(0xffAD8B19),
                        tabs: <Widget>[
                          Tab(
                            text: "PERFIL",
                          ),
                          Tab(
                            text: "FAVORITOS",
                          ),
                          Tab(
                            text: "PAGO",
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Expanded(
                        child: TabBarView(
                          children: <Widget>[
                            Profile(user),
                            UserFavorites(uiduser: user.uid,),
                            SingleChildScrollView(
                              child: CreditCardsPage(uiduser: user.uid,),
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
}
