import 'package:flutter/material.dart';
import 'package:plug/screens/home_screen.dart';
import 'package:plug/screens/registration_screen.dart';
import 'package:plug/screens/sign_in_screen.dart';
import 'package:plug/utilities/constants.dart';
import 'package:plug/components/reusable_button.dart';

class WelcomePage extends StatefulWidget {
  static const routeName = '/welcome';

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(26, 26, 26, 0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              Text.rich(
                TextSpan(
                  text: 'Welcome to ',
                  style: kHeadingTextyStyle1,
                  children: kCustomPlugText + kExclamationPoint,
                ),
              ),
              const Text(
                'Right Business, Right Audience',
                style: kSubHeadingTextStyle,
              ),
              const SizedBox(height: 40),
              Image.asset(
                "assets/images/first.png",
                height: 350,
                width: 350,
              ),
              const SizedBox(height: 42),
              ReusableButton(
                title: 'Create Business Account',
                color: MaterialStateProperty.all(
                  kPrimaryColor1,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, RegistrationPage.routeName);
                },
              ),
              const SizedBox(height: 20),
              ReusableButton(
                title: 'View Products',
                color: MaterialStateProperty.all(
                  kPrimaryColor2,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, HomePage.routeName);
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account?',
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, SignInPage.routeName);
                    },
                    child: const Text(
                      'Sign in',
                      style: kTextSytle3,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
