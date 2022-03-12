import 'dart:convert';

import 'package:cbc_learning_materials/global_consts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LearningMaterial {
  final String name;
  final String downloadUrl;

  LearningMaterial({required this.name, required this.downloadUrl});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'downloadUrl': downloadUrl,
    };
  }

  factory LearningMaterial.fromMap(Map<String, dynamic> map) {
    return LearningMaterial(
      name: map['name'] ?? '',
      downloadUrl: map['downloadUrl'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LearningMaterial.fromSnap(QuerySnapshot snap) {
    var snapshot = snap.docs as Map<String, dynamic>;

    return LearningMaterial(
      name: snapshot[learningMaterialName],
      downloadUrl: snapshot[learningMaterialUrl],
    );
  }

  factory LearningMaterial.fromJson(String source) =>
      LearningMaterial.fromMap(json.decode(source));
}
