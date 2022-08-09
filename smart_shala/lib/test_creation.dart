import 'package:flutter/material.dart';

class TestCreationPage extends StatefulWidget {
  const TestCreationPage({Key? key}) : super(key: key);

  @override
  State<TestCreationPage> createState() => _TestCreationPageState();
}

class _TestCreationPageState extends State<TestCreationPage> {
  /// This page contains 4 radio buttons signifying options a,b,c,d 
  /// for each question that was specified in the previous page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(title: const Text('Create Test')),
    );
  }

}
