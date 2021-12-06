import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

enum ImageSourceType { gallery, camera }

class LocalImage {

  var _type;

  LocalImage(this._type);

  Future<Image?> pickImage() async {
    var imagePicker = ImagePicker();

    var source = _type == ImageSourceType.camera
        ? ImageSource.camera
        : ImageSource.gallery;

    XFile? image = await imagePicker.pickImage(
        source: source,
        imageQuality: 50,
        preferredCameraDevice: CameraDevice.rear);

    var imagePath = image?.path;

    return imagePath == null ? null
        : Image.file(
      File(imagePath),
      width: 150.0,
      height: 150.0,
      fit: BoxFit.fill,
    );
  }
}