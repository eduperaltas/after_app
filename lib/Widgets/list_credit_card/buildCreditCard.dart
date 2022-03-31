// @dart=2.9
import 'package:after_app/Users/model/card.dart';
import 'package:after_app/Widgets/add_credit_card/add_credit_card_view.dart';
import 'package:flutter/material.dart';

class BuildCreditCard extends StatelessWidget {

  final CardModel card;
  BuildCreditCard({ this.card });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      color: Colors.white54,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),


      child: Container(

        height: 200,
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildLogosBlock("assets/images/mastercard.png"),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                card.cardNumber,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontFamily: 'CourrierPrime'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildDetailsBlock(
                  label: 'TITULAR',
                  value: card.cardHolderName,
                ),
                _buildDetailsBlock(label: 'Vencimiento', value: card.expiryDate),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Row _buildLogosBlock( String cardLogo) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Image.asset(
          "assets/images/contact_less.png",
          height: 20,
          width: 18,
        ),
        Image.asset(
          cardLogo,
          height: 50,
          width: 50,
        ),
      ],
    );
  }

  Column _buildDetailsBlock({@required String label, @required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '$label',
          style: TextStyle(
              color: Colors.grey, fontSize: 9, fontWeight: FontWeight.bold),
        ),
        Text(
          '$value',
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  Container _buildAddCardButton({
    @required Icon icon,
    @required Color color,
    context
  }) {
    return Container(
      margin: const EdgeInsets.only(top: 24.0),
      alignment: Alignment.center,
      child: FloatingActionButton(
        elevation: 2.0,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return AddCreditCardView();
          }));
        },
        backgroundColor: color,
        mini: false,
        child: icon,
      ),
    );
  }
}