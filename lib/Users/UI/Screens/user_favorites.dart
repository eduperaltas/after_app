// @dart=2.9
import 'package:after_app/Users/UI/Widgets/maps/search/maps1.dart';
import 'package:after_app/Users/UI/Widgets/maps/search/user_places.dart';
import 'package:after_app/Users/model/location_card.dart';
import 'package:after_app/Users/repository/cloud_firestore_api.dart';
import 'package:after_app/Widgets/MyPreferences.dart';
import 'package:flutter/material.dart';
import 'package:after_app/Users/model/place.dart';
import 'package:page_transition/page_transition.dart';

class UserFavorites extends StatefulWidget {
  String uiduser;

  UserFavorites({this.uiduser});

  @override
  _UserFavoritesState createState() => _UserFavoritesState();
}

Widget  FavoritosCasa(BuildContext context, String direccion, MyPreferences _myPreferences){
  FavoritePlacesModel casa;
  MyPreferences _myPreferences = MyPreferences();
  return StreamBuilder<Object>(
      stream: CloudFirestoreAPI(uid: _myPreferences.uid,favorito: "casa").userFavoritedir,
      builder: (context, snapshot){
        if(!snapshot.hasData){ print("no tiene data");
        return ListTile(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 0.0,
          ),
          leading: IconButton(
            icon: Icon(Icons.home),
          ),
          title: Text(
            "Casa",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
            direccion, style: TextStyle(fontWeight: FontWeight.w100),
          ),
          trailing: IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              _myPreferences.favorite = "casa";
              _myPreferences.commit();
              Navigator.push(
                  context,
                  PageTransition(child: SearchMap(dirfavoritos: true,), type: PageTransitionType.rightToLeft));
            },
          ),
        );
        }
        else {
          print(" tiene data");
          casa = snapshot.data;
          return  ListTile(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 0.0,
                      ),
                      leading: IconButton(
                        icon: Icon(Icons.home),
                      ),
                      title: Text(
                        "Casa",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(
                        casa.direccion != null ? casa.direccion:direccion,
                        style: TextStyle(fontWeight: FontWeight.w100),
                      ),

                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          _myPreferences.favorite = "casa";
                          _myPreferences.commit();
                          Navigator.push(
                              context,
                              PageTransition(child: SearchMap(dirfavoritos: true), type: PageTransitionType.rightToLeft));
                        },
                      ),
                    );

        }
      }

  );



}

Widget  FavoritosTrabajo(BuildContext context, String direccion, MyPreferences _myPreferences){
  FavoritePlacesModel trabajo;
  MyPreferences _myPreferences = MyPreferences();
  return StreamBuilder<Object>(
      stream: CloudFirestoreAPI(uid: _myPreferences.uid,favorito: "trabajo").userFavoritedir,
      builder: (context, snapshot){
        if(!snapshot.hasData){ print("no tiene data");
        return ListTile(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 0.0,
          ),
          leading: IconButton(
            icon: Icon(Icons.work),
          ),
          title: Text(
            "Trabajo",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
            direccion,
            style: TextStyle(fontWeight: FontWeight.w100),
          ),
          trailing: IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              _myPreferences.favorite = "trabajo";
              _myPreferences.commit();
              Navigator.push(
                  context,
                  PageTransition(child: SearchMap(dirfavoritos: true), type: PageTransitionType.rightToLeft));
            },
          ),
        );
        }
        else {
          print(" tiene data");
          trabajo = snapshot.data;
          return  ListTile(
            contentPadding: EdgeInsets.symmetric(
              horizontal: 0.0,
            ),
            leading: IconButton(
              icon: Icon(Icons.work),
            ),
            title: Text(
              "Trabajo",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
                trabajo.direccion != null ? trabajo.direccion:direccion,
              style: TextStyle(fontWeight: FontWeight.w100),
            ),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                _myPreferences.favorite = "trabajo";
                _myPreferences.commit();
                Navigator.push(
                    context,
                    PageTransition(child: SearchMap(dirfavoritos: true), type: PageTransitionType.rightToLeft));
              },
            ),
          );

        }
      }

  );



}



class _UserFavoritesState extends State<UserFavorites> {
  String direccion= "no hay direccion guardada";

  MyPreferences _myPreferences = MyPreferences();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream: CloudFirestoreAPI(uid: widget.uiduser).favoriteplaces,
      builder: (context, snapshot) {

        if (!snapshot.hasData ) {
          print("No tiene direcciones");
          return Center(
          child:CircularProgressIndicator() // <---- no return here
          ); // <---- no return here
        }

        else {


          final List <FavoritePlacesModel> favoriteplaces = snapshot.data;
          print("tiene  "+ favoriteplaces.length.toString() +"   direcciones");

          if(favoriteplaces.length == 0){

            print("No tiene direcciones");

            return Scaffold(
              body: SingleChildScrollView(
                child:Container(
                  padding: EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Divider(),
                      FavoritosCasa( context,  direccion,  _myPreferences),
                      Divider(),
                      FavoritosTrabajo(context, direccion, _myPreferences),
                      Divider(),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "Recientes",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14.0,
                          color: Color(0xFF9CA4AA),
                        ),
                      ),
                      Column(children: [
                        Image.asset("assets/images/sinMapas.png",width: 300.0,height:300.0,),
                        Text(
                          "Aun no has solicitado servicios",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14.0,
                            color: Color(0xFF9CA4AA),
                          ),
                        ),
                      ],)

                    ],
                  ),
                ),
              ),
            );

          }

          if(favoriteplaces.length == 1){

            List<Place> _places = [
              Place(
                  name: favoriteplaces[favoriteplaces.length.toInt() - 1].direccion != null ? favoriteplaces[favoriteplaces.length.toInt() - 1].direccion : direccion),


            ];

            return Scaffold(
              body: SingleChildScrollView(
                child:Container(
                  padding: EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Divider(),
                      FavoritosCasa( context,  direccion,  _myPreferences),
                      Divider(),
                      FavoritosTrabajo(context, direccion, _myPreferences),
                      Divider(),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "Recientes",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14.0,
                          color: Color(0xFF9CA4AA),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Column(
                        children: _places
                            .map(
                              (place) => LocationCard(place),
                        )
                            .toList(),
                      )
                    ],
                  ),
                ),
              ),
            );
          }

          if(favoriteplaces.length == 2){

            List<Place> _places = [
              Place(
                  name: favoriteplaces[favoriteplaces.length.toInt() - 1].direccion != null ? favoriteplaces[favoriteplaces.length.toInt() - 1].direccion : direccion),
              Place(
                 name: favoriteplaces[favoriteplaces.length.toInt() - 2].direccion != null ? favoriteplaces[favoriteplaces.length.toInt() - 2].direccion : direccion),

            ];

            return Scaffold(
              body: SingleChildScrollView(
                child:Container(
                  padding: EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Divider(),
                      FavoritosCasa( context,  direccion,  _myPreferences),
                      Divider(),
                      FavoritosTrabajo(context, direccion, _myPreferences),
                      Divider(),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "Recientes",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14.0,
                          color: Color(0xFF9CA4AA),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Column(
                        children: _places
                            .map(
                              (place) => LocationCard(place),
                        )
                            .toList(),
                      )
                    ],
                  ),
                ),
              ),
            );
          }



                if(favoriteplaces.length >= 3){



        List<Place> _places = [
        Place(
        name: favoriteplaces[favoriteplaces.length.toInt() - 1].direccion != null ? favoriteplaces[favoriteplaces.length.toInt() - 1].direccion : direccion),
        Place(
            name: favoriteplaces[favoriteplaces.length.toInt() - 2].direccion != null ? favoriteplaces[favoriteplaces.length.toInt() - 2].direccion : direccion),
        Place(
            name: favoriteplaces[favoriteplaces.length.toInt() - 3].direccion != null ? favoriteplaces[favoriteplaces.length.toInt() - 3].direccion : direccion),
        ];
        return Scaffold(
          body: SingleChildScrollView(
            child:Container(
              padding: EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Divider(),
                  FavoritosCasa( context,  direccion,  _myPreferences),
                  Divider(),
                  FavoritosTrabajo(context, direccion, _myPreferences),
                  Divider(),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    "Recientes",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14.0,
                      color: Color(0xFF9CA4AA),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Column(
                    children: _places
                        .map(
                          (place) => LocationCard(place),
                    )
                        .toList(),
                  )
                ],
              ),
            ),
          ),
        );

        }
        }
      }
    );



  }

}

