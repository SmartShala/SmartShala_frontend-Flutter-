import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:smart_shala/Views/camera.dart';
import 'package:smart_shala/Views/dash.dart';
import 'package:smart_shala/Views/home.dart';
import 'Views/login.dart';
import 'Views/register.dart';
import 'Views/main_view.dart';

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
  final cameras = await availableCameras();

  // // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;
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
      '/hom/': (context) => const Homepage_view(),
      '/camera/': (context) => TakePictureScreen(camera: firstCamera)
    },
  ));
}
