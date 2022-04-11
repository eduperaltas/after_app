import 'package:after_app/Users/UI/Widgets/maps/search/map_screen.dart';
import 'package:after_app/Users/model/place_search.dart';
import 'package:after_app/Users/repository/maps_service.dart';
import 'package:flutter/material.dart';

import '../../../../../Widgets/styles/colors.dart';
import '../../../../repository/cloud_firestore_api.dart';


class SearchMap extends StatefulWidget {

  final bool editFav;

  const SearchMap({Key key,this.editFav}) : super(key: key);

  @override
  _SearchMapState createState() => _SearchMapState();

}


class _SearchMapState extends State<SearchMap> {
  final TextEditingController _searchAddresController = TextEditingController();
  final TextEditingController _favoriteController = TextEditingController();
  final CloudFirestoreAPI _firestoreAPI = CloudFirestoreAPI();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
                  // fontSize: MediaQuery.of(context).size.height*0.05,
                ),
              ),
            ],
          ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //SearchBar
            Container(
              //search bar
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10.0,
                    spreadRadius: 2.0,
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 50, right: 40, bottom: 10),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height*0.06,
                  child: TextField(
                    controller: _searchAddresController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Color(0xff222B45),
                      ),
                      hintText: '¿A dónde vamos?',
                      hintStyle: TextStyle(
                        color: Colors.black38,
                        fontSize: MediaQuery.of(context).size.height*0.02,
                      ),
                    ),
                    // onChanged: (value){
                    //   // print(value);
                    //   // MapsService().getPlaces(_searchAddresController.text);
                    //   // _searchAddresController.text = value;
                    // },
                  ),
                ),
              ),
            ),
            iconAndText(Icons.star,'Favoritos',3),
            placeslist()
            //Resultados
          ],
        ),
      ),
    );
  }

  Widget iconAndText(IconData icon,String text, double strkDivider){
    return Container(
      margin: const EdgeInsets.only(top: 10,left: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //circle icon
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: CircleAvatar(child: Icon(icon, color: Colors.white,size: 20,), radius: 15, backgroundColor: Colors.grey),
              ),
              //text
              Expanded(
                child: Text(text, style: const TextStyle(
                  color: Color(0xff222B45),
                  fontSize: 16,
                ),maxLines: 2),
              ),
            ],
          ),
          Divider( color: Colors.grey, thickness:strkDivider),
        ],
      ),
    );
  }

  loading(String text)  {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator( color: Colors.black),
          Text(text, style: const TextStyle(
            color: Color(0xff222B45),
            fontSize: 16,
          ),),
        ],
      ),
    );
  }

  Widget placeslist() {
    return FutureBuilder(
        future: MapsService().getPlaces(_searchAddresController.text),
        builder: (BuildContext context, AsyncSnapshot<List<Place>> snapshot) {
          if (snapshot.hasData) {
            List<Place> placeslst = snapshot.data;
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: placeslst.length,
              itemBuilder: (BuildContext context, int index){
                return GestureDetector(
                  onTap: (){
                    widget.editFav? _displayDialogFavorito(placeslst[index])
                        :Navigator.push(context, MaterialPageRoute(builder: (context) => MapScreen(place: placeslst[index])));
                  },
                    child: iconAndText(Icons.place, placeslst[index].description,1));
              },
            );
          } else {
            return loading('Cargando...');
          }
        });
  }


  _displayDialogFavorito(Place _place) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Expanded(
          child: SimpleDialog(
            title: const Text('Agregar a favoritos'),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _favoriteController,
                  decoration:  InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: lprimaryColor, width: 2.0),
                    ),
                    border: const OutlineInputBorder(),
                    labelText: 'Nombre',
                    labelStyle: const TextStyle(color: Colors.black),
                    hintText: 'Ingrese el nombre de la ubicación',
                  ),
                ),
        ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red[300]),
                    ),
                    child: const Text('Cancelar'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ElevatedButton(
                      onPressed: (){
                        _firestoreAPI.createUseraddress(_place, true, _favoriteController.text);
                        // Navigator.pop(context);
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(lprimaryColor),
                      ),
                      child: const Text('Agregar'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}