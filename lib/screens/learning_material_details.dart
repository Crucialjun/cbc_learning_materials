import 'package:cbc_learning_materials/models/learning_material.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:cbc_learning_materials/string_extensions.dart';

class LearningMaterialDetails extends StatelessWidget {
  final LearningMaterial learningMaterial;
  const LearningMaterialDetails({Key? key, required this.learningMaterial})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var format = DateFormat('dd-MM-yy');
    var dateadded = format.format(learningMaterial.dateAdded.toDate());
    return Scaffold(
      appBar: AppBar(
        title: Text(learningMaterial.name),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
        Image.network(learningMaterial.downloadUrl),
        Text(
          learningMaterial.name.toTitleCase(),
          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
            Row(
              children: [
                const Text(
                  "Date Added: ",
                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),
                ),
                Text(
                  dateadded,
                  style: const TextStyle(fontSize: 16,fontStyle: FontStyle.italic),
                ),
              ],
            ),
                Text(learningMaterial.description)
      ])),
    );
  }
}
