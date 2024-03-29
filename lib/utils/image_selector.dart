import 'package:image_picker/image_picker.dart';

Future<List<XFile>?> imageSelectorGallery() async {
  final ImagePicker picker = ImagePicker();
  // Pick images for question; may need to add option to choose a pdf
  final List<XFile>? image = await picker.pickMultiImage();
  return image;
}

Future<XFile?> imageSelectorCamera() async {
  final ImagePicker picker = ImagePicker();
  // Pick images for question; may need to add option to choose a pdf
  final image = await picker.pickImage(source: ImageSource.camera);
  return image;
}
