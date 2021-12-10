import 'package:flutter/material.dart';
import 'package:plug/components/custom_textfields.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
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
            onChanged: (value) => _email = value,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(
            height: 16,
          ),
          PasswordTextField(onChanged: (value) => _password = value),
          const SizedBox(
            height: 16,
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                print('email = $_email and password = $_password');
              }
            },
            child: const Text('SIGN IN'),
          ),
        ],
      ),
    );
  }
}
