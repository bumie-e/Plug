import 'package:flutter/material.dart';
import 'package:plug/utilities/constants.dart';

class CategoryCard extends StatelessWidget {
  final String text;
  final bool isSelected;
  final String imageLocation;
  double? width = 110;
  double? height = 110;

  CategoryCard(
      {required this.text,
        required this.isSelected,
        required this.imageLocation,
        this.width,
        this.height});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 8.0),
          decoration: isSelected
              ? kBoxDecoration.copyWith(boxShadow: kBoxShadow)
              : kBoxDecoration,
          child: Image.asset(
            imageLocation,
            height: height,
            width: width,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? kPrimaryColor1 : const Color(0xFF94A2B0),
            ),
          ),
        ),
      ],
    );
  }
}