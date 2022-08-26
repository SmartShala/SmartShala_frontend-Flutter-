// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/routes.dart';
import '../api/login_api.dart';
import '../progress_hud.dart';
import '../models/login_model.dart';
import '../utils/validators.dart' as valid;
import '../api/getuser_api.dart';

/*

get email and password from user
hit api with these
get refresh and access token
store in shared_prefs

*/

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool _isApiCallInProgress = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      inAsyncCall: _isApiCallInProgress,
      opacity: 0.3,
      child: _uiSetup(context),
    );
  }

  Widget _uiSetup(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          // padding: const EdgeInsets.only(left: 35, top: 130),
          height: MediaQuery.of(context).size.height * 1.0,
          width: MediaQuery.of(context).size.width * 1.0,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [Colors.blue, Color.fromARGB(255, 255, 255, 255)],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          )),
          // child: Image.asset(
          //   "images/log_img.png",
          // )
        ),
        SingleChildScrollView(
          child: Container(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Image.asset(
                "images/teacher_logo.png",
              ),
              const SizedBox(height: 50),
              Container(
                margin: const EdgeInsets.only(left: 35, right: 35),
                child: Form(
                  key: _formkey,
                  child: Column(children: [
                    TextFormField(
                      controller: _emailCtrl,
                      validator: valid.isEmail,
                      style: const TextStyle(color: Colors.black),
                      autocorrect: false,
                      decoration: _getDecor('Email'),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      validator: valid.isShort,
                      controller: _passCtrl,
                      autocorrect: false,
                      obscureText: true,
                      decoration: _getDecor('Password'),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Sign in',
                          style: TextStyle(
                              fontSize: 27, fontWeight: FontWeight.w700),
                        ),
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: const Color(0xff4c505b),
                          child: IconButton(
                              color: Colors.white,
                              onPressed: loginCallback,
                              icon: const Icon(
                                Icons.arrow_forward,
                              )),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(registerRoute);
                            },
                            child: const Text(
                              'Don\'t have an account? Sign Up',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Color(0xff4c505b),
                                  fontSize: 18),
                            ),
                          ),
                        ]),
                  ]),
                ),
              ),
            ]),
          ),
        ),
      ]),
    );
  }

  void loginCallback() {
    if (_formkey.currentState!.validate()) {
      setState(() {
        _isApiCallInProgress = true;
      });

      LoginApi loginApi = LoginApi();
      loginApi
          .login(LoginRequestModel(
              email: _emailCtrl.text.trim(), password: _passCtrl.text))
          .then((value) async {
        setState(() {
          _isApiCallInProgress = false;
        });
        if (value.access.isNotEmpty) {
          final SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          sharedPreferences.setString('access', value.access);
          sharedPreferences.setString('refresh', value.refresh);
          _setUserDetails(value.access, sharedPreferences);

          if (!mounted) return;
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Login Successful')));
          Navigator.of(context)
              .pushNamedAndRemoveUntil(mainpageRoute, (route) => false);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('User not registered')));
        }
      });
    }
  }

  void _setUserDetails(
      String accessToken, SharedPreferences sharedPreferences) {
    final GetUserApi getUserApi = GetUserApi();
    getUserApi.getUser(accessToken).then((value) {
      sharedPreferences.setString('name', value.name ?? "null");
      sharedPreferences.setInt('contact', value.contact!);
      sharedPreferences.setString('email', value.email ?? "null");
      sharedPreferences.setString('teacher_id', value.teacherId ?? "null");
    });
  }

  static InputDecoration _getDecor(String label) {
    return InputDecoration(
        fillColor: Color.fromARGB(249, 245, 245, 245),
        filled: true,
        hintText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ));
  }
}
