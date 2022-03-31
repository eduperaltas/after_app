import 'package:after_app/Widgets/list_credit_card/credit_cards_pago.dart';
import 'package:flutter/material.dart';


class SelectCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Credit Cards Project',
      theme: ThemeData(fontFamily: 'Lato'),
      debugShowCheckedModeBanner: false,

      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios , color: Colors.black),
            onPressed: () {
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }
            },
          ),
          centerTitle: true,
          title: Container(
            child: SizedBox(
              height:60,
              width:90,
              child: Image.asset(
                'assets/images/Logoprincipal.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        body: SafeArea(child: CreditCardsPago()),
      ),
    );
  }
}
