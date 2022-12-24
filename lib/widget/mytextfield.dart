import 'package:flutter/material.dart';

Padding mytextfiled(
    String img, TextEditingController controller, bool obsecure) {
  return Padding(
    padding: const EdgeInsets.only(top: 8, bottom: 16),
    child: TextFormField(
      obscureText: obsecure,
      controller: controller,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300, width: 2.0),
        ),
        border: const OutlineInputBorder(),
        prefixIcon: img != ""
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Image.asset(img),
              )
            : null,
      ),
    ),
  );
}
