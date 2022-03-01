import 'package:cbc_learning_materials/firebase_utils/firebase_auth_methods.dart';
import 'package:cbc_learning_materials/models/app_user.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  AppUser? _user;

  final FirebaseAuthMethods _firebaseAuthMethods = FirebaseAuthMethods();

  AppUser get getUser => _user!;

  Future<void> refreshUser() async {
    var user = await _firebaseAuthMethods.getUser();
    _user = user;
    notifyListeners();
  }
}
