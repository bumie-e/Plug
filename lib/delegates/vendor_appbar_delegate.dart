import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plug/screens/home_screen.dart';
import 'package:plug/screens/welcome_screen.dart';
import 'package:plug/utilities/alert_mixins.dart';
import 'package:plug/utilities/constants.dart';

class VendorAppBarDelegate
    extends SliverPersistentHeaderDelegate with AlertMixins {

  final BuildContext context;
  final double expandedHeight = 132;
  final String imageUrl;
  final bool showMenu;

  final List<String> menuList = ['Home', 'Logout'];

  VendorAppBarDelegate({
    required this.context,
    required this.imageUrl,
    this.showMenu = true
  });

  @override
  Widget build(BuildContext context, double shrinkOffset,
      bool overlapsContent) {
    const double heightTextField = 111;
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
    if (url.isEmpty) {
      return const Text('No business logo');
    } else {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          boxShadow: kImageBoxShadow
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.network(
            url,
            width: 111,
            height: 111,
          ),
        ),
      );
    }
  }

  List<PopupMenuItem<String>> getItemBuilder() {

    return menuList.map((String choice) {
      return PopupMenuItem<String>(
        value: choice,
        child: getItem(choice),
      );
    }).toList();
  }

  Widget getItem(String choice) {
    late Icon icon;
    if (choice == menuList[0]) {
      icon = const Icon(Icons.home, color: kPrimaryColor2,);
    } else {
      icon = const Icon(Icons.logout, color: kPrimaryColor2,);
    }
    return Row(
      children: [
        icon,
        const SizedBox(width: 20,),
        Text(choice),
      ],
    );
  }

  void handleItemClick(BuildContext context, String value) {
    if (value == menuList[0]) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return HomePage();
      }));
    } else {
      signOut();
    }
  }

  Widget getAppbar(BuildContext context) {
    return AppBar(
      actions: showMenu ? [
        PopupMenuButton<String>(
          onSelected: (value) => handleItemClick(context, value),
          itemBuilder: (BuildContext context) {
            return getItemBuilder();
          },
        ),
      ] : null,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
    );
  }

  void signOut() async {
    showLoadingAlert(context, text: 'Signing out');
    await FirebaseAuth.instance.signOut();
    dismissLoader(context);
    Navigator.pushReplacementNamed(context, WelcomePage.routeName);
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