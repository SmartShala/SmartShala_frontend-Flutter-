import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constants/routes.dart';
import '../api/dash_test_api.dart';
import '../models/dash_testmodel.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 1, 21, 37),
        title: Text(title),
      ),
      body: FutureBuilder<List<DashTestModel>>(
        future: fetchTests(http.Client()),
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
    if (tests.isEmpty) {
      return Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Oops! No test found."),
          TextButton(
            onPressed: (() {}),
            child: const Text("Create a test"),
          )
        ],
      ));
    }
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
              color: Colors.blueGrey,
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
                        scanRoute,
                        arguments: (item.testid).toString(),
                      );
                    }),
                    icon: Image.asset(
                      'images/scan-page-512.jpg',
                    ))
              ],
            ),
          ),
        );
      },
    );
  }
}
