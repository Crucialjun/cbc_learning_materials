import 'package:cbc_learning_materials/app_colors.dart';
import 'package:cbc_learning_materials/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';

import '../firebase_utils/firebase_auth_methods.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24),
          child: Column(children: [
            Expanded(
                child: Hero(
                    tag: "topsvg",
                    child: SvgPicture.asset(
                        "assets/svg/forgot_password_image.svg"))),
            const Text(
              'SIGN IN',
              style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.all(4),
                prefixIcon: const Icon(
                  Icons.email,
                  color: Colors.black,
                ),
                labelText: "Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            TextFormField(
              obscureText: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return " Please enter password";
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.all(8),
                prefixIcon: const Icon(
                  Icons.password,
                  color: Colors.black,
                ),
                labelText: "Create Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            const Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                  child: Text(
                "Forgot Password",
                style: TextStyle(
                    color: AppColors.primaryColor, fontWeight: FontWeight.bold),
              )),
            ),
            const SizedBox(
              height: 16,
            ),
            ProgressButton.icon(
              iconedButtons: {
                ButtonState.idle: const IconedButton(
                    text: "Sign In",
                    icon: Icon(Icons.send, color: Colors.white),
                    color: AppColors.primaryColor),
                ButtonState.loading: IconedButton(
                    text: "Loading", color: Colors.deepPurple.shade700),
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
              state: _isLoading ? ButtonState.loading : ButtonState.idle,
              onPressed: () async {},
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(color: Colors.black),
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpScreen()),
                        );
                      },
                      child: const Text(
                        " Sign Up",
                        style: TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
