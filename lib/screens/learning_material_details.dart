import 'package:cbc_learning_materials/models/learning_material.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:progressive_image/progressive_image.dart';

class LearningMaterialDetails extends StatelessWidget {
  final LearningMaterial learningMaterial;
  const LearningMaterialDetails({Key? key, required this.learningMaterial})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var format = DateFormat('yyyy-MM-dd hh:mm');
    var dateadded = format.format(learningMaterial.dateAdded.toDate());
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(onPressed: () {}),
      body: SafeArea(
          child: Column(children: [
        Row(
          children: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.favorite)),
          ],
        ),
        Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ProgressiveImage.custom(
                  placeholderBuilder: (context) => const CircularProgressIndicator(),
                  image:NetworkImage( learningMaterial.downloadUrl), height: 260, thumbnail: NetworkImage( learningMaterial.downloadUrl), width: 180,)
            )),
        Align(
          alignment: Alignment.center,
          child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Description"),
              )),
        ),
        Text(
          learningMaterial.name,
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
            Text(
              dateadded,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
      ])),
    );
  }
}
