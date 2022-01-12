import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plug/components/empty_catalog_view.dart';
import 'package:plug/components/product_card.dart';
import 'package:plug/delegates/vendor_appbar_delegate.dart';
import 'package:plug/model/product.dart';
import 'package:plug/model/vendor.dart';
import 'package:plug/screens/product_detail.dart';
import 'package:plug/utilities/constants.dart';

class VendorPage extends StatefulWidget {
  static const routeName = '/vendor-page';
  final String id;

  const VendorPage({Key? key, required this.id}) : super(key: key);

  @override
  _VendorPageState createState() => _VendorPageState(id);
}

class _VendorPageState extends State<VendorPage> {
  Vendor? _vendor;
  final String id;
  late final Stream<QuerySnapshot> _productsStream;

  _VendorPageState(this.id);

  @override
  void initState() {
    _productsStream = FirebaseFirestore.instance
        .collection('products')
        .where('id', isEqualTo: id)
        .snapshots();

    showSignedInSnackbar();
    getVendor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor2,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ProductDetailsPage(id: id);
          }));
        },
        child: const Icon(
          Icons.add,
          size: 22.5,
        ),
      ),
      body: _vendor == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  delegate: VendorAppBarDelegate(
                      context: context, imageUrl: _vendor!.logoUrl),
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
                            _vendor!.businessName,
                            style: const TextStyle(fontSize: 36),
                          ),
                          Text(_vendor!.businessEmail),
                          const Divider(),
                          Text(_vendor!.desc),
                          const Divider(),
                          Text.rich(
                            TextSpan(
                                text: 'Open ',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                children: [
                                  TextSpan(
                                      text: _vendor!.openingHours +
                                          ' - ' +
                                          _vendor!.closingHours,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: kPrimaryColor2))
                                ]),
                          ),
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
                      return const EmptyCatalogView();
                    }

                    return SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 280,
                        mainAxisExtent: 220,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final product =
                              Product.fromDocument(snapshot.data!.docs[index]);
                          return ProductCard(
                            product: product,
                            showForUser: false,
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

  showSignedInSnackbar() {
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
  }

  void getVendor() async {
    final doc =
        await FirebaseFirestore.instance.doc('vendors/${widget.id}').get();
    setState(() {
      _vendor = Vendor.fromDocument(doc);
    });
  }
}
