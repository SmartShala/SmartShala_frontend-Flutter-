import 'dart:developer';
import 'package:flutter/material.dart';
import 'utils/padded_text.dart';
import 'models/question_data.dart';

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
            child: DropdownButton<String>(
              value: widget.questionData.correctAns,
              icon: const Icon(Icons.check_box_outlined, size: 18),
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  widget.questionData.correctAns = newValue!;
                });
              },
              items: QuestionData.opts
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
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
  const TestCreationPage({Key? key, required this.totalQuestions})
      : super(key: key);

  @override
  State<TestCreationPage> createState() => _TestCreationPageState();
}

class _TestCreationPageState extends State<TestCreationPage> {
  List<QuestionData> dataList = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.totalQuestions; i++) {
      dataList.add(QuestionData());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Set Question Paper')),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            for (QuestionData c in dataList) {
              log(c.toJson().toString());
            }
          },
          child: const Icon(Icons.send)),
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
}
