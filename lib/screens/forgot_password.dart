import 'package:cbc_learning_materials/app_colors.dart';
import 'package:cbc_learning_materials/screens/sign_up_screen.dart';
import 'package:cbc_learning_materials/utils.dart';
import 'package:email_validator/email_validator.dart';
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
  TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24),
          child: Form(
            key: _formKey,
            child: Column(children: [
              Expanded(
                  child: Hero(
                      tag: "topsvg",
                      child: SvgPicture.asset(
                          "assets/svg/forgot_password_image.svg"))),
              const Text(
                'FORGOT PASSWORD',
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text("Enter your email to receive the password reset link"),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: _emailController,
                validator: (value) => EmailValidator.validate(value!)
                    ? null
                    : "Please enter a valid email",
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
              ProgressButton.icon(
                iconedButtons: {
                  ButtonState.idle: const IconedButton(
                      text: "Reset Password",
                      icon: Icon(Icons.email_outlined, color: Colors.white),
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
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _isLoading = true;
                    });
                    await FirebaseAuthMethods()
                        .resetPassword(_emailController.text, context);
                    setState(() {
                      _isLoading = false;
                    });

                    showSuccessDialog(context,
                        "Reset link successfully sent to $_emailController.text");
                  }
                },
              ),
              const SizedBox(
                height: 16,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
