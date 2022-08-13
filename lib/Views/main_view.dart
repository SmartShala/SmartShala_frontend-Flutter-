import 'package:flutter/material.dart';
import 'package:smart_shala/Views/dash.dart';
import 'package:smart_shala/Views/home.dart';

import 'package:smart_shala/Views/login.dart';
import 'package:smart_shala/Views/ocr.dart';
import 'package:smart_shala/Views/test.dart';
import 'addtest.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  final screens = [
    // testpage(),
    // const LoginView(),
    const Homepage_view(),
    const Dashboard(title: 'Dashboard'),
    const OcrPage(),
    const TestDetails(),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
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
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.article),
              label: 'Tests',
              backgroundColor: Colors.green,
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.camera_outlined),
                label: 'OCR',
                backgroundColor: Colors.blue),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Add Test',
              backgroundColor: Colors.green,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Login',
              backgroundColor: Colors.blue,
            ),
          ],
        ),
      );
}
