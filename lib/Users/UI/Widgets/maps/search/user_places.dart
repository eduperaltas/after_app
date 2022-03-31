// @dart=2.9
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserPlacesModel {
  LatLng latitude  ;
  LatLng longitude ;
  String direccion = '';


  UserPlacesModel(this.latitude, this.longitude, this.direccion,);
}

class FavoritePlacesModel {
  String direccion = '';


  FavoritePlacesModel( {this.direccion,});
}
