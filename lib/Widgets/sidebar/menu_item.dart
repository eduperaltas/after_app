import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function onTap;

  const MenuItem({Key key, this.icon, this.title, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              color: Colors.white,
              size: MediaQuery.of(context).size.height * 0.025,
            ),
            SizedBox(width: MediaQuery.of(context).size.height * 0.02),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: MediaQuery.of(context).size.height * 0.025,
                color: Colors.white,
                fontFamily: "BAHNSCHRIFT",
              ),
            )
          ],
        ),
      ),
    );
  }
}
