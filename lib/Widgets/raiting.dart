// @dart=2.9
import 'package:flutter/material.dart';

class Rating extends StatelessWidget {
  double stars;
  double marginLeft;
  double fontSize;

  Rating(this.stars, this.marginLeft, this.fontSize);

  Widget getStar(double star) {
    var icon = Icon(
      Icons.star,
      color: Color(0xFFf2C611),
      size: fontSize,
    );

    if (star == 0.5) {
      icon = Icon(
        Icons.star_half,
        color: Color(0xFFf2C611),
        size: fontSize,
      );
    }
    else {
      if (star < 0.5) {
        icon = Icon(
          Icons.star_border,
          color: Color(0xFFa3a5a7),
          size: fontSize,
        );
      }
    }

    return Container(
        margin: EdgeInsets.only(
            right: 1.0
        ),
        child: icon
    );
  }

  Widget getRating(double stars) {
    var list = new List<Widget>();

    for (var n = 0; n < 5; n++) {
      list.add(getStar(stars));
      stars--;
    }
    return Container(
      margin: EdgeInsets.only(left: marginLeft),
      child: Row(
        children: list,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return getRating(stars);
  }
}