import 'package:flutter/material.dart';
import 'utils/padded_text.dart';

/// Stateful class that is reponsible to create the individual rows of
/// question number and their options

class TestOptions extends StatefulWidget {
  final int questionnum;
  const TestOptions({Key? key, required this.questionnum}) : super(key: key);

  @override
  State<TestOptions> createState() => _TestOptionsState();
}

class _TestOptionsState extends State<TestOptions> {
  String correctAns = 'A';
  static const opts = ['A', 'B', 'C', 'D'];
  final question = TextEditingController();
  final optControllers = opts.map((e) => TextEditingController()).toList();

  @override
  void dispose() {
    question.dispose();
    for (TextEditingController c in optControllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// Container holds both the question number and the option radios
    /// to give them padding as a whole

    // TODO: Save the options in an attribute
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      height: 530,
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
            width: 400, child: getPaddedText('Question', controller: question)),
        for (int i = 0; i < opts.length; i++)
          SizedBox(
            child: Row(children: [
              Text('${opts[i]})'),
              SizedBox(
                width: 300,
                child: getPaddedText('Option ${opts[i]}',
                    controller: optControllers[i], outlineborder: false),
              ),
            ]),
          ),
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Correct Option:'),
            ),
            SizedBox(
              width: 30,
              child: DropdownButton<String>(
                value: correctAns,
                icon: const Icon(Icons.arrow_circle_down, size: 18),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    correctAns = newValue!;
                  });
                },
                items: <String>['A', 'B', 'C', 'D']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ],
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
