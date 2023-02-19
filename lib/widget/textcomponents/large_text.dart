// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

Widget large_text(String text, {Color? color}) {
  return Text(
    text,
    style: GoogleFonts.bebasNeue(fontSize: 25, color: color ?? Colors.black),
  );
}
