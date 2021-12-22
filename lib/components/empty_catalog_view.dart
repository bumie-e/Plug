import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyCatalogView extends StatelessWidget {
  const EmptyCatalogView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/try2.svg',
            height: 350,
            width: 350,
          ),
          const Text(
            'No product in your catalog yet',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(
            height: 9,
          ),
          const Text(
            'Click on the \'+\' below to add product',
          ),
        ],
      ),
    );
  }
}
