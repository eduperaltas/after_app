import 'package:firebase_auth/firebase_auth.dart';
import 'package:after_app/Users/repository/firebase_auth_api.dart';

class AuthRepository {
  final _firebaseAuthAPI = FirebaseAuthAPI();
  Future<User> signFirebaseGoogle() => _firebaseAuthAPI.signIn();
  Future<User> signFirebaseFacebook() => _firebaseAuthAPI.facebookSignIn();
  Future<User> signFirebaseMail() => _firebaseAuthAPI.signInWithEmailAndPassword(" ", "");
  Future<User> getCurrentUserDatatoCreate() => _firebaseAuthAPI.getuserdatatocreate();
  signOut() => _firebaseAuthAPI.signOut();

}