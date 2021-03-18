import 'package:firebase_auth/firebase_auth.dart';
import 'package:the_ranch_app/models/ranch_user.dart';

abstract class AuthBase {
  Future<RanchUser> signInWithEmailAndPassword(String email, String password);
  Future<void> signOut();
  Stream<RanchUser> get userAuthState;
  Future<RanchUser> get currentUser;
}

class Auth implements AuthBase {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<RanchUser> signInWithEmailAndPassword(
      String email, String password) async {
    AuthResult authResult = await _auth.signInWithEmailAndPassword(
        email: email, password: password);

    return RanchUser.getUserFromFirebase(authResult.user);
  }

  @override
  Future<void> signOut() async {
    return await _auth.signOut();
  }

  @override
  Stream<RanchUser> get userAuthState {
    return _auth.onAuthStateChanged
        .map((firebaseUser) => RanchUser.getUserFromFirebase(firebaseUser));
  }

  @override
  Future<RanchUser> get currentUser async {
    FirebaseUser firebaseUser = await _auth.currentUser();
    return RanchUser.getUserFromFirebase(firebaseUser);
  }
}
