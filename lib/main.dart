import 'package:cbc_learning_materials/firebase_utils/firebase_auth_methods.dart';
import 'package:cbc_learning_materials/global_consts.dart';
import 'package:cbc_learning_materials/providers/user_provider.dart';
import 'package:cbc_learning_materials/screens/main_dashboard.dart';
import 'package:cbc_learning_materials/screens/onboarding_screen.dart';
import 'package:cbc_learning_materials/widgets/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
      Provider<FirebaseAuthMethods>(create: (_) => FirebaseAuthMethods()),
      StreamProvider(
        create: (context) =>
            context.read<FirebaseAuthMethods>().authStateChanges,
        initialData: null,
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.wait([
      precachePicture(
        ExactAssetPicture(SvgPicture.svgStringDecoderBuilder,
            'assets/svg/page_view_image1.svg'),
        null,
      ),
      precachePicture(
        ExactAssetPicture(SvgPicture.svgStringDecoderBuilder,
            'assets/svg/page_view_image2.svg'),
        null,
      ),
      precachePicture(
        ExactAssetPicture(SvgPicture.svgStringDecoderBuilder,
            'assets/svg/page_view_image3.svg'),
        null,
      ),
      precachePicture(
        ExactAssetPicture(SvgPicture.svgStringDecoderBuilder,
            'assets/svg/page_view_image4.svg'),
        null,
      ),
    ]);
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: appName,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const OnboardingScreen());
  }
}
