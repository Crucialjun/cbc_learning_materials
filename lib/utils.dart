import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';

showErrorDialog(BuildContext context, String text) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.ERROR,
    animType: AnimType.BOTTOMSLIDE,
    title: "Error",
    desc: text,
    btnOkOnPress: () {},
  ).show();
}

showSuccessDialog(BuildContext context, String text) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.SUCCES,
    animType: AnimType.BOTTOMSLIDE,
    title: "Success",
    desc: text,
    btnOkOnPress: () {},
  ).show();
}
