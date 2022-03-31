import 'package:flutter/material.dart';

class RideCard extends StatelessWidget {
  String  date;
  String typeofhaircut;
  String photoservice= "assets/images/Servicio.jpg";
  String price= "/s 45";
  String barbername= "Pepito Perez";
  String servicedirection= "CASA";
  RideCard(this.date,this.typeofhaircut,this.price,this.barbername,this.servicedirection);
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.only(
        top: 10.0,
      ),
      child: Card(
        elevation: 0.0,
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    date,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17.0,
                    ),
                  ),
                  SizedBox(
                    width: 50.0,
                  ),
                  Text(
                    typeofhaircut,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 17.0,
                    ),
                  ),
                ],
              ),
              ListTile(
                contentPadding: EdgeInsets.only(
                  left: 0.0,
                ),
                title: Text(
                  barbername,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.pin_drop,
                      color: Color(0xffAD8B19),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      servicedirection,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "Precio",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      price,
                      style: TextStyle(
                        fontSize: 24.0,
                        color: Color(0xffAD8B19),
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
