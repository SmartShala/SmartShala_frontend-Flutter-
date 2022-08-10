import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'test_creation.dart';

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
              // Test Name Field
              _getPaddedText('Test Name'),
              // Test Description Field
              _getPaddedText('Description'),
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
              _getPaddedText('Topic'),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                child: TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Enter number of questions"),
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: SizedBox(
                  width: double.infinity,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            imageSelectorGallery();
                          },
                          icon: const Icon(Icons.image),
                          label: const Text('Upload Question'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const TestCreationPage()));
                            // TODO: Add data validation and store input data
                          },
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromARGB(255, 247, 86, 75),
                          ),
                          child: const Text('Create'),
                        )
                      ]),
                ),
              ),
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

  Future<List<XFile>?> imageSelectorGallery() async {
    dynamic scaf = ScaffoldMessenger.of(context);
    final ImagePicker picker = ImagePicker();
    // Pick an image
    final List<XFile>? image = await picker.pickMultiImage();
    // TODO: Use the image for upload
    setState(() {});
    scaf.showSnackBar(const SnackBar(content: Text('Image Selected')));
    return image;
  }
}
