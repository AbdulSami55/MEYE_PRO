// ignore_for_file: non_constant_identifier_names, prefer_final_fields, must_be_immutable

import 'package:flutter/material.dart';
import 'package:live_streaming/Screens/signup.dart';
import 'package:live_streaming/widget/button.dart';
import 'package:live_streaming/widget/outlinedbutton.dart';
import 'package:live_streaming/widget/textfield.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  TextEditingController _Email = TextEditingController();
  TextEditingController _Password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.orange,
          title: const Text(
            'Sign In',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: "Poppins",
              fontSize: 30,
              color: Colors.white,
            ),
          ),
        ),
        body: CustomScrollView(slivers: [
          SliverToBoxAdapter(
              child: Column(children: [
            Stack(
              children: <Widget>[
                Opacity(
                  opacity: 0.5,
                  child: ClipPath(
                    clipper: WaveClipper(),
                    child: Container(
                      color: Colors.orangeAccent,
                      height: 200,
                    ),
                  ),
                ),
                ClipPath(
                  clipper: WaveClipper(),
                  child: Container(
                      padding: const EdgeInsets.only(bottom: 50),
                      color: Colors.orange,
                      height: 180,
                      alignment: Alignment.center,
                      child: const Text(
                        "MEYE PRO",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins",
                          fontSize: 40,
                          color: Colors.white,
                        ),
                      )),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            MyTextField(
              controller: _Email,
              labelText: "User ID",
              hintText: "User ID",
              ispassword: false,
            ),
            MyTextField(
              controller: _Password,
              labelText: "Password",
              hintText: "Password",
              ispassword: true,
            ),
            const SizedBox(
              height: 15,
            ),
            InkWell(
                onTap: () {},
                child: MyButton(
                  text: "Login",
                )),
            const SizedBox(
              height: 20,
            ),
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => const Signup()));
                },
                child: MyOutlineButton(
                  text: "Register Now",
                ))
          ]))
        ]));
  }
}

//Costom CLipper class with Path
class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);

    var firstStart = Offset(size.width / 5, size.height);
    var firstEnd = Offset(size.width / 2.25, size.height - 50.0);
    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);

    var secondStart =
        Offset(size.width - (size.width / 3.24), size.height - 105);
    var secondEnd = Offset(size.width, size.height - 10);
    path.quadraticBezierTo(
        secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false; //if new instance have different instance than old instance
    //then you must return true;
  }
}
