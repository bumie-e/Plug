import 'package:flutter/material.dart';
import 'package:plug/model/product.dart';
import 'package:plug/screens/view_product_screen.dart';
import 'package:plug/utilities/constants.dart';

class VendorProductCard extends StatelessWidget {
  final Product product;
  final String? currentId;

  const VendorProductCard({Key? key, this.currentId, required this.product})
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
              currentUserId: currentId,
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

class HomeProductCard extends StatelessWidget {
  final Product product;
  const HomeProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ViewProductPage(product: product);
        }));
      },
      child: Container(
        height: 120,
        margin: const EdgeInsets.fromLTRB(22, 15, 22, 15),
        decoration: kBoxDecoration.copyWith(boxShadow: kBoxShadow),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                product.photoUrl,
                width: 112,
                height: 112,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(fontSize: 24.0),
                  ),
                  Text(
                    product.description,
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text.rich(
                    TextSpan(
                      text: 'N',
                      style: const TextStyle(
                        color: kPrimaryColor2,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                            text: product.price,
                            style: const TextStyle(
                              color: kPrimaryColor1,
                              fontWeight: FontWeight.bold,
                            ))
                      ],
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
