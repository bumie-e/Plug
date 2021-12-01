import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plug/screens/buyer_signin.dart';
import 'package:plug/screens/buyer_signup.dart';
import 'package:plug/screens/home_screen.dart';
import 'package:plug/screens/welcome_screen.dart';
import 'package:plug/utilities/constants.dart';

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
        textTheme: const TextTheme(
          bodyText2: TextStyle(
            color: kPrimaryColor1,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      initialRoute: WelcomePage.id,
      routes: {
        WelcomePage.id: (context) => WelcomePage(),
        HomePage.id: (context) => HomePage(),
        BuyerSignInPage.id: (context) => BuyerSignInPage(),
        BuyerSignUpPage.id: (context) => BuyerSignUpPage(),
      },
    );
  }
}
