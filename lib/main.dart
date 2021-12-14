import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:plug/screens/home_screen.dart';
import 'package:plug/screens/product_detail.dart';
import 'package:plug/screens/registration_screen.dart';
import 'package:plug/screens/sign_in_screen.dart';
import 'package:plug/screens/vendor_screen.dart';
import 'package:plug/screens/welcome_screen.dart';
import 'package:plug/utilities/constants.dart';
import 'package:plug/screens/reset_password.dart';
import 'package:plug/screens/new_Password.dart';
import './screens/verify-email.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Plug',
      theme: ThemeData(
        primarySwatch: kPrimaryColorSwatch,
        // fontFamily: 'Inter',
        textTheme: GoogleFonts.quicksandTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: appropriateHome(),
      routes: {
        WelcomePage.routeName: (context) => WelcomePage(),
        HomePage.routeName: (context) => HomePage(),
        SignInPage.routeName: (context) => SignInPage(),
        RegistrationPage.routeName: (context) => RegistrationPage(),
        ForgotPassword.routeName: (context) => ForgotPassword(),
        NewPassWord.id: (context) => NewPassWord(),
        VerifyEmail.id: (context) => VerifyEmail(),
        ProductDetailsPage.routeName: (context) => ProductDetailsPage(),
      },
    );
  }

  Widget appropriateHome() {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return WelcomePage();
    } else {
      return VendorPage(id: currentUser.uid);
    }
  }
}
