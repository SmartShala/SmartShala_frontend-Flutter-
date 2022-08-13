import 'dart:async';
import 'dart:convert';
// import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Upcoming>> fetchTests(http.Client client) async {
  Map<String, String> requestHeaders = {
    'X-Master-key':
        '\$2b\$10\$AhFzro77.S6nmUO2cjhv8uFocHLETdLHfKaKHFCrkXO8sMJ/dW1WC',
  };
  final response = await client.get(
      Uri.parse('https://api.jsonbin.io/v3/b/62eff5095c146d63ca634aea'),
      headers: requestHeaders
      // Uri.parse('https://jsonplaceholder.typicode.com/photos'),
      );
  // print(response.body);
  // Use the compute function to run parseTests in a separate isolate.
  // print(response);
  print(response.body);
  return compute(parseTests, response.body);
}

// A function that converts a response body into a List<Photo>.
List<Upcoming> parseTests(String responseBody) {
  final parsed =
      (jsonDecode(responseBody)['record']).cast<Map<String, dynamic>>();
  return parsed.map<Upcoming>((json) => Upcoming.fromJson(json)).toList();
}

class Upcoming {
  final int teacherid;
  final String subject;
  final String forClass;
  final String topic;

  const Upcoming({
    required this.teacherid,
    required this.subject,
    required this.forClass,
    required this.topic,
  });

  factory Upcoming.fromJson(Map<String, dynamic> json) {
    return Upcoming(
      teacherid: json['teacherid'] as int,
      subject: json['Subject'] as String,
      forClass: json['class'] as String,
      topic: json['topic'] as String,
    );
  }
}

// void main() => runApp(const MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     const appTitle = 'Isolate Demo';

//     return const MaterialApp(
//       title: appTitle,
//       home: Dashboard(title: appTitle),
//     );
//   }
// }

class Dashboard extends StatelessWidget {
  const Dashboard({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 1, 21, 37),
        title: Text(title),
      ),
      body: FutureBuilder<List<Upcoming>>(
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

  final List<Upcoming> tests;

  @override
  Widget build(BuildContext context) {
    // return GridView.builder(
    //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //     crossAxisCount: 2,
    //   ),
    //   itemCount: tests.length,
    //   itemBuilder: (context, index) {
    //     return Text(tests[index].subject);
    //   },
    // );
    return PageView.builder(
      scrollDirection: Axis.horizontal,
      // shrinkWrap: true,
      // Let the ListView know how many items it needs to build.
      itemCount: tests.length,
      // Provide a builder function. This is where the magic happens.
      // Convert each item into a widget based on the type of item it is.
      itemBuilder: (context, index) {
        final item = tests[index];
        return Center(
          child: Container(
            height: 570.0,
            width: 400.0,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 8, 216, 231),
              border: Border.all(
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Column(
              children: [
                Text(item.subject,
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(color: Colors.white)),
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
              ],
            ),
          ),
        );
      },
    );
  }
}
