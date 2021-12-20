import 'package:flutter/material.dart';
import 'package:plug/utilities/alert_mixins.dart';
import 'package:plug/utilities/constants.dart';

class ViewProductAppBarDelegate
    extends SliverPersistentHeaderDelegate with AlertMixins {

  final BuildContext context;
  final String? id;
  final double expandedHeight = 200;
  final String imageUrl;

  ViewProductAppBarDelegate({
    this.id,
    required this.context,
    required this.imageUrl
  });

  @override
  Widget build(BuildContext context, double shrinkOffset,
      bool overlapsContent) {
    const double heightTextField = 247;
    final top = expandedHeight - shrinkOffset - heightTextField / 2;

    return Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      children: [
        getAppbar(context),
        Positioned(
          top: top,
          left: 0,
          right: 0,
          child: Align(
            alignment: Alignment.center,
            child: Opacity(
              opacity: disappear(shrinkOffset),
              child: loadImage(imageUrl),
            ),
          ),
        ),
      ],
    );
  }

  Widget loadImage(String url) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(120),
          boxShadow: kImageBoxShadow
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(120),
        child: Image.network(
          url,
          width: 247,
          height: 247,
        ),
      ),
    );
  }


  Widget getAppbar(BuildContext context) {
    return AppBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
    );
  }

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