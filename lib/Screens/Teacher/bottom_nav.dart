// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:live_streaming/Screens/Teacher/attendance.dart';
import 'package:live_streaming/Screens/Teacher/home_screen.dart';
import 'package:live_streaming/Screens/Teacher/teacher_chr.dart';
import 'package:live_streaming/view_models/Teacher/attendance.dart';
import 'package:live_streaming/view_models/handle_bottom_nav.dart';
import 'package:provider/provider.dart';
import '../../utilities/constants.dart';

class TeacherBottomNav extends StatelessWidget {
  const TeacherBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> lst = [
      const TeacherDashboard(),
      const AttendanceCamera(),
      const TeacherCHRScreen()
    ];
    final provider = context.watch<BottomNavViewModel>();
    final providerAttendance = context.watch<AttendanceViewModel>();
    return Scaffold(
        backgroundColor: backgroundColorLight,
        body: lst[provider.teacherSelectedValue],
        bottomNavigationBar: Transform.translate(
          offset: const Offset(0, 10),
          child: SafeArea(
            child: Container(
              padding: const EdgeInsets.only(
                  left: 12, top: 12, right: 12, bottom: 12),
              margin: const EdgeInsets.only(left: 24, bottom: 20, right: 24),
              decoration: BoxDecoration(
                color: backgroundColor2.withOpacity(0.8),
                borderRadius: const BorderRadius.all(Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                    color: backgroundColor2.withOpacity(0.3),
                    offset: const Offset(0, 20),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      provider.setTeacherSelectValue(0);
                    },
                    child: Opacity(
                        opacity: provider.teacherSelectedValue == 0 ? 1 : 0.5,
                        child: bottomIcon(CupertinoIcons.home)),
                  ),
                  InkWell(
                    onTap: () async {
                      showGeneralDialog(
                        context: context,
                        barrierLabel: "Barrier",
                        barrierDismissible: true,
                        barrierColor: Colors.black.withOpacity(0.5),
                        transitionDuration: const Duration(milliseconds: 400),
                        pageBuilder: (_, __, ___) {
                          return Center(
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.3,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 32, horizontal: 24),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.95),
                                borderRadius: BorderRadius.circular(40),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    offset: const Offset(0, 30),
                                    blurRadius: 60,
                                  ),
                                  const BoxShadow(
                                    color: Colors.black45,
                                    offset: Offset(0, 30),
                                    blurRadius: 60,
                                  ),
                                ],
                              ),
                              child: Scaffold(
                                backgroundColor: Colors.transparent,
                                body: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Center(
                                      child: Text("Select Type",
                                          style: GoogleFonts.bebasNeue(
                                              fontSize: 40)),
                                    ),
                                    const SizedBox(height: 30),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        InkWell(
                                            onTap: () async {
                                              XFile? img = await ImagePicker()
                                                  .pickImage(
                                                      source:
                                                          ImageSource.gallery);
                                              if (img != null) {
                                                providerAttendance
                                                    .markAttendance(
                                                        File(img.path));
                                                provider
                                                    .setTeacherSelectValue(1);
                                              }
                                              Navigator.pop(context);
                                            },
                                            child: const Icon(
                                              CupertinoIcons.photo,
                                              size: 50,
                                            )),
                                        InkWell(
                                            onTap: () async {
                                              XFile? img = await ImagePicker()
                                                  .pickImage(
                                                      source:
                                                          ImageSource.camera);
                                              if (img != null) {
                                                providerAttendance
                                                    .markAttendance(
                                                        File(img.path));
                                                provider
                                                    .setTeacherSelectValue(1);
                                              }
                                              Navigator.pop(context);
                                            },
                                            child: const Padding(
                                              padding:
                                                  EdgeInsets.only(left: 20.0),
                                              child: Icon(
                                                CupertinoIcons.photo_camera,
                                                size: 50,
                                              ),
                                            ))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        transitionBuilder: (_, anim, __, child) {
                          Tween<Offset> tween;

                          tween = Tween(
                              begin: const Offset(0, -1), end: Offset.zero);

                          return SlideTransition(
                            position: tween.animate(
                              CurvedAnimation(
                                  parent: anim, curve: Curves.easeInOut),
                            ),
                            child: child,
                          );
                        },
                      );
                    },
                    child: Opacity(
                        opacity: provider.teacherSelectedValue == 1 ? 1 : 0.5,
                        child: bottomIcon(Icons.camera_alt_outlined)),
                  ),
                  InkWell(
                    onTap: () {
                      provider.setTeacherSelectValue(2);
                    },
                    child: Opacity(
                        opacity: provider.teacherSelectedValue == 2 ? 1 : 0.5,
                        child: bottomIcon(Icons.file_copy)),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  SizedBox bottomIcon(IconData iconData) {
    return SizedBox(
        height: 36,
        width: 36,
        child: Icon(
          iconData,
          color: containerColor,
        ));
  }
}
