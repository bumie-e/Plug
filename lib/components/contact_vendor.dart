import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:plug/model/product.dart';
import 'package:plug/model/vendor.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactVendor extends StatefulWidget {
  final Product product;

  const ContactVendor(this.product, {Key? key}) : super(key: key);

  @override
  _ContactVendorState createState() => _ContactVendorState();
}

class _ContactVendorState extends State<ContactVendor> {

  late Product product;
  late Vendor vendor;

  String getMessage() {
    return 'From Plug, Hello ${vendor.businessName}'
        '\nI want to get ${product.name} priced at ${product.price} naira\n';
  }

  openWhatsApp(BuildContext context) async {

    var whatsappNumberFormat = '234${int.parse(vendor.whatsappNumber)}'; //vendor whatsApp number
    var whatsappURlAndroid = "whatsapp://send?phone="
        + whatsappNumberFormat + "&text=${getMessage()}";

    if (await canLaunch(whatsappURlAndroid)) {
      await launch(whatsappURlAndroid);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("WhatsApp not installed")));
    }
  }

  launchDialler() async {
    final url = "tel: ${vendor.whatsappNumber}";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  openMail() {
    launch(
        'mailto:${vendor.businessEmail}'
        '?subject=Product Purchase&body=${getMessage()}');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Order via'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                launchDialler();
              },
              icon: const Icon(Icons.call),
            ),
            const SizedBox(
              width: 50,
            ),
            IconButton(
              onPressed: () {
                openWhatsApp(context);
              },
              icon: const Icon(FontAwesomeIcons.whatsapp),
            ),
            const SizedBox(
              width: 50,
            ),
            IconButton(
              onPressed: () {
                openMail();
              },
              icon: const Icon(Icons.email),
            ),
          ],
        )
      ],
    );
  }

  @override
  void initState() {
    product = widget.product;
    getVendor();
    super.initState();
  }

  void getVendor() async {
    final doc = await FirebaseFirestore.instance
        .doc('vendors/${product.id}').get();
    vendor = Vendor.fromDocument(doc);
  }
}
