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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 45,
            ),
            Text(
              'Continue with',
              style: kSubHeading,
            ),
            SizedBox(
              height: 42,
            ),
            SizedBox(
              height: 62,
              child: ElevatedButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/google.png',
                        height: 40, width: 30),
                    Text(
                      '    Sign in with Google',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: Divider(
                    color: kPrimaryColor1,
                    endIndent: 10,
                  ),
                ),
                Text('or'),
                Expanded(
                  child: Divider(
                    color: kPrimaryColor1,
                    indent: 10,
                  ),
                ),
              ],
            ),
            SignInForm(),
          ],
        ),
      ),
    );
  }
}
