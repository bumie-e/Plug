import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plug/components/vendor_card.dart';
import 'package:plug/delegates/home_appbar_delegate.dart';
import 'package:plug/components/category_card.dart';
import 'package:plug/model/vendor.dart';
import 'package:plug/utilities/constants.dart';
import 'package:plug/components/section_header.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

enum Category { food, shoes, hostels, clothes, others }

class _HomePageState extends State<HomePage> {
  Category selectedCategory = Category.food;
  List<String> images = [
    'pizza.png',
    'shoes.png',
    'hostels.png',
    'clothes.png',
    'others.png',
  ];

  late Stream<QuerySnapshot> _productStream;

  @override
  void initState() {
    setStream(selectedCategory.index);
    super.initState();
  }

  void setStream(int index) {
    setState(() {
      _productStream = FirebaseFirestore.instance
          .collection('vendors')
          .where('category', isEqualTo: kCategories[index])
          .snapshots();
    });
  }

  void onCategoryChange(int index) {
    setState(() {
      selectedCategory = Category.values[index];
    });
    setStream(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: HomeAppBarDelegate(expandedHeight: 132),
            pinned: true,
            floating: false,
          ),
          SliverPadding(
            padding: const EdgeInsets.only(top: 50),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                SectionHeader(text: 'Category'),
                SizedBox(
                  height: 150.0,
                  child: ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: kCategories.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            onCategoryChange(index);
                          },
                          child: CategoryCard(
                            text: kCategories[index],
                            isSelected: index == selectedCategory.index,
                            // Same image for now
                            imageLocation: kImagesRoot + images[index],
                            width: 95,
                            height: 100,
                          ),
                        );
                      }),
                ),
                SectionHeader(
                    text:
                        'Available Vendors: ${kCategories[selectedCategory.index]}'),
              ]),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: _productStream,
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
                return const SliverToBoxAdapter(
                  child: Center(
                    child: Text('Unavailable'),
                  ),
                );
              }

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final vendor =
                        Vendor.fromDocument(snapshot.data!.docs[index]);
                    return HomeVendorCard(vendor: vendor);
                  },
                  childCount: snapshot.hasData ? snapshot.data!.size : 0,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
