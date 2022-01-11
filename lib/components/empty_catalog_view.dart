import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyCatalogView extends StatelessWidget {
  final bool showForUser;

  const EmptyCatalogView({Key? key, this.showForUser = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/empty_catalog.png',
          ),
          Text(
            showForUser ? 'No available product in catalog.'
                : 'No product in your catalog yet',
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),

          showForUser ? const SizedBox() :
          const Padding(
            padding: EdgeInsets.only(top: 9.0),
            child: Text(
              'Click on the \'+\' below to add product',
            ),
          ),
        ],
      ),
    );
  }
}
