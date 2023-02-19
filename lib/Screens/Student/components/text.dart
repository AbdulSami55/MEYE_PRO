import 'package:flutter/material.dart';

Text student_text(BuildContext context, String text, double size) {
  return Text(
    text,
    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
        color: Colors.black, fontWeight: FontWeight.bold, fontSize: size),
  );
}
