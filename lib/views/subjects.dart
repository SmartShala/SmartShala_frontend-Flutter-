import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import '../api/stdtest_api.dart';
import '../constants/routes.dart';
import '../models/dash_testmodel.dart';

class Subjectdetails extends StatefulWidget {
  const Subjectdetails({Key? key, required this.id}) : super(key: key);
  final int id;
  @override
  State<Subjectdetails> createState() => _SubjectdetailsState();
}

class _SubjectdetailsState extends State<Subjectdetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 1, 21, 37),
        title: const Text('Test'),
      ),
      body: FutureBuilder<List<DashTestModel>>(
        future: fetchstdTests(http.Client(), widget.id),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return Testlist(tests: snapshot.data!);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class Testlist extends StatelessWidget {
  const Testlist({super.key, required this.tests});

  final List<DashTestModel> tests;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.horizontal,
      // Let the ListView know how many items it needs to build.
      itemCount: tests.length,
      // Provide a builder function. This is where the magic happens.
      // Convert each item into a widget based on the type of item it is.
      itemBuilder: (context, index) {
        final item = tests[index];
        return Center(
          child: Container(
            height: 640.0,
            width: 370.0,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 125, 223, 248),
              border: Border.all(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Column(
              children: [
                Text(item.subject,
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(color: const Color.fromARGB(255, 2, 25, 44))),
                const SizedBox(
                  height: 20,
                ),
                Text(item.topic,
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: Colors.white)),
                const SizedBox(
                  height: 25,
                ),
                Text('Class:${item.forClass}',
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: Colors.white)),
                const SizedBox(
                  height: 50,
                ),
                IconButton(
                    iconSize: 100,
                    onPressed: (() {
                      // Navigator.pushNamed(context, '/edgecamera/');
                      Navigator.of(context).pushNamed(
                        resultRoute,
                        arguments: (item.testid).toString(),
                      );
                    }),
                    icon: Image.asset(
                      'images/result.png',
                    ))
              ],
            ),
          ),
        );
      },
    );
  }
}
