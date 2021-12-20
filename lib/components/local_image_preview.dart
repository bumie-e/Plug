import 'dart:io';

import 'package:flutter/material.dart';
import 'package:plug/utilities/alert_mixins.dart';
import 'package:plug/utilities/constants.dart';

class LocalImagePreview extends StatefulWidget {
  final String label;
  final Function(File? file) onImageUpload;

  const LocalImagePreview({Key? key,
    required this.label,
    required this.onImageUpload
  }) : super(key: key);

  @override
  _LocalImagePreviewState createState() => _LocalImagePreviewState();
}

class _LocalImagePreviewState
    extends State<LocalImagePreview> with AlertMixins {

  File? _imageFile;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showImageBottomSheet(context, onImageUpload: (file) {
          if(file != null) {
            widget.onImageUpload(file);
            setState(() => _imageFile = file);
          }
        });
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 180,
          width: 180,
          decoration: kBoxDecoration.copyWith(color: kPrimaryColor1),
          child: _imageFile == null
            ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.camera_alt,
                color: Colors.white,
              ),
              Text(
                widget.label,
                style: kTextSytle2.copyWith(
                    color: Colors.white),
              ),
            ],
          )
              : showImage(),
        ),
      ),
    );
  }

  Image showImage() => Image.file(
    _imageFile!,
    width: 180.0,
    height: 180.0,
  );
}
