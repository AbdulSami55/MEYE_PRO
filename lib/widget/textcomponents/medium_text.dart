// ignore_for_file: non_constant_identifier_names

import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:live_streaming/utilities/constants.dart';

Text text_medium(String text, {Color? color}) {
  return Text(
    text,
    style: GoogleFonts.poppins(
        fontSize: 17, textStyle: TextStyle(color: color ?? shadowColorDark)),
  );
}
