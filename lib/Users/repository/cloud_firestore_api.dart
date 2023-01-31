// @dart=2.9
import 'package:after_app/Users/UI/Widgets/maps/search/user_places.dart';
import 'package:after_app/Users/repository/auth_repository.dart';
import 'package:after_app/Users/repository/maps_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:after_app/Users/model/card.dart';
import 'package:after_app/Users/model/user.dart';
import 'package:after_app/Widgets/add_credit_card/credit_card_model.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

import '../model/place_search.dart';

class CloudFirestoreAPI {
  final String USERS = "users";
  final String BARBERS = "barbers";
  String _currentUid = 'asd';
  String favorito;

  CloudFirestoreAPI({this.favorito});

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  void createUserData(User user) async {
    DocumentReference ref = _db
        .collection(USERS)
        .doc(_currentUid)
        .collection('datos')
        .doc(user.uid);
    return await ref.set({
      'uid': user.uid,
      'name': user.name,
      'email': user.email,
      'photoUrl': user.photoURL,
      'phonenumber': user.phonenumber,
      'lastSingIn': DateTime.now()
    });
  }

  void saveDeviceToken(String tipoUsuario) async {
    // FirebaseUser user = await _auth.currentUser();

    // Get the token for this device
    String fcmToken = await _fcm.getToken();
    if (tipoUsuario == 'user') {
      // Save it to Firestore
      DocumentReference ref = _db
          .collection(USERS)
          .doc(_currentUid)
          .collection('tokens')
          .doc(fcmToken);
      print("el token del telefono es: " + fcmToken);
      if (fcmToken != null) {
        _fcm.subscribeToTopic('usuario');
        return await ref.set({
          'token': fcmToken,
          'createdAt': FieldValue.serverTimestamp(), // optional
          'platform': Platform.operatingSystem // optional
        });
      }
    }
    if (tipoUsuario == 'barber') {
      // Save it to Firestore
      DocumentReference ref = _db
          .collection(BARBERS)
          .doc(BARBERS)
          .collection(_currentUid)
          .doc('tokens')
          .collection('tokens')
          .doc(fcmToken);
      print("el token del telefono es: " + fcmToken);
      if (fcmToken != null) {
        _fcm.subscribeToTopic('barbero');
        return await ref.set({
          'token': fcmToken,
          'createdAt': FieldValue.serverTimestamp(), // optional
          'platform': Platform.operatingSystem // optional
        });
      }
    }
  }

  void createUserCard(CreditCardModel card) async {
    DocumentReference ref = _db
        .collection(USERS)
        .doc(_currentUid)
        .collection('tarjetas')
        .doc("tarjeta" + card.cardNumber);
    String cid = "tarjeta" + card.cardNumber;
    return await ref.set({
      'number': card.cardNumber,
      'cardid': cid,
      'expirateDate': card.expiryDate,
      'cardHolder': card.cardHolderName,
      'cvv': card.cvvCode,
    });
  }

  Future<void> deleteUserCard(String cardUid) {
    return _db
        .collection(USERS)
        .doc(_currentUid)
        .collection('tarjetas')
        .doc(cardUid)
        .delete();
  }

  void createUseraddress(Place place, bool favo, String favoName) async {
    String uid = AuthRepository().getCurrentUserData().uid;
    place = await MapsService().getPlaceDetails(place);
    DocumentReference ref =
        _db.collection(USERS).doc(_currentUid).collection('direcciones').doc();
    return await ref.set({
      'placeId': place.placeId,
      'description': place.description,
      'direccion': place.direction,
      'latitud': place.lat,
      'longitud': place.lng,
      'favorite': favo,
      'favName': favoName,
    });
  }

  Future<void> updateUserData(User user, String newData) async {
    DocumentReference ref =
        _db.collection(USERS).doc(user.uid).collection('datos').doc(user.uid);
    return await ref.update({
      'phonenumber': newData,
    });
  }

  User userDataFromSnapshot(DocumentSnapshot snapshot) {
    return User(
        uid: snapshot['uid'],
        name: snapshot['name'],
        email: snapshot['email'],
        photoURL: snapshot['photoUrl'],
        phonenumber: snapshot['phonenumber']);
  }

  Stream<User> get userData {
    return _db
        .collection(USERS)
        .doc(_currentUid)
        .collection('datos') //necesito sacar el uid
        .doc(_currentUid)
        .snapshots()
        .map(userDataFromSnapshot);
  }

  //obteniendo direcciones favoritas
  List<Place> userDirectionsSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Place(
          placeId: doc['placeId'],
          description: doc['description'],
          direction: doc['direccion'],
          lat: doc['latitud'],
          lng: doc['longitud'],
          isFavorite: doc['favorite'],
          favName: doc['favName']);
    }).toList();
  }

  Stream<List<Place>> get userDirections {
    return _db
        .collection(USERS)
        .doc(_currentUid)
        .collection('direcciones')
        .snapshots()
        .map(userDirectionsSnapshot);
  }

  // card list from snapshot
  List<CardModel> _cardListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return CardModel(
        cardNumber: doc['number'],
        expiryDate: doc['expirateDate'],
        carduid: doc['cardid'],
        cardHolderName: doc['cardHolder'],
        cvvCode: doc['cvv'],
      );
    }).toList();
  }

  // get card stream
  Stream<List<CardModel>> get cards {
    return _db
        .collection(USERS)
        .doc(_currentUid)
        .collection('tarjetas') //necesito sacar el uid
        .snapshots()
        .map(_cardListFromSnapshot);
  }

// get directions stream

  List<FavoritePlacesModel> _directionsListFromSnapshot(
      QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return FavoritePlacesModel(
        direccion: doc['direccion'],
      );
    }).toList();
  }

  // get card stream
  Stream<List<FavoritePlacesModel>> get favoriteplaces {
    return _db
        .collection(USERS)
        .doc(_currentUid)
        .collection('direcciones') //necesito sacar el uid
        .snapshots()
        .map(_directionsListFromSnapshot);
  }

//////////////////////////////////////////////////BARBERS//////////////////////////////////////////////////////////////////////////////

  void createBarberData(User user, String bank, String nameaccount,
      String numaccount, String cci) async {
    DocumentReference ref =
        _db.collection(BARBERS).doc(BARBERS).collection(user.uid).doc('datos');
    return await ref.set({
      'uid': user.uid,
      'active': false,
      'name': user.name,
      'email': user.email,
      'photoUrl': user.photoURL,
      'phonenumber': user.phonenumber,
      'lastSingIn': DateTime.now(),
      'bank': bank,
      'accountname': nameaccount,
      'numAccount': numaccount,
      'CCI': cci
    });
  }

  void createBarberDocument(String documento, String url) async {
    DocumentReference ref = _db
        .collection(BARBERS)
        .doc(BARBERS)
        .collection(_currentUid)
        .doc('documentos')
        .collection('dni')
        .doc('dni');
    return await ref.set({
      'photoUrl': url,
      'lastUpdate': DateTime.now(),
      'approved': false,
    });
  }

  void createBarberProfile(String urlprofile, String name, String study,
      String work, String direction, String description) async {
    DocumentReference ref = _db
        .collection(BARBERS)
        .doc('profile')
        .collection('profile')
        .doc(_currentUid);
    return await ref.set({
      'active': false,
      'uid': _currentUid,
      'photo profile': urlprofile,
      'name': name,
      'study': study,
      'work': work,
      'direction': direction,
      'description': description,
      'lastUpdate': DateTime.now(),
    });
  }

  Future<void> updateBarberphoto(String llamado, String photo1) async {
    DocumentReference ref = _db
        .collection(BARBERS)
        .doc('profile')
        .collection('profile')
        .doc(_currentUid);
    return await ref.set({
      llamado: photo1,
    });
  }

  //Obteniendo perfil de barbero

  // BarberProfileData barberProfileDataFromSnapshot(DocumentSnapshot snapshot) {
  //   return BarberProfileData(
  //       name: snapshot['name'],
  //       direction: snapshot['direction'],
  //       description: snapshot['description'],
  //       study: snapshot['study'],
  //       work: snapshot['work'],
  //       Profilephoto: snapshot['photo profile'],
  //       photo1: snapshot['photo1'],
  //       photo2: snapshot['photo2'],
  //       photo3: snapshot['photo3'],
  //   );
  // }
  //
  //
  // Stream<BarberProfileData> get barberProfileData {
  //   return _db.collection(BARBERS).doc('profile').collection('profile') //necesito sacar el uid
  //       .doc(_currentUid).snapshots()
  //       .map(barberProfileDataFromSnapshot);
  // }

  Barber barberDataFromSnapshot(DocumentSnapshot snapshot) {
    return Barber(
        uid: snapshot['uid'],
        name: snapshot['name'],
        email: snapshot['email'],
        photoURL: snapshot['photoUrl'],
        phonenumber: snapshot['phonenumber'],
        bank: snapshot['bank'],
        accountname: snapshot['accountname'],
        numAccount: snapshot['numAccount'],
        CCI: snapshot['CCI']);
  }

  Stream<Barber> get barberData {
    return _db
        .collection(BARBERS)
        .doc(BARBERS)
        .collection(_currentUid)
        .doc('datos')
        .snapshots()
        .map(barberDataFromSnapshot);
  }

  Future<void> updatebarberData(String phone, String bank, String numaccount,
      String cci, String accountname) async {
    DocumentReference ref = _db
        .collection(BARBERS)
        .doc(BARBERS)
        .collection(_currentUid)
        .doc('datos');
    return await ref.set({
      'phonenumber': phone,
      'bank': bank,
      'accountname': accountname,
      'numAccount': numaccount,
      'CCI': cci,
      'lastSingIn': DateTime.now()
    });
  }

/////////////////////////////////////////////////////Comentarios de barbero /////////////////////////////////////////////////////////////////////////

  void createBarberReview(
      String barberuid, String comentario, double estrellas) async {
    DocumentReference ref = _db
        .collection(BARBERS)
        .doc('Reviews')
        .collection(barberuid)
        .doc(DateTime.now().toString());
    return await ref.set({
      'comentario': comentario,
      'autoruid': _currentUid,
      'estrellas': estrellas,
      'Fecha': DateTime.now(),
    });
  }

  /////////////////////////////////////////////////////Barberos Activos /////////////////////////////////////////////////////////////////////////

  void activeBarber() async {
    _fcm.subscribeToTopic('barberoActivo');
    print('suscrito como barberoActivo');
  }

  void inactiveBarber() async {
    _fcm.unsubscribeFromTopic('barberoActivo');
    print('dessuscrito como barberoActivo');
  }

  Future<void> updateBarberStateData(bool newData) async {
    DocumentReference ref = _db
        .collection(BARBERS)
        .doc(BARBERS)
        .collection(_currentUid)
        .doc('datos');
    return await ref.update({
      'active': newData,
    });
  }

  Future<void> updateBarberStateProfile(bool newData) async {
    DocumentReference ref = _db
        .collection(BARBERS)
        .doc('profile')
        .collection('profile')
        .doc(_currentUid);
    return await ref.update({
      'active': newData,
    });
  }

/////////////////////////////////////////////////////SERVICIOS/////////////////////////////////////////////////////////////////////////
  void createServicesDocument(
      var latitude,
      var longitude,
      String direction,
      String tipoDeServicio,
      String barbero,
      String corte,
      int precio,
      var fecha,
      var hora) async {
    print("Se creara:" + tipoDeServicio);
    if (tipoDeServicio == 'inmediato') {
      DocumentReference ref = _db
          .collection('servicios')
          .doc('solicitudes')
          .collection('inmediato')
          .doc();
      return await ref.set({
        'useruid': _currentUid,
        'corte': corte,
        'direccion': direction,
        'latitude': latitude,
        'longitude': longitude,
        'docid': ref.id,
        'precio': precio,
        'hora de pedido': DateTime.now(),
      });
    }
    if (tipoDeServicio == 'escoge') {
      DocumentReference ref = _db
          .collection('servicios')
          .doc('solicitudes')
          .collection('escoge')
          .doc();
      return await ref.set({
        'useruid': _currentUid,
        'corte': corte,
        'barberuid': barbero,
        'direccion': direction,
        'latitude': latitude,
        'longitude': longitude,
        'docid': ref.id,
        'precio': precio,
        'hora de pedido': DateTime.now(),
      });
    }

    if (tipoDeServicio == 'reserva') {
      DocumentReference ref = _db
          .collection('servicios')
          .doc('solicitudes')
          .collection('reserva')
          .doc();
      return await ref.set({
        'useruid': _currentUid,
        'corte': corte,
        'fecha': fecha,
        'hora': hora,
        'barberuid': barbero,
        'direccion': direction,
        'latitude': latitude,
        'longitude': longitude,
        'docid': ref.id,
        'precio': precio,
        'hora de pedido': DateTime.now(),
      });
    }
  }
}
