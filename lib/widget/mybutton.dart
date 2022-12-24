import 'package:flutter/material.dart';

Padding mybutton(dynamic func, String text, IconData icon) {
  return Padding(
    padding: const EdgeInsets.only(top: 8, bottom: 24),
    child: ElevatedButton.icon(
      onPressed: func,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green[400],
        minimumSize: const Size(double.infinity, 56),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(25),
            bottomRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
          ),
        ),
      ),
      icon: Icon(
        icon,
        color: Colors.greenAccent,
      ),
      label: Text(text),
    ),
  );
}
