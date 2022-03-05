import 'package:cbc_learning_materials/firebase_utils/firebase_auth_methods.dart';
import 'package:cbc_learning_materials/screens/main_dashboard.dart';
import 'package:cbc_learning_materials/screens/onboarding_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthController extends StatelessWidget {
  const AuthController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = context.watch<User?>();

    if(user == null){
    return const OnboardingScreen();
  }else{
      return const MainDashboard();
    }
    }
}
