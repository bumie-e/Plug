import 'package:flutter/material.dart';

import '../components/reusable.dart';

class NewPassWord extends StatefulWidget {
  static const id ='/new-password';
  @override
  State<NewPassWord> createState() => _NewPassWordState();
}

class _NewPassWordState extends State<NewPassWord> {
  final _form = GlobalKey<FormState>();

  bool _passwordVisible = false;
  String _password = '';

  void saveForm(){
    if(_form.currentState!.validate()){
      _form.currentState!.save();
      print(_password);
    }
  }

  void save(value){
    _password = value;
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
              decoration: const BoxDecoration(color: Color(0xFFFDEDBD), shape: BoxShape.circle),
              child: Container(
                width: 90,
                height: 90,
                child: Image.asset(
                  'assets/images/verified.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            
            const SizedBox(height: 39),
            
            Container(
                alignment: Alignment.center,
                child: Text(
                  '''
          Your new password must be different 
            from previously used password
          ''',
                  style: Reusable.bottomPageWidgetStyle(const Color(0xFF092C4C), 'Inter', FontWeight.w500, 17),
                )),
            
            const SizedBox(height: 36),
            
            Container(
                padding: const EdgeInsets.only(left: 16, right: 16),
                alignment: Alignment.bottomLeft,
                child: Reusable.displayTextPlusSizedBox('New Password')),
            
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Reusable.container(
                Row(
                  children: [
                    Expanded(
                        child: Form(
                          key: _form,
                            child: TextFormField(
                            obscureText: !_passwordVisible,
                            style: Reusable.bottomPageWidgetStyle(Color(0xFF092C4C), 'Nunito', FontWeight.w400, 17),
                            decoration: InputDecoration(border: InputBorder.none),
                            validator: (value) =>Reusable.passwordValidationCheck(value!),
                            onSaved: (value) => save(value!),
                    ),
                        ),
                    ),
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
            ),
            const SizedBox(height: 40),
            Reusable.elevatedButton(
              'Save',
              saveForm,
              padding: const EdgeInsets.only(left: 26, right: 26),
            ),
            const SizedBox(height: 25),

            TextButton(onPressed: (){}, child:Text('Forgot Password', style: Reusable.bottomPageWidgetStyle(Color(0xFFE2B93B), 'Inter', FontWeight.w500, 18),)),

            const SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}
