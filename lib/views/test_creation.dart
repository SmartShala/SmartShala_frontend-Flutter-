import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/padded_text.dart';
import '../models/question_data.dart';
import '../api/testcreationapi.dart';
import '../api/test_delete.dart';
import '../constants/routes.dart';

/// Stateful class that is reponsible to create the individual blocks of
/// question number and their options
/// A custom widget to render one question, with question data class
/// passed by reference and controllers installed

class TestOptions extends StatefulWidget {
  final int questionnum;
  final QuestionData questionData;
  const TestOptions(
      {Key? key, required this.questionnum, required this.questionData})
      : super(key: key);

  @override
  State<TestOptions> createState() => _TestOptionsState();
}

class _TestOptionsState extends State<TestOptions> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      height: 550,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Flexible(
          child: Text(
            'Q${widget.questionnum}.',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        SizedBox(
            width: 400,
            child: getPaddedText('Question',
                controller: widget.questionData.question)),
        for (int i = 0; i < QuestionData.opts.length; i++)
          SizedBox(
            child: Row(children: [
              Text('${QuestionData.opts[i]})'),
              SizedBox(
                width: 300,
                child: getPaddedText('Option ${QuestionData.opts[i]}',
                    controller: widget.questionData.optControllers[i],
                    outlineborder: false),
              ),
            ]),
          ),

        // Correct Option Dropdown with label
        Row(children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Correct Option:'),
          ),
          SizedBox(
            width: 30,
            child: DropdownButton<int?>(
                value: widget.questionData.correctAns,
                icon: const Icon(Icons.check_box_outlined, size: 18),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (int? newValue) {
                  setState(() {
                    widget.questionData.correctAns = newValue!;
                  });
                },
                items: [
                  for (int i = 0; i < QuestionData.opts.length; i++)
                    DropdownMenuItem<int>(
                      value: i,
                      child: Text(QuestionData.opts[i]),
                    )
                ]),
          ),
        ]),
      ]),
    );
  }
}

/// Stateful class responsible to use individual question blocks
/// to build a scrollable listview, save data in question data model; serve
/// to api on button press

class TestCreationPage extends StatefulWidget {
  final int totalQuestions;
  final int testId;
  const TestCreationPage(
      {Key? key, required this.totalQuestions, required this.testId})
      : super(key: key);

  @override
  State<TestCreationPage> createState() => _TestCreationPageState();
}

class _TestCreationPageState extends State<TestCreationPage> {
  List<QuestionData> dataList = [];
  String? _accessToken;

  @override
  void initState() {
    super.initState();
    _getToken();
    for (int i = 0; i < widget.totalQuestions; i++) {
      dataList.add(QuestionData());
    }
  }

  void _getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _accessToken = sharedPreferences.getString('access');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: BackButton(onPressed: _onBackPressed),
          title: const Text('Set Question Paper')),
      floatingActionButton: FloatingActionButton(
          onPressed: createCallback, child: const Icon(Icons.send)),
      body: ListView.builder(
          itemCount: widget.totalQuestions,
          itemBuilder: (context, index) {
            return Column(children: [
              TestOptions(
                questionnum: index + 1,
                questionData: dataList[index],
              ),
              const Divider(
                thickness: 2,
                indent: 9,
                endIndent: 9,
              ),
            ]);
          }),
    );
  }

  void createCallback() async {
    List<Map<String, dynamic>> jsonData = [];
    for (QuestionData c in dataList) {
      jsonData.add(c.toJson());
    }
    TestCreationApi testCreationApi = TestCreationApi();
    testCreationApi
        .create(jsonEncode(jsonData), widget.testId, _accessToken!)
        .then(
      (value) {
        log("value -> ${value.toString()}");
        if (value.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Test Successfully Created')));
          Navigator.of(context)
              .pushNamedAndRemoveUntil(testdashRoute, (route) => false);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Test Creation Failed')));
        }
      },
    );
  }

  void _onBackPressed() async {
    TestDeleteApi testDeleteApi = TestDeleteApi();
    testDeleteApi.delete(_accessToken!, widget.testId).then((value) {
      if (value != TestDeleteApi.deleteCode) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Server Error $value')));
      } else {
        Navigator.of(context).pushReplacementNamed(addtestRoute);
      }
    });
  }
}
