// @dart=2.9
import 'package:after_app/Users/bloc/bloc_user.dart';
import 'package:after_app/Users/model/user.dart' as us;
import 'package:after_app/Users/repository/cloud_firestore_api.dart';
import 'package:after_app/Users/repository/firebase_auth_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:after_app/Widgets/styles/colors.dart';
import 'package:page_transition/page_transition.dart';
import '../../../router.dart';
import 'home_page_user.dart';

class RegisterUser extends StatefulWidget {
  @override
  _RegisterUserState createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  final FirebaseAuthAPI _auth = FirebaseAuthAPI();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password, _name, _phonenumber;
  String error = "";
  UserBloc userBloc;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    userBloc = BlocProvider.of(context);
    return _handleCurrentSession();
  }

  Widget _handleCurrentSession() {
    return SignUp();
  }

  Widget SignUp() {
    final ThemeData _theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: _theme.scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        elevation: 0,
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
              Navigator.of(context).pushNamed(LoginUserRoute);
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                "Inicia Sesión",
                style: TextStyle(
                  fontFamily: "BAHNSCHRIFT",
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
          padding:
              EdgeInsets.only(left: 15.0, right: 15.0, bottom: 5.0, top: 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "Regístrate",
                  style: _theme.textTheme.titleLarge.merge(
                    TextStyle(fontSize: 30.0, fontFamily: "BAHNSCHRIFT"),
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              _signupForm(),
              SizedBox(
                height: 30.0,
              ),

              // Container(
              //   width: MediaQuery.of(context).size.width,
              //   margin: EdgeInsets.only(bottom: 10.0),
              //   height: 45.0,
              //   child: FlatButton(
              //     shape: new RoundedRectangleBorder(
              //       borderRadius: new BorderRadius.circular(30.0),
              //     ),
              //     color: Color(0xffAD8B19),
              //     onPressed: () async {
              //       if(_formKey.currentState.validate()){
              //         dynamic result = await _auth.registerWithEmailAndPassword(_email, _password).then((User user)
              //         {userBloc.createUserData(us.User(
              //           uid: user.uid,
              //           name: _name,
              //           email: _email,
              //           photoURL: "https://image.flaticon.com/icons/png/512/16/16363.png",
              //           phonenumber:_phonenumber,
              //         ));
              //         CloudFirestoreAPI().saveDeviceToken('user');
              //         });

              //       }
              //       Navigator.push(context, PageTransition(child: HomePageUser(), type: PageTransitionType.rightToLeftWithFade));
              //       },

              //     child: Text(
              //       "Regístrate",
              //       style: TextStyle(color: Colors.white, fontSize: 16.0),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signupForm() {
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              margin: const EdgeInsets.only(left: 0, top: 0, right: 0),
              child: TextFormField(
                  cursorColor: Color(0xffAD8B19),
                  style: TextStyle(
                      //color: Color(0xffAD8B19),
                      ),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nombre',
                      hintText: 'Ingresa tu nombre'),
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  validator: (input) =>
                      input.isEmpty ? 'introduce tu nombre' : null,
                  onChanged: (input) {
                    setState(() => _name = input);
                  }),
            ),
            SizedBox(
              height: 5.0,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              margin: const EdgeInsets.only(left: 0, top: 2, right: 0),
              child: TextFormField(
                  cursorColor: Color(0xffAD8B19),
                  style: TextStyle(
                      //color: Color(0xffAD8B19),
                      ),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      hintText: 'Ingresa tu email'),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: (input) =>
                      input.isEmpty ? 'coloca tu email' : null,
                  onChanged: (input) {
                    setState(() => _email = input);
                  }),
            ),
            SizedBox(
              height: 5.0,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              margin: const EdgeInsets.only(left: 0, top: 2, right: 0),
              child: TextFormField(
                  cursorColor: Color(0xffAD8B19),
                  style: TextStyle(
                      //color: Color(0xffAD8B19),
                      ),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Numero de Telefono',
                      hintText: 'Ingresa tu Telefono'),
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  validator: (input) =>
                      input.isEmpty ? 'introduce tu numero de telefono' : null,
                  onChanged: (input) {
                    setState(() => _phonenumber = input);
                  }),
            ),
            SizedBox(
              height: 5.0,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              margin: const EdgeInsets.only(left: 0, top: 2, right: 0),
              child: TextFormField(
                cursorColor: Color(0xffAD8B19),
                style: TextStyle(
                    //color: Color(0xffAD8B19),
                    ),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'contraseña',
                    hintText: 'Ingresa tu contraseña'),
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,
                validator: (input) => input.length < 6
                    ? 'Coloca una contraseña de mini 6 caracteres'
                    : null,
                onChanged: (input) {
                  setState(() => _password = input);
                },
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(
              "Apretando \"Regístrate\" aceptas  nuestros términos y condiciones así como nuestra política de privacidad",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: dbasicDarkColor),
            )
          ],
        ),
      ),
    );
  }
}
