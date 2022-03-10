import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:cbc_learning_materials/app_colors.dart';
import 'package:cbc_learning_materials/firebase_utils/firebase_auth_methods.dart';
import 'package:cbc_learning_materials/firebase_utils/firestore_methods.dart';
import 'package:cbc_learning_materials/models/app_user.dart';
import 'package:cbc_learning_materials/providers/user_provider.dart';
import 'package:cbc_learning_materials/screens/add_learning_material-screen.dart';
import 'package:cbc_learning_materials/screens/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    final User user = context.watch<User>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 4.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    FontAwesomeIcons.award,
                    size: 28,
                    color: AppColors.primaryColor,
                  ),
                  StreamBuilder<AppUser>(
                      stream: Firestoremethods().getUser(user.uid),
                      builder: (context, AsyncSnapshot<AppUser?> snapshot) {
                        if (snapshot.hasError) {
                          return Text(
                            snapshot.error.toString(),
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w200,
                                color: Colors.black),
                          );
                        } else {
                          return Text(
                            "Welcome ${snapshot.data?.firstName} ${snapshot.data?.lastName}",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          );
                        }
                      }),
                  InkWell(
                    onTap: () {},
                    child: CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.white,
                      child: user.photoURL == null
                          ? SvgPicture.asset("assets/svg/defaultpic.svg")
                          : Image(image: NetworkImage(user.photoURL ?? "")),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Find your learning",
                  style: GoogleFonts.poppins(
                      fontSize: 29,
                      wordSpacing: 1.0,
                      letterSpacing: 1.0,
                      height: 1.1,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primaryColor),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Materials here!",
                  style: GoogleFonts.poppins(
                      fontSize: 29,
                      wordSpacing: 1.0,
                      letterSpacing: 1.0,
                      height: 1.1,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              StreamBuilder<AppUser>(
                  stream: Firestoremethods().getUser(user.uid),
                  builder: (context, AsyncSnapshot<AppUser> snapshot) {
                    if (snapshot.hasData) {
                      if (!snapshot.data!.isAdmin) {
                        return TextFormField(
                          decoration: InputDecoration(
                            labelStyle:
                                const TextStyle(color: AppColors.primaryColor),
                            labelText: "Search here",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            prefixIcon: const Icon(
                              FontAwesomeIcons.search,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        );
                      } else {
                        return Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelStyle: const TextStyle(
                                      color: AppColors.primaryColor),
                                  labelText: "Search here",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  prefixIcon: const Icon(
                                    FontAwesomeIcons.search,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) =>
                                              const AddLearningMaterial())));
                                },
                                icon: const Icon(Icons.settings))
                          ],
                        );
                      }
                    } else {
                      return TextFormField(
                        decoration: InputDecoration(
                          labelStyle:
                              const TextStyle(color: AppColors.primaryColor),
                          labelText: "Search here",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          prefixIcon: const Icon(
                            FontAwesomeIcons.search,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      );
                    }
                  }),
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
