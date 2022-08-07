import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/icon_data.dart';
import 'package:smart_shala/dash.dart';

import 'package:smart_shala/login.dart';
import 'package:smart_shala/ocr.dart';
import 'package:smart_shala/test.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  final screens = [
    //testpage(),
    // const Dashboard(),
    // ocrpage(),
    //addtestpage(),
    // const LoginView(),
  ];
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          centerTitle: true,
        ),
        body: IndexedStack(
          index: currentIndex,
          // children: screens,
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white60,
          iconSize: 30,
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.article),
              label: 'tests',
              backgroundColor: Colors.green,
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                label: 'ocr',
                backgroundColor: Colors.blue),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'addtest',
              backgroundColor: Colors.green,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'login',
              backgroundColor: Colors.blue,
            ),
          ],
        ),
      );
}
