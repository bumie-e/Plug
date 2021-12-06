import 'package:flutter/material.dart';
import 'package:plug/components/custom_textfields.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({Key? key}) : super(key: key);

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {

  final _formKey = GlobalKey<FormState>();

  String _businessName = '';
  String _businessEmail='';
  String _password='';
  String _number='';
  String _address='';
  String _openingHours = '';
  String _closingHours = '';
  String _desc='';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          PrimaryTextField(
            labelText: 'Business name',
            onChanged: (value) => _businessName = value,
          ),
          SizedBox(height: 12,),

          PrimaryTextField(
            labelText: 'Business email',
            onChanged: (value) => _businessEmail = value,
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 12,),

          PasswordTextField(onChanged: (value) => _password = value),
          SizedBox(height: 12,),

          PrimaryTextField(
            labelText: 'WhatsApp number',
            onChanged: (value) => _number = value,
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 12,),

          PrimaryTextField(
            labelText: 'Address',
            onChanged: (value) => _address = value,
          ),
          SizedBox(height: 12,),

          TimePickerTextField(text: 'Opening hours', onTimePicked: (value) {
            _openingHours = value.toString();
          }),
          SizedBox(height: 12,),

          TimePickerTextField(text: 'Closing hours', onTimePicked: (value) {
            _closingHours = value.toString();
          }),
          SizedBox(height: 12,),

          MultiLineTextField(onChanged: (value) => _desc = value),

          ElevatedButton(
            onPressed: () {
              print('$_businessName $_businessEmail $_password $_number'
                  '$_address $_openingHours $_closingHours $_desc');
              /*if (_formKey.currentState!.validate()) {
                print(_openingHours);
              }*/
            },
            child: const Text('REGISTER'),
          ),
        ],
      ),
    );
  }
}
