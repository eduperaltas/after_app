// @dart=2.9
import 'package:after_app/Users/bloc/bloc_user.dart';
import 'package:after_app/Users/model/user.dart';
import 'package:after_app/Users/repository/firebase_auth_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

import 'confimation_screen.dart';

class Profile extends StatefulWidget {
  User user;
  String phonenumber;
  Profile(@required this.user);
  @override
  State createState() {
    return _Profile(user);
  }
}
class _Profile extends State<Profile> {
  User user;
  String phonenumber;
  _Profile(@required this.user);
  UserBloc userBloc;
  final  FirebaseAuthAPI _auth = FirebaseAuthAPI();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBloc>(context);
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Text("Nombre: "+
                            user.name, style: TextStyle(
                            fontSize: 20,
                            fontFamily: "Lato",
                            fontWeight: FontWeight.w600
                        ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width*0.70,
                        child: Text("Email: "+
                            user.email, style: TextStyle(
                            fontSize: 20,
                            fontFamily: "BAHNSCHRIFT",
                            fontWeight: FontWeight.w600
                        ),
                        ),
                      ),
                      Icon(
                        Icons.check_circle,
                        color: Color(0xffAD8B19),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  child: Text("Numero de telefono: ",
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: "BAHNSCHRIFT",
                        fontWeight: FontWeight.w600
                    ),
                  ),
                ),SizedBox(
                  height: 10.0,
                ),
                Form(
                  key: _formKey,
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: user.phonenumber
                    ),
                    obscureText: false,
                    cursorColor: Color(0xffAD8B19),
                    validator: (input)=> input.isEmpty ? 'Ingrese un número de teléfono' : null,
                    onChanged: (val){
                      setState(() {
                        phonenumber= val;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 90.0,
                ),

                FloatingActionButton.extended(
                  onPressed: () {
                     if(_formKey.currentState.validate()){
                       userBloc.updateUserData(user, phonenumber);
                     }
                  },
                  label: Text('Guardar cambios'),
                  icon: Icon(Icons.save),
                  backgroundColor: Colors.grey,
                ),
                SizedBox(
                  height: 30.0,
                ),

                FloatingActionButton.extended(
                  onPressed: () {
                    userBloc.signOut();
                  },
                  label: Text('Cerrar sesion'),
                  icon: Icon(Icons.exit_to_app),
                  backgroundColor: Color(0xffAD8B19),
                ),
              ],
            ),
          ),
        ));


  }}