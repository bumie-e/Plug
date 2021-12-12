import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:plug/components/custom_textfields.dart';
import 'package:plug/utilities/alert_mixins.dart';
import 'package:plug/screens/vendor_screen.dart';
import 'package:plug/utilities/image_picker.dart';
import 'package:plug/utilities/constants.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({Key? key}) : super(key: key);

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> with AlertMixins{
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
                child: _businessLogo == null ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                    ),
                    Text('Business Logo', style: TextStyle(color: Colors.white,),),
                  ],
                ) : showImage(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0,),
            child: PrimaryTextField(
              labelText: 'Business name',
              onSaved: (value) => _businessName = value,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: PrimaryTextField(
              labelText: 'Business email',
              onSaved: (value) => _businessEmail = value,
              keyboardType: TextInputType.emailAddress,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: PasswordTextField(onSaved: (value) => _password = value),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: PrimaryTextField(
              labelText: 'WhatsApp number',
              onSaved: (value) => _whatsappNumber = value,
              keyboardType: TextInputType.number,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: PrimaryTextField(
              labelText: 'Address',
              onSaved: (value) => _address = value,
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
            child: MultiLineTextField(onSaved: (value) => _desc = value),
          ),
          ElevatedButton(
            onPressed: () async {
              final form = _formKey.currentState!;

              if(form.validate()) {
                form.save();
                createAccount(context);
              }
            },
            child: const Text('REGISTER'),
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
          email: _businessEmail,
          password: _password
      );
      onRegistrationSuccess(context, userCredential.user);
    } on FirebaseAuthException catch (e) {
      dismissLoader(context);
      if (e.code == 'email-already-in-use') {
        showRegistrationErrorAlert(context, 'Email already exists');
      }
    } catch (e) {
      dismissLoader(context);
      showRegistrationErrorAlert(context,
          'Registration failed. Please check and try again'
      );
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
        errorTitle: 'Error occurred',
        errorMessage: errorMessage
    );
  }

  void addVendorDetails(BuildContext context, String id, String logoUrl) {
    DocumentReference vendors = FirebaseFirestore.instance
        .doc('vendors/$id');
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
    })
        .then((value) {
          dismissLoader(context);
          // Pops all and pushes the VendorPage
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) {
              return VendorPage(id: id,);
            }),
            (route) => false,
          );
    })
        .catchError((error) {
          dismissLoader(context);
          showRegistrationErrorAlert(context, 'Try again');
    });
  }

  void pickImage() async {
    var imageFile = await LocalImage(ImageSourceType.gallery).pickImageFile();
    setState(() {
      if(imageFile != null) {
        _businessLogo = imageFile;
      }
    });
  }

  Image showImage() => Image.file(
    _businessLogo!,
    width: 180.0,
    height: 180.0,
  );

  Future<String> uploadLogo(String id) async {
    final Reference ref = FirebaseStorage.instance.ref('logo/$id.jpg');
    String url = await (await ref.putFile(_businessLogo!)).ref.getDownloadURL();
    return url;
  }
}
