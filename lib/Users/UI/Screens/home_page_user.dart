// @dart=2.9
import 'package:after_app/Users/UI/Screens/faq_users.dart';
import 'package:after_app/Users/UI/Screens/user_profile.dart';
import 'package:after_app/Users/UI/Screens/user_services.dart';
import 'package:after_app/Users/bloc/bloc_user.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

import 'user_resume.dart';

class HomePageUser extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePageUser();
  }
}

class _HomePageUser extends State<HomePageUser> {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  @override
  void initState() {
    super.initState();

    // _fcm.configure(
    //   onMessage: (Map<String, dynamic> message) async {
    //     print("onMessage en app: $message");
    //     showDialog(
    //       context: context,
    //       builder: (context) => AlertDialog(
    //         content: ListTile(
    //           title: Text(message['notification']['title']),
    //           subtitle: Text(message['notification']['body']),
    //         ),
    //         actions: <Widget>[
    //           FlatButton(
    //             color: Colors.amber,
    //             child: Text('Ok'),
    //             onPressed: () => Navigator.of(context).pop(),
    //           ),
    //         ],
    //       ),
    //     );
    //   },
    //
    //   onLaunch: (Map<String, dynamic> message) async {
    //     print("onLaunch: $message");
    //     // TODO optional
    //   },
    //   onResume: (Map<String, dynamic> message) async {
    //     print("onResume: $message");
    //     // TODO optional
    //   },
    // );
  }

  int indexTap = 1;
  final List<Widget> widgetsChildren = [
    UserResume(),
    UserServices(),
    BlocProvider<UserBloc>(
      bloc: UserBloc(),
      child: UserProfile(),
    ),
    FAQUsers()
  ];

  void onTapped(int index) {
    setState(() {
      indexTap = index;
    });
  }

  UserBloc userBloc;
  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBloc>(context);
    // TODO: implement build
    return Scaffold(
      body: widgetsChildren[indexTap],
      bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
              canvasColor: Color(0xffffffff), primaryColor: Color(0xffAD8B19)),
          child: WillPopScope(
              child: BottomNavigationBar(
                  onTap: onTapped,
                  currentIndex: indexTap,
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.restore, color: Color(0xffAD8B19)),
                      label: "Recientes",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home, color: Color(0xffAD8B19)),
                      label: "Inicio",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person, color: Color(0xffAD8B19)),
                      label: "Perfil",
                    ),
                    BottomNavigationBarItem(
                      icon:
                          Icon(Icons.question_answer, color: Color(0xffAD8B19)),
                      label: "Preguntas",
                    )
                  ]),
              onWillPop: () {
                // return showDialog(
                //   context: context,
                //   builder: (context) => AlertDialog(
                //     content: ListTile(
                //       title: Text('¿Estás seguro que quieres cerrar sesion?'),
                //     ),
                //     actions: <Widget>[
                //       FlatButton(
                //         child: Text('Cancelar',style: TextStyle(color: Colors.grey),),
                //         onPressed: () => Navigator.of(context).pop(),
                //       ),
                //       FlatButton(
                //         color: Colors.amber,
                //         child: Text('Ok',style: TextStyle(color: Colors.white)),
                //         onPressed: () {userBloc.signOut();
                //         Navigator.of(context).pop();
                //         } ,
                //       ),
                //     ],
                //   ),
                // );
              })),
    );
  }
}
