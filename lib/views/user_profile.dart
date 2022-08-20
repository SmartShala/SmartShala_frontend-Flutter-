import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  @override
  void initState() {
    _getUserDetails();
    super.initState();
  }

  void _getUserDetails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      _username = sharedPreferences.getString('name');
      _contact = sharedPreferences.getInt('contact');
      _email = sharedPreferences.getString('email');
      _teacherId = sharedPreferences.getString('teacher_id');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.redAccent,
          child: IconButton(
            onPressed: () {

            },
            icon: const Icon(Icons.logout),
          )),
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
