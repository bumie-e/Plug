import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plug/model/vendor.dart';
import 'package:plug/screens/welcome_screen.dart';
import 'package:plug/utilities/alert_mixins.dart';
import 'package:plug/utilities/constants.dart';

class VendorPage extends StatefulWidget {
  static const routeName = '/vendor-page';
  final String id;

  const VendorPage({Key? key, required this.id}) : super(key: key);

  @override
  _VendorPageState createState() => _VendorPageState();
}

class _VendorPageState extends State<VendorPage> with AlertMixins{
  Vendor? _vendor;

  @override
  void initState() {
    Future<void>.delayed(Duration.zero, () {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: kPrimaryColor1,
          content: Text(
            "Signed in",
            style: TextStyle(fontFamily: 'Inter'),
          ),
        ),
      );
    });
    getVendor();
    super.initState();
  }

  void getVendor() async {
    final doc =
        await FirebaseFirestore.instance.doc('vendors/${widget.id}').get();
    setState(() {
      _vendor = Vendor.fromDocument(doc);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _vendor == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Welcome ${_vendor!.businessName}'),
                loadImage(),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    child: const Text('Sign out'),
                    onPressed: () => signOut(context),
                  ),
                )
              ],
            ),
    );
  }

  Widget loadImage() {
    String url = _vendor!.logoUrl;
    if (url.isEmpty) {
      return const Text('No business logo');
    } else {
      return Image.network(
        url,
        width: 300,
        height: 300,
        loadingBuilder: (BuildContext context, Widget child,
        ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) return child;
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );
    }
  }

  void signOut(BuildContext context) async {
    showLoadingAlert(context, text: 'Signing out');
    await FirebaseAuth.instance.signOut();
    dismissLoader(context);
    Navigator.pushReplacementNamed(context, WelcomePage.routeName);
  }
}
