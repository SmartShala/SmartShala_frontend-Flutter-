import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TestCreationPage extends StatefulWidget {
  const TestCreationPage({Key? key}) : super(key: key);

  @override
  State<TestCreationPage> createState() => _TestCreationPageState();
}

class _TestCreationPageState extends State<TestCreationPage> {
  String? year = 'MultipleChoice';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Test')),
      body: Column(
        children: [
          Row(
            children: [
              ElevatedButton(
                  onPressed: () {
                    imageSelectorGallery();
                  },
                  child: Text('Browse')),
              DropdownButton<String>(
                value: year,
                items:
                    <String>['MultipleChoice', 'Checkbox'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    year = value;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  imageSelectorGallery() async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    // TODO: Use the image for upload
    setState(() {});
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Image Selected')));
  }
}
