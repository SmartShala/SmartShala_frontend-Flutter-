import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import '../api/result_api.dart';
import '../models/resultmodel.dart';

class ResultView extends StatefulWidget {
  const ResultView({Key? key, required this.testID}) : super(key: key);
  final String testID;
  @override
  State<ResultView> createState() => _ResultViewState();
}

class _ResultViewState extends State<ResultView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 1, 21, 37),
        title: const Text("Results"),
      ),
      body: FutureBuilder<List<ResultModel>>(
        future: fetchresults(http.Client(), widget.testID),
        builder: (context, snapshot) {
          print(snapshot);
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return Resultlist(results: snapshot.data!);
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

class Resultlist extends StatelessWidget {
  const Resultlist({super.key, required this.results});

  final List<ResultModel> results;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      // Let the ListView know how many items it needs to build.
      itemCount: results.length,
      // Provide a builder function. This is where the magic happens.
      // Convert each item into a widget based on the type of item it is.
      itemBuilder: (context, index) {
        final item = results[index];
        return Center(
          child: Container(
            height: 120.0,
            width: 400.0,
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              border: Border.all(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text("Id:${item.id}",
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                          color: const Color.fromARGB(255, 2, 25, 44))),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(item.status,
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(color: Colors.white)),
                ]),
                const SizedBox(
                  height: 25,
                ),
                Text('Score:${item.score}',
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(color: Colors.white)),
              ],
            ),
          ),
        );
      },
    );
  }
}
