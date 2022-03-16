import 'package:cbc_learning_materials/models/learning_material.dart';
import 'package:flutter/material.dart';

class LearningMaterialDetails extends StatelessWidget {
  final LearningMaterial learningMaterial;
  const LearningMaterialDetails({Key? key, required this.learningMaterial})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(onPressed: () {}),
      body: SafeArea(
          child: Column(children: [
        Row(
          children: [
            IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
            IconButton(onPressed: () {}, icon: Icon(Icons.favorite)),
          ],
        ),
        Stack(
          children: [
            Positioned(
              child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Image.network(
                      learningMaterial.downloadUrl,
                    ),
                  )),
            ),
            Positioned(
              bottom: -20,
              child: Align(
                alignment: Alignment.center,
                child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: Text("Description"),
                    )),
              ),
            ),
          ],
        ),
        Text(
          learningMaterial.name,
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
      ])),
    );
  }
}
