import 'package:flutter/material.dart';
import 'package:plug/components/custom_textfields.dart';
import 'package:plug/utilities/constants.dart';
import 'package:plug/components/reusable_button.dart';
import 'package:plug/utilities/image_picker.dart';

class ProdDetailPage extends StatefulWidget {
  static const routeName = '/productDetail';

  const ProdDetailPage({Key? key}) : super(key: key);

  @override
  _ProdDetailPageState createState() => _ProdDetailPageState();
}

class _ProdDetailPageState extends State<ProdDetailPage> {
  final _formKey = GlobalKey<FormState>();
  Image? _productImage;
  String _productName = '';
  String _price = '';
  String _desc = '';
  final category = ['Food', 'Shoes', 'Hostels', 'Others'];

  void pickImage() async {
    var image = await LocalImage(ImageSourceType.gallery).pickImage();
    setState(() {
      if (image != null) {
        _productImage = image;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            // title: Text('Register'),
            ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Add Product Details',
                  style: kSubHeading,
                ),
                PrimaryTextField(
                  labelText: 'Product name',
                  onChanged: (value) => _productName = value,
                ),
                PrimaryTextField(
                  labelText: 'Price',
                  keyboardType: TextInputType.number,
                  onChanged: (value) => _price = value,
                ),
                MultiLineTextField(
                    labelText: 'Product Description',
                    onChanged: (value) => _desc = value),
                Text('Description should not be more than 500 words'),
                ReusableButton(
                  title: 'Add Products',
                  color: MaterialStateProperty.all(
                    kPrimaryColor1,
                  ),
                  onPressed: () {
                    // Navigator.pushNamed(context, HomePage.routeName);
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
