// @dart=2.9
import 'dart:async';

import 'package:after_app/Users/UI/Screens/login_user.dart';
import 'package:after_app/Users/bloc/bloc_user.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import '../../Users/model/user.dart';
import '../../Users/repository/cloud_firestore_api.dart';
import '../../Users/repository/firebase_auth_api.dart';
import '../MyPreferences.dart';
// import 'menu_item.dart';
import 'navigation_bloc.dart';
import 'package:after_app/Widgets/sidebar/menu_item.dart' as m;

//import 'package:generic_bloc_provider/generic_bloc_provider.dart';
class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
  UserBloc userBloc;
}

class _SideBarState extends State<SideBar>
    with SingleTickerProviderStateMixin<SideBar> {
  UserBloc userBloc;
  User _user;
  FirebaseAuthAPI fAuth;
  AnimationController _animationController;
  StreamController<bool> isSidebarOpenedStreamController;
  Stream<bool> isSidebarOpenedStream;
  StreamSink<bool> isSidebarOpenedSink;
  final _animationDuration = const Duration(milliseconds: 500);
  final MyPreferences _myPreferences = MyPreferences();

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: _animationDuration);
    isSidebarOpenedStreamController = PublishSubject<bool>();
    isSidebarOpenedStream = isSidebarOpenedStreamController.stream;
    isSidebarOpenedSink = isSidebarOpenedStreamController.sink;
  }

  @override
  void dispose() {
    _animationController.dispose();
    isSidebarOpenedStreamController.close();
    isSidebarOpenedSink.close();
    super.dispose();
  }

  void onIconPressed() {
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if (isAnimationCompleted) {
      isSidebarOpenedSink.add(false);
      _animationController.reverse();
    } else {
      isSidebarOpenedSink.add(true);
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return StreamBuilder<bool>(
      initialData: false,
      stream: isSidebarOpenedStream,
      builder: (context, isSideBarOpenedAsync) {
        return AnimatedPositioned(
          duration: _animationDuration,
          top: 0,
          bottom: 0,
          left: isSideBarOpenedAsync.data ? 0 : -screenWidth,
          right: isSideBarOpenedAsync.data ? 0 : screenWidth - 45,
          child: Row(
            children: <Widget>[
              Expanded(
                child: StreamBuilder(
                    stream: CloudFirestoreAPI().userData,
                    builder: (context, AsyncSnapshot snapshot) {
                      _user = snapshot.data;
                      if (!snapshot.hasData) {
                        //  Loading
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        color: const Color(0xffAD8B19),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.1,
                            ),
                            ListTile(
                                title: Text(
                                  _user.name,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.03,
                                      fontWeight: FontWeight.w800),
                                ),
                                subtitle: Text(
                                  _user.email,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.02,
                                  ),
                                ),
                                leading: CircleAvatar(
                                    radius: 25.0,
                                    backgroundImage:
                                        NetworkImage(_user.photoURL))),
                            Divider(
                              height: 50,
                              thickness: 0.5,
                              color: Colors.white.withOpacity(0.3),
                              indent: 32,
                              endIndent: 32,
                            ),
                            m.MenuItem(
                              icon: Icons.cached_rounded,
                              title: "Recientes",
                              onTap: () {
                                onIconPressed();
                                BlocProvider.of<NavigationBloc>(context).add(
                                    NavigationEvents.userResumeClickedEvent);
                              },
                            ),
                            m.MenuItem(
                              icon: Icons.home,
                              title: "Inicio",
                              onTap: () {
                                onIconPressed();
                                BlocProvider.of<NavigationBloc>(context).add(
                                    NavigationEvents.homeScreenClickedEvent);
                              },
                            ),
                            m.MenuItem(
                              icon: Icons.person,
                              title: "Perfil",
                              onTap: () {
                                onIconPressed();
                                BlocProvider.of<NavigationBloc>(context).add(
                                    NavigationEvents.userProfileClickedEvent);
                              },
                            ),
                            m.MenuItem(
                              icon: Icons.question_answer,
                              title: "Preguntas Frecuentes",
                              onTap: () {
                                onIconPressed();
                                BlocProvider.of<NavigationBloc>(context)
                                    .add(NavigationEvents.faqUsersClickedEvent);
                              },
                            ),
                            Divider(
                              height: 10,
                              thickness: 0.5,
                              color: Colors.white.withOpacity(0.3),
                              indent: 32,
                              endIndent: 32,
                            ),
                            m.MenuItem(
                              icon: Icons.exit_to_app,
                              title: "Logout",
                              onTap: () {
                                userBloc.signOut();
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        child: SignInScreen(),
                                        type: PageTransitionType.rightToLeft));
                              },
                            ),
                          ],
                        ),
                      );
                    }),
              ),
              Align(
                alignment: const Alignment(0, -1),
                child: GestureDetector(
                  onTap: () {
                    onIconPressed();
                  },
                  child: ClipPath(
                    clipper: CustomMenuClipper(),
                    child: Container(
                      width: 45,
                      height: 110,
                      color: const Color(0xffAD8B19),
                      alignment: Alignment.centerLeft,
                      child: AnimatedIcon(
                        progress: _animationController.view,
                        icon: AnimatedIcons.menu_close,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;

    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, 0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
