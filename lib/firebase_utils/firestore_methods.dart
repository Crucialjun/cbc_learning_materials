import 'package:cbc_learning_materials/global_consts.dart';
import 'package:cbc_learning_materials/models/app_user.dart';
import 'package:cbc_learning_materials/models/learning_material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Firestoremethods {
  CollectionReference users =
      FirebaseFirestore.instance.collection(userTableName);

  CollectionReference learningMaterials =
      FirebaseFirestore.instance.collection(learningMaterialTableName);

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

  Stream<AppUser> getUser(String userUid) {
    return users.doc(userUid).snapshots().map((snap) => AppUser.fromSnap(snap));
  }

  Future<void> addLearningMaterial(LearningMaterial learningMaterial) {
    return learningMaterials.add(learningMaterial);
  }
}
