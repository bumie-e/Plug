import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plug/utilities/constants.dart';
import 'package:plug/components/reusable_button.dart';

class BuyerSignUpPage extends StatelessWidget {

  static const id = '/buyer_signup';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: Icon(Icons.home),
      // ),
      body: Padding(
        padding: kPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 45,
            ),
            Text(
              'Sign up to continue!',
              style: kSubHeading,
            ),
            SizedBox(
              height: 42,
            ),
            Center(
              child: Image.asset(
                'assets/images/second.png',
                height: 250,
                width: 250,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 62,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(kPrimaryColor1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/google.png',
                            height: 40, width: 30),
                        Text(
                          '      Sign up with Google',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {},
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  decoration: BoxDecoration(),
                  height: 62,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        shadowColor: MaterialStateProperty.all(kPrimaryColor1),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white)),
                    onPressed: () {},
                    child: RichText(
                      text: TextSpan(
                        text: 'Already a member?',
                        style: TextStyle(
                          color: Color(0xff092C4C),
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                        children: [
                          TextSpan(text: ' Sign In', style: kTextSytle3),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 37,
                ),
                Text(
                  'By signing up,you agree to Plug’s',
                  style: kTextSytle2,
                  textAlign: TextAlign.center,
                ),
                Text(
                  'terms and conditions',
                  style: kTextSytle3,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 37,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
