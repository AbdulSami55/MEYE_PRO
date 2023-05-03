// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:live_streaming/utilities/constants.dart';
import 'package:live_streaming/view_models/signin_view_model.dart';
import 'package:live_streaming/widget/progress_indicator.dart';
import 'package:live_streaming/widget/snack_bar.dart';
import 'package:provider/provider.dart';
import '../../../widget/mybutton.dart';
import '../../../widget/mytextfield.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    return Consumer<SignInViewModel>(
        builder: ((context, provider, child) =>
            _ui(provider, context, email, password)));
  }

  Widget _ui(SignInViewModel provider, BuildContext context,
      TextEditingController email, TextEditingController password) {
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
        mybutton(() async {
          if (email.text.isNotEmpty && password.text.isNotEmpty) {
            showLoaderDialog(context, "Signin....");
            var response = await provider.signin(email.text, password.text);
            if (response == "done") {
              Navigator.pop(context);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                  snack_bar(provider.userError!.message.toString(), false));
              provider.setloading(false);
            } else {
              Navigator.pop(context);
              if (provider.user.role == "Admin") {
                context.go(routesAdminBottomNavBar);
              } else if (provider.user.role == "Teacher") {
                context.go(routesTeacherBottomNavBar);
              } else if (provider.user.role == "Student") {
                context.go(routesStudentDashboard);
              } else if (provider.user.role == "Director") {
                context.go(routesDirectorDashboard);
              }
            }
          } else {
            Navigator.pop(context);
            ScaffoldMessenger.of(context)
                .showSnackBar(snack_bar("Fill all fields..", false));
            provider.setloading(false);
          }
        }, "Sign In", CupertinoIcons.arrow_right),
      ],
    );
  }
}
