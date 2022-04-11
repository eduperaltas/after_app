// @dart=2.9
import 'package:after_app/Users/UI/Widgets/maps/search/search_place.dart';
import 'package:after_app/Widgets/MyPreferences.dart';
import 'package:after_app/Widgets/styles/colors.dart';
import 'package:flutter/material.dart';

import '../../model/place_search.dart';
import '../../repository/cloud_firestore_api.dart';

class UserFavorites extends StatefulWidget {
  String uiduser;

  UserFavorites({Key key, this.uiduser}) : super(key: key);

  @override
  _UserFavoritesState createState() => _UserFavoritesState();
}


class _UserFavoritesState extends State<UserFavorites> {
  String direccion= "no hay direccion guardada";
  final CloudFirestoreAPI _firestoreAPI = CloudFirestoreAPI();
  List<Place> _lstPlaces;
  List<Place> _favotitePlaces;
  List<Place> _recentPlaces;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream: _firestoreAPI.userDirections,
      builder: (context,AsyncSnapshot snapshot) {
        if(snapshot.hasData){
          _lstPlaces = snapshot.data;
          _favotitePlaces = _lstPlaces.where((p) => p.isFavorite).toList();
          _recentPlaces = _lstPlaces.where((p) => !p.isFavorite).toList();
        }
        return SingleChildScrollView(
          child: !snapshot.hasData ? loading('Cargando...')
              :Column(
            children: [
              const Text(
                "Favoritos",textAlign: TextAlign.left,
                style: TextStyle( fontWeight: FontWeight.w700, fontSize: 14.0, color: Color(0xFF9CA4AA), ), ),
              const Divider( color: Colors.grey, thickness:1),
              _favotitePlaces.isEmpty ? noDataSection("assets/images/sinMapas.png", 'No hay favoritos') :
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: _favotitePlaces.length,
                  itemBuilder: (BuildContext context, int index){
                      return favoContainer(_favotitePlaces[index].favName, _favotitePlaces[index].direction);
                  },),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SearchMap(editFav: true,)),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(lprimaryColor),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.add, color: Colors.white,),
                      Text('Añadir un favorito', style: TextStyle( color: Colors.white,fontSize: 16,),),
                    ],
                  )),

              const Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "Recientes",
                  style: TextStyle( fontWeight: FontWeight.w700, fontSize: 14.0, color: Color(0xFF9CA4AA), ), ),
              ),
              const Divider( color: Colors.grey, thickness:1),
              // noDataSection(),
              _recentPlaces.isEmpty ? noDataSection("assets/images/sinMapas.png", "Aún no has solicitado servicios") :
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: _recentPlaces.length,
                  itemBuilder: (BuildContext context, int index){
                    return recienteContainer(_recentPlaces[index].direction);
                  },),
              ),
            ],
          ),
        );
      }
    );
  }

  Widget noDataSection(String imgPath, String title){
   return Center(
     child: Column(children: [
        Image.asset(imgPath,width: 150.0,height:150.0,),
        Text(
              title,
          style: TextStyle( fontWeight: FontWeight.w700, fontSize: 14.0, color: Color(0xFF9CA4AA), ),
        ),
      ],),
   );
  }

  Widget favoContainer(String name,String direction){
    return SizedBox(
      height: 45,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: CircleAvatar(child: Icon(Icons.star, color: Colors.white,size: 20,), radius: 15, backgroundColor: Color(0xffAD8B19),),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(
                  color: Color(0xff222B45), fontSize: 18, fontWeight: FontWeight.w800,
                ),),
                Text(direction, style: const TextStyle(
                  color: Color(0xFF9CA4AA), fontSize: 12,
                ),),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget recienteContainer(String description){
    return SizedBox(
      height: 45,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Icon(Icons.place, color: Color(0xffAD8B19),size: 30),
          ),
          Expanded(
            child: Text(description, style: const TextStyle(
              color: Color(0xff222B45), fontSize: 18, fontWeight: FontWeight.w500,
            ),),
          ),
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

}

