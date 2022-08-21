import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'test_creation.dart';
import '../utils/padded_text.dart';
import '../api/substd_api.dart';
import '../utils/validators.dart';

/// Get the test details from the user and send to api;
/// then display the test creation page
class TestDetails extends StatefulWidget {
  const TestDetails({Key? key}) : super(key: key);

  @override
  State<TestDetails> createState() => _TestDetailsState();
}

class _TestDetailsState extends State<TestDetails> {
  final _formkey = GlobalKey<FormState>();

  int? standard;
  int? subject;
  final name = TextEditingController();
  final desc = TextEditingController();
  final topic = TextEditingController();
  final quesNum = TextEditingController();
  List<List<int>>? standards;
  List<List<dynamic>>? subjects;

  @override
  void initState() {
    _getSubAndStd();
    super.initState();
  }

  void _getSubAndStd() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? accessToken = sharedPreferences.getString('access');
    SubAndStdApi substdapi = SubAndStdApi();
    substdapi.getdata(accessToken!).then((value) {
      setState(() {
        standards = value.standards;
        subjects = value.subjects;
      });
      log(standards.toString());
      log(subjects.toString());
    });
  }

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
    return Scaffold(
      appBar: AppBar(title: const Text('Create Test')),
      body: Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // Test Name Field
                getPaddedText('Test Name', controller: name),
                // Test Description Field
                getPaddedText('Description', controller: desc),
                // Year and Section Row
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 2.0),
                  child: SizedBox(
                    width: double.maxFinite,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Standard',
                              style: TextStyle(fontSize: 20)),
                          SizedBox(
                            width: 60,
                            child: DropdownButtonFormField<int?>(
                              value: standard,
                              validator: (value) =>
                                  value != null ? null : "Required",
                              icon: const Icon(Icons.arrow_downward),
                              elevation: 16,
                              style: const TextStyle(color: Colors.deepPurple),
                              onChanged: (int? newValue) {
                                setState(() {
                                  standard = newValue!;
                                });
                              },
                              items: (standards ?? [])
                                  .map<DropdownMenuItem<int?>>((value) {
                                return DropdownMenuItem<int>(
                                  value: value[0],
                                  child: Text(value[1].toString()),
                                );
                              }).toList(),
                            ),
                          ),
                          const Text('Subject', style: TextStyle(fontSize: 20)),
                          SizedBox(
                            width: 100,
                            child: DropdownButtonFormField<int>(
                              validator: (value) =>
                                  value != null ? null : "Required",
                              value: subject,
                              icon:
                                  const Icon(Icons.arrow_circle_down, size: 18),
                              elevation: 16,
                              style: const TextStyle(color: Colors.deepPurple),
                              onChanged: (int? newValue) {
                                setState(() {
                                  subject = newValue!;
                                });
                              },
                              items: (subjects ?? [])
                                  .map<DropdownMenuItem<int>>((value) {
                                return DropdownMenuItem<int>(
                                  value: value[0],
                                  child: Text(value[1]),
                                );
                              }).toList(),
                            ),
                          )
                        ]),
                  ),
                ),
                // Test Topic Field
                getPaddedText('Topic', controller: topic),

                // Question Number Field
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: TextFormField(
                    validator: isInt,
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
                      // On callback validate the form and send the details to api
                      onPressed: createCallback,
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
      ),
    );
  }

  void createCallback() {
    if (_formkey.currentState!.validate()) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => TestCreationPage(
          totalQuestions: int.parse(quesNum.text),
        ),
      ));
    }
  }
}
