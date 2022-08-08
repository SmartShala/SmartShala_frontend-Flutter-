import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class TestDetails extends StatefulWidget {
  const TestDetails({Key? key}) : super(key: key);

  @override
  State<TestDetails> createState() => _TestDetailsState();
}

class _TestDetailsState extends State<TestDetails> {
  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    return Form(
      key: _formkey,
      child: _TestForm(),
    );
  }
}

class _TestForm extends StatelessWidget {
  const _TestForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _getPaddedText('Test Name'),
            _getPaddedText('Description'),
            _getPaddedText('Topic'),
            ElevatedButton(
              onPressed: () {
                // if _formKey
              },
              child: const Text('Create'),
            )
          ],
        ),
      ),
    );
  }
}

Padding _getPaddedText(String label, {double px = 8, double py = 16}) {
  /// Generate padded textform widgets with default padding parameters
  /// to avoid unnecessary duplicating
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: px, vertical: py),
    child: TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Required Field';
        }
        return null;
      },
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: label,
      ),
    ),
  );
}
