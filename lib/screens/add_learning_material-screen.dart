import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../app_colors.dart';

class AddLearningMaterial extends StatelessWidget {
  const AddLearningMaterial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24),
          child: Column(children: [
            Hero(
                tag: "topsvg",
                child: SvgPicture.asset("assets/svg/upload.svg")),
            const Text(
              'UPLOAD LEARNING MATERIAL',
              style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
            ),
          ]),
        ),
      ),
    );
  }
}
