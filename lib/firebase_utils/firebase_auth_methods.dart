import 'package:cbc_learning_materials/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
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

  Future resetPassword(String email, BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email)
          .then((_) {
        showSuccessDialog(context, "Reset link succesfully sent to $email");
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        showErrorDialog(
            context, "$email not found please register with the email");
      }
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
