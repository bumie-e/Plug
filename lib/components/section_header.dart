import 'package:flutter/material.dart';
import 'package:plug/utilities/constants.dart';

class SectionHeader extends StatelessWidget {
  final String text;

  SectionHeader({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}