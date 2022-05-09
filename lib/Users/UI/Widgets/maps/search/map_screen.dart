import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:after_app/Users/model/place_search.dart';
import 'package:after_app/Users/repository/maps_service.dart';
import 'package:after_app/Widgets/list_credit_card/credit_cards_pago.dart';
import 'package:after_app/Widgets/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final Place place;
  @override
  const MapScreen({Key key, this.place}) : super(key: key);


  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Place _place = Place();
  Uint8List pinLocationIcon;
  List<bool> _isSelected = [false,false,false];
  @override
  initState() {
    super.initState();
    setCustomMarker();
    MapsService().getPlaceDetails(widget.place).then((value) {
      setState(() {
        _place = value;
      });
    });
  }

  void setCustomMarker() async {
    pinLocationIcon = await getBytesFromAsset(path: 'assets/images/Barba.png', width: 100);
  }

  Future<Uint8List> getBytesFromAsset({String path,int width})async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(
        data.buffer.asUint8List(),
        targetWidth: width
    );
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(
        format: ui.ImageByteFormat.png))
        .buffer.asUint8List();
  }

  final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    setState(() {
      _markers.clear();
      final marker = Marker(
        markerId: MarkerId(_place.description),
        position: LatLng(_place.lat, _place.lng),
        icon: BitmapDescriptor.fromBytes(pinLocationIcon),
        infoWindow: InfoWindow(
          title: _place.description,
          snippet: _place.direction,
        ),
      );
      _markers[_place.description] = marker;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(left: 45.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/Barba.png'),
                radius: 26,
                backgroundColor: Colors.transparent,
              ),
              Text('BARBERS  HOME', style:
              TextStyle(
                color: Color(0xff222B45),
                fontWeight: FontWeight.w800,
                fontFamily: "The Foregen Rough One",
              ),
              ),
            ],
          ),
        ),
      ),
      body: _place.lat!=null && pinLocationIcon!=null? Column(
        children: [
          maps(),
          boxOptions(),
        ],
      ):
      Center(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: CircularProgressIndicator( color: Colors.black),
              ),
              Text('Cargando Mapa', style: TextStyle(
                color: Color(0xff222B45),
                fontSize: 16,
              ),),
            ],
          ),
        ),
    );
  }

  Widget maps(){
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.45,
      child: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(_place.lat, _place.lng),
              zoom: 17,
            ),
            markers: _markers.values.toSet(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 20),
              width: MediaQuery.of(context).size.width*0.5,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/images/Máquina de Afeitar.png' ),
                  ),
                  Expanded(
                    child: Text(_place.description.split(',')[0],textAlign: TextAlign.center, style: const TextStyle(
                      color: Color(0xff222B45), fontSize: 14, overflow: TextOverflow.ellipsis, ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget boxOptions(){
    return Container(
      color: Colors.white54,
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 15.0, bottom: 5.0),
            child: const Text(
              'Elige un tipo de corte',
              style: TextStyle( fontSize: 14),
            ),
          ),
          const Divider(color: Colors.grey,thickness: 1, height: 0),
          optionsCorte( 'assets/images/Barba.png','Corte de pelo','10:10 a.m', '\$10.00',0),
          optionsCorte( 'assets/images/Navaja.png','Corte de pelo','10:10 a.m', '\$10.00',1),
          optionsCorte( 'assets/images/Cera.png','Corte de pelo','10:10 a.m', '\$10.00',2),
          //Button solicitar corte
          SizedBox(
            width: MediaQuery.of(context).size.width*0.95,
            child: ElevatedButton(
                onPressed: () {
                  _isSelected.contains(true)?
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CreditCardsPago()),
                    ): null;
                },
                style: ButtonStyle(
                  backgroundColor: _isSelected.contains(true)? MaterialStateProperty.all(lprimaryColor) : MaterialStateProperty.all(Colors.grey),
                ),
                child: const Text('Solicitar corte', style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),)),
          ),
        ],
      ),
    );
  }

  void selectOption(int index){
    setState(() {
      for(int i=0; i<_isSelected.length; i++){
        i==index?_isSelected[i]=true:_isSelected[i]=false;
        }});
  }

  Widget optionsCorte(String pathImg, String title,String hour, String price, int index){
    return GestureDetector(
      onTap: (){
        selectOption(index);
      },
      child: Container(
        color: _isSelected[index]?Colors.grey[200]:Colors.white,
        height: 70,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Image.asset(pathImg, width: 60, height: 60,),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(
                    color: Color(0xff222B45), fontSize: 18, fontWeight: FontWeight.w800,
                  ),),
                  Text(hour, style: const TextStyle(
                    color: Color(0xff222B45), fontSize: 12,
                  ),),
                ],
              ),
            ),
            Expanded(
                child:  Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text(price, style: const TextStyle(
                      color: Color(0xff222B45), fontSize: 18, fontWeight: FontWeight.w800),),
                  ),
                ),
            )
          ],
        ),
      ),
    );
  }

}