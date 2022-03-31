import 'package:flutter/material.dart';
class ImageCardView extends StatelessWidget {
  String image;
  ImageCardView(this.image);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if(image==null){
      final card= Container(
          margin: EdgeInsets.only(right: 15.0,left: 20.0,top: 10.0,bottom: 10.0),
          height: 350,
          width: 200,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage("https://i.pinimg.com/236x/83/5b/aa/835baafbbae55355e3f5f5848d27d543.jpg")
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
    else{
      final card= Container(
          margin: EdgeInsets.only(right: 15.0,left: 20.0,top: 10.0,bottom: 10.0),
          height: 350,
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

}