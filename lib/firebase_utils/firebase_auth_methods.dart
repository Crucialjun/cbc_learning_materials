
import 'package:cbc_learning_materials/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class FirebaseAuthMethods{

  FirebaseAuth auth = FirebaseAuth.instance;

  signUp(String email,String password,BuildContext context) async {
    try{
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
    }on FirebaseAuthException catch (e){
      if(e.code == 'email-already-in-use') {
        showErrorDialog(context, 'An account already exists for that email.');
      }
    }catch (e){
      showErrorDialog(context, e.toString());
    }
  }
}