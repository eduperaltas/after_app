// @dart=2.9
import 'package:flutter/material.dart';

class LabeledCheckbox extends StatelessWidget {
  const LabeledCheckbox({
    this.label,
    this.padding,
    this.value,
    this.onChanged,
  });

  final String label;
  final EdgeInsets padding;
  final bool value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Expanded(child: Text(label,
              style: TextStyle(
                fontSize: 18.0,
                fontFamily: "Lato",
              ),
            ),),
            Checkbox(
              value: value,
              activeColor: Color(0xffAD8B19),
              onChanged: (bool newValue) {
                onChanged(newValue);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  String servicios;
  String descripcion;

  MyStatefulWidget(this.servicios,this.descripcion);
  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState(servicios);
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  String servicio;
  bool _isSelected = false;
  _MyStatefulWidgetState(this.servicio);
  @override
  Widget build(BuildContext context) {
    return LabeledCheckbox(
      label: servicio,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      value: _isSelected,
      onChanged: (bool newValue) {
        setState(() {
          _isSelected = newValue;
        });
      },
    );
  }
}