import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../widget/mybutton.dart';
import '../../../widget/mytextfield.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Email",
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
        mytextfiled("assets/icons/emilicon.png", email, false),
        const Text(
          "Password",
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
        mytextfiled("assets/icons/pass.png", password, true),
        mybutton(() {}, "Sign In", CupertinoIcons.arrow_right),
      ],
    );
  }
}
