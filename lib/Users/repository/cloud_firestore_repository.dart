import 'package:after_app/Users/model/user.dart';
import 'package:after_app/Users/repository/cloud_firestore_api.dart';
import 'package:after_app/Widgets/add_credit_card/credit_card_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CloudFirestoreRepository {
  final _cloudFirestoreAPI = CloudFirestoreAPI();


  void createUserDataFirestore(User user) => _cloudFirestoreAPI.createUserData(user);
  void createBarberData(User user,String bank,String nameaccount,String numaccount,String cci) => _cloudFirestoreAPI.createBarberData(user,bank,nameaccount,numaccount,cci);
  void createUserCard(CreditCardModel card) => _cloudFirestoreAPI.createUserCard(card);
  User userDataFromSnapshot(DocumentSnapshot snapshot) => _cloudFirestoreAPI.userDataFromSnapshot(snapshot);
  Future<void> updateUserData(User user,String newData)=> _cloudFirestoreAPI.updateUserData(user, newData);


}