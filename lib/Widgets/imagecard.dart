import 'package:flutter/material.dart';
class ImageCard extends StatelessWidget {
  String image="asset/images/background.jpg";
  ImageCard(this.image);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final card= Container(
      margin: EdgeInsets.only(right: 10.0),
        height: 300,
        width: 200,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(image)
            ),
            borderRadius: BorderRadius.all(Radius.circular((30.0))),
            shape: BoxShape.rectangle,
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black38,
                  blurRadius: 15.0,
                  offset: Offset(0.0, 0.7))]
        )
    );
    return card;
  }

}