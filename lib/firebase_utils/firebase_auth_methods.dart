import 'package:cbc_learning_materials/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class FirebaseAuthMethods {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future signUp(String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showErrorDialog(context, 'An account already exists for that email.');
      }
    } catch (e) {
      showErrorDialog(context, e.toString());
    }
  }

  Future signIn(String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: "barry.allen@example.com",
              password: "SuperSecretPassword!");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showErrorDialog(context, "No user with that email, please sign up");
      } else if (e.code == 'wrong-password') {
        showErrorDialog(context, 'Wrong password provided please try again');
      }
    } catch (e) {
      showErrorDialog(context, e.toString());
    }
  }

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
