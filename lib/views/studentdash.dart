import 'package:flutter/material.dart';

import '../constants/routes.dart';

class StudentDash extends StatefulWidget {
  const StudentDash({Key? key}) : super(key: key);

  @override
  State<StudentDash> createState() => _StudentDashState();
}

class _StudentDashState extends State<StudentDash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          backgroundColor: const Color.fromARGB(255, 3, 19, 32),
        ),
        body: Column(
          children: [
            Image.asset('images/candidatedash.gif'),
            const SizedBox(height: 30),
            _buildButton("images/classes.jpg", "Classes", classRoute),
            _buildButton("images/subjects.png", "Subjects", subjectRoute),
            _buildButton("images/results.png", "Test results", classRoute),
          ],
        ));
  }

  Widget _buildButton(String imagePath, String title, String route) => Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          width: 350,
          height: 40,
          decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(
            color: Colors.grey,
            width: 1,
          ))),
          child: Row(children: [
            Image.asset(imagePath),
            Expanded(
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(route);
                    },
                    child: Text(
                      title,
                      style: const TextStyle(fontSize: 16, height: 1.4),
                    ))),
            const Icon(
              Icons.keyboard_arrow_right,
              color: Colors.grey,
              size: 40.0,
            )
          ])));
}
