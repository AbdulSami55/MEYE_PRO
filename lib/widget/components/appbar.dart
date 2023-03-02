import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utilities/constants.dart';

SliverAppBar appbar(
  String text, {
  bool? automaticallyImplyLeading,
}) {
  return SliverAppBar(
    automaticallyImplyLeading: automaticallyImplyLeading ?? true,
    foregroundColor: shadowColorDark,
    backgroundColor: backgroundColor,
    snap: false,
    pinned: true,
    floating: false,
    title: Text(
      text,
      style: GoogleFonts.poppins(fontSize: 25, color: shadowColorDark),
    ),
    elevation: 0,
  );
}
