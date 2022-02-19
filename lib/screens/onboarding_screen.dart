import 'package:cbc_learning_materials/app_colors.dart';
import 'package:cbc_learning_materials/global_consts.dart';
import 'package:cbc_learning_materials/screens/sign_in_screen.dart';
import 'package:cbc_learning_materials/screens/sign_up_screen.dart';
import 'package:cbc_learning_materials/widgets/onboarding_pageview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                appName,
                style: TextStyle(
                    fontSize: 18,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Skip",
                style: TextStyle(color: AppColors.PRIMARY_COLOR_LIGHT),
              ),
            ],
          ),
          const Expanded(child: OnboardingPageView()),
          Hero(
            tag: 'signup',
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: AppColors.primaryColor),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUpScreen(),
                    ),
                    (route) => false);
              },
              child: const Text("Create an Account"),
            ),
          ),
          Hero(
            tag: "signin",
            child: OutlinedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignInScreen(),
                    ),
                    (route) => false);
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
    );
  }
}
