import 'package:flutter/material.dart';
import 'package:smart_shala/views/dash.dart';
import 'package:smart_shala/views/edgedetection.dart';
import 'package:smart_shala/views/home.dart';
import 'package:smart_shala/views/login.dart';
import 'package:smart_shala/views/main_view.dart';
import 'package:smart_shala/views/register.dart';

const loginRoute = "/login/";
const registerRoute = "/register/";
const mainpageRoute = "/main/";
const testdashRoute = "/testdash/";
const createtestRoute = "/createtest/";
const homeRoute = '/home/';
const scanRoute = '/edgecamera/';
const baseurl = "http://parikshana.smartshala.live/api";


class RouteGenerator{
  static Route<dynamic>? generateRoute(RouteSettings settings){
    final args = settings.arguments;
    switch(settings.name){
      case loginRoute:
      return MaterialPageRoute(builder: (_) => const LoginView());
      case registerRoute:
      return MaterialPageRoute(builder: (_) => const RegisterView());
      case mainpageRoute:
      return MaterialPageRoute(builder: (_) => const MainPage());
      case testdashRoute:
      return MaterialPageRoute(builder: (_) => const Dashboard(title:'Dashboard'));
      case homeRoute:
      return MaterialPageRoute(builder: (_) => const HomePage());
      case scanRoute:
      if (args is String){
      return MaterialPageRoute(builder: (_) =>  EgeCam(testID: args,));
      }
    }
    return null;
  }
}