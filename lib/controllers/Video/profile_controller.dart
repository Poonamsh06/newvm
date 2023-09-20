import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController {
  Future<File?> selectImageOfController(ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile == null) {
      return null;
    }

    final croppedImageFile = await cropImage(pickedFile);
    if (croppedImageFile == null) return null;
    final File imageFile = File(croppedImageFile.path);
    return imageFile;
  }

  Future<CroppedFile?> cropImage(XFile file) async {
    final croppedImage = await ImageCropper().cropImage(
      sourcePath: file.path,
      compressQuality: 20,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
    );

    if (croppedImage == null) {
      return null;
    }

    return croppedImage;
  }
}
