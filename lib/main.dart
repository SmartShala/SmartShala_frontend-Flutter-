import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:smart_shala/Views/dash.dart';
import 'package:smart_shala/Views/home.dart';
import 'Views/login.dart';
import 'Views/register.dart';
import 'Views/main_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: AnimatedSplashScreen(
      duration: 1500,
      splashIconSize: 300,
      splashTransition: SplashTransition.fadeTransition,
      splash: Center(
        child: Image.asset('images/logo.jpeg'),
      ),
      nextScreen: const LoginView(),
    ),
    routes: {
      '/login/': (context) => const LoginView(),
      '/register/': (context) => const RegisterView(),
      '/mainpage/': (context) => const MainPage(),
      '/dashboard/': (context) => const Dashboard(title: "Dashboard"),
      '/home': (context) => const Homepage_view()
    },
  ));
}
