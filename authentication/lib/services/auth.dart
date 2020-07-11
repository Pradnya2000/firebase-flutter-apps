import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class User {
  final String uid;
  User({@required this.uid});
}

abstract class AuthBase {
  Stream<User> get onAuthStateChange;
  Future<User> signInWithEmail(String email,String password);
  Future<User> createUserWithEmail(String email,String password);
  Future<User> currentUser();
  Future<User> signInAnonymously();
  Future<User> signInWithGoogle();
  Future<void> signOut();
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;
  User _userFromFirebase(FirebaseUser user) {
    if (user == null) return null;
    return User(uid: user.uid);
  }

  @override
  Stream<User> get onAuthStateChange {
    return _firebaseAuth.onAuthStateChanged.map(_userFromFirebase);
  }

  @override
  Future<User> currentUser() async {
    final user = await _firebaseAuth.currentUser();
    return _userFromFirebase(user);
  }

  @override
  Future<User> signInAnonymously() async {
    final authResult = await _firebaseAuth.signInAnonymously();
    return User(uid: authResult.user.uid);
  }
  @override
  Future<User> signInWithEmail(String email,String password)async{
    final authResult=await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return _userFromFirebase(authResult.user); 
  }
  @override
   Future<User> createUserWithEmail(String email,String password)async{
    final authResult=await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    return _userFromFirebase(authResult.user); 
  }
  Future<User> signInWithGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      GoogleSignInAuthentication googleAuth =
          await googleSignInAccount.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        final authResult = await _firebaseAuth.signInWithCredential(
          GoogleAuthProvider.getCredential(
              idToken: googleAuth.idToken, accessToken: googleAuth.accessToken),
        );
        return _userFromFirebase(authResult.user);
      } else {
        throw PlatformException(
            code: 'ERROR_MISSING_GOOGLE_ACCESS_TOKEN',
            message: 'missing google auth token');
      }
    } else {
      throw PlatformException(
          code: 'ERROR_MISSING_GOOGLE_ACCESS_TOKEN',
          message: 'missing google auth token');
    }
  }

  @override
  Future<void> signOut() async {
    GoogleSignIn googleSignIn=GoogleSignIn();
    googleSignIn.signOut(); 
    await _firebaseAuth.signOut();
  }
}
