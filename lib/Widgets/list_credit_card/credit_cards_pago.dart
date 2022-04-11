// @dart=2.9
import 'package:after_app/Users/UI/Screens/confimation_screen.dart';
import 'package:after_app/Users/model/card.dart';
import 'package:after_app/Users/repository/cloud_firestore_api.dart';
import 'package:after_app/Widgets/MyPreferences.dart';
import 'package:after_app/Widgets/add_credit_card/add_credit_card_view.dart';
import 'package:flutter/material.dart';

class CreditCardsPago extends StatelessWidget {
  MyPreferences _myPreferences = MyPreferences();


  @override
  Widget build(BuildContext context) {
    int precio;
    print("Tipo de servicio: "+_myPreferences.servicio);
    return SingleChildScrollView(
      child: Container(
          padding: const EdgeInsets.all(8.0),
          child:GestureDetector(
            onTap: (){
              if(_myPreferences.corte=='Especial Barbers'){
                precio=45;
              }
              if(_myPreferences.corte=='Corte clasico'){
                precio=35;
              }
              if(_myPreferences.corte=='Corte simple'){
                precio=30;
              }
              CloudFirestoreAPI().createServicesDocument(_myPreferences.latitude,_myPreferences.longitude,_myPreferences.direction,_myPreferences.servicio,_myPreferences.barber, _myPreferences.corte,precio,_myPreferences.fecha,_myPreferences.hora);
              _myPreferences.commit();
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ConfirmationScreen()));

              _myPreferences.direction ="";
              _myPreferences.latitude = "";
              _myPreferences.longitude ="";
              _myPreferences.commit();
            },

            child: StreamBuilder<Object>(
                stream: CloudFirestoreAPI().cards,
                builder: (context, snapshot) {
                  if (!snapshot.hasData ) {
                    print("No tiene tarjetas");
                    return Center(
                        child:Column(
                          children: <Widget> [
                            Text("Agrega una nueva tarjeta en el boton +"),
                            _buildAddCardButton(
                                icon: Icon(Icons.add,
                                  color: Colors.white,),
                                color: Colors.black,
                                context: context
                            ),
                          ],
                        )
                    );
                    // <---- no return here
                  } else {
                    print("tiene tarjetas");
                    final List <CardModel> tarjetas = snapshot.data;
                    print("tiene  "+ tarjetas.length.toString() +"   tarjetas");

                    if(tarjetas.length == 0){
                      print("No tiene tarjetas");
                      return Center(
                          child:Column(
                            children: <Widget> [
                              Text("Agrega una nueva tarjeta en el boton +"),
                              _buildAddCardButton(
                                  icon: Icon(Icons.add,
                                    color: Colors.white,),
                                  color: Colors.black,
                                  context: context
                              ),
                            ],
                          )
                      );
                    }

                    if(tarjetas.length == 1){
                      return SingleChildScrollView(
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[

                              _buildCreditCard(tarjetas: tarjetas[0]),

                            ],
                          ),
                        ),
                      );
                    }

                    if(tarjetas.length == 2 ){
                      return SingleChildScrollView(
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[

                              _buildCreditCard(tarjetas: tarjetas[0]),
                              _buildCreditCard(tarjetas: tarjetas[1]),

                            ],
                          ),
                        ),
                      );
                    }

                    if(tarjetas.length == 3 ){
                      return SingleChildScrollView(
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[

                              _buildCreditCard(tarjetas: tarjetas[0]),
                              _buildCreditCard(tarjetas: tarjetas[1]),
                              _buildCreditCard(tarjetas: tarjetas[2]),

                            ],
                          ),
                        ),
                      );
                    }

                    if(tarjetas.length == 4 ){
                      return SingleChildScrollView(
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[

                              _buildCreditCard(tarjetas: tarjetas[0]),
                              _buildCreditCard(tarjetas: tarjetas[1]),
                              _buildCreditCard(tarjetas: tarjetas[2]),
                              _buildCreditCard(tarjetas: tarjetas[3]),

                            ],
                          ),
                        ),
                      );
                    }

                  }
                }
            ),)


      ),
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


  Card _buildCreditCard(
      { @required CardModel tarjetas}) {

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
                _buildDetailsBlock(label: 'Vencimiento', value: tarjetas.expiryDate),
              ],
            ),
          ],
        ),
      ),
    );


  }

  Row _buildLogosBlock( CardModel tarjetas) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Image.asset(
          "assets/images/contact_less.png",
          height: 20,
          width: 18,
        ),

        Padding(
          padding: const EdgeInsets.only(left: 16, right: 10, top: 8),
          child: getCardTypeIcon(tarjetas.cardNumber),
        ),
        //Image.asset(
        //  cardLogo,
        //  height: 50,
        //  width: 50,
        //),
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
