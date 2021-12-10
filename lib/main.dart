import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:plug/screens/home_screen.dart';
import 'package:plug/screens/registration_screen.dart';
import 'package:plug/screens/sign_in_screen.dart';
import 'package:plug/screens/welcome_screen.dart';
import 'package:plug/utilities/constants.dart';
import 'package:plug/screens/reset_password.dart';
import 'package:plug/screens/new_Password.dart';
import 'package:plug/screens/product_detail.dart';
import './screens/verify-email.dart';

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
      initialRoute: ProdDetailPage.routeName,
      routes: {
        WelcomePage.routeName: (context) => WelcomePage(),
        HomePage.routeName: (context) => HomePage(),
        SignInPage.routeName: (context) => SignInPage(),
        RegistrationPage.routeName: (context) => RegistrationPage(),
        ForgotPassword.routeName: (context) => ForgotPassword(),
        NewPassWord.id: (context) => NewPassWord(),
        VerifyEmail.id: (context) => VerifyEmail(),
        ProdDetailPage.routeName: (context) => ProdDetailPage(),
      },
    );
  }
}
