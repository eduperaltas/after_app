import 'package:firebase_auth/firebase_auth.dart';
import 'package:after_app/Users/repository/firebase_auth_api.dart';
import 'package:after_app/Users/model/user.dart' as us;

class AuthRepository {
  final _firebaseAuthAPI = FirebaseAuthAPI();
  Future<User> signFirebaseGoogle() => _firebaseAuthAPI.signIn();
  Future<User> signFirebaseFacebook() => _firebaseAuthAPI.facebookSignIn();
  Future<User> signFirebaseMail() => _firebaseAuthAPI.signInWithEmailAndPassword(" ", "");
  User getCurrentUserData() => _firebaseAuthAPI.getCurrentUser();
  signOut() => _firebaseAuthAPI.signOut();
}