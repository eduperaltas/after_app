// @dart=2.9

import 'package:after_app/Users/model/directions_model.dart';
import 'package:after_app/Users/repository/directions_repository.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapsRouting extends StatefulWidget {
  @override
  _MapsRoutingState createState() => _MapsRoutingState();
}

class _MapsRoutingState extends State<MapsRouting> {
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(-12.0464, -77.0428),
    zoom: 11.5,
  );
  GoogleMapController _googleMapController;
  Marker _origin;
  Marker _destination;
  Directions _info;
  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        alignment: Alignment.center,
        children: [
          GoogleMap(
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            initialCameraPosition: _initialCameraPosition,
            onMapCreated: (controller) => _googleMapController = controller,
            markers: {
              if (_origin != null) _origin,
              if (_destination != null) _destination
            },
            polylines: {
              if (_info != null)
                Polyline(
                  polylineId:PolylineId('overview_polyline'),
                  color: Color(0xffAD8B19),
                  width: 5,
                  points: _info.polylinePoints
                      .map((e) => LatLng(e.latitude, e.longitude))
                      .toList(),
                ),
            },
            onLongPress: _addMarker,
          ),
          if (_info != null)
            Positioned(
              top: 100.0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 6.0,
                  horizontal: 12.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      blurRadius: 6.0,
                    )
                  ],
                ),
                child: Text(
                  '${_info.totalDuration}',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          Padding(padding: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.72,),
              child: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 400,
                  child: Stack(
                    children: <Widget>[
                      AnimatedPositioned(
                        width: selected ? MediaQuery.of(context).size.width : MediaQuery.of(context).size.width,
                        height: selected ? MediaQuery.of(context).size.height*0.5 : MediaQuery.of(context).size.height*0.1,
                        top: selected ? 10 : 150,
                        duration: const Duration(seconds: 2),
                        curve: Curves.fastOutSlowIn,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selected = !selected;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                              top: 8.0,),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30.0),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: Colors.black38,
                                      blurRadius: 15.0,
                                      offset: Offset(0.0, 0.7))]
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: MediaQuery.of(context).size.height*0.05,
                                      width: MediaQuery.of(context).size.width*0.2,
                                      child: Text("Fecha: Hora:",style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: MediaQuery.of(context).size.height*0.018
                                      ),),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width*0.25,
                                    ),
                                    CircleAvatar(
                                        radius: MediaQuery.of(context).size.height*0.025,
                                        backgroundColor: Colors.white,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: AssetImage("assets/images/APP - Pantalla Foto Perfil Referencial.png")
                                            ),
                                          ),)),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      child: Text("NOMBRE APELLIDO", style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: MediaQuery.of(context).size.width*0.024,
                                        fontWeight: FontWeight.w400,
                                      ),),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 30,
                                      child: Text("Barbero: Juan Lopez",style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "BAHNSCHRIFT",
                                        fontSize:   15,
                                      ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Container(
                                      height: 30,
                                      child: Text("Costo: s/35",style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "BAHNSCHRIFT",
                                        fontSize:   15,
                                      ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                        child: Center(
                                          child: Icon(
                                              Icons.credit_card
                                          ),
                                        )
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Container(
                                      height: 30,
                                      child: Center(
                                          child: Text("Visa 44525",style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "BAHNSCHRIFT",
                                            fontSize:   15,
                                          ),
                                          ),)
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 30,
                                  child: Center(
                                    child: Text("Origen: Av. Alejandro Velasco Astete 983",style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "BAHNSCHRIFT",
                                      fontSize:   15,
                                    ),
                                    ),
                                  )
                                ),
                                Container(
                                  height: 30,
                                  child: Text("Destino: Avenida Javier Prado Este 4200",style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "BAHNSCHRIFT",
                                    fontSize:   15,
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
                )
                ,
              )
          ),

        ],
      ),
      /*floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.black,
        onPressed: () => _googleMapController.animateCamera(
          _info != null
              ? CameraUpdate.newLatLngBounds(_info.bounds, 100.0)
              : CameraUpdate.newCameraPosition(_initialCameraPosition),
        ),
        child: const Icon(Icons.center_focus_strong),
      ),*/
    );
  }
  void _addMarker(LatLng pos) async {
    if (_origin == null || (_origin != null && _destination != null)) {
      // Origin is not set OR Origin/Destination are both set
      // Set origin
      setState(() {
        _origin = Marker(
          markerId:  MarkerId('origin'),
          infoWindow: const InfoWindow(title: 'Origin'),
          icon:
          BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          position: pos,
        );
        // Reset destination
        _destination = null;

        // Reset info
        _info = null;
      });
    } else {
      // Origin is already set
      // Set destination
      setState(() {
        _destination = Marker(
          markerId: MarkerId('destination'),
          infoWindow: const InfoWindow(title: 'Destination'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          position: pos,
        );
      });

      // Get directions
      final directions = await DirectionsRepository()
          .getDirections(origin: _origin.position, destination: pos);
      setState(() => _info = directions);
    }
  }
}