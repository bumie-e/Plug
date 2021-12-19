import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:plug/components/custom_textfields.dart';
import 'package:plug/components/local_image_preview.dart';
import 'package:plug/components/reusable_button.dart';
import 'package:plug/utilities/alert_mixins.dart';
import 'package:plug/utilities/constants.dart';

class ProductForm extends StatefulWidget {
  final String vendorId;

  const ProductForm({Key? key, required this.vendorId}) : super(key: key);

  @override
  _ProductFormState createState() => _ProductFormState(vendorId);
}

class _ProductFormState extends State<ProductForm> with AlertMixins {

  final String vendorId;
  final _formKey = GlobalKey<FormState>();
  File? _productImageFile;
  String _productName = '';
  String _price = '';
  String _desc = '';
  String? _category;

  bool changeCategoryColor = false;

  _ProductFormState(this.vendorId);

  void uploadProduct(BuildContext context, String url) async {
    CollectionReference vendorProducts = FirebaseFirestore.instance
        .collection('products');

    vendorProducts.add({
      'id': vendorId,
      'productImageUrl': url,
      'category': _category,
      'productName': _productName,
      'price': _price,
      'description': _desc
    }).then((value) {
      dismissLoader(context);
      Navigator.pop(context);
    }).catchError((error) {
      dismissLoader(context);
      showErrorAlert(
          context,
          errorTitle: 'Upload Failed',
          errorMessage: 'Try again'
      );
    });
  }

  void uploadLogo(BuildContext context) async {
    final Reference ref = FirebaseStorage.instance
        .ref('products/$vendorId/${_productImageFile!.path}.jpg');
    String url = await (await ref.putFile(_productImageFile!)).ref.getDownloadURL();
    uploadProduct(context, url);
  }

  void startUpload(BuildContext context) {
    showLoadingAlert(context, text: 'Uploading');
    uploadLogo(context);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          LocalImagePreview(
            label: 'Product logo',
            onImageUpload: (file) {
              _productImageFile = file;
            },
          ),
          const SizedBox(
            height: 30,
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
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: PrimaryTextField(
              labelText: 'Product name',
              onSaved: (value) => _productName = value,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 30.0,
            ),
            child: PrimaryTextField(
              labelText: 'Price',
              keyboardType: TextInputType.number,
              onSaved: (value) => _price = value,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0, bottom: 20),
            child: MultiLineTextField(
                labelText: 'Product Description',
                onSaved: (value) => _desc = value),
          ),

          ReusableButton(
            title: 'Add Products',
            color: MaterialStateProperty.all(
              kPrimaryColor1,
            ),
            onPressed: () {
              if(_productImageFile == null) {
                setState(() => changeCategoryColor = true);
                showErrorAlert(
                  context,
                  errorTitle: 'Required',
                  errorMessage: 'Upload product image'
                );
              } else if(_category == null) {
                showErrorAlert(
                    context,
                    errorTitle: 'Required',
                    errorMessage: 'Select a category'
                );
              } else {
                final form = _formKey.currentState!;
                if (form.validate()) {
                  form.save();
                  startUpload(context);
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
