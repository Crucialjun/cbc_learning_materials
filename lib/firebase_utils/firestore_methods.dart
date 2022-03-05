import 'package:cbc_learning_materials/global_consts.dart';
import 'package:cbc_learning_materials/models/app_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Firestoremethods {
  CollectionReference users =
      FirebaseFirestore.instance.collection(userTableName);

  Future<void> addUser(AppUser user) {
    // Call the user's CollectionReference to add a new user
    return users
        .doc(user.uid)
        .set({
          userFirstName: user.firstName,
          userLastName: user.lastName,
          userEmail: user.email,
          userPhotoUrl: user.photoUrl,
          userUid: user.uid,
          userIsAdmin: user.isAdmin,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<AppUser> getUser(String userUid) async {
    var currentUser = FirebaseAuth.instance.currentUser;

    var snapshot = await users.doc(userUid).get();

    return AppUser.fromSnap(snapshot);
  }
}
