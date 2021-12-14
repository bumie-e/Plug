import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plug/components/custom_textfields.dart';
import 'package:plug/utilities/alert_mixins.dart';
import 'package:plug/screens/vendor_screen.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> with AlertMixins {
  final _formKey = GlobalKey<FormState>();
  String _password = '';
  String _email = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          PrimaryTextField(
            labelText: 'Email address',
            onSaved: (value) => _email = value,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: PasswordTextField(onSaved: (value) => _password = value),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              final form = _formKey.currentState!;
              if (form.validate()) {
                _formKey.currentState!.save();
                signInVendor(context);
              }
            },
            child: const Text('Sign in'),
          ),
        ],
      ),
    );
  }

  void signInVendor(BuildContext context) {
    showLoadingAlert(context, text: 'Signing in');

    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: _email, password: _password)
        .then((value) {
      onSignInSuccess(context, value.user);
    }).catchError((e) {
      onSignInFailure(context);
    });
  }

  void onSignInSuccess(BuildContext context, User? user) {
    if (user != null) {
      dismissLoader(context);

      // Pops all and pushes the VendorPage
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) {
          return VendorPage(
            id: user.uid,
          );
        }),
        (route) => false,
      );
    }
  }

  void onSignInFailure(BuildContext context) {
    dismissLoader(context);
    showErrorAlert(context,
        errorTitle: 'Sign in failed',
        errorMessage: 'Invalid email/password combination');
  }
}
