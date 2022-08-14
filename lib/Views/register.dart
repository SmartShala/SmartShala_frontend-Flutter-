import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
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
              ))),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 35, right: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Create\nAccount',
                style: TextStyle(color: Colors.white, fontSize: 33),
              ),
              const SizedBox(
                height: 35,
              ),
              TextField(
                style: const TextStyle(color: Colors.white),
                controller: _nameCtrl,
                decoration: _getDecor('Name'),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                style: const TextStyle(color: Colors.white),
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                controller: _emailCtrl,
                decoration: _getDecor('Email'),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.phone,
                controller: _contactCtrl,
                decoration: _getDecor('Contact'),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                style: const TextStyle(color: Colors.white),
                controller: _teacherIdCtrl,
                decoration: _getDecor('Teacher ID'),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                autocorrect: false,
                style: const TextStyle(color: Colors.white),
                obscureText: true,
                controller: _passwordCtrl,
                decoration: _getDecor('Password'),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/login/', (route) => false);
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
            ],
          ),
        ),
      ),
    );
  }

  void registerCallback() {}

  static InputDecoration _getDecor(String label) {
    return InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.black,
          ),
        ),
        hintText: label,
        hintStyle: const TextStyle(color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ));
  }
}
