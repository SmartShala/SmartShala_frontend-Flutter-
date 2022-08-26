import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_shala/constants/routes.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String? _username;
  int? _contact;
  String? _email;
  String? _teacherId;
  SharedPreferences? _sharedPreferences;

  void _getUserDetails() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      _username = _sharedPreferences!.getString('name');
      _contact = _sharedPreferences!.getInt('contact');
      _email = _sharedPreferences!.getString('email');
      _teacherId = _sharedPreferences!.getString('teacher_id');
    });
  }

  Future<void> _clearOnLogout() async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text("Confimation"),
              content: const Text("Are you sure you want to exit?"),
              actions: [
                ElevatedButton(
                    onPressed: () async {
                      await _sharedPreferences!.clear();
                      if (!mounted) return;
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil('/login/', (route) => false);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Successfully Logged Out')));
                    },
                    child: const Text('Sure')),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: const Text('Cancel')),
              ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    _getUserDetails();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.redAccent,
          child: IconButton(
              onPressed: () {
                _clearOnLogout();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(loginoptRoute, (route) => false);
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Successfully Logged Out')));
              },
              icon: const Icon(Icons.logout))),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('User Profile'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(30)),
                  // color: Colors.blue,
                  child: const Icon(
                    Icons.account_circle,
                    color: Colors.white70,
                    size: 90,
                  )),
              const SizedBox(
                height: 40,
              ),
              _buildUserInfoDisplay(_username, 'Name'),
              _buildUserInfoDisplay(_contact?.toString(), 'Phone'),
              _buildUserInfoDisplay(_email, 'Email'),
              _buildUserInfoDisplay(_teacherId, 'Teacher ID'),
            ],
          ),
        ),
      ),
    );
  }

  // Widget builds the display item with the proper
  // formatting to display the user's info
  Widget _buildUserInfoDisplay(String? getValue, String title) => Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 1,
          ),
          Container(
              width: 350,
              height: 40,
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: Colors.grey,
                width: 1,
              ))),
              child: Row(children: [
                Expanded(
                    child: TextButton(
                        onPressed: () {},
                        child: Text(
                          getValue ?? "",
                          style: const TextStyle(fontSize: 16, height: 1.4),
                        ))),
                const Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.grey,
                  size: 40.0,
                )
              ]))
        ],
      ));
}
