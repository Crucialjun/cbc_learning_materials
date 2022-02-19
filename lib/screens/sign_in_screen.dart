import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';

import '../app_colors.dart';
import '../firebase_utils/firebase_auth_methods.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
                      child: SvgPicture.asset("assets/svg/signup_image.svg"))),
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
              TextFormField(
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return " Please enter password";
                  } else {
                    return null;
                  }
                },
                controller: _passwordController,
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
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold),
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
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _isLoading = true;
                    });
                    await FirebaseAuthMethods().signIn(_emailController.text,
                        _passwordController.text, context);
                    setState(() {
                      _isLoading = false;
                    });
                  }
                },
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
                        onTap: () {},
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
      ),
    );
  }
}
