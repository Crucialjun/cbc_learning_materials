import 'dart:io';

import 'package:cbc_learning_materials/firebase_utils/firestore_methods.dart';
import 'package:cbc_learning_materials/global_consts.dart';
import 'package:cbc_learning_materials/models/learning_material.dart';
import 'package:cbc_learning_materials/utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class FirebaseStorageMethods {
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<String?> pickFile() async {
    FilePickerResult? results = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['pdf', 'jpg', 'png']);

    if (results == null) {
      return null;
    } else {
      return results.files.single.path;
    }
  }

  Future<void> uploadfile(
      BuildContext context, String filename, String path) async {
    File file = File(path);
    var uuid = const Uuid();
    var id = uuid.v4();
    if (filename.isEmpty) {
      showErrorDialog(context, "Please Enter File Name");
    } else {
      try {
        var ref = storage.ref("$learningMaterialStorageFolder/$filename");
        var task = await ref.putFile(file);
        String downloadUrl = await ref.getDownloadURL();
        var learningMaterial =
            LearningMaterial(name: filename, downloadUrl: downloadUrl, id: id);
        Firestoremethods().addLearningMaterial(learningMaterial);
        if (kDebugMode) {
          print(downloadUrl);
        }
      } on FirebaseException catch (e) {
        showErrorDialog(context, e.message.toString());
        if (kDebugMode) {
          print(e.toString());
        }
      }
    }
  }
}
