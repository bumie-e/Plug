import 'package:flutter/material.dart';
import 'package:plug/utilities/constants.dart';

class HomeAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  HomeAppBarDelegate({required this.expandedHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    const double heightTextField = 44;
    final top = expandedHeight - shrinkOffset - heightTextField / 2;

    return Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      children: [
        getAppbar(),
        Positioned(
          top: top,
          left: 20,
          right: 20,
          child: Opacity(
            opacity: disappear(shrinkOffset),
            child: Material(
              elevation: 5,
              color: Colors.transparent,
              shadowColor: const Color(0xFFBEBEC1),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: 'Search for vendor',
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Color(0xFFBEBEC1),
                  ),
                  fillColor: const Color(0xFFEFEFF0),
                  filled: true,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget getAppbar() => AppBar(
    title: const Text.rich(
      TextSpan(
        style: TextStyle(fontSize: 24.0),
        children: kCustomPlugText,
      ),
    ),
    centerTitle: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(10),
        bottomRight: Radius.circular(10),
      ),
    ),
  );

  double appear(double shrinkOffset) => shrinkOffset / expandedHeight;

  double disappear(double shrinkOffset) => 1 - shrinkOffset / expandedHeight;

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight + 30;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}