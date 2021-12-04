import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plug/components/appbar_delegate.dart';
import 'package:plug/components/category_card.dart';
import 'package:plug/utilities/constants.dart';
import 'package:plug/components/section_header.dart';

class HomePage extends StatefulWidget {

  static const id = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

enum Category { food, shoes, hostels, others }

class _HomePageState extends State<HomePage> {
  Category selectedCategory = Category.food;
  List<String> categories = ['Food', 'Shoes', 'Hostels', 'Others'];
  List<String> images = ['pizza.png', 'shoes.png', 'hostels.png', 'others.png'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: CustomSliverAppBarDelegate(expandedHeight: 132),
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
                      itemCount: categories.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCategory = Category.values[index];
                            });
                          },
                          child: CategoryCard(
                            text: categories[index],
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
                        'Available Vendors: ${categories[selectedCategory.index]}'),
              ]),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Container(
                height: 120,
                margin: const EdgeInsets.fromLTRB(22, 15, 22, 15),
                decoration: kBoxDecoration.copyWith(boxShadow: kBoxShadow),
                child: Row(
                  children: [
                    Image.asset(
                      // Same image still
                      'assets/images/pizza.png',
                      height: 110,
                      width: 110,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'McDonald\'s',
                          style: TextStyle(fontSize: 24.0),
                        ),
                        Text(
                          'Food at your door step',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          'OAU Campus',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              childCount: 10,
            ),
          ),
        ],
      ),
    );
  }
}
