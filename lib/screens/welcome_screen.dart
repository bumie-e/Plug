import 'package:flutter/material.dart';
import 'package:plug/screens/buyer_signin.dart';
import 'package:plug/screens/buyer_signup.dart';
import 'package:plug/utilities/constants.dart';
import 'package:plug/components/reusable_button.dart';
import 'vendorsregisterscreen.dart';

class WelcomePage extends StatefulWidget {

  static const id = '/';

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child:
      Padding(
        padding: const EdgeInsets.all(26.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(height: 36),
            Text.rich(
              TextSpan(
                text: 'Welcome to ',
                style: TextStyle(fontSize: 30.0),
                children: kCustomPlugText + kExclamationPoint,
              ),
            ),
            const Text(
              'Become a Vendor',
              textAlign: TextAlign.start,
              style: kSubHeadingTextStyle,
            ),
            const Text(
              'Make purchases easily.',
              textAlign: TextAlign.start,
              style: kSubHeadingTextStyle,
            ),
            SizedBox(height: 20),
            Center(
              child: Image.asset(
                "assets/images/first.png",
                height: 350,
                width: 350,
              ),
            ),
            SizedBox(height: 42),
            Container(
              height: 62,
              child: ReusableButton(
                title: 'Become a Vendor',
                color: MaterialStateProperty.all(
                  kPrimaryColor1,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(VendorRegisterScreen.routeName);
                },
              ),
            ),
            SizedBox(height: 16),
            Container(
              height: 62,
              child: ReusableButton(
                title: 'Make a Purchase',
                color: MaterialStateProperty.all(
                  kPrimaryColor2,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, BuyerSignUpPage.id);
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
                },
                child: const Text('skip'),
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}
