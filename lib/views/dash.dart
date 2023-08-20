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
            height: MediaQuery.of(context).size.height * 1.0,
            width: MediaQuery.of(context).size.width * 1.0,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [Colors.blue, Color.fromARGB(255, 255, 255, 255)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(item.subject,
                      style: const TextStyle(
                        fontSize: 50.0,
                        fontWeight: FontWeight.w500,
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(item.topic,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400,
                      )),
                  const SizedBox(
                    height: 25,
                  ),
                  Text('Class:${item.forClass}',
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                          color: const Color.fromARGB(255, 20, 20, 20))),
                  const SizedBox(
                    height: 100,
                  ),
                  Container(
                    // height: 300,
                    // width: 300,
                    padding: const EdgeInsets.all(64),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    child: IconButton(
                        iconSize: 150.0,
                        onPressed: (() {
                          // Navigator.pushNamed(context, '/edgecamera/');
                          Navigator.of(context).pushNamed(
                            scanRoute,
                            arguments: (item.testid).toString(),
                          );
                        }),
                        icon: Image.asset(
                          'images/SCAN.jpg',
                        )),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
