// @dart=2.9
class CardModel {
  final String cardNumber     ;
  final String carduid     ;
  final String expiryDate       ;
  final String cardHolderName ;
  final String cvvCode          ;


  CardModel({this.cardNumber, this.expiryDate, this.cardHolderName, this.cvvCode,this.carduid});
}
