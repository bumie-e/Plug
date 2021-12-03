import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import '../components/reusable.dart';
import 'vendorsigninscreen.dart';

class VendorRegisterScreen extends StatefulWidget {
  @override
  _VendorRegisterScreenState createState() => _VendorRegisterScreenState();
  static const routeName = '/vendor-Register-Screen';
}

class _VendorRegisterScreenState extends State<VendorRegisterScreen> {
  final _validationStyle=Reusable.bottomPageWidgetStyle(Color(0xFF092C4C), 'Nunito', FontWeight.w400, 17);
  final _form = GlobalKey<FormState>();
  bool _showOpeningTime = false;
  bool _showClosingTime = false;
  bool _passwordVisible = false;
  bool _amTime = true;
  DateTime _openingDateTime = DateTime.now();
  DateTime _closingDateTime = DateTime.now();
  
   String _businessName='';
   String _email='';
   String _password='';
   String _number='';
   String _address='';
   String _desc='';

  void saveForm(){
    _form.currentState!.validate();
    if(_form.currentState!.validate()){
      _form.currentState!.save();
      final savedData = {_businessName,_email,_password,_number,_address,_desc,_openingDateTime,_closingDateTime}; //A set of the data entered by the user
      print(savedData);
    }return;
  }


  void signIn(){
    Navigator.of(context).pushNamed(VendorSignInScreen.routeName);
  }

  dynamic timeScreen(context) {
    return showDialog(
        context: context,
        builder: (ctx) => SimpleDialog(
              title: Text('Select Time'),
              children: [
                TimePickerSpinner(
                  is24HourMode: true,
                  normalTextStyle: TextStyle(fontSize: 24, color: Colors.grey),
                  highlightedTextStyle:
                      TextStyle(fontSize: 24, color: Color(0xFF092c4c)),
                  spacing: 50,
                  itemHeight: 80,
                  isForce2Digits: true,
                  onTimeChange: (time) {
                    _amTime
                        ? setState(() {
                            _openingDateTime = time;
                            _showOpeningTime = true;
                          })
                        : setState(
                            () {
                              _closingDateTime = time;
                              _showClosingTime = true;
                            },
                          );
                  },
                )
              ],
            ));
  }
 

  @override
  Widget build(BuildContext context) {
    // final leftPadding = MediaQuery.of(context).size.width *(14/32);
    // final rightPadding = MediaQuery.of(context).size.width *(18/32);
    return Scaffold(
      appBar: Reusable.appBar(context),
      body: SingleChildScrollView(
              child: Padding(
          padding: const EdgeInsets.only(left: 14, right: 18),
          
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Form(
                key: _form,
                child: Container(
                  
                  height: (MediaQuery.of(context).size.height -
                      AppBar().preferredSize.height -
                      MediaQuery.of(context).padding.top),
                  
                  child: ListView(children: <Widget>[
                    Text(
                      'Register your business!',
                      style: Reusable.bottomPageWidgetStyle(Color(0xFF092c4c), 'Inter', FontWeight.w600, 24),
                    ),
                    
                    SizedBox(height: 24),
                    
                    
                    Reusable.displayTextPlusSizedBox('Business name'),
                    
                    
                    Reusable.container(
                      TextFormField(
                        style: _validationStyle,
                        decoration: InputDecoration(border: InputBorder.none),
                        keyboardType: TextInputType.name,
                        validator: (value) =>Reusable.businessValidationCheck(value!),
                        onSaved: (value)=> Reusable.saved(value!, _businessName),
                      ),
                    ),
                    
                    SizedBox(height: 20),
                    
                    Reusable.displayTextPlusSizedBox('Business email'),
                    
                    Reusable.container(
                      TextFormField(
                        style: _validationStyle,
                        decoration: InputDecoration(border: InputBorder.none),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) =>
                            Reusable.emailValidationCheck(value!),
                        onSaved: (value) => Reusable.saved(value!, _email),
                      ),
                    ),
                    
                    SizedBox(height: 20),
                    
                    Reusable.displayTextPlusSizedBox('Password'),
                    
                    Reusable.container(
                      Row(
                        children: [
                          Expanded(
                              child: TextFormField(
                                obscureText: !_passwordVisible,
                                style: _validationStyle,
                            decoration: InputDecoration(border: InputBorder.none),
                            validator: (value) =>
                                Reusable.passwordValidationCheck(value!),
                            onSaved: (value) => Reusable.saved(value!, _password),
                          )),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  _passwordVisible= !_passwordVisible;
                                });
                              }, icon: _passwordVisible? Icon(Icons.visibility): Icon(Icons.visibility_off))
                        ],
                      ),
                    ),
                    
                    Reusable.infoText('Password should be at least 6 characters'),
                    
                    SizedBox(height: 20),
                    
                    Reusable.displayTextPlusSizedBox('WhatsApp number'),
                    
                    Reusable.container(
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal:3),
                              child: Text(
                            '+234',
                            style: _validationStyle,
                          )),
                          VerticalDivider(),
                          Expanded(
                            child: TextFormField(
                              style: _validationStyle,
                              decoration:InputDecoration(border: InputBorder.none),
                              keyboardType: TextInputType.number,
                              validator: (value) =>Reusable.whatsAppValidationCheck(value!),
                              onSaved: (value) => Reusable.saved(value!, _number),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20),

                    Reusable.displayTextPlusSizedBox('Address'),
                    
                    
                    Reusable.container(
                      TextFormField(
                        decoration: InputDecoration(border: InputBorder.none),
                        style: _validationStyle,
                        keyboardType: TextInputType.streetAddress,
                        validator: (value) => Reusable.addressValidator(value!),
                        onSaved: (value) => Reusable.saved(value!, _address),
                      ),
                    ),
                    
                    SizedBox(height: 20),
                    
                    Reusable.displayTextPlusSizedBox('Allowed Hours'),
                    
                    Reusable.container(Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: _showOpeningTime
                                ? Text(DateFormat.Hm().format(_openingDateTime),style: _validationStyle,)
                                : Text(''),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              timeScreen(context);
                            },
                            icon: Icon(Icons.expand_more))
                      ],
                    ),
                    ),
                    SizedBox(height: 20),
                    
                    Reusable.displayTextPlusSizedBox('To'),
                    
                    Reusable.container(
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: _showClosingTime
                                  ? Text(DateFormat.Hm().format(_closingDateTime),style: _validationStyle,)
                                  : Text(''),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                timeScreen(context);
                                _amTime = false;
                              },
                              icon: Icon(Icons.expand_more))
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    Reusable.displayTextPlusSizedBox('Business Description'),
                    
                    Reusable.container(
                      TextFormField(
                        style: _validationStyle,
                        decoration: InputDecoration(border: InputBorder.none),
                        maxLines: 3,
                        validator: (value) =>
                            Reusable.descriptionValidator(value!),
                        onSaved: (value)=> Reusable.saved(value!, _desc),
                      ),
                    ),
                    Reusable.infoText('Description should not be more than 500 words'),
                    
                    SizedBox(height: 29),
                    
                    Padding(
                      padding: const EdgeInsets.only(left: 9, right: 9),
                      child: Column(
                        children: [
                          Reusable.elevatedButton('Register  Business', saveForm),
                          SizedBox(height: 25),
                          Reusable.openContainer('Already a Member? ', 'Sign In ', signIn ),
                        ],
                      ),
                    ),
                    SizedBox(height: 25),
                    Container(
                      padding: EdgeInsets.only(left: 43, right: 44),
                      child: Container(
                        width: 288,
                        height: 51,
                        child: FittedBox(
                          child: Row(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('By signing up,you agree to Plug’s',
                                    style: Reusable.bottomPageWidgetStyle(
                                        Color(0xFF092C4C),
                                        'Inter',
                                        FontWeight.w500,
                                        18)),
                                TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'terms and conditions',
                                    style: Reusable.bottomPageWidgetStyle(
                                        Color(0xFFE2B93B),
                                        'Inter',
                                        FontWeight.w500,
                                        16),
                                  ),
                                )
                              ]),
                        ),
                      ),
                    )
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
