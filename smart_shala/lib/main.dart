import 'package:flutter/material.dart';
import 'package:smart_shala/dash.dart';
import './login.dart';
import './register.dart';
import './home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const Dashboard(title: "Dashboard"),
    routes: {
      '/login/': (context) => const LoginView(),
      '/register/': (context) => const RegisterView(),
      '/home/': (context) => const MainPage(),
      '/dashboard/': (context) => const Dashboard(title: "Dashboard")
    },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const LoginView();
  }
}
