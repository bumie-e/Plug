import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:plug/components/reusable_button.dart';
import 'package:plug/delegates/view_product_appbar_delegate.dart';
import 'package:plug/model/product.dart';
import 'package:plug/utilities/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewProductPage extends StatelessWidget {
  final String? currentUserId;
  final Product product;

  const ViewProductPage({Key? key, this.currentUserId, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    openWhatsApp() async {
      var whatsapp = ""; //vendor whatsApp number
      var whatsappURlAndroid =
          "whatsapp://send?phone=" + whatsapp + "&text=Hello";

      if (await canLaunch(whatsappURlAndroid)) {
        await launch(whatsappURlAndroid);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("WhatsApp not installed")));
      }
    }

    launchDialler() async {
      const url = "tel: 09060930475";
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: ViewProductAppBarDelegate(
                context: context,
                id: currentUserId,
                imageUrl: product.photoUrl),
            pinned: false,
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(26, 132, 26, 0),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(fontSize: 36),
                  ),
                  Text.rich(
                    TextSpan(
                      text: 'N',
                      style: const TextStyle(
                        color: kPrimaryColor2,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                            text: product.price,
                            style: const TextStyle(
                              color: kPrimaryColor1,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ))
                      ],
                    ),
                    textAlign: TextAlign.right,
                  ),
                  Text(product.description),
                  const SizedBox(
                    height: 100,
                  ),
                  currentUserId != null
                      ? ReusableButton(
                          title: 'Edit',
                          color: MaterialStateProperty.all(kPrimaryColor1),
                          onPressed: () {})
                      : Column(
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
                                    openWhatsApp();
                                  },
                                  icon: const Icon(FontAwesomeIcons.whatsapp),
                                ),
                                const SizedBox(
                                  width: 50,
                                ),
                                IconButton(
                                  onPressed: () {
                                    launch(
                                        'mailto:plugsupport@gmail.com?subject=This is Subject Title&body=This is Body of Email');
                                  },
                                  icon: const Icon(Icons.email),
                                ),
                              ],
                            )
                          ],
                        )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
