import 'package:flutter/material.dart';
import 'package:plug/utilities/constants.dart';

class ReusableButton extends StatelessWidget {
  final String title;
  final MaterialStateProperty<Color> color;
  final Function onPressed;

  const ReusableButton(
      {Key? key,
      required this.title,
      required this.color,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text(
        title,
        style: kElevatedButtonTextStyle,
      ),
      style: ButtonStyle(
        backgroundColor: color,
      ),
    );
  }
}
