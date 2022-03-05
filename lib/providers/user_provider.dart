import 'package:cbc_learning_materials/firebase_utils/firebase_auth_methods.dart';
import 'package:cbc_learning_materials/firebase_utils/firestore_methods.dart';
import 'package:cbc_learning_materials/models/app_user.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  AppUser? _user;

  final Firestoremethods _firestoremethods = Firestoremethods();

  AppUser? get getUser => _user;

  Future<void> refreshUser(String userUid) async {
    var user = await _firestoremethods.getUser(userUid);
    _user = user;
    notifyListeners();
  }
}
