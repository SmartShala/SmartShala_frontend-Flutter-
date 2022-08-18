import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/login_api.dart';
import '../progress_hud.dart';
import '../models/login_model.dart';
import '../utils/validators.dart' as valid;

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
      backgroundColor: Colors.blueAccent,
      body: Stack(children: [
        Container(
          padding: const EdgeInsets.only(left: 35, top: 130),
          child: const Text(
            'Welcome\nBack',
            style: TextStyle(color: Colors.white, fontSize: 33),
          ),
        ),
        SingleChildScrollView(
          child: Container(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.5),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                              Navigator.pushNamed(context, '/register/');
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
          .then((value) {
        setState(() {
          _isApiCallInProgress = false;
        });
        if (value.access.isNotEmpty) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Login Successful')));
          Navigator.of(context).pushReplacementNamed('/mainpage/');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('User not registered')));
        }
      });
    }
  }

  static InputDecoration _getDecor(String label) {
    return InputDecoration(
        fillColor: Colors.grey.shade100,
        filled: true,
        hintText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ));
  }
}
