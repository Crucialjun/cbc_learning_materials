import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(children: const [
        Text(
          "Register",
          style: TextStyle(fontWeight: FontWeight.bold),
        )
      ]),
    );
  }
}
