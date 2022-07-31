import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/icon_data.dart';
import 'package:smart_shala/login.dart';
import 'package:smart_shala/ocr.dart';
import 'package:smart_shala/test.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  final screens = [
    testpage(),
    ocrpage(),
    addtestpage(),
    LoginView(),
  ];
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Bottom navbar'),
          centerTitle: true,
        ),
        body: IndexedStack(
          index: currentIndex,
          children: screens,
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white60,
          iconSize: 30,
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
          items: [
            BottomNavigationBarItem(
              icon: (Icons.home),
              label: 'Home',
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: (Icons.favorite),
              label: 'tests',
              backgroundColor: Colors.green,
            ),
            BottomNavigationBarItem(
              icon: (Icons.chat),
              label: 'ocr',
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: (Icons.add),
              label: 'addtest',
              backgroundColor: Colors.green,
            ),
            BottomNavigationBarItem(
              icon: (Icons.person),
              label: 'login',
              backgroundColor: Colors.blue,
            ),
          ],
        ),
      );
}
