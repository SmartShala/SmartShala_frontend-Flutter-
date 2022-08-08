import 'package:flutter/material.dart';

// ignore: camel_case_types
class testpage extends StatefulWidget {
  const testpage({Key? key}) : super(key: key);
  @override
  _testpageState createState() => _testpageState();
}

// ignore: camel_case_types
class _testpageState extends State<testpage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(children: <Widget>[
        Container(
            height: size.height * 2,
            decoration: const BoxDecoration(
              image:
                  DecorationImage(image: AssetImage('assets/images/head.png')),
            )),
        SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(children: <Widget>[
                  SizedBox(
                    height: 64,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CircleAvatar(
                            radius: 32,
                            child: Image.asset("assets/images/usericon.png")),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const <Widget>[
                            Text('Hi User!'),
                          ],
                        )
                      ],
                    ),
                  ),
                ])))
      ]),
    );
  }
}

// class testpage extends StatefulWidget {
//   const testpage({key key}) : super(key: key);
//   @override
//   _testpageState createState() => _testpageState();
// }

// class key {}

// class _testpageState extends State<testpage> {
//   @override
//   Widget build(BuildContext context) {
//     final double height = MediaQuery.of(context).size.height;
//     final double width = MediaQuery.of(context).size.width;
//     return Scaffold(backgroundColor: Colors.white, body: Column());
//   }
// }

