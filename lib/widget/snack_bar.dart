// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

SnackBar snack_bar(String text, bool isgreen) {
  return SnackBar(
    content: Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 15,
        fontFamily: "Poppins",
      ),
    ),
    backgroundColor: isgreen ? Colors.green : Colors.red,
    elevation: 10,
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
  );
}
