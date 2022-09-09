import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  // initializing firebase auth
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  // this function will return current user information
  static User? get user => _auth.currentUser;

  static Future<bool> signIn(String email, String password) async{
    // await _auth.useAuthEmulator('10.0.2.2',9099);
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    print('credential: $userCredential');
    return userCredential.user != null;
    // return AuthDB.isAdmin(userCredential.user!.uid);
  }

  static Future<void> signOut() => _auth.signOut();


}