import 'package:flutter/material.dart';
import 'package:plug/model/product.dart';
import 'package:plug/screens/view_product_screen.dart';
import 'package:plug/utilities/constants.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final bool showForUser;

  const ProductCard({
    Key? key,
    required this.product,
    required this.showForUser
  })
      : super(key: key);

  Widget loadProductImage(String url) {
    return Image.network(
      url,
      width: 112,
      height: 112,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ViewProductPage(
              product: product,
              showForUser: showForUser,
            );
          }));
        },
        child: Card(
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                loadProductImage(product.photoUrl),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  product.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  product.description,
                  style: const TextStyle(
                      fontSize: 11, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
                Text.rich(
                  TextSpan(
                    text: 'N',
                    // ignore: prefer_const_constructors
                    style: TextStyle(
                      color: kPrimaryColor2,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      // decorationStyle: TextDecoration.lineThrough,
                    ),
                    children: [
                      TextSpan(
                          text: product.price,
                          style: const TextStyle(
                            color: kPrimaryColor1,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
