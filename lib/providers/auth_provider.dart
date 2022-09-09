import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/auth/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  bool isObscure = true;
  bool isVisible = false;
  String? email;
  String? password;
  String errorMessage = '';

  // change visibility of password
  void changeVisibility() {
    isVisible = !isVisible;
    isObscure = !isObscure;

    print('obscure: $isObscure');
    notifyListeners();
  }

  // set email from email field
  void setEmail(String email) {
    this.email = email;
  }

  // set password from password field
  void setPassword(String password) {
    this.password = password;
  }

  void setError(String err) {
    errorMessage = err;
    notifyListeners();
  }

  // signing in admin
  Future<void> _signIn() async {
    try {
      bool isSuccess = await AuthService.signIn(email!, password!);
      if (isSuccess) {
        return;
      }
    } on FirebaseAuthException catch (e) {
      rethrow;
    }
  }

  // authenticating admin
  Future<void> authenticate() async {
    try {
        final status = await AuthService.signIn(email!, password!);

        if (!status) {
          AuthService.signOut();
          throw 'You are not admin';
        }

    } on FirebaseAuthException catch (e) {
      setError(e.message!);
    }
  }

  // this method will return current user info
  User? getCurrentUser() => AuthService.user;
}
