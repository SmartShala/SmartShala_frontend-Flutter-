import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Home')),
        body: Column(
          children: [
            Image.asset('images/home_bg.gif'),
            const SizedBox(height: 30),
            _buildButton("images/classes.jpg", "Classes"),
            _buildButton("images/subjects.png", "Subjects"),
            _buildButton("images/results.png", "Test results"),
          ],
        ));
  }

  Widget _buildButton(String imagePath, String title) => Padding(
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
                    onPressed: () {},
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
