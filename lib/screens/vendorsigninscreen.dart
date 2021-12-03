import 'package:flutter/material.dart';

import '../components/reusable.dart';

class VendorSignInScreen extends StatefulWidget {
  @override
  _VendorSignInScreenState createState() => _VendorSignInScreenState();
  static const routeName = '/VendorSignIn';
}

class _VendorSignInScreenState extends State<VendorSignInScreen> {
  final _formFieldStyle = Reusable.bottomPageWidgetStyle(
      Color(0xFF092C4C), 'Nunito', FontWeight.w400, 17);
  final _form = GlobalKey<FormState>();

  bool _passwordVisible = false;

  String _password = '';
  String _email = '';

  void saveForm() {
    if (_form.currentState!.validate()) {
      _form.currentState!.save();
      final savedData = {_email, _password};
      print(savedData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Reusable.appBar(context),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.only(left: 19),
              child: Text(
                'Welcome back!',
                style: Reusable.bottomPageWidgetStyle(
                    const Color(0xFF092c4c), 'Inter', FontWeight.w600, 24),
              ),
            ),
            SizedBox(height: 42),
            Container(
              alignment: Alignment.center,
              height: 175,
              width: 214,
              // padding: EdgeInsets.only(left: 76),
              child: Image.asset('assets/images/clip1.png', fit: BoxFit.cover),
            ),
            SizedBox(height: 45),
            Form(
              key: _form,
              child: Padding(
                padding: EdgeInsets.only(left: 19, right: 13),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Business email',
                          style: Reusable.bottomPageWidgetStyle(
                              Color(0xFF092c4c),
                              'Nunito',
                              FontWeight.w400,
                              16)),
                      SizedBox(height: 8),
                      Reusable.container(
                        TextFormField(
                            style: _formFieldStyle,
                            validator: (value) =>
                                Reusable.emailValidationCheck(value!),
                            decoration:
                                InputDecoration(border: InputBorder.none),
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (value) => Reusable.saved(value!, _email)),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Password',
                        style: Reusable.bottomPageWidgetStyle(
                            Color(0xFF092c4c), 'Nunito', FontWeight.w400, 16),
                      ),
                      SizedBox(height: 8),
                      Reusable.container(
                        Row(
                          children: [
                            Expanded(
                                child: TextFormField(
                              obscureText: !_passwordVisible,
                              style: _formFieldStyle,
                              decoration:
                                  InputDecoration(border: InputBorder.none),
                              validator: (value) =>
                                  Reusable.passwordValidationCheck(value!),
                              onSaved: (value) =>
                                  Reusable.saved(value!, _password),
                            )),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                                icon: _passwordVisible
                                    ? const Icon(Icons.visibility)
                                    : const Icon(Icons.visibility_off))
                          ],
                        ),
                      ),
                    ]),
              ),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 26),
              child: Column(
                children: [
                  Reusable.elevatedButton('Sign in as a vendor ', saveForm),
                  SizedBox(height: 30),
                  Reusable.openContainer('Not a Member? ', 'Register', () {}),
                ],
              ),
            ),
            SizedBox(height: 30),
            Container(
              alignment: Alignment.center,
              child: TextButton(
                  onPressed: () {},
                  child: Text('Forgot Password?',
                      style: Reusable.bottomPageWidgetStyle(
                          Color(0xFFE2B93B), 'inter', FontWeight.w500, 18))),
            )
          ]),
        ));
  }
}
