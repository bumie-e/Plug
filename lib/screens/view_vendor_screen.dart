import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plug/components/product_card.dart';
import 'package:plug/delegates/vendor_appbar_delegate.dart';
import 'package:plug/model/product.dart';
import 'package:plug/model/vendor.dart';

class ViewVendorPage extends StatefulWidget {
  final Vendor vendor;
  const ViewVendorPage({Key? key, required this.vendor}) : super(key: key);

  @override
  _ViewVendorPageState createState() => _ViewVendorPageState();
}

class _ViewVendorPageState extends State<ViewVendorPage> {
  late Vendor _vendor;


  late final Stream<QuerySnapshot> _productsStream;

  @override
  void initState() {
    _vendor = widget.vendor;

    _productsStream = FirebaseFirestore.instance
        .collection('products')
        .where('id', isEqualTo: _vendor.id)
        .snapshots();

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: VendorAppBarDelegate(
                context: context,
                imageUrl: _vendor.logoUrl,
                showMenu: false
            ),
            pinned: false,
          ),
          SliverPadding(
            padding: const EdgeInsets.only(top: 64),
            sliver: SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _vendor.businessName,
                      style: const TextStyle(fontSize: 36),
                    ),
                    Text(_vendor.businessEmail),
                    const SizedBox(
                      height: 15,
                    ),
                    const Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Catalog',
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: _productsStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const SliverToBoxAdapter(
                  child: Center(child: Text('Something went wrong')),
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              if (snapshot.data!.size == 0) {
                return const Text('No available product');
              }

              return SliverGrid(
                gridDelegate:
                const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 280,
                  mainAxisExtent: 220,
                ),
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    final product = Product.fromDocument(snapshot.data!.docs[index]);
                    return ProductCard(
                      product: product,
                      showForUser: true,
                    );
                  },
                  childCount: snapshot.hasData ? snapshot.data!.size : 0,
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
