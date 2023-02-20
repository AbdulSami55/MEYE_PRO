// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

Text student_text(BuildContext context, String text, double size,
    {Color? color}) {
  return Text(
    text,
    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
        color: color ?? Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: size),
  );
}
