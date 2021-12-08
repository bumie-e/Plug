import 'package:flutter/material.dart';
import 'package:plug/components/custom_textfields.dart';
import 'package:plug/utilities/image_picker.dart';
import 'package:plug/utilities/constants.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({Key? key}) : super(key: key);

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();

  Image? _businessLogo;
  String _businessName = '';
  String _businessEmail = '';
  String _password = '';
  String _number = '';
  String _address = '';
  String _openingHours = '';
  String _closingHours = '';
  String _desc = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              pickImage();
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                  height: 150,
                  width: 150,
                  decoration: kBoxDecoration.copyWith(color: kPrimaryColor1),
                  child: _businessLogo ??
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                          ),
                          Text(
                            'Business Logo',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )),
            ),
          ),
          PrimaryTextField(
            labelText: 'Business name',
            onChanged: (value) => _businessName = value,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: PrimaryTextField(
              labelText: 'Business email',
              onChanged: (value) => _businessEmail = value,
              keyboardType: TextInputType.emailAddress,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: PasswordTextField(onChanged: (value) => _password = value),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: PrimaryTextField(
              labelText: 'WhatsApp number',
              onChanged: (value) => _number = value,
              keyboardType: TextInputType.number,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: PrimaryTextField(
              labelText: 'Address',
              onChanged: (value) => _address = value,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: TimePickerTextField(
                text: 'Opening hours',
                onTimePicked: (value) {
                  _openingHours = value.toString();
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: TimePickerTextField(
                text: 'Closing hours',
                onTimePicked: (value) {
                  _closingHours = value.toString();
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: MultiLineTextField(
                labelText: 'Bussiness Description',
                onChanged: (value) => _desc = value),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                print(_openingHours);
              }
            },
            child: const Text('REGISTER'),
          ),
        ],
      ),
    );
  }

  void pickImage() async {
    var image = await LocalImage(ImageSourceType.gallery).pickImage();
    setState(() {
      if (image != null) {
        _businessLogo = image;
      }
    });
  }
}
