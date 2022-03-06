import 'dart:convert';

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

  factory LearningMaterial.fromJson(String source) =>
      LearningMaterial.fromMap(json.decode(source));
}
