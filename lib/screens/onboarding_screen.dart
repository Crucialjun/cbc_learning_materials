import 'package:cbc_learning_materials/app_colors.dart';
import 'package:cbc_learning_materials/global_consts.dart';
import 'package:cbc_learning_materials/screens/main_dashboard.dart';
import 'package:cbc_learning_materials/screens/sign_in_screen.dart';
import 'package:cbc_learning_materials/screens/sign_up_screen.dart';
import 'package:cbc_learning_materials/widgets/onboarding_pageview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    final User? user = context.watch<User?>();

    if (user != null) {
      return const MainDashboard();
    }
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  appName,
                  style: TextStyle(
                      fontSize: 18,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => const SignInScreen(),
                        transition: Transition.zoom);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Skip",
                      style: TextStyle(
                          color: AppColors.PRIMARY_COLOR_LIGHT, fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
            const Expanded(child: OnboardingPageView()),
            Hero(
              tag: 'signup',
              child: ElevatedButton(
                style:
                    ElevatedButton.styleFrom(primary: AppColors.primaryColor),
                onPressed: () {
                  Get.to(() => const SignUpScreen(),
                      transition: Transition.zoom);
                },
                child: const Text("Create an Account"),
              ),
            ),
            Hero(
              tag: "signin",
              child: OutlinedButton(
                onPressed: () {
                  Get.to(() => const SignInScreen(),
                      transition: Transition.zoom);
                },
                style: OutlinedButton.styleFrom(
                    primary: AppColors.primaryColor,
                    backgroundColor: Colors.white,
                    side: const BorderSide(
                        width: 1.0, color: AppColors.primaryColor)),
                child: const Text("I already have an account"),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
