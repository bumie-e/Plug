import 'package:flutter/material.dart';
import 'package:plug/utilities/constants.dart';

class SectionHeader extends StatelessWidget {
  final String text;

  SectionHeader({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(fontSize: 20),
          ),
          const Text(
            'See All',
            style: TextStyle(
              fontSize: 16,
              color: kPrimaryColor2,
            ),
          ),
        ],
      ),
    );
  }
}