import 'dart:io';

import 'package:engagementwallet/src/utils/colors.dart';
import 'package:engagementwallet/values/assets.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

final picker = ImagePick();

class ImagePick {

  //selected croppedFile
 File? _croppedImage;

 File? get croppedImage => _croppedImage;

 setCroppedImage(File? croppedImage) => _croppedImage = croppedImage;

 final pick = ImagePicker();


 // crop image
  Future<File?> cropImage(File file, BuildContext context) async {
    File? croppedImageFile = await ImageCropper().cropImage(
      sourcePath: file.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9,
      ],
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: primaryColor,
          toolbarWidgetColor: Colors.black,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      iosUiSettings: const IOSUiSettings(
        minimumAspectRatio: 1.0,
      ),
      compressQuality: 100,
      compressFormat: ImageCompressFormat.jpg,
      // maxHeight: 256,
      // maxWidth: 256,
      cropStyle: CropStyle.circle,
    );

    return croppedImageFile;
  }

//picks image to post from gallery or from camera
  onImagePickerPressed(ImageSource source, BuildContext context) async {
    final imageFile = await  pick.getImage(source: source, imageQuality: 30);

    File? result = await cropImage(File(imageFile!.path), context);

    print('imageFile:${result?.readAsBytesSync().lengthInBytes}');

    return result;
  }



  Widget imageDisplay( Widget imagePlaceholder) {
    if (_croppedImage != null) {
      return Container(
        height: 70.0,
        width: 70.0,
        decoration: BoxDecoration(
            image:  DecorationImage(
              image:  FileImage(File(croppedImage!.path)),
              fit: BoxFit.cover,
            ),
            shape: BoxShape.circle
        ),
      );
    } else {
      return imagePlaceholder;
    }
  }
}
