import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String firstName;
  final String lastName;
  final String photoUrl;
  final String email;
  final String uid;

  AppUser(
      {required this.firstName,
      required this.lastName,
      required this.photoUrl,
      required this.email,
      required this.uid});

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'photoUrl': photoUrl,
      'email': email,
      'uid': uid,
    };
  }

  factory AppUser.fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return AppUser(
      firstName: snapshot['firstName'],
      lastName: snapshot['lastName'],
      photoUrl: snapshot['photoUrl'],
      email: snapshot['email'],
      uid: snapshot['uid'],
    );
  }
}
