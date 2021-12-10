import 'package:flutter/material.dart';

const kPrimaryColor1 = Color(0xff092C4C);
const kPrimaryColor2 = Color(0xffE2B93B);

const kImagesRoot = 'assets/images/';

const kHeadingTextyStyle1 = TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.w700,
  color: kPrimaryColor1,
);

const kHeadingTextyStyle2 = TextStyle(
  color: kPrimaryColor2,
  fontSize: 30,
);

const kSubHeadingTextStyle = TextStyle(
  fontSize: 20.0,
  color: kPrimaryColor1,
);

const kTextSytle2 = TextStyle(
  fontSize: 18.0,
  color: Color(0xff092C4C),
);

const kTextSytle3 = TextStyle(
  fontSize: 18.0,
  color: Color(0xffE2B93B),
);

const kSubHeading = TextStyle(
  fontSize: 24.0,
  fontWeight: FontWeight.w600,
  color: Color(0xff092C4C),
);

const kElevatedButtonTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w700,
);

const kPadding = EdgeInsets.all(26.0);

const kCustomPlugText = <TextSpan>[
  TextSpan(text: 'Pl'),
  TextSpan(text: 'u', style: TextStyle(color: kPrimaryColor2)),
  TextSpan(text: 'g'),
];

const kBoxDecoration = BoxDecoration(
  color: kGreyColor,
  borderRadius: BorderRadius.all(Radius.circular(12)),
);

const kBoxShadow = [
  BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.25),
    spreadRadius: 1,
    blurRadius: 10,
    offset: Offset(0, 0.1),
  )
];

const kExclamationPoint = <TextSpan>[
  TextSpan(text: '!'),
];

const kGreyColor = Color(0xFFF3F3F5);

const kPrimaryColorSwatch = MaterialColor(0xFF092C4C, {
  50: Color.fromRGBO(9, 44, 76, .1),
  100: Color.fromRGBO(9, 44, 76, .2),
  200: Color.fromRGBO(9, 44, 76, .3),
  300: Color.fromRGBO(9, 44, 76, .4),
  400: Color.fromRGBO(9, 44, 76, .5),
  500: Color.fromRGBO(9, 44, 76, .6),
  600: Color.fromRGBO(9, 44, 76, .7),
  700: Color.fromRGBO(9, 44, 76, .8),
  800: Color.fromRGBO(9, 44, 76, .9),
  900: Color.fromRGBO(9, 44, 76, 1),
});

const kSubHeadingStyle = TextStyle(fontSize: 20.0);

const kSkipTextStyle = TextStyle(fontSize: 18.0);
