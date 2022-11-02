// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class MyOutlineButton extends StatelessWidget {
  MyOutlineButton({super.key, required this.text});
  String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.orange),
        borderRadius: BorderRadius.circular(30.0),
      ),
      constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.95, minHeight: 50.0),
      alignment: Alignment.center,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: "Poppins",
          fontSize: 25,
          color: Colors.white,
        ),
      ),
    );
  }
}
