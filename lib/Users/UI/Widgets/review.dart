import 'package:after_app/Users/model/user.dart';
import 'package:after_app/Users/repository/cloud_firestore_api.dart';
import 'package:after_app/Widgets/raiting.dart';
import 'package:flutter/material.dart';

class Review extends StatelessWidget {

  double stars;
  String coment ;
  String autoruid ;
  double topmarginname= 20;
  double topmarginpic= 20;
  double widthpic = 80;
  double heightpic = 80;
  double widthborderpic= 1;
  Review(this.stars,this.coment,this.autoruid);
  @override
  Widget build(BuildContext context) {
   return StreamBuilder<User>(
      stream: CloudFirestoreAPI(uid: autoruid).userData,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if (!snapshot.hasData) {
          return Center(
              child:CircularProgressIndicator());
          // <---- no return here
        }else{
              User user = snapshot.data;
              return showreviewdata(context,snapshot,user);
        }
      },
    );

    // TODO: implement build


  }

  Widget showreviewdata(BuildContext context,AsyncSnapshot snapshot, User user){
    final usercoment = Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(
            left: 20.0
        ),
        child: Text(coment ,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: "Lato",
            ))

    );
    final userstars = Rating(stars, 20.0, 14.0);

    final username = Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(
            top: topmarginname,
            left: 20.0
        ),
        child: Text(user.name ,
            textAlign: TextAlign.left,
            style: TextStyle(
                fontFamily: "Lato",
                fontSize: 17.0,
                fontWeight: FontWeight.bold
            ))
    );

    final userDetails = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        username,
        userstars,
        usercoment
      ],
    );
    final photo= Container(
        margin: EdgeInsets.only(
            top: topmarginpic,
            left: 30.0
        ),
        width: widthpic,
        height: heightpic,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(user.photoURL)
          ),
          border: Border.all(
            color: Colors.white,
            width: widthborderpic,
          ),
        ));


    return
      SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row (
              children: <Widget>[
                photo,
                userDetails
              ]
          ));
  }

}