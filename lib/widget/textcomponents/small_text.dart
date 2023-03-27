import 'package:flutter/material.dart';

Text textSmall(String text, {Color? color}) {
  return Text(
    text,
    style: TextStyle(
      color: color ?? Colors.black54,
    ),
  );
}
