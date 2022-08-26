import 'package:flutter/material.dart';
import 'package:smart_shala/views/classes.dart';
import 'package:smart_shala/views/dash.dart';
import 'package:smart_shala/views/addtest.dart';
import 'package:smart_shala/views/edgedetection.dart';
import 'package:smart_shala/views/home.dart';
import 'package:smart_shala/views/login.dart';
import 'package:smart_shala/views/login_student.dart';
import 'package:smart_shala/views/logoptions.dart';
import 'package:smart_shala/views/main_view.dart';
import 'package:smart_shala/views/register.dart';
import 'package:smart_shala/views/result.dart';
import 'package:smart_shala/views/studentdash.dart';
import 'package:smart_shala/views/subjects.dart';

import '../views/sub.dart';

const loginRoute = "/login/";
const loginoptRoute = "/logoption/";
const registerRoute = "/register/";
const mainpageRoute = "/main/";
const testdashRoute = "/testdash/";
const createtestRoute = "/createtest/";
const addtestRoute = '/addtest/';
const homeRoute = '/home/';
const scanRoute = '/edgecamera/';
const subRoute = '/subs/';
const resultRoute = '/result/';
const classRoute = '/class/';
const subjectRoute = '/subject';
const studentloginRoute = '/studentlogin/';
const studashRoute = '/studentdash/';
const loginstuRoute = '/logstud/';
const baseurl = "http://parikshana.smartshala.live/api";

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case loginoptRoute:
        return MaterialPageRoute(builder: (_) => const PrevLogin());
      case loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case loginstuRoute:
        return MaterialPageRoute(builder: (_) => const LoginstudentView());
      case registerRoute:
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case mainpageRoute:
        return MaterialPageRoute(builder: (_) => const MainPage());
      case addtestRoute:
        return MaterialPageRoute(builder: (_) => const TestDetails());
      case testdashRoute:
        return MaterialPageRoute(
            builder: (_) => const Dashboard(title: 'Dashboard'));
      case classRoute:
        return MaterialPageRoute(builder: (_) => const ClassDetails());
      case homeRoute:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case scanRoute:
        if (args is String) {
          return MaterialPageRoute(
              builder: (_) => EgeCam(
                    testID: args,
                  ));
        }
        break;
      case subRoute:
        if (args is int) {
          return MaterialPageRoute(
              builder: (_) => Subjectdetails(
                    id: args,
                  ));
        }
        break;
      case resultRoute:
        if (args is String) {
          return MaterialPageRoute(
              builder: (_) => ResultView(
                    testID: args,
                  ));
        }
        break;
      case subjectRoute:
        return MaterialPageRoute(builder: (_) => const SubjectDetails());
      case studentloginRoute:
        return MaterialPageRoute(builder: (_) => const LoginstudentView());
      case studashRoute:
        return MaterialPageRoute(builder: (_) => const StudentDash());
    }
    return null;
  }
}
