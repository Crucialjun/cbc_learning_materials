import 'package:cbc_learning_materials/firebase_utils/firebase_auth_methods.dart';
import 'package:flutter/material.dart';

class MainDashboard extends StatelessWidget {
  const MainDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              FirebaseAuthMethods().signOut();
            },
            child: const Text("Log Out")),
      ),
    );
  }
}
