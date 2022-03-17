

import 'package:cbc_learning_materials/firebase_utils/firebase_storage_methods.dart';
import 'package:cbc_learning_materials/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'dart:io';

import '../app_colors.dart';

class AddLearningMaterial extends StatefulWidget {
  const AddLearningMaterial({Key? key}) : super(key: key);

  @override
  State<AddLearningMaterial> createState() => _AddLearningMaterialState();
}

class _AddLearningMaterialState extends State<AddLearningMaterial> {
  final TextEditingController _fileNameController = TextEditingController();
  final TextEditingController _fileDescriptionController = TextEditingController();
  String? _imagePath;
  bool _isLoadingImage = false;
  bool _isLoadingUpload = false;
  ButtonState _uploadingButtonState = ButtonState.idle;

  @override
  void dispose() {
    _fileNameController.dispose();
    _fileDescriptionController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24,bottom: 24),
          child: Column(children: [
            const Padding(
              padding: EdgeInsets.only(top: 24.0),
              child: Text(
                'UPLOAD LEARNING MATERIAL',
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Hero(
                  tag: "topsvg",
                  child: _imagePath ==  null || _imagePath == ""? SvgPicture.asset("assets/svg/upload.svg") :Image.file(File(_imagePath ?? "")), ),
            ),
            const SizedBox(height: 24,),
            ElevatedButton(onPressed: () async{
              setState(() {
                _isLoadingImage = true;
              });
              var result = await FirebaseStorageMethods().pickFile();
              setState(() {
                _imagePath = result ?? "";
                _isLoadingImage = false;

              });


            }, child: Text("Pick file")

            ),
            SizedBox(height: 24,),

            TextField(
              controller: _fileNameController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(4),
                labelText: "Enter File Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
            ),),

            const SizedBox(height: 24,),
            TextField(
              maxLines: null,
              keyboardType: TextInputType.multiline,
              controller: _fileDescriptionController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(4),
                labelText: "Enter File Description",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),),

            const SizedBox(height: 24,),
            ProgressButton.icon(
              iconedButtons: {
                ButtonState.idle: const IconedButton(
                    text: "Upload File",
                    icon: Icon(Icons.send, color: Colors.white),
                    color: AppColors.primaryColor),
                ButtonState.loading: IconedButton(
                    text: "Uploading", color: Colors.deepPurple.shade700),
                ButtonState.fail: IconedButton(
                    text: "Failed",
                    icon: const Icon(Icons.cancel, color: Colors.white),
                    color: Colors.red.shade300),
                ButtonState.success: IconedButton(
                    text: "Success",
                    icon: const Icon(
                      Icons.check_circle,
                      color: Colors.white,
                    ),
                    color: Colors.green.shade400)
              },
              state: _uploadingButtonState,
              onPressed: () async {
                setState(() {
                  _uploadingButtonState = ButtonState.loading;
                });
                if(_fileNameController.text.isEmpty){
                  setState(() {
                    _uploadingButtonState = ButtonState.fail;
                  });
                  showErrorDialog(context, "Enter File Name");
                }else{
                  await FirebaseStorageMethods().uploadfile(context, _fileNameController.text,_imagePath!,_fileDescriptionController.text);
                  setState(() {
                    _uploadingButtonState = ButtonState.success;
                    _fileNameController.clear();
                    _imagePath = null;
                  });

                }

              },
            ),
          ]
          ),
        ),
      ),
    );
  }
}
