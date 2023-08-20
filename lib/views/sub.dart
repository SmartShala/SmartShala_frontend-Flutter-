import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/substd_api.dart';

class SubjectDetails extends StatefulWidget {
  const SubjectDetails({Key? key}) : super(key: key);
  @override
  State<SubjectDetails> createState() => _SubjectDetailsState();
}

class _SubjectDetailsState extends State<SubjectDetails> {
  int? standard;
  int? subject;
  String? _accessToken;
  List<List<int>>? standards;
  List<List<dynamic>>? subjects;

  @override
  void initState() {
    _getSubAndStd();
    super.initState();
  }

  void _getSubAndStd() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _accessToken = sharedPreferences.getString('access');
    SubAndStdApi substdapi = SubAndStdApi();
    await substdapi.getdata(_accessToken!).then((value) {
      setState(() {
        standards = value.standards;
        subjects = value.subjects;
      });
      log(standards.toString());
      log(subjects.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Subjects"),
          backgroundColor: const Color.fromARGB(255, 3, 37, 1),
        ),
        body: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: subjects?.length,
          itemBuilder: (context, index) {
            final item = subjects?[index];
            return Center(
              child: Container(
                height: 100.0,
                width: 420.0,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 4, 22, 31),
                  border: Border.all(
                    color: const Color.fromARGB(255, 243, 241, 241),
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(item?[1],
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: const Color.fromARGB(255, 255, 255, 255))),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
