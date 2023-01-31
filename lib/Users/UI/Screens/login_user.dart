// @dart=2.9
import 'package:after_app/Users/repository/cloud_firestore_api.dart';
import 'package:after_app/Users/repository/firebase_auth_api.dart';
import 'package:after_app/Widgets/MyPreferences.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:after_app/Users/bloc/bloc_user.dart';
import 'package:after_app/Users/model/user.dart' as us;
import '../../../router.dart';
import 'FirstView_User.dart';

class SignInScreen extends StatefulWidget {
  @override
  State createState() {
    return _SignInScreen();
  }
}

class _SignInScreen extends State<SignInScreen> {
  us.User user;
  MyPreferences _myPreferences = MyPreferences();
  final FirebaseAuthAPI _auth = FirebaseAuthAPI();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password;
  String error = "";
  UserBloc userBloc;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    userBloc = BlocProvider.of(context);
    return _handleCurrentSession();
  }

  Widget _handleCurrentSession() {
    return StreamBuilder(
      stream: userBloc.authStatus,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        //snapshot- data - Object User
        if (!snapshot.hasData || snapshot.hasError) {
          return LoginUser(snapshot);
        } else {
          User user = snapshot.data;
          _myPreferences.uid = user.uid;
          _myPreferences.commit();
          print("us.User UID login: " + _myPreferences.uid);
          return FirstView();
        }
      },
    );
  }

  Widget LoginUser(AsyncSnapshot snapshot) {
    final ThemeData _theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: _theme.scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }
          },
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(RegisterUserRoute);
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: const Text(
                "Regístrate",
                style: TextStyle(
                  color: Color(0xffAD8B19),
                  fontFamily: "BAHNSCHRIFT",
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  "Inicia Sesión",
                  style: _theme.textTheme.titleLarge.merge(
                    const TextStyle(
                      fontFamily: "the-foregen-rough-one",
                      fontSize: 30.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              _loginForm(context),
              const SizedBox(
                height: 30.0,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin:
                    const EdgeInsets.only(left: 30.0, right: 30.0, top: 0.0),
                alignment: Alignment.center,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(8.0),
                        decoration:
                            BoxDecoration(border: Border.all(width: 0.25)),
                      ),
                    ),
                    const Text(
                      "O ingresa con",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(8.0),
                        decoration:
                            BoxDecoration(border: Border.all(width: 0.25)),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin:
                    const EdgeInsets.only(left: 29.0, right: 30.0, top: 20.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(right: 8.0),
                        alignment: Alignment.center,
                        child: Row(
                          children: <Widget>[
                            //  Expanded(
                            //   child:  FlatButton(
                            //     shape:  RoundedRectangleBorder(
                            //       borderRadius:  BorderRadius.circular(30.0),
                            //     ),
                            //     color: const Color(0Xff3B5998),
                            //     onPressed: () {
                            //       print("R");
                            //     },
                            //     child:  Row(
                            //       mainAxisAlignment: MainAxisAlignment.center,
                            //       children: <Widget>[
                            //         Expanded(
                            //           child:  FlatButton(
                            //             onPressed: () => {
                            //               userBloc.facebookSignIn().then((User user) {
                            //                 userBloc.createUserData(us.User(
                            //                   uid: user.uid,
                            //                   name: user.displayName,
                            //                   email: user.email,
                            //                   photoURL: user.photoURL,
                            //                 ));
                            //                 CloudFirestoreAPI().saveDeviceToken('user');
                            //               })
                            //             },
                            //             padding: const EdgeInsets.only(
                            //               top: 20.0,
                            //               bottom: 20.0,
                            //             ),
                            //             child:  Row(
                            //               mainAxisAlignment:
                            //               MainAxisAlignment.spaceEvenly,
                            //               children: const <Widget>[
                            //                 Icon(
                            //                   FontAwesomeIcons.facebookSquare,
                            //                   color: Colors.white,
                            //                 ),
                            //                 Text(
                            //                   "FACEBOOK",
                            //                   textAlign: TextAlign.center,
                            //                   style: TextStyle(
                            //                       color: Colors.white,
                            //                       fontWeight:
                            //                       FontWeight.bold),
                            //                 ),
                            //               ],
                            //             ),
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                    //  Expanded(
                    //   child:  Container(
                    //     margin: const EdgeInsets.only(left: 8.0),
                    //     alignment: Alignment.center,
                    //     child:  Row(
                    //       children: <Widget>[
                    //          Expanded(
                    //           child:  FlatButton(
                    //             shape:  RoundedRectangleBorder(
                    //               borderRadius:  BorderRadius.circular(30.0),
                    //             ),
                    //             color: Color(0Xffdb3236),
                    //             onPressed: () => {},
                    //             child:  Container(
                    //               child:  Row(
                    //                 mainAxisAlignment: MainAxisAlignment.center,
                    //                 children: <Widget>[
                    //                    Expanded(
                    //                     child:  FlatButton(
                    //                       onPressed: () => {
                    //                         userBloc.signIn().then((User user){
                    //                           userBloc.createUserData(us.User(
                    //                             uid: user.uid,
                    //                             name: user.displayName,
                    //                             email: user.email,
                    //                             photoURL: user.photoURL,
                    //                           ));
                    //                           CloudFirestoreAPI().saveDeviceToken('user');
                    //                         }),
                    //                       },
                    //                       padding: const EdgeInsets.only(
                    //                         top: 20.0,
                    //                         bottom: 20.0,
                    //                       ),
                    //                       child:  Row(
                    //                         mainAxisAlignment:
                    //                         MainAxisAlignment.spaceEvenly,
                    //                         children: const <Widget>[
                    //                           Icon(
                    //                             FontAwesomeIcons.google,
                    //                             color: Colors.white,
                    //                           ),
                    //                           Text(
                    //                             "GOOGLE",
                    //                             textAlign: TextAlign.center,
                    //                             style: TextStyle(
                    //                                 color: Colors.white,
                    //                                 fontWeight:
                    //                                 FontWeight.bold),
                    //                           ),
                    //                         ],
                    //                       ),
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loginForm(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Email'),
              validator: (input) => input.isEmpty ? 'Ingresa un Email' : null,
              onChanged: (val) {
                setState(() => _email = val);
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
              validator: (input) =>
                  input.length < 6 ? 'Ingresa una contraseña mas larga' : null,
              onChanged: (val) {
                setState(() => _password = val);
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(ForgotPasswordRoute);
              },
              child: Container(
                child: Text(
                  "Olvidaste tu contraseña?",
                  style: TextStyle(
                      color: Color(0xffAD8B19),
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            // Container(
            //   width: MediaQuery.of(context).size.width,
            //   height: 45.0,
            //   child: FlatButton(
            //     shape:  RoundedRectangleBorder(
            //       borderRadius:  BorderRadius.circular(30.0),
            //     ),
            //     color: Color(0xffAD8B19),
            //     onPressed: () async {

            //       if(_formKey.currentState.validate()){
            //         dynamic result = await _auth.signInWithEmailAndPassword(_email, _password);
            //         return FirstView();
            //       }
            //     },
            //     child: Text(
            //       "Inicia Sesíon",
            //       style: TextStyle(color: Colors.white, fontSize: 16.0,
            //           fontFamily: "BAHNSCHRIFT"),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _myPreferences.init().then((value) {
      setState(() {
        _myPreferences = value;
      });
    });
  }
}
