import 'package:after_app/Widgets/MyPreferences.dart';
import 'package:flutter/material.dart';
import 'package:place_picker/place_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class SearchMap extends StatefulWidget {

  final bool dirfavoritos;

  const SearchMap({Key key,this.dirfavoritos}) : super(key: key);

  static final kInitialPosition = LatLng(-33.8567844, 151.213108);

  @override
  _SearchMapState createState() => _SearchMapState();

}

class _SearchMapState extends State<SearchMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Picker Example')),
      body: Center(
        child: FlatButton(
          child: Text("Pick Delivery location"),
          onPressed: () {
            // showPlacePicker();
          },
        ),
      ),
    );
  }

  void showPlacePicker() async {
    LocationResult result = await Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => PlacePicker("AIzaSyCjPT6CPuggcxtQ3LG9VHRiTe8DH8zHDoU")));

    // Handle the result in your way
    print(result);
  }
}