import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plug/forms/sign_in_form.dart';
import 'package:plug/utilities/constants.dart';

class SignInPage extends StatefulWidget {
  static const routeName = '/sign_in';

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              "assets/images/second.png",
              height: 350,
              width: 350,
            ),
            SignInForm(),
          ],
        ),
      ),
    );
  }
}
