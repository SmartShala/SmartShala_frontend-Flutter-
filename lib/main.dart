import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'constants/routes.dart';
import 'views/login.dart';
import 'views/main_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
   // final cameras = await availableCameras();
 
  // get login instance
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  var accessToken = sharedPreferences.getString('access');

  // // Get a specific camera from the list of available cameras.
  // final firstCamera = cameras.first;
  runApp(MaterialApp(
    title: 'SmartShala',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: AnimatedSplashScreen(
      duration: 1500,
      splashIconSize: 300,
      splashTransition: SplashTransition.fadeTransition,
      splash: Center(
        child: Image.asset('images/logo.png'),
      ),
      // if logged in, redirect to main page, else to login page
      nextScreen: (accessToken != null && accessToken.isNotEmpty)
          ? const MainPage()
          : const LoginView(),
    ),
   onGenerateRoute: RouteGenerator.generateRoute,
  ));
}
