import 'dart:developer';
import 'dart:async';
import 'package:flutter/material.dart';
import '../constants/routes.dart';
import '../api/register_api.dart';
import '../models/register_model.dart';
import '../progress_hud.dart';
import '../utils/validators.dart' as valid;

/*

get name, email, contact, teacher id, pass from user
hit api with these
if success, show snackbar and ask to sign in
if failed, show fail message

*/

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _contactCtrl = TextEditingController();
  final TextEditingController _teacherIdCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();

  final _formkey = GlobalKey<FormState>();
  bool _isApiCallInProgress = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _contactCtrl.dispose();
    _teacherIdCtrl.dispose();
    _passwordCtrl.dispose();
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
      backgroundColor: Colors.brown,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff4c505b),
        onPressed: () {},
        child: IconButton(
          color: Colors.white,
          onPressed: registerCallback,
          icon: const Icon(
            Icons.arrow_forward,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 35, right: 35),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              'Create\nAccount',
              style: TextStyle(color: Colors.white, fontSize: 33),
            ),
            const SizedBox(
              height: 35,
            ),
            Form(
                key: _formkey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: valid.isShort,
                      style: const TextStyle(color: Colors.white),
                      controller: _nameCtrl,
                      decoration: _getDecor('Name'),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      validator: valid.isEmail,
                      style: const TextStyle(color: Colors.white),
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailCtrl,
                      decoration: _getDecor('Email'),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      validator: valid.isPhone,
                      style: const TextStyle(color: Colors.white),
                      keyboardType: TextInputType.phone,
                      controller: _contactCtrl,
                      decoration: _getDecor('Contact'),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      style: const TextStyle(color: Colors.white),
                      controller: _teacherIdCtrl,
                      decoration: _getDecor('Teacher ID'),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      validator: valid.isShort,
                      autocorrect: false,
                      style: const TextStyle(color: Colors.white),
                      obscureText: true,
                      controller: _passwordCtrl,
                      decoration: _getDecor('Password'),
                    )
                  ],
                )),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(loginRoute, (route) => false);
              },
              style: const ButtonStyle(),
              child: const Text(
                'Sign In',
                textAlign: TextAlign.left,
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.white,
                    fontSize: 18),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  void registerCallback() {
    /// Logic to handle api request callback on button press
    if (_formkey.currentState!.validate()) {
      setState(() {
        _isApiCallInProgress = true;
      });

      RegisterApi register = RegisterApi();
      register
          .register(RegisterRequestModel(
              name: _nameCtrl.text,
              email: _emailCtrl.text,
              password: _passwordCtrl.text,
              contact: int.parse(_contactCtrl.text),
              teacherId: _teacherIdCtrl.text))
          .then(((value) {
        setState(() {
          _isApiCallInProgress = false;
        });
        if (value.id != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('User Created Successfully'),
            ),
          );
          Timer(const Duration(seconds: 2), () {
            setState(() {
              _isApiCallInProgress = true;
            });
          });
          Timer(const Duration(seconds: 3), () {
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/login/', (route) => false);
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Username or contact already exists'),
            ),
          );
          log(value.toJson().toString());
        }
      }));
    }
  }

  static InputDecoration _getDecor(String label) {
    return InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          width: 2,
          color: Colors.grey,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          width: 3,
          color: Colors.white,
        ),
      ),
      hintText: label,
      hintStyle: const TextStyle(color: Colors.white),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
