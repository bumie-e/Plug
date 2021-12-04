import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:plug/screens/home_screen.dart';
import 'package:plug/screens/registration_screen.dart';
import 'package:plug/screens/sign_in_screen.dart';
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
        WelcomePage.routeName: (context) => WelcomePage(),
        HomePage.routeName: (context) => HomePage(),
        SignInPage.routeName: (context) => SignInPage(),
        RegistrationPage.routeName: (context) => RegistrationPage(),
      },
    );
  }
}
