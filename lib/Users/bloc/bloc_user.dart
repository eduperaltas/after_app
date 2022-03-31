import 'package:after_app/Users/model/user.dart' as us;
import 'package:after_app/Users/repository/cloud_firestore_api.dart';
import 'package:after_app/Users/repository/cloud_firestore_repository.dart';
import 'package:after_app/Widgets/MyPreferences.dart';
import 'package:after_app/Widgets/add_credit_card/credit_card_model.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:after_app/Users/repository/auth_repository.dart';
class UserBloc implements Bloc {

  final _auth_repository = AuthRepository();
  MyPreferences _myPreferences = MyPreferences();
  //Flujo de datos - Streams
  //Stream - Firebase
  //StreamController
  Stream<User> streamFirebase = FirebaseAuth.instance.authStateChanges();
  Stream<User> get authStatus => streamFirebase;

  //Casos uso
  //1. SignIn a la aplicación Google
  Future<User> signIn() {
    return _auth_repository.signFirebaseGoogle();
  }
  Future<User> facebookSignIn() {
    return _auth_repository.signFirebaseFacebook();
  }
  Future<User> signInWithEmailAndPassword(us.User user) {
    return _auth_repository.signFirebaseMail();
  }
  Future<User> getuserdatatocreate() {
    return _auth_repository.getCurrentUserDatatoCreate();
  }
  Future<User> getuserdatatocreate1() {
    return _auth_repository.getCurrentUserDatatoCreate();
  }

  String getuid(){    
    String Useruid="";
    getuserdatatocreate().then((User user) {
     Useruid =  user.uid.toString();
    });
    return Useruid;
  }

  final _cloudFirestoreRepository = CloudFirestoreRepository();
  void createUserData(us.User user) => _cloudFirestoreRepository.createUserDataFirestore(user);
  void createBarberData(us.User user,String bank,String nameaccount,String numaccount,String cci) => _cloudFirestoreRepository.createBarberData(user,bank,nameaccount,numaccount,cci);
  void createUserCard(CreditCardModel card) => _cloudFirestoreRepository.createUserCard(card);


  Future<void> updateUserData(us.User user,String newData){
    return _cloudFirestoreRepository.updateUserData(user, newData);
  }
  
  signOut() {
    _myPreferences.active = false;
    CloudFirestoreAPI(uid: _myPreferences.uid).updateBarberStateData(_myPreferences.active);
    _myPreferences.uid = "";
    _auth_repository.signOut();
  }


  @override
  void dispose() {

  }
}