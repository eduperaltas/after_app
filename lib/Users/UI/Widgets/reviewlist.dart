// @dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'review.dart';

class ReviewList extends StatelessWidget {
  String profileuserphoto1='assets/images/Servicio.jpg';
  String name1="Varuna Yasas";
  String details1="5 servicios";
  String coment1 = "Fue un excelent servicio";
  String barberuid ;

  ReviewList({this.barberuid});

  Widget notData(ThemeData _theme){
    return Center(
        child:Column(children: [
          Image.asset("assets/images/fotostrabajos.png"),
          Text(
            'Se el primero en comentar',
            style: _theme.textTheme.bodyText1.merge(
              TextStyle(
                color: Colors.grey[600],
                height: 1.3,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

        ])
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final ThemeData _theme = Theme.of(context);
  print("barberuid en reviewlisd:    "+barberuid);
    print('barberuid: ' + barberuid);
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('barbers')
            .doc('Reviews')
            .collection(barberuid).snapshots(),
        builder: (context, snapshot) {
          if(!snapshot.hasData){
            notData(_theme);

          }
        var length = snapshot.data.documents.length;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: length,
                itemBuilder: (context, index) {
                  DocumentSnapshot snpReview = snapshot.data.documents[index];
                  return new Review(  snpReview['estrellas'], snpReview['comentario'],snpReview['autoruid']);
                }),
          ],
        );

        }
    );

  }
}
