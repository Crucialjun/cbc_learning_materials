import 'package:cbc_learning_materials/firebase_utils/firestore_methods.dart';
import 'package:cbc_learning_materials/models/app_user.dart';
import 'package:cbc_learning_materials/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //auth state provider
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<bool> signUp(String email, String password, String firstName,
      String lastName, BuildContext context) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email.trim(), password: password)
          .then((value) async {
        AppUser user = AppUser(
            firstName: firstName,
            lastName: lastName,
            photoUrl: value.user?.photoURL,
            email: email,
            uid: value.user!.uid,
            isAdmin: false);
        await Firestoremethods().addUser(user);
        return true;
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showErrorDialog(context, 'An account already exists for that email.');
        return false;
      }
    } catch (e) {
      showErrorDialog(context, e.toString());
      return false;
    }
    return false;
  }

  Future signIn(String email, String password, BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email.trim(), password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showErrorDialog(context, "No user with that email, please sign up");
        return false;
      } else if (e.code == 'wrong-password') {
        showErrorDialog(context, 'Wrong password provided please try again');
        return false;
      }
    } catch (e) {
      showErrorDialog(context, e.toString());
      return false;
    }
    return false;
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

  Future<UserCredential?> signInWithFacebook(BuildContext context) async {
    TextEditingController _emailcontroller = TextEditingController();
    TextEditingController _passwordcontroller = TextEditingController();
    String password = "";

    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      // Create a credential from the access token
      final OAuthCredential credential =
          FacebookAuthProvider.credential(result.accessToken!.token);

      final userData = await FacebookAuth.instance.getUserData();

      List<String> signInMethods = await FirebaseAuth.instance
          .fetchSignInMethodsForEmail(userData['email']);

      if (signInMethods.isEmpty || signInMethods.contains('facebook.com')) {
        // Once signed in, return the UserCredential
        return await FirebaseAuth.instance.signInWithCredential(credential);
      } else {
        _emailcontroller.text = userData['email'];
        Alert(
            context: context,
            title: "Add a password to secure your account",
            content: Column(
              children: [
                TextField(
                  enabled: false,
                  controller: _emailcontroller,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.account_circle),
                    labelText: 'Email',
                  ),
                ),
                TextField(
                  controller: _passwordcontroller,
                  obscureText: true,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.lock),
                    labelText: 'Password',
                  ),
                ),
              ],
            ),
            buttons: [
              DialogButton(
                onPressed: () async {
                  password = _passwordcontroller.text;
                  UserCredential emailCredintials = await FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: userData['email'], password: password);

                  await emailCredintials.user?.linkWithCredential(credential);
                  Navigator.pop(context);
                },
                child: const Text(
                  "LOGIN",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              )
            ]).show();
      }
    }

    return null;
  }
}
