import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:smart_shala/constants/routes.dart';

class PrevLogin extends StatelessWidget {
  const PrevLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: (Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Choose your Role",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  border: Border.all(
                      width: 5, color: Color.fromARGB(255, 153, 149, 149)),
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                child: IconButton(
                    icon: Image.asset("images/teacher.png"),
                    iconSize: 150.0,
                    onPressed: (() {
                      Navigator.pushNamed(context, loginRoute);
                    })),
              ),
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  border: Border.all(
                      width: 5, color: Color.fromARGB(255, 153, 149, 149)),
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                child: IconButton(
                    icon: Image.asset("images/student.png"),
                    iconSize: 150.0,
                    onPressed: (() {
                      Navigator.pushNamed(context, loginstuRoute);
                    })),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
