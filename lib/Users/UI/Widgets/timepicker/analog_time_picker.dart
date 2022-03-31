library analog_time_picker;

import 'package:after_app/Widgets/MyPreferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:after_app/Users/UI/Widgets/timepicker/clock_text.dart';
import 'package:after_app/Users/UI/Widgets/timepicker/clock.dart';



class AnalogTimePicker extends StatefulWidget {
  final ValueChanged<Map> onChanged;

  const AnalogTimePicker({Key key, this.onChanged}) : super(key: key);
  @override
  _AnalogTimePickerState createState() => _AnalogTimePickerState();
}

class _AnalogTimePickerState extends State<AnalogTimePicker> {
  String cita;
  Map<String, DateTime> _dateTime = new Map();
  MyPreferences _myPreferences = MyPreferences();
  DateTime colckTime = DateTime.now();

  List<DateModel> dateList = new List<DateModel>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var now = colckTime;

    var today = new DateTime(now.year, now.month, now.day);
    var today_1 = new DateTime(now.year, now.month, now.day + 1);
    var today_2 = new DateTime(now.year, now.month, now.day + 2);
    var today_3 = new DateTime(now.year, now.month, now.day + 3);
    var today_4 = new DateTime(now.year, now.month, now.day + 4);
    var today_5 = new DateTime(now.year, now.month, now.day + 5);
    var today_6 = new DateTime(now.year, now.month, now.day + 6);
    var today_7 = new DateTime(now.year, now.month, now.day + 8);
    var today_8 = new DateTime(now.year, now.month, now.day + 9);
    var today_9 = new DateTime(now.year, now.month, now.day + 10);
    var today_10 = new DateTime(now.year, now.month, now.day + 11);
    var today_11 = new DateTime(now.year, now.month, now.day + 12);
    var today_12 = new DateTime(now.year, now.month, now.day + 13);
    var today_13 = new DateTime(now.year, now.month, now.day + 14);
    var today_14 = new DateTime(now.year, now.month, now.day + 15);
    var today_15 = new DateTime(now.year, now.month, now.day + 16);
    var today_16 = new DateTime(now.year, now.month, now.day + 17);
    var today_17 = new DateTime(now.year, now.month, now.day + 18);
    var today_18 = new DateTime(now.year, now.month, now.day + 19);
    var today_19 = new DateTime(now.year, now.month, now.day + 20);
    var today_20 = new DateTime(now.year, now.month, now.day + 21);
    var today_21 = new DateTime(now.year, now.month, now.day + 22);
    var today_22 = new DateTime(now.year, now.month, now.day + 23);
    var today_23 = new DateTime(now.year, now.month, now.day + 24);
    var today_24 = new DateTime(now.year, now.month, now.day + 25);

    dateList.add(DateModel(true, today));
    dateList.add(DateModel(false, today_1));
    dateList.add(DateModel(false, today_2));
    dateList.add(DateModel(false, today_3));
    dateList.add(DateModel(false, today_4));
    dateList.add(DateModel(false, today_5));
    dateList.add(DateModel(false, today_6));
    dateList.add(DateModel(false, today_7));
    dateList.add(DateModel(false, today_8));
    dateList.add(DateModel(false, today_9));
    dateList.add(DateModel(false, today_10));
    dateList.add(DateModel(false, today_11));
    dateList.add(DateModel(false, today_12));
    dateList.add(DateModel(false, today_13));
    dateList.add(DateModel(false, today_14));
    dateList.add(DateModel(false, today_15));
    dateList.add(DateModel(false, today_16));
    dateList.add(DateModel(false, today_17));
    dateList.add(DateModel(false, today_18));
    dateList.add(DateModel(false, today_19));
    dateList.add(DateModel(false, today_20));
    dateList.add(DateModel(false, today_21));
    dateList.add(DateModel(false, today_22));
    dateList.add(DateModel(false, today_23));
    dateList.add(DateModel(false, today_24));

    if (mounted) {
      _dateTime['date'] = colckTime;
      _dateTime['time'] = colckTime;
      _publishSelection(_dateTime);
    }
  }

  @override
  Widget build(BuildContext context) {

    return new Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(1.0),
              alignment: Alignment.topLeft,
              child: Text(
                "¿CUANDO NECESITAS TU CORTE?",
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold,
                  fontFamily: "The Foregen Rough One",),
              ),
            ),
            _sevenDay(),
            Container(
              margin: EdgeInsets.all(2.0),
              alignment: Alignment.topLeft,
              child: Text(
                "Selecciona una hora",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              margin: const EdgeInsets.only(left: 0, top: 2, right: 0),
              child: TextFormField(
                cursorColor: Color(0xffAD8B19),
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Fecha de reserva',
                    hintText: 'dia/mes/año horas:minutos'),
                keyboardType: TextInputType.datetime,
                textInputAction: TextInputAction.next,
                onChanged: (val){
                  setState(() {
                    cita= val;
                  });
                },
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
           Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(2.0),
                    alignment: Alignment.topRight,
                    child: Text(new DateFormat.jm().format(colckTime)),
                  ),
                  Container(
                    margin:
                    EdgeInsets.only(left: 50.0, right: 50.0, bottom: 16.0),
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        showCupertinoModalPopup<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return _buildBottomPicker(
                              CupertinoDatePicker(
                                mode: CupertinoDatePickerMode.time,
                                initialDateTime: colckTime,
                                onDateTimeChanged: (DateTime newDateTime) {
                                  setState(() {
                                    colckTime = newDateTime;
                                    _dateTime['time'] = newDateTime;
                                    _myPreferences.hora= DateFormat('Hm').format(_dateTime['time']);
                                    print(_myPreferences.hora);
                                  });
                                },
                              ),
                            );
                          },
                        );
                      },
                      child: new Clock(
                        circleColor: Colors.white,
                        showBellsAndLegs: false,
                        bellColor: Colors.blueAccent,
                        clockText: ClockText.arabic,
                        showHourHandleHeartShape: false,
                        time: colckTime,
                      ),
                    ),
                  ),
                ],
              ),

            Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10.0),
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {
                          showCupertinoModalPopup<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return _buildBottomPicker(
                                CupertinoDatePicker(
                                  mode: CupertinoDatePickerMode.time,
                                  initialDateTime: colckTime,
                                  onDateTimeChanged: (DateTime newDateTime) {
                                    setState(() {
                                      colckTime = newDateTime;
                                      _dateTime['time'] = newDateTime;
                                      _myPreferences.hora= DateFormat('Hm').format(_dateTime['time']);
                                      print(_myPreferences.hora);
                                    });
                                  },
                                ),
                              );
                            },
                          );
                        },
                        child: Text( new DateFormat.jm().format(colckTime)),
                      ),


                    ),   //es de fecha
                    Container(
                      padding: EdgeInsets.all(10.0),
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {
                          showCupertinoModalPopup<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return _buildBottomPicker(
                                CupertinoDatePicker(
                                  mode: CupertinoDatePickerMode.date,
                                  initialDateTime: colckTime,
                                  onDateTimeChanged: (DateTime newDateTime) {
                                    setState(() {
                                      colckTime = newDateTime;
                                      _dateTime['time'] = newDateTime;
                                      _myPreferences.fecha= DateFormat('d/M/y').format(_dateTime['time']);
                                      print(_myPreferences.fecha);
                                    });
                                  },
                                ),
                              );
                            },
                          );
                        },
                        child: Text(new DateFormat.yMd().format(colckTime)),


                      ),

                    )
                  ],
                )


          ],
        ),
      ),
    );
  }

  Widget _buildBottomPicker(Widget picker) {
    return Container(
      height: 150.0,
      padding: const EdgeInsets.only(top: 6.0),
      color: CupertinoColors.white,
      child: DefaultTextStyle(
        style: const TextStyle(
          color: CupertinoColors.black,
          fontSize: 22.0,
        ),
        child: GestureDetector(
          // Blocks taps from propagating to the modal sheet and popping.
          onTap: () {},
          child: SafeArea(
            top: false,
            child: picker,
          ),
        ),
      ),
    );
  }

  Widget _sevenDay() {
    return Container(
      height: 90.0,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        scrollDirection: Axis.horizontal,
        itemCount: dateList.length,
        itemBuilder: (BuildContext context, int index) {
          return new InkWell(
            onTap: () {
              //print("Click on ${dateList[index].dateTime}");

              setState(() {
                dateList.forEach((element) => element.isSelected = false);
                dateList[index].isSelected = true;
                _dateTime['date'] = dateList[index].dateTime;
                _myPreferences.fecha= DateFormat('d/M/y').format(_dateTime['time']);
                print(_myPreferences.fecha);

              });
            },
            child: new DateItem(dateList[index]),
          );
        },
      ),
    );
  }


  void _publishSelection(Map _dateTime) {
    if (widget.onChanged != null) {
      widget.onChanged(_dateTime);
    }
  }
}

class DateItem extends StatelessWidget {
  final DateModel _item;
  DateItem(this._item);

  _dateItem(DateModel _item) {
    DateTime dateTime = _item.dateTime;
    return Card(
      color: _item.isSelected ? Color(0xffAD8B19) : Colors.white,
      child: Container(
        color: _item.isSelected ? Color(0xffAD8B19) : Colors.white,
        margin: EdgeInsets.all(8.0),
        alignment: Alignment.topCenter,
        height: 100.0,
        width: 100.0,
        child: Column(
          children: <Widget>[
            Text(
              DateFormat.LLLL().format(dateTime),
              style: TextStyle(
                  color: _item.isSelected ? Colors.white : Colors.blueGrey),
            ),
            Text(dateTime.day.toString(),
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: _item.isSelected ? Colors.white : Colors.blueGrey)),
            Text(
              DateFormat.EEEE().format(dateTime),
              style: TextStyle(
                  color: _item.isSelected ? Colors.white : Colors.blueGrey),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _dateItem(_item);
  }
}

class DateModel {
  bool isSelected;
  final DateTime dateTime;
  DateModel(this.isSelected, this.dateTime);
}
