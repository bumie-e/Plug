import 'package:flutter/material.dart';
import 'package:plug/components/custom_textfields.dart';
import 'package:plug/forms/product_form.dart';
import 'package:plug/utilities/constants.dart';
import 'package:plug/components/reusable_button.dart';
import 'package:plug/utilities/image_picker.dart';

class ProductDetailsPage extends StatefulWidget {
  static const routeName = '/productDetails';
  final String id;

  const ProductDetailsPage({Key? key, required this.id}) : super(key: key);

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState(id);
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  final String id;

  _ProductDetailsPageState(this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Add Product Details',
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ProductForm(vendorId: id,),
          ),
        ));
  }
}
