import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:edge_detection/edge_detection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_shala/api/upload_api.dart';

class EgeCam extends StatefulWidget {
  const EgeCam({Key? key}) : super(key: key);

  @override
  State<EgeCam> createState() => _EgeCamState();
}

class _EgeCamState extends State<EgeCam> {
  String? _imagePath;
  bool cam = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> getImage() async {
    String? imagePath;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      imagePath = (await EdgeDetection.detectEdge);
      log("$imagePath");
    } on PlatformException catch (e) {
      imagePath = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return;
    }

    setState(() {
      _imagePath = imagePath;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final arguments = (ModalRoute.of(context)?.settings.arguments ??
    //     <int, dynamic>{}) as Map;
    // log(arguments['testid']);
    return Scaffold(
      appBar: AppBar(
        title: const Text('StartScan'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: ElevatedButton(
                onPressed: getImage,
                child: const Text('Scan'),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Cropped image path:'),
            Padding(
              padding: const EdgeInsets.only(top: 0, left: 0, right: 0),
              child: ElevatedButton(
                onPressed: (() async {
                  upload(File(_imagePath ?? ""));
                }),
                child: const Text('Submit'),
              ),
            ),
            Visibility(
              visible: _imagePath != null,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.file(
                  File(_imagePath ?? ''),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> upload(File file) async {
    log("started");
    UploadApi uploadapi = UploadApi();
    await uploadapi.uploadImage(file);
  }
}
