import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:plug/components/custom_textfields.dart';
import 'package:plug/components/local_image_preview.dart';
import 'package:plug/utilities/alert_mixins.dart';
import 'package:plug/screens/vendor_screen.dart';
import 'package:plug/utilities/constants.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({Key? key}) : super(key: key);

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> with AlertMixins {
  final _formKey = GlobalKey<FormState>();
  File? _businessLogo;
  String _businessName = '';
  String _businessEmail = '';
  String _password = '';
  String _whatsappNumber = '';
  String _address = '';
  String _openingHours = '';
  String _closingHours = '';
  String _desc = '';
  String? _category;
  bool changeCategoryColor = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          LocalImagePreview(
            label: 'Business logo',
            onImageUpload: (file) {
              _businessLogo = file;
            },
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 12.0,
            ),
            child: PrimaryTextField(
              labelText: 'Business name',
              onSaved: (value) => _businessName = value,
            ),
          ),
          const SizedBox(
            height: 27,
          ),
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
              border: Border.all(
                color: changeCategoryColor ? Colors.red : Colors.grey,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: DropdownButton(
              hint: Text(
                'Select Category',
                style: TextStyle(
                  color: changeCategoryColor ? Colors.red : null,
                ),
              ),
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 36,
              focusColor: kPrimaryColor1,
              isExpanded: true,
              underline: const SizedBox(),
              value: _category,
              onChanged: (value) {
                FocusScope.of(context).requestFocus(FocusNode());
                setState(() {
                  _category = value as String?;
                });
              },
              items: kCategories
                  .map((valueItem) => DropdownMenuItem(
                        value: valueItem,
                        child: Text(valueItem),
                      ))
                  .toList(),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: PrimaryTextField(
              labelText: 'Business email',
              onSaved: (value) => _businessEmail = value,
              keyboardType: TextInputType.emailAddress,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: PasswordTextField(onSaved: (value) => _password = value),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: PrimaryTextField(
              labelText: 'WhatsApp number',
              onSaved: (value) => _whatsappNumber = value,
              keyboardType: TextInputType.number,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: PrimaryTextField(
              labelText: 'Address',
              onSaved: (value) => _address = value,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: TimePickerTextField(
                text: 'Opening hours',
                onTimePicked: (value) {
                  _openingHours = value.toString();
                }),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: TimePickerTextField(
                text: 'Closing hours',
                onTimePicked: (value) {
                  _closingHours = value.toString();
                }),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: MultiLineTextField(
              labelText: 'Business Description',
              onSaved: (value) => _desc = value,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(
            onPressed: () async {
              final form = _formKey.currentState!;
              setState(() => changeCategoryColor = true);

              if (form.validate()) {
                form.save();
                createAccount(context);
              }
            },
            child: const Text('Register'),
          ),
        ],
      ),
    );
  }

  void createAccount(BuildContext context) async {
    showLoadingAlert(context, text: 'Creating account');
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _businessEmail, password: _password);
      onRegistrationSuccess(context, userCredential.user);
    } on FirebaseAuthException catch (e) {
      dismissLoader(context);
      if (e.code == 'email-already-in-use') {
        showRegistrationErrorAlert(context, 'Email already exists');
      }
    } catch (e) {
      dismissLoader(context);
      showRegistrationErrorAlert(
          context, 'Registration failed. Please check and try again');
    }
  }

  void onRegistrationSuccess(BuildContext context, User? vendor) async {
    if (vendor != null) {
      String id = vendor.uid;
      String logoUrl = '';
      if (_businessLogo != null) {
        logoUrl = await uploadLogo(id);
      }
      addVendorDetails(context, id, logoUrl);
    }
  }

  void showRegistrationErrorAlert(BuildContext context, String errorMessage) {
    showErrorAlert(context,
        errorTitle: 'Error occurred', errorMessage: errorMessage);
  }

  void addVendorDetails(BuildContext context, String id, String logoUrl) {
    DocumentReference vendors = FirebaseFirestore.instance.doc('vendors/$id');
    vendors.set({
      'id': id,
      'logoUrl': logoUrl,
      'businessName': _businessName,
      'businessEmail': _businessEmail,
      'whatsappNumber': _whatsappNumber,
      'address': _address,
      'openingHours': _openingHours,
      'closingHours': _closingHours,
      'description': _desc
    }).then((value) {
      dismissLoader(context);
      // Pops all and pushes the VendorPage
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) {
          return VendorPage(
            id: id,
          );
        }),
        (route) => false,
      );
    }).catchError((error) {
      dismissLoader(context);
      showRegistrationErrorAlert(context, 'Try again');
    });
  }

  Future<String> uploadLogo(String id) async {
    final Reference ref = FirebaseStorage.instance.ref('logo/$id.jpg');
    String url = await (await ref.putFile(_businessLogo!)).ref.getDownloadURL();
    return url;
  }
}
