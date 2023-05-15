import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utilities/constants.dart';

SliverAppBar appbar(String text,
    {bool? automaticallyImplyLeading, bool? isGreen, Color? bgColor}) {
  return SliverAppBar(
    automaticallyImplyLeading: automaticallyImplyLeading ?? true,
    foregroundColor: isGreen != null ? backgroundColorLight : shadowColorDark,
    backgroundColor:
        bgColor ?? (isGreen != null ? primaryColor : backgroundColor),
    snap: false,
    pinned: true,
    floating: false,
    title: Text(
      text,
      style: GoogleFonts.poppins(
          fontSize: 25,
          color: isGreen != null ? backgroundColorLight : shadowColorDark),
    ),
    elevation: 0,
  );
}
