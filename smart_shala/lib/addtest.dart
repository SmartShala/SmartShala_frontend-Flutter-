import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'test_creation.dart';
import 'models/testdetailsmodel.dart';

class TestDetails extends StatefulWidget {
  const TestDetails({Key? key}) : super(key: key);

  @override
  State<TestDetails> createState() => _TestDetailsState();
}

class _TestDetailsState extends State<TestDetails> {
  final _formkey = GlobalKey<FormState>();

  int? year = 1;
  String? section = 'A';
  final name = TextEditingController();
  final desc = TextEditingController();
  final topic = TextEditingController();
  final quesNum = TextEditingController();

  /// Override the default destructor to destruct resources taken by
  /// controllers first
  @override
  void dispose() {
    name.dispose();
    desc.dispose();
    topic.dispose();
    quesNum.dispose();
    super.dispose();
  }

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
              // Test Name Field
              _getPaddedText('Test Name', controller: name),
              // Test Description Field
              _getPaddedText('Description', controller: desc),
              // Year and Section Row
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Year', style: TextStyle(fontSize: 20)),
                        DropdownButton<int?>(
                          value: year,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (int? newValue) {
                            setState(() {
                              year = newValue!;
                            });
                          },
                          items: <int>[1, 2, 3, 4]
                              .map<DropdownMenuItem<int?>>((value) {
                            return DropdownMenuItem<int?>(
                              value: value,
                              child: Text(value.toString()),
                            );
                          }).toList(),
                        ),
                        const SizedBox(width: 90),
                        const Text('Section', style: TextStyle(fontSize: 20)),
                        DropdownButton<String>(
                          value: section,
                          icon: const Icon(Icons.arrow_circle_down, size: 18),
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              section = newValue!;
                            });
                          },
                          items: <String>['A', 'B', 'C', 'D']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        )
                      ]),
                ),
              ),
              // Test Topic Field
              _getPaddedText('Topic', controller: topic),

              // Question Number Field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                child: TextFormField(
                  validator: (value) {
                    int intval;

                    if (value == null || value.isEmpty) {
                      return 'Required Field';
                    }
                    try {
                      intval = int.parse(value);
                    } on FormatException {
                      return 'Non-number character input';
                    }
                    if (intval < 1) {
                      return 'Invalid Question Number';
                    }
                    return null;
                  },
                  controller: quesNum,
                  decoration: const InputDecoration(
                      labelText: "Enter number of questions"),
                  keyboardType: TextInputType.number,
                ),
              ),

              // Creation Button
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        _sendDetailsToApi(TestDetailsModel(
                            name: name.text,
                            desc: desc.text,
                            year: year!,
                            sec: section!,
                            topic: topic.text));

                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => TestCreationPage(
                            totalQuestions: int.parse(quesNum.text),
                          ),
                        ));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 247, 86, 75),
                    ),
                    child: const Text('Create'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _sendDetailsToApi(TestDetailsModel model) {
    // TODO: Send model to api
    log(model.toJson().toString());
  }

  Widget _getPaddedText(String label,
      {required TextEditingController controller,
      double px = 8,
      double py = 16}) {
    /// Generate padded textform widgets with default padding parameters
    /// to avoid unnecessary duplicating

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: px, vertical: py),
      child: TextFormField(
        controller: controller,
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

  Future<List<XFile>?> imageSelectorGallery() async {
    final scaf = ScaffoldMessenger.of(context);
    final ImagePicker picker = ImagePicker();
    // Pick images for question; may need to add option to choose a pdf
    final List<XFile>? image = await picker.pickMultiImage();
    // TODO: Use the image for upload
    setState(() {});
    scaf.showSnackBar(const SnackBar(content: Text('Image Selected')));
    return image;
  }
}
