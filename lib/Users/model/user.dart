// @dart=2.9
import 'package:flutter/material.dart';

class User {

  final String uid;
  final String name;
  final String email;
  final String photoURL;
  final String phonenumber;

  //myFavoritePlaces
  //myPlaces
  User({
   Key Key,
   @required this.uid,
   @required this.name,
   @required this.email,
   @required this.photoURL,
    this.phonenumber,
   });
}


class Barber {

  final String uid;
  final String name;
  final String email;
  final String photoURL;
  final String phonenumber;
  final String bank;
  final String accountname;
  final String numAccount;
  final String CCI;

  //myFavoritePlaces
  //myPlaces
  Barber({
    Key Key,
    @required this.uid,
    @required this.name,
    @required this.email,
    @required this.photoURL,
    this.phonenumber,
    this.bank,
    this.accountname,
    this.numAccount,
    this.CCI,
  });
}





class UserId {
  final String uid;

  UserId({ this.uid });
}
