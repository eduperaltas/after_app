// @dart=2.9
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:after_app/Users/model/user.dart' as us;
// import 'package:flutter_facebook_login/flutter_facebook_login.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert' as Json;

class FirebaseAuthAPI {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  // final FacebookLogin  facebookLogin= FacebookLogin();

  Future<User> signIn() async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: gSA.accessToken,
      idToken: gSA.idToken,
    );
    final User user = (await _auth.signInWithCredential(credential)).user;
    return user;
  }


  Future<User> facebookSignIn() async {
    // final resultFb = await facebookLogin.logIn(['email']);
    //
    // switch (resultFb.status) {
    //   case FacebookLoginStatus.loggedIn:
    //
    //     final token = resultFb.accessToken.token;
    //     final graphResponse = await http.get(
    //         'https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}');
    //     //dynamic user2  = Json.jsonDecode(graphResponse.body);
    //     FirebaseUser user2  = await _auth.signInWithCredential(FacebookAuthProvider.getCredential(accessToken: resultFb.accessToken.token));
    //     print('todo bientos');
    //     return user2;
    //     //_isLoggedIn = true;
    //     //fbname = profile['name'];
    //     //fbemail = profile['email'];
    //     //fbphotoUrl = profile['picture']['data']['url'];
    //
    //     break;
    //
    //   case FacebookLoginStatus.error:
    //     print('error');
    //     break;
    //
    //   case FacebookLoginStatus.cancelledByUser:
    //     print('cancelledByUser');
    //     break;
    // }
  }

  Future sendPasswordResetEmail(String email) async {
    return _auth.sendPasswordResetEmail(email: email);
  }
  Future <User> registerWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    }catch(e){
      print(e.toString());
      return null;

    }
  }

  // get current User data
  User getCurrentUser() {
    return _auth.currentUser;
  }

  Future <User> signInWithEmailAndPassword(String email, String password) async{
    //cont=1;
    try{
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;

    }catch(e){
      print(e.toString());
      return null;

    }
  }

  void signOut() async {
    await googleSignIn.signOut();
    await _auth.signOut();
    // facebookLogin.logOut();
    print(("sesiones cerradas"));
}


}