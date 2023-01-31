// @dart=2.9
import 'package:after_app/Users/model/card.dart';
import 'package:after_app/Users/repository/cloud_firestore_api.dart';
import 'package:after_app/Widgets/add_credit_card/add_credit_card_view.dart';
import 'package:after_app/Widgets/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../styles/colors.dart';
import '../styles/colors.dart';

class CreditCardsPage extends StatelessWidget {
  String uiduser;
  CreditCardsPage({this.uiduser});
  @override
  Widget build(BuildContext context) {
    print("uid cards:" + uiduser);
    return StreamBuilder<Object>(
        stream: CloudFirestoreAPI().cards,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          List<CardModel> lstCards = snapshot.data;

          return Column(
            children: [
              lstCards.isEmpty
                  ? Center(
                      child: Column(
                      children: <Widget>[
                        Image.asset("assets/images/noCard.png"),
                      ],
                    ))
                  : ListView.builder(
                      padding: const EdgeInsets.all(20.0),
                      shrinkWrap: true,
                      itemCount: lstCards.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _buildCreditCard(tarjetas: lstCards[0]);
                      }),
              const Text("Agrega una nueva tarjeta en el boton +"),
              _buildAddCardButton(
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  color: Color(0xffAD8B19),
                  context: context),
            ],
          );
        });
  }

  Container _buildAddCardButton(
      {@required Icon icon, @required Color color, context}) {
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

  Card _buildCreditCard(
      {@required CardModel tarjetas, BuildContext context, String cardid}) {
    return Card(
        elevation: 4.0,
        color: lprimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        child: Stack(
          children: [
            Container(
              height: 200,
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 22.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _buildLogosBlock(tarjetas),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(
                      tarjetas.cardNumber,
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
                        value: tarjetas.cardHolderName,
                      ),
                      _buildDetailsBlock(
                          label: 'Vencimiento', value: tarjetas.expiryDate),
                    ],
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                print('object TAP');

                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    // return object of type Dialog
                    return AlertDialog(
                      title: new Text("Borrar Tarjeta"),
                      content: new Text(
                          "¿Estas seguro que quieres borrar tu tarjeta? "),
                      actions: <Widget>[
                        // usually buttons at the bottom of the dialog
                        // new FlatButton(
                        //   child: new Text("No",style: TextStyle(
                        //     color: Colors.black,)),
                        //   onPressed: () {
                        //     Navigator.of(context).pop();
                        //   },
                        // ),
                        // new FlatButton(
                        //   color:Colors.red,
                        //   child: new Text("Borrar"),
                        //   onPressed: () {
                        //     print('esta tarjeta borraras: ' + cardid);
                        //     CloudFirestoreAPI().deleteUserCard(cardid);
                        //     Navigator.of(context).pop();
                        //   },
                        // ),
                      ],
                    );
                  },
                );
              },
              child: Container(
                  padding: const EdgeInsets.only(
                      left: 310.0, right: 0, bottom: 27.0, top: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      CircleAvatar(
                          radius: 15.0,
                          backgroundImage: NetworkImage(
                              "https://cdn4.iconfinder.com/data/icons/social-messaging-ui-color-and-shapes-4/177800/175-512.png"))
                    ],
                  )),
            )
          ],
        ));
  }

  Row _buildLogosBlock(CardModel tarjetas) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Image.asset(
          "assets/images/contact_less.png",
          height: 20,
          width: 18,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 14, top: 8),
          child: getCardTypeIcon(tarjetas.cardNumber),
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
          style: const TextStyle(
              color: Colors.white54, fontSize: 9, fontWeight: FontWeight.bold),
        ),
        Text(
          '$value',
          style: const TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

//funciones para el logo de la tarjeta dependiendo de el numero

  Map<CardType, Set<List<String>>> cardNumPatterns =
      <CardType, Set<List<String>>>{
    CardType.visa: <List<String>>{
      <String>['4'],
    },
    CardType.americanExpress: <List<String>>{
      <String>['3'],
      <String>['34'],
      <String>['37'],
    },
    CardType.discover: <List<String>>{
      <String>['6011'],
      <String>['622126', '622925'],
      <String>['644', '649'],
      <String>['65']
    },
    CardType.mastercard: <List<String>>{
      <String>['5'],
      <String>['51', '55'],
      <String>['2221', '2229'],
      <String>['223', '229'],
      <String>['23', '26'],
      <String>['270', '271'],
      <String>['2720'],
    },
    CardType.diners: <List<String>>{
      <String>['30'],
      <String>['36'],
      <String>['38'],
    },
  };

  /// This function determines the Credit Card type based on the cardPatterns
  /// and returns it.
  CardType detectCCType(String cardNumber) {
    //Default card type is other
    CardType cardType = CardType.otherBrand;

    if (cardNumber.isEmpty) {
      return cardType;
    }

    cardNumPatterns.forEach(
      (CardType type, Set<List<String>> patterns) {
        for (List<String> patternRange in patterns) {
          // Remove any spaces
          String ccPatternStr =
              cardNumber.replaceAll(RegExp(r'\s+\b|\b\s'), '');
          final int rangeLen = patternRange[0].length;
          // Trim the Credit Card number string to match the pattern prefix length
          if (rangeLen < cardNumber.length) {
            ccPatternStr = ccPatternStr.substring(0, rangeLen);
          }

          if (patternRange.length > 1) {
            // Convert the prefix range into numbers then make sure the
            // Credit Card num is in the pattern range.
            // Because Strings don't have '>=' type operators
            final int ccPrefixAsInt = int.parse(ccPatternStr);
            final int startPatternPrefixAsInt = int.parse(patternRange[0]);
            final int endPatternPrefixAsInt = int.parse(patternRange[1]);
            if (ccPrefixAsInt >= startPatternPrefixAsInt &&
                ccPrefixAsInt <= endPatternPrefixAsInt) {
              // Found a match
              cardType = type;
              break;
            }
          } else {
            // Just compare the single pattern prefix with the Credit Card prefix
            if (ccPatternStr == patternRange[0]) {
              // Found a match
              cardType = type;
              break;
            }
          }
        }
      },
    );

    return cardType;
  }

  // This method returns the icon for the visa card type if found
  // else will return the empty container
  Widget getCardTypeIcon(String cardNumber) {
    Widget icon;
    switch (detectCCType(cardNumber)) {
      case CardType.visa:
        icon = Image.asset(
          "assets/images/visa.png",
          height: 48,
          width: 48,
        );

        break;

      case CardType.americanExpress:
        icon = Image.asset(
          'assets/images/amex.png',
          height: 48,
          width: 48,
        );

        break;

      case CardType.mastercard:
        icon = Image.asset(
          'assets/images/mastercard.png',
          height: 48,
          width: 48,
        );

        break;

      case CardType.discover:
        icon = Image.asset(
          'assets/images/discover.png',
          height: 48,
          width: 48,
        );

        break;
      case CardType.diners:
        icon = Image.asset(
          'assets/images/diners.png',
          height: 48,
          width: 48,
        );

        break;
      default:
        icon = Container(
          height: 48,
          width: 48,
        );

        break;
    }

    return icon;
  }
}

enum CardType {
  otherBrand,
  mastercard,
  diners,
  visa,
  americanExpress,
  discover,
}
