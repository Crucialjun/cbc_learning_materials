import 'package:cbc_learning_materials/global_consts.dart';
import 'package:flutter/material.dart';

import 'package:optimized_cached_image/optimized_cached_image.dart';

class LearningMaterialCard extends StatelessWidget {
  final snap;
  const LearningMaterialCard({Key? key, this.snap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(children: [
          Align(
              alignment: Alignment.center,
              child: Text(
                (snap[learningMaterialName]).toString().toUpperCase(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  decoration: TextDecoration.underline,
                ),
              )),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: OptimizedCacheImage(
              imageUrl: snap[learningMaterialUrl],
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ]),
      ),
    );
  }
}
