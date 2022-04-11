import 'dart:convert';

import 'package:after_app/Users/model/place_search.dart';
import 'package:http/http.dart' as http;

class MapsService {
  final String key ='AIzaSyCjPT6CPuggcxtQ3LG9VHRiTe8DH8zHDoU';

  Future<List<Place>> getPlaces(String place) async {
    var url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$place&key=$key&components=country:PE';
    var response = await http.get(Uri.parse(url));
    var json = jsonDecode(response.body);
    var jsonResults = json['predictions'] as List;
    List<Place> places = jsonResults.map((p) => Place.fromJson(p)).toList();
    return places;
  }

  Future<Place> getPlaceDetails(Place place) async {
    String placeId = place.placeId;
    var url = 'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$key';
    var response = await http.get(Uri.parse(url));
    var json = jsonDecode(response.body);
    var jsonResults = json['result'] as Map;
    place.direction = jsonResults['formatted_address'];
    place.lat = jsonResults['geometry']['location']['lat'];
    place.lng = jsonResults['geometry']['location']['lng'];
    return place;
  }

}