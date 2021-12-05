import 'package:flutter/material.dart';

import '../components/reusable.dart';
import 'verify-email.dart';

class ForgotPassword extends StatelessWidget {

  static const id = '/forgot-password';
  final _form = GlobalKey<FormState>();

  String _businessName = '';


  
  void _saveForm(BuildContext context){
    if(_form.currentState!.validate()){
      _form.currentState!.save();
      Navigator.of(context).pushNamed(VerifyEmail.id, arguments: _businessName);
    }
  }

  void save(value){
    _businessName = value;
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Reusable.appBar(context),
      body: SingleChildScrollView(
              child: Column(
              children: <Widget>[

          Reusable.screenHeader('Forgot Password'),

          const SizedBox(height: 34),

        Container(
          alignment: Alignment.center,
          height: 220,
          width: 220,
          decoration: const BoxDecoration(color: Color(0xFFFDEDBD),shape: BoxShape.circle),
          child: Container(width: 90,height: 90,child: Image.asset('assets/images/password.png',fit: BoxFit.contain,),),
        ),

        const SizedBox(height:39),

        Container(
          alignment: Alignment.center,
          child: Text('''
          Please enter your business email
            to receive a verification code
          ''', style: Reusable.bottomPageWidgetStyle(const Color(0xFF092C4C), 'Inter',FontWeight.w500, 17),)
        ),

        const SizedBox(height: 36),

        Container(
          padding: const EdgeInsets.only(left: 16, right:16),
          alignment: Alignment.bottomLeft,
          child: Reusable.displayTextPlusSizedBox('Business email')),

        Padding(
          padding: const EdgeInsets.only(left: 16, right:16),
          child: Reusable.container(
            Form(
              key: _form,
              child: TextFormField(
              style: Reusable.bottomPageWidgetStyle(Color(0xFF092C4C), 'Nunito', FontWeight.w400, 17),
              decoration: const InputDecoration(border: InputBorder.none),
              keyboardType: TextInputType.name,
              validator: (value)=> Reusable.emailValidationCheck(value!),
              onSaved: (value)=> save(value!),
          ),
            ),
          ),
        ),

        const SizedBox(height:40),

        Reusable.elevatedButton('Send', (){_saveForm(context);},padding: const EdgeInsets.only(left: 26, right:26),),

        const SizedBox(height:10)

        ],),
      ),
    );
  }
}