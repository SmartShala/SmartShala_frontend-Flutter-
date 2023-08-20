import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:edge_detection/edge_detection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_shala/api/upload_api.dart';
import '../progress_hud.dart';

class EgeCam extends StatefulWidget {
  const EgeCam({Key? key, required this.testID}) : super(key: key);

  final String testID;

  @override
  State<EgeCam> createState() => _EgeCamState();
}

class _EgeCamState extends State<EgeCam> {
  String? _imagePath;
  bool cam = false;
  bool _isApiCallInProgress = false;

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
    return ProgressHUD(
      inAsyncCall: _isApiCallInProgress,
      opacity: 0.3,
      child: _uiSetup(context),
    );
  }

  Widget _uiSetup(BuildContext context) {
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
                onPressed: _uploadCallback,
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

  Future<void> _uploadCallback() async {
    log("started image upload");
    setState(() {
      _isApiCallInProgress = true;
    });
    UploadApi uploadapi = UploadApi(widget.testID);
    await uploadapi.uploadImage(File(_imagePath!));
    setState(() {
      _isApiCallInProgress = false;
    });
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Image uploaded'),
    ));
  }
}
