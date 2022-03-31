// @dart=2.9
import 'package:after_app/Users/repository/firebase_auth_api.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:after_app/Users/bloc/bloc_user.dart';
import 'package:after_app/Users/model/user.dart' as us;
import '../../../router.dart';
import 'home_page_user.dart';
//import 'package:shared_preferences/shared_preferences.dart';
class ForgotPassword extends StatefulWidget {

  @override

  State createState() {
    return _ForgotPassword();
  }
}


class _ForgotPassword extends State<ForgotPassword> {
  us.User user;

  final  FirebaseAuthAPI _auth = FirebaseAuthAPI();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password;
  String error ="";
  UserBloc userBloc;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    userBloc = BlocProvider.of(context);
    return _handleCurrentSession();
  }

  Widget _handleCurrentSession(){
    return StreamBuilder(
      stream: userBloc.authStatus,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        //snapshot- data - Object User
        if(!snapshot.hasData || snapshot.hasError) {
          return LoginUser(snapshot);
        } else {
          return HomePageUser();
        }
      },
    );

  }
  Widget  LoginUser(AsyncSnapshot snapshot){
    //user =User(phonenumber:  phonenumber);
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
              child: Text(
                "Regístrate",
                style: TextStyle(
                  color: Color(0xffAD8B19),
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
          padding: EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  "Correo de Recuperación",
                  style: _theme.textTheme.titleLarge.merge(
                    TextStyle(
                      fontFamily: "BAHNSCHRIFT",
                      fontSize: 30.0,
                      color: Colors.black,),
                  ),
                ),
              ),

              SizedBox(
                height: 30.0,
              ),
              _loginForm(context),
              SizedBox(
                height: 30.0,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin:
                const EdgeInsets.only(left: 30.0, right: 30.0, top: 0.0),
                alignment: Alignment.center,
                child: Row(
                  children: <Widget>[
                    new Expanded(
                      child: new Container(
                        margin: EdgeInsets.all(8.0),
                        decoration:
                        BoxDecoration(border: Border.all(width: 0.25)),
                      ),
                    ),
                    Text(
                      "O ingresa con",
                      style: TextStyle(
                        fontFamily: "BAHNSCHRIFT",
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    new Expanded(
                      child: new Container(
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
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new Container(
                        margin: EdgeInsets.only(right: 8.0),
                        alignment: Alignment.center,
                        child: new Row(
                          children: <Widget>[
                            new Expanded(
                              child: new FlatButton(
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30.0),
                                ),
                                color: Color(0Xff3B5998),
                                onPressed: () {
                                  print("R");
                                },
                                child: new Container(
                                  child: new Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Expanded(
                                        child: new FlatButton(
                                          onPressed: () => {
                                            userBloc.facebookSignIn().then((User user) {
                                              userBloc.createUserData(us.User(
                                                uid: user.uid,
                                                name: user.displayName,
                                                email: user.email,
                                                photoURL: user.photoURL,
                                              ));
                                            })
                                          },
                                          padding: EdgeInsets.only(
                                            top: 20.0,
                                            bottom: 20.0,
                                          ),
                                          child: new Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              Icon(
                                                FontAwesomeIcons.facebookSquare,
                                                color: Colors.white,
                                              ),
                                              Text(
                                                "FACEBOOK",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    new Expanded(
                      child: new Container(
                        margin: EdgeInsets.only(left: 8.0),
                        alignment: Alignment.center,
                        child: new Row(
                          children: <Widget>[
                            new Expanded(
                              child: new FlatButton(
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30.0),
                                ),
                                color: Color(0Xffdb3236),
                                onPressed: () => {},
                                child: new Container(
                                  child: new Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Expanded(
                                        child: new FlatButton(
                                          onPressed: () => {
                                            userBloc.signIn().then((User user){
                                              userBloc.createUserData(us.User(
                                                uid: user.uid,
                                                name: user.displayName,
                                                email: user.email,
                                                photoURL: user.photoURL,
                                              ));
                                            }),
                                          },
                                          padding: EdgeInsets.only(
                                            top: 20.0,
                                            bottom: 20.0,
                                          ),
                                          child: new Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              Icon(
                                                FontAwesomeIcons.google,
                                                color: Colors.white,
                                              ),
                                              Text(
                                                "GOOGLE",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
              decoration: InputDecoration(
                  labelText: 'Email'
              ),
              validator: (input)=> input.isEmpty ? 'Ingresa un Email' : 'Se envio un enlace de recuperación al correo seleccionado',
              onChanged: (val){
                setState(() => _email = val);
              },

            ),
            SizedBox(
              height: 20.0,
            ),
            SizedBox(
              height: 25.0,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 45.0,
              child: FlatButton(
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
                color: Color(0xffAD8B19),
                onPressed: () async {
                  if(_formKey.currentState.validate()){
                    Text("Un enlace de recuperación fue enviado a tu correo");
                    await _auth.sendPasswordResetEmail(_email);

                  }
                },
                child: Text(
                  "Enviar nueva contraseña",
                  style: TextStyle(color: Colors.white, fontSize: 16.0,fontFamily: "BAHNSCHRIFT",),
                ),
              ),
            )
          ],
        ),

      ),
    );
  }

}
