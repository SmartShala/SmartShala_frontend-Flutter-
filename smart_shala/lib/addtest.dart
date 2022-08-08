import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TestDetails extends StatefulWidget {
  const TestDetails({Key? key}) : super(key: key);

  @override
  State<TestDetails> createState() => _TestDetailsState();
}

class _TestDetailsState extends State<TestDetails> {
  final _formkey = GlobalKey<FormState>();
  int? year = 1;
  String? section = 'A';

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 90,
                    child: DropdownButtonFormField<int>(
                      value: year,
                      items: [1, 2, 3, 4].map((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(value.toString()),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          year = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: 90,
                    child: DropdownButtonFormField<String>(
                      value: section,
                      items: ['A', 'B', 'C', 'D'].map((value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          section = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              _getPaddedText('Topic'),
              SizedBox(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const TestCreationPage()));
                    // TODO: Add data validation and store input data
                  },
                  child: const Text('Create'),
                ),
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
  String? dropdownvalue = 'MultipleChoice';

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
                  child: const Text('Browse')),
              DropdownButtonFormField<String>(
                value: dropdownvalue,
                items:
                    <String>['MultipleChoice', 'Checkbox'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    dropdownvalue = value;
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
