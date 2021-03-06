import 'package:cbc_learning_materials/app_colors.dart';
import 'package:cbc_learning_materials/firebase_utils/firebase_auth_methods.dart';
import 'package:cbc_learning_materials/providers/user_provider.dart';
import 'package:cbc_learning_materials/screens/sign_in_screen.dart';
import 'package:cbc_learning_materials/utils.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_buttons/flutter_awesome_buttons.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:provider/provider.dart';

import 'main_dashboard.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordvalid = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _emailController.dispose();
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
                'SIGN UP',
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: TextFormField(
                      validator: ((value) {
                        if (value!.isEmpty) {
                          return "This Field should not be empty";
                        } else if (!RegExp(r'^[a-z A-Z,.\-]+$')
                            .hasMatch(value)) {
                          return "Enter name in the correct format";
                        } else {
                          return null;
                        }
                      }),
                      controller: _firstNameController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.all(4),
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                        labelText: "First Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Flexible(
                    child: TextFormField(
                      validator: ((value) {
                        if (value!.isEmpty) {
                          return "This Field should not be empty";
                        } else if (!RegExp(r'^[a-z A-Z,.\-]+$')
                            .hasMatch(value)) {
                          return "Enter name in the correct format";
                        } else {
                          return null;
                        }
                      }),
                      controller: _lastNameController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.all(4),
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                        labelText: "Last Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
                height: 8,
              ),
              TextFormField(
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return " Please enter password";
                  } else if (!_isPasswordvalid) {
                    return "Please enter a valid password";
                  } else {
                    return null;
                  }
                },
                controller: _passwordController,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.all(4),
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
                height: 4,
              ),
              FlutterPwValidator(
                  controller: _passwordController,
                  minLength: 6,
                  width: 300,
                  height: 24,
                  onSuccess: () {
                    setState(() {
                      _isPasswordvalid = true;
                    });
                  },
                  onFail: () {
                    setState(() {
                      _isPasswordvalid = false;
                    });
                  }),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please Confirm Password";
                  } else if (_passwordController.text !=
                      _confirmPasswordController.text) {
                    return " Passwords do not match";
                  } else {
                    return null;
                  }
                },
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.all(4),
                  prefixIcon: const Icon(
                    Icons.password,
                    color: Colors.black,
                  ),
                  labelText: "Confirm Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              ProgressButton.icon(
                height: 32.0,
                iconedButtons: {
                  ButtonState.idle: const IconedButton(
                      text: "Sign Up",
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
                    await FirebaseAuthMethods().signUp(
                        _emailController.text,
                        _confirmPasswordController.text,
                        _firstNameController.text,
                        _lastNameController.text,
                        context);
                    setState(() {
                      _isLoading = false;
                    });
                  }
                },
              ),
              const SizedBox(
                height: 12,
              ),
              InkWell(
                onTap: () async {
                  UserCredential userCredential =
                      await FirebaseAuthMethods().signInWithGoogle();
                  if (userCredential.user != null) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MainDashboard(),
                        ),
                        (route) => false);
                  }
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        alignment: WrapAlignment.center,
                        children: [
                          Image.asset(
                            "assets/svg/google_icon.png",
                            width: 24,
                            height: 24,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          const Text(
                            "Continue with Google",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          )
                        ]),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  UserCredential? userCredential =
                      await FirebaseAuthMethods().signInWithFacebook(context);
                  if (userCredential?.user != null) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MainDashboard(),
                        ),
                        (route) => false);
                  }
                },
                child: Card(
                  color: const Color(0xFF1777f2),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        alignment: WrapAlignment.center,
                        children: [
                          Image.asset(
                            "assets/svg/facebook_logo.png",
                            width: 24,
                            height: 24,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          const Text(
                            "Continue with Facebook",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )
                        ]),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(color: Colors.black),
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignInScreen()),
                          );
                        },
                        child: const Text(
                          " Sign in",
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
