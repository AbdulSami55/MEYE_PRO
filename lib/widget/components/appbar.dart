import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../../utilities/constants.dart';

SliverAppBar appbar(String text, {bool? backarrow, BuildContext? context}) {
  return SliverAppBar(
    automaticallyImplyLeading: backarrow ?? true,
    foregroundColor: shadowColorDark,
    backgroundColor: backgroundColor,
    snap: false,
    pinned: true,
    floating: false,
    title: Row(
      children: [
        backarrow == false
            ? Row(
                children: [
                  InkWell(
                      onTap: () => context!.go(routesAdminBottomNavBar),
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
