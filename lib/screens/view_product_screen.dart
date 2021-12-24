import 'package:flutter/material.dart';
import 'package:plug/components/contact_vendor.dart';
import 'package:plug/components/reusable_button.dart';
import 'package:plug/delegates/view_product_appbar_delegate.dart';
import 'package:plug/model/product.dart';
import 'package:plug/model/vendor.dart';
import 'package:plug/utilities/constants.dart';

class ViewProductPage extends StatelessWidget {
  final Product product;
  final bool showForUser;

  const ViewProductPage({Key? key, required this.showForUser, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: ViewProductAppBarDelegate(
                context: context,
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
                  showForUser
                      ? ContactVendor(product)
                      : ReusableButton(
                      title: 'Edit',
                      color: MaterialStateProperty.all(kPrimaryColor1),
                      onPressed: () {})
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
