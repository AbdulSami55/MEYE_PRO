import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../../utilities/constants.dart';

SliverAppBar appbar(String text,
    {bool? backarrow,
    BuildContext? context,
    bool? automaticallyImplyLeading,
    String? route}) {
  return SliverAppBar(
    automaticallyImplyLeading: automaticallyImplyLeading ?? true,
    foregroundColor: shadowColorDark,
    backgroundColor: backgroundColor,
    snap: false,
    pinned: true,
    floating: false,
    title: Row(
      children: [
        backarrow == true
            ? Row(
                children: [
                  InkWell(
                      onTap: () => context!.go(route!),
                      child: const Icon(Icons.arrow_back)),
                  const SizedBox(
                    width: 15,
                  )
                ],
              )
            : const Padding(padding: EdgeInsets.zero),
        Text(
          text,
          style: GoogleFonts.poppins(fontSize: 25, color: shadowColorDark),
        ),
      ],
    ),
    elevation: 0,
  );
}
