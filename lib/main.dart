import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:plug/screens/home_screen.dart';
import 'package:plug/screens/registration_screen.dart';
import 'package:plug/screens/sign_in_screen.dart';
import 'package:plug/screens/welcome_screen.dart';
import 'package:plug/utilities/constants.dart';
<<<<<<< HEAD
import 'package:plug/screens/vendorsigninscreen.dart';
import 'package:plug/screens/vendorsregisterscreen.dart';
import 'package:plug/screens/reset_password.dart';
import 'package:plug/screens/new_Password.dart';
import './screens/verify-email.dart';
=======
>>>>>>> 26c9ddd37d7ba9b3a202e8129813067895e53698

void main() {
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
        fontFamily: 'Inter',
        textTheme: const TextTheme(
          bodyText2: TextStyle(
            color: kPrimaryColor1,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      initialRoute: WelcomePage.routeName,
      routes: {
<<<<<<< HEAD
        WelcomePage.id: (context) => WelcomePage(),
        HomePage.id: (context) => HomePage(),
        BuyerSignInPage.id: (context) => BuyerSignInPage(),
        BuyerSignUpPage.id: (context) => BuyerSignUpPage(),
        VendorSignInScreen.routeName : (context) => VendorSignInScreen(),
        VendorRegisterScreen.routeName : (context) => VendorRegisterScreen(),
        ForgotPassword.id : (context) => ForgotPassword(),
        NewPassWord.id : (context) => NewPassWord(),
        VerifyEmail.id: (context) => VerifyEmail()

=======
        WelcomePage.routeName: (context) => WelcomePage(),
        HomePage.routeName: (context) => HomePage(),
        SignInPage.routeName: (context) => SignInPage(),
        RegistrationPage.routeName: (context) => RegistrationPage(),
>>>>>>> 26c9ddd37d7ba9b3a202e8129813067895e53698
      },
    );
  }
}
