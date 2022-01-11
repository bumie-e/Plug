import 'package:flutter/material.dart';
import 'package:plug/forms/registration_form.dart';

class RegistrationPage extends StatefulWidget {
  static const routeName = '/registration';

  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: RegistrationForm(),
        ),
      )
    );
  }
}
