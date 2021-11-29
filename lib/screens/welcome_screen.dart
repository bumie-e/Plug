import 'package:flutter/material.dart';
import 'package:plug/components/constants.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(height: 79),
            RichText(
              text: const TextSpan(
                text: 'Welcome to ',
                style: TextStyle(
                  color: Color(0xff092C4C),
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
                children: <TextSpan>[
                  TextSpan(text: 'Pl', style: kHeadingTextyStyle1),
                  TextSpan(
                    text: 'u',
                    style: kHeadingTextyStyle2,
                  ),
                  TextSpan(
                    text: 'g!',
                    style: kHeadingTextyStyle1,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Become a Vendor',
              textAlign: TextAlign.start,
              style: kTextSytle1,
            ),
            const Text(
              'Make purchases easily.',
              textAlign: TextAlign.start,
              style: kTextSytle1,
            ),
            SizedBox(height: 69),
            Center(
              child: Image.asset(
                "assets/images/first.png",
                height: 350,
                width: 350,
              ),
            ),
            SizedBox(height: 42),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 62,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      'Become a Vendor',
                      style: kElevatedButtonTextStyle,
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Color(0xff092C4C),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  height: 62,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      'Make a Purchase',
                      style: kElevatedButtonTextStyle,
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        const Color(0xffE2B93B),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'skip',
                    style: kTextSytle2,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
