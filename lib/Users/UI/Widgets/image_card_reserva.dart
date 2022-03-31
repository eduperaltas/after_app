// @dart=2.9
import 'package:after_app/Widgets/MyPreferences.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:after_app/Users/UI/Widgets/timepicker/full_page_analog_time_picker.dart';
//import 'package:uberr/screens/reservation_screen.dart';
class FullPageClock extends StatelessWidget {
  final Map mapData;
  const FullPageClock({Key key, this.mapData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FullPageAnalogTimePicker(
      mapData: mapData,
    );
  }
}
class ImageCardReserva extends StatelessWidget {
  String buttonText;
  String image="asset/images/background.jpg";
  MyPreferences _myPreferences = MyPreferences();
  ImageCardReserva(this.image,this.buttonText);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final card= GestureDetector(
        onTap: () {
          _myPreferences.servicio = "reserva";
          _myPreferences.commit();
          Navigator.push(context, PageTransition(child: FullPageClock(), type: PageTransitionType.rightToLeft));},
        child:Container(
            margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            height: 190.0,
            width: 400.0,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(image)
                ),
                borderRadius: BorderRadius.all(Radius.circular((30.0))),
                shape: BoxShape.rectangle,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black38,
                      blurRadius: 15.0,
                      offset: Offset(0.0, 0.7))]
            )
        ));
    final button= GestureDetector(
      onTap: () { Navigator.push(context, PageTransition(child: FullPageClock(), type: PageTransitionType.rightToLeft));},
      child: Container(
        margin: EdgeInsets.only(top:145.0),
        height: 45.0 ,
        width: 400.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(0.0),topRight: Radius.circular(0.0),bottomRight: Radius.circular(30.0),bottomLeft: Radius.circular(30.0)),
            color: Color(0xffAD8B19).withOpacity(0.7),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black38,
                  blurRadius: 15.0,
                  offset: Offset(0.0, 0.7))]
        ),

        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 25.0,
                fontFamily: "Lato",
                color: Colors.white
            ),

          ),

        ),
      ),
    );

    return Stack(
      alignment: Alignment(0.3,0),
      children: <Widget>[
        card,
        button,
        SizedBox(
          height: 50,
        )
      ],
    );
  }

}