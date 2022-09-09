import 'package:cloud_firestore/cloud_firestore.dart';

class AuthDB{
  static const String collectionAdmin = 'admins';
  static final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  // this method will check the uid with admins collection from firebase firestore
  // then will return true or false
  static Future<bool> isAdmin(String uid) async{
    DocumentSnapshot snapshot = await _firebaseFirestore.collection(collectionAdmin).doc(uid).get();
    return snapshot.exists;
  }
}