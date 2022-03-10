import 'package:cbc_learning_materials/firebase_utils/firebase_storage_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../app_colors.dart';

class AddLearningMaterial extends StatelessWidget {
  const AddLearningMaterial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _fileNameController = TextEditingController();


    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24),
          child: Column(children: [
            Expanded(
              child: Hero(
                  tag: "topsvg",
                  child: SvgPicture.asset("assets/svg/upload.svg")),
            ),
            const Text(
              'UPLOAD LEARNING MATERIAL',
              style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _fileNameController,
            ),
            ElevatedButton(onPressed: () async{
              FirebaseStorageMethods().uploadfile(context, _fileNameController.text);
            }, child: Text("Upload file"))
          ]),
        ),
      ),
    );
  }
}
