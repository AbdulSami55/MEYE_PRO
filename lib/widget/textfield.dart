// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:velocity_x/velocity_x.dart';

class MyTextField extends StatelessWidget {
  MyTextField(
      {super.key,
      this.labelText,
      this.hintText,
      required this.controller,
      required this.ispassword});

  String? labelText;
  String? hintText;
  TextEditingController? controller;
  bool? ispassword;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: VxTextField(
        controller: controller,
        labelText: labelText,
        hint: hintText,
        borderType: VxTextFieldBorderType.roundLine,
        isPassword: ispassword!,
      ),
    );
  }
}
