import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:cbc_learning_materials/app_colors.dart';
import 'package:cbc_learning_materials/firebase_utils/firebase_auth_methods.dart';
import 'package:cbc_learning_materials/firebase_utils/firestore_methods.dart';
import 'package:cbc_learning_materials/providers/user_provider.dart';
import 'package:cbc_learning_materials/screens/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MainDashboard extends StatefulWidget {
  const MainDashboard({Key? key}) : super(key: key);

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  TextEditingController _searchTextController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    UserProvider _userProvider = Provider.of<UserProvider>(context);
    _userProvider.refreshUser(FirebaseAuth.instance.currentUser!.uid);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Consumer<UserProvider>(
                builder: (_,notifier,__)
               =>
              Text(
                  notifier.getUser?.email ?? "Welcome No data",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  )),),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.menu,
                    size: 28,
                    color: AppColors.primaryColor,
                  ),
                  InkWell(
                    onTap: () {},
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(FirebaseAuth
                                  .instance.currentUser!.photoURL ==
                              null
                          ? "https://images.unsplash.com/photo-1638913974023-cef988e81629?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80"
                          : FirebaseAuth.instance.currentUser!.photoURL
                              .toString()),
                    ),
                  ),
                ],
              ),
              Text(
                "Find C.B.C Learning Materials",
                style: GoogleFonts.roboto(
                    fontSize: 32,
                    wordSpacing: 1.0,
                    letterSpacing: 1.0,
                    height: 1.1,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              AnimSearchBar(
                helpText: "Search",
                textController: _searchTextController,
                onSuffixTap: () {
                  setState(() {
                    _searchTextController.clear();
                  });
                },
                width: 400,
              ),
              ElevatedButton(
                  onPressed: () async {
                    await FirebaseAuthMethods().signOut();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignInScreen(),
                        ),
                        (route) => false);
                  },
                  child: const Text("Logout")),
            ],
          ),
        ),
      ),
    );
  }
}
