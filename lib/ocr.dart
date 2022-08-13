import 'package:flutter/material.dart';
import 'utils/image_selector.dart';

class OcrPage extends StatelessWidget {
  const OcrPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.blueGrey,
        body: Center(
          child: ElevatedButton.icon(
            icon: const Icon(Icons.camera_alt),
            label: const Text('Scan using camera'),
            onPressed: () {
              imageSelectorCamera();
              const SnackBar(
                content: Text('done'),
              );
            },
          ),
        ),
      );
}
