import 'package:flutter/material.dart';

/// Stateful class that is reponsible to create the individual rows of
/// question number and their options

class TestOptions extends StatefulWidget {
  final int? questionnum;
  const TestOptions({Key? key, this.questionnum}) : super(key: key);

  @override
  State<TestOptions> createState() => _TestOptionsState();
}

class _TestOptionsState extends State<TestOptions> {
  int? answerkey;
  final opts = ['A', 'B', 'C', 'D'];
  @override
  Widget build(BuildContext context) {
    /// Container holds both the question number and the option radios
    /// to give them padding as a whole

    // TODO: Save the options in an attribute
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          'Q${widget.questionnum}.',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        for (var i = 0; i < opts.length; i++)
          Flexible(
            child: RadioListTile(
                title: Text(opts[i]),
                value: i,
                groupValue: answerkey,
                onChanged: (value) {
                  setState(() {
                    answerkey = value as int?;
                  });
                }),
          ),
      ]),
    );
  }
}

/// Stateful class responsible to leverage the use of individual test options
/// class to build a scrollable listview on-demand

class TestCreationPage extends StatefulWidget {
  final int totalQuestions;
  const TestCreationPage({Key? key, required this.totalQuestions})
      : super(key: key);

  @override
  State<TestCreationPage> createState() => _TestCreationPageState();
}

class _TestCreationPageState extends State<TestCreationPage> {
  /// This page contains a listview of 4 radio buttons signifying
  /// options a,b,c,d for each question; question number
  /// was specified in the previous page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Test')),
      floatingActionButton:
          FloatingActionButton(onPressed: () {}, child: const Icon(Icons.send)),
      body: ListView.builder(
          // TODO: Get the question number from the previous page
          itemCount: widget.totalQuestions,
          itemBuilder: (context, index) {
            return Column(children: [
              TestOptions(questionnum: index + 1),
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
