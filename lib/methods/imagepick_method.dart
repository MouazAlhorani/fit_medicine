import 'package:image_picker/image_picker.dart';
import 'dart:io';

final ImagePicker _picker = ImagePicker();

Future<File?> pickImage(ImageSource source) async {
  final XFile? pickedFile = await _picker.pickImage(source: source);
  if (pickedFile != null) {
    File imageFile = File(pickedFile.path);
    return imageFile;
  }
  return null;
}
