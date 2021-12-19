import 'dart:io';

import 'package:flutter/material.dart';
import 'package:plug/utilities/constants.dart';
import 'package:plug/utilities/image_picker.dart';

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

  showErrorAlert(BuildContext context,
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
              Navigator.pop(context);
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

  void showImageBottomSheet(BuildContext context,
      {required Function(File? file) onImageUpload}) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(12.0),
          height: 200,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  child: const Text('Upload image from gallery'),
                  onPressed: () async {
                    dismissLoader(context);
                    onImageUpload(
                        await LocalImage(ImageSourceType.gallery).pickImage());
                  },
                ),
                ElevatedButton(
                  child: const Text('Take picture with camera'),
                  onPressed: () async {
                    dismissLoader(context);
                    onImageUpload(
                        await LocalImage(ImageSourceType.camera).pickImage());
                  },
                ),
                TextButton(
                  child: const Text('Remove photo'),
                  onPressed: () {
                    onImageUpload(null);
                    dismissLoader(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
