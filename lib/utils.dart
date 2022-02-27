import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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

showAlertDialog(BuildContext context, String email) {
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  _emailcontroller.text = email;
  Alert(
      context: context,
      title: "Add a password to secure your account",
      content: Column(
        children: [
          TextField(
            enabled: false,
            controller: _emailcontroller,
            decoration: const InputDecoration(
              icon: Icon(Icons.account_circle),
              labelText: 'Email',
            ),
          ),
          TextField(
            controller: _passwordcontroller,
            obscureText: true,
            decoration: const InputDecoration(
              icon: Icon(Icons.lock),
              labelText: 'Password',
            ),
          ),
        ],
      ),
      buttons: [
        DialogButton(
          onPressed: () {},
          child: const Text(
            "LOGIN",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ]).show();
}
