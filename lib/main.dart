import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:camera/camera.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'views/dash.dart';
import 'views/home.dart';
import 'views/edgedetection.dart';
import 'views/login.dart';
import 'views/register.dart';
import 'views/main_view.dart';

Future<CameraDescription> cam() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;
  return firstCamera;
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // get login instance
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  var accessToken = sharedPreferences.getString('access');

  // // Get a specific camera from the list of available cameras.
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
      // if logged in, redirect to main page, else to login page
      nextScreen: (accessToken != null && accessToken.isNotEmpty)
          ? const MainPage()
          : const LoginView(),
    ),
    routes: {
      '/login/': (context) => const LoginView(),
      '/register/': (context) => const RegisterView(),
      '/mainpage/': (context) => const MainPage(),
      '/dashboard/': (context) => const Dashboard(title: "Dashboard"),
      '/home/': (context) => const HomePage(),
      '/edgecamera/': (context) => const EgeCam(),
    },
  ));
}
