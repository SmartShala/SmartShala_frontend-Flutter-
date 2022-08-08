import 'package:flutter/material.dart';

class TestDetails extends StatefulWidget {
  const TestDetails({Key? key}) : super(key: key);

  @override
  State<TestDetails> createState() => _TestDetailsState();
}

class _TestDetailsState extends State<TestDetails> {
  final _formkey = GlobalKey<FormState>();
  // Function nameOnSaved (value) => ;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _getPaddedText('Test Name'),
              _getPaddedText('Description'),
              _getPaddedText('Topic'),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext context) => TestCreationPage())
                  );
                  // TODO: Add data validation and store input data
                },
                child: const Text('Create'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _getPaddedText(String label, {double px = 8, double py = 16}) {
    /// Generate padded textform widgets with default padding parameters
    /// to avoid unnecessary duplicating
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: px, vertical: py),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Required Field';
          }
          if (value.length < 3) {
            return 'Too short';
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
}

class TestCreationPage extends StatefulWidget {
  const TestCreationPage({Key? key}) : super(key: key);

  @override
  State<TestCreationPage> createState() => _TestCreationPageState();
}

class _TestCreationPageState extends State<TestCreationPage> {
  @override
  Widget build(BuildContext context) {
    return const Text('Nice');
  }
}
