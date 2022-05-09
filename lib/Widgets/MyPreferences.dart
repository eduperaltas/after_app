// @dart=2.9
import 'package:shared_preferences/shared_preferences.dart';

class MyPreferences {
  static const AUTOMATIC = "automatic";
  static const UID = "uid";
  static const FAVORITE = "favorite";
  static const DIRECTION = "direction";
  static const SERVICIO = "servicio";
  static const BARBER = "barber";
  static const CORTE = "corte";
  static const LATITUDE = "latitude";
  static const LONGITUDE = "longitude";
  static const FECHA = "fecha";
  static const CONTADOR = "contador";
  static const HORA = "hora";
  static const ACTIVE = "active";

  static final MyPreferences instance = MyPreferences._internal();

  //Campos a manejar
  SharedPreferences _sharedPreferences;
  bool automatic = true;
  bool active = false;
  String uid = "";
  String favorite = "";
  String barber = "";
  String corte = "";
  String direction = "";
  String servicio = "";
  var latitude;
  var longitude;
  var contador;
  var fecha;
  var hora;

  MyPreferences._internal() {}

  factory MyPreferences() => instance;

  Future<SharedPreferences> get preferences async {
    if (_sharedPreferences != null) {
      return _sharedPreferences;
    } else {
      _sharedPreferences = await SharedPreferences.getInstance();
      automatic = _sharedPreferences.getBool(AUTOMATIC);
      active = _sharedPreferences.getBool(ACTIVE);
      uid = _sharedPreferences.getString(UID);
      favorite = _sharedPreferences.getString(FAVORITE);
      direction = _sharedPreferences.getString(DIRECTION);
      barber = _sharedPreferences.getString(BARBER);
      corte = _sharedPreferences.getString(CORTE);
      servicio = _sharedPreferences.getString(SERVICIO);
      latitude = _sharedPreferences.getString(LATITUDE);
      longitude = _sharedPreferences.getString(LONGITUDE);
      contador = _sharedPreferences.getString(CONTADOR);
      fecha = _sharedPreferences.getString(FECHA);
      hora = _sharedPreferences.getString(HORA);

      if (automatic == null) {
        automatic = false;
        active;
        uid = "";
        favorite = "";
        direction = "";
        corte = "";
        barber = "";
        servicio = "";
        corte = "";
        latitude = "";
        longitude = "";
        contador = "";
        fecha = "";
        hora = "";
      }
      return _sharedPreferences;
    }
  }

  Future<bool> commit() async {
    await _sharedPreferences.setBool(AUTOMATIC, automatic);
    await _sharedPreferences.setBool(ACTIVE, active);
    await _sharedPreferences.setString(UID, uid);
    await _sharedPreferences.setString(FAVORITE, favorite);
    await _sharedPreferences.setString(DIRECTION, direction);
    await _sharedPreferences.setString(BARBER, barber);
    await _sharedPreferences.setString(CORTE, corte);
    await _sharedPreferences.setString(SERVICIO, servicio);
    await _sharedPreferences.setInt(LATITUDE, latitude);
    await _sharedPreferences.setInt(CONTADOR, contador);
    await _sharedPreferences.setInt(LONGITUDE, longitude);
    await _sharedPreferences.setInt(FECHA, fecha);
    await _sharedPreferences.setInt(HORA, hora);
  }

  Future<MyPreferences> init() async {
    _sharedPreferences = await preferences;
    return this;
  }
}
