// ignore_for_file: non_constant_identifier_names

import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

Center ErrorMessage(String error) {
  return Center(
      child: Text(
    error,
    style: GoogleFonts.bebasNeue(fontSize: 30),
  ));
}
