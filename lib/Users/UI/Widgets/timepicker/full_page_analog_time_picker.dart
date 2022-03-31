library analog_time_picker;

// import 'package:after_app/Barbers/UI/Screens/alert_screen.dart';
import 'package:after_app/Users/UI/Screens/list_of_barbers.dart';
import 'package:after_app/Widgets/MyPreferences.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:after_app/Users/UI/Widgets/timepicker/analog_time_picker.dart';
class FullPageAnalogTimePicker extends StatelessWidget {
  final Map mapData;
  final String route;
  final Widget container;
  MyPreferences _myPreferences = MyPreferences();
  FullPageAnalogTimePicker({Key key, this.mapData, this.container, this.route})
      : super(key: key);

  Map<String, DateTime> _dateTime = new Map();
  @override
  Widget build(BuildContext context) {
    print(mapData);
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            elevation: 0.0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                }
              },
            )),
        body: SingleChildScrollView(
          child: Container(
            height: 680,
            child: Stack(
              children: <Widget>[
                container != null ? container : Container(),
                Container(
                  alignment: Alignment.center,
                  child: AnalogTimePicker(
                    onChanged: getDayTime,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                      left: 10,
                      right: 10,
                      bottom: 10),
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    backgroundColor:Color(0xffAD8B19),
                    child: Icon(Icons.arrow_forward),
                    onPressed: () {
                      print('Fecha: '+_myPreferences.fecha.toString() +'Hora: '+_myPreferences.hora.toString());
                      if(_myPreferences.fecha.toString()=='null' ||_myPreferences.hora.toString()=='null'){
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            content: ListTile(
                              title: Text('Olvidaste algo'),
                              subtitle: Text('Debes seleccionar la fecha y hora para reservar tu servicio'),
                            ),
                            actions: <Widget>[
                              FlatButton(
                                color: Colors.amber,
                                child: Text('Ok',style: TextStyle(color: Colors.white)),
                                onPressed: () {
                                Navigator.of(context).pop();
                                } ,
                              ),
                            ],
                          ),
                        );
                      }else{
                      showDialog(context: context, builder: (context)
                      {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)
                          ),
                          elevation: 10,
                          backgroundColor: Colors.white,
                          child: Container(
                            height: 260.0,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text('Confirma tu reserva',
                                          style: TextStyle(fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),),
                                        Container(
                                            height: 100,
                                            width: 100,
                                            margin: EdgeInsets.only(
                                                top: 10.0, bottom: 10.0),
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: AssetImage(
                                                      'assets/images/calendar.png')
                                              ),
                                            )
                                        ),
                                        // Text(superHero1.nameofbarber, style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),),
                                      ],
                                    ),

                                  ),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Color(0xffAD8B19),
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          topRight: Radius.circular(12))
                                  ),
                                ),
                                SizedBox(height: 5,),


                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 10, left: 16),
                                  child: Text('Fecha y hora:', style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                    textAlign: TextAlign.center,),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 10, left: 16),
                                  child: Text(
                                    _myPreferences.fecha.toString() + ' a las ' +
                                        _myPreferences.hora.toString(),
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                    textAlign: TextAlign.center,),
                                ),

                                SizedBox(height: 5,),

                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 10, left: 16),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      RaisedButton(onPressed: () {
                                        return Navigator.push(context,
                                            PageTransition(
                                                child: Services('Todos'),
                                                type: PageTransitionType
                                                    .rightToLeft));
                                      },
                                        child: Text('Confirmar'),
                                        color: Colors.white,
                                        textColor: Color(0xffAD8B19),)
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      });
                      }

                      // print(DateFormat.yMMMMd().format(_dateTime['date']));
                    },
                  ),
                ),
              ],
            ),
          ),
        )

    );
  }

  void getDayTime(Map value) {
    _dateTime = value;
  }
}
