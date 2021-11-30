import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plug/screens/buyer_SignIn_Page.dart';
import 'package:plug/screens/buyer_signUp.dart';
import 'package:plug/screens/welcome_screen.dart';

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
        primarySwatch: Colors.blue,
      ),
      home: const BuyerSignInPage(
          // title: 'Plug',
          ),
    );
  }
}
