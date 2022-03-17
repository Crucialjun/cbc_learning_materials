import 'dart:convert';

import 'package:cbc_learning_materials/global_consts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LearningMaterial {
  final String name;
  final String downloadUrl;
  final String id;
  final dynamic dateAdded;
  final String description;

  LearningMaterial(
      {required this.name, required this.downloadUrl, required this.id,required this.dateAdded,required this.description});

  Map<String, dynamic> toMap() {
    return {'name': name, 'downloadUrl': downloadUrl, 'id': id};
  }

  factory LearningMaterial.fromMap(Map<String, dynamic> map) {
    return LearningMaterial(
        name: map['name'] ?? '',
        downloadUrl: map['downloadUrl'] ?? '',
        id: map['id'] ?? '',
      dateAdded: map['dateAdded'] ?? '',
      description: map['description'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LearningMaterial.fromSnap(QuerySnapshot snap) {
    var snapshot = snap.docs as Map<String, dynamic>;

    return LearningMaterial(
      name: snapshot[learningMaterialName],
      downloadUrl: snapshot[learningMaterialUrl],
      id: snapshot["id"],
      dateAdded: snapshot[learningMaterialDate],
      description: snapshot[learningMaterialDescription],
    );
  }
  factory LearningMaterial.fromDocSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return LearningMaterial(
      name: snapshot[learningMaterialName],
      downloadUrl: snapshot[learningMaterialUrl],
      id: snapshot["id"] ?? "",
      dateAdded: snapshot[learningMaterialDate] ?? "",
      description: snapshot[learningMaterialDescription] ?? "",
    );
  }

  factory LearningMaterial.fromJson(String source) =>
      LearningMaterial.fromMap(json.decode(source));
}
