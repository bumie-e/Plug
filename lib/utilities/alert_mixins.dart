import 'package:flutter/material.dart';
import 'package:plug/utilities/constants.dart';

mixin AlertMixins {
  showLoadingAlert(BuildContext context, {required String text}) {
    AlertDialog alert = AlertDialog(
      backgroundColor: kPrimaryColor1,
      content: Row(
        children: [
          const CircularProgressIndicator(
            color: Colors.white,
          ),
          Container(
            margin: const EdgeInsets.only(left: 7),
            child: Text(
              "$text...",
              style: kWhiteTextStyle,
            ),
          ),
        ],
      ),
    );

    showDialog(
      barrierColor: Colors.black26,
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showErrorAlert(BuildContext context ,
      {required String errorTitle, required String errorMessage}) {
    AlertDialog alert = AlertDialog(
      backgroundColor: kPrimaryColor1,
      title: Text(
        errorTitle,
        style: kWhiteTextStyle,
      ),
      content: Text(
        errorMessage,
        style: kWhiteTextStyle,
      ),
      actions: [
        TextButton(
            child: const Text(
              'OK',
              style: kWhiteTextStyle,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ],
    );

    showDialog(
      barrierColor: Colors.black26,
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void dismissLoader(BuildContext context) => Navigator.pop(context);
}
