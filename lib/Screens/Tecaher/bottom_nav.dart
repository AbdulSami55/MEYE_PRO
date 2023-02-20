// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:live_streaming/Screens/Tecaher/attendance.dart';
import 'package:live_streaming/Screens/Tecaher/home_screen.dart';
import 'package:live_streaming/view_models/handle_bottom_nav.dart';
import 'package:provider/provider.dart';

import '../../utilities/constants.dart';

class TeacherBottomNav extends StatelessWidget {
  const TeacherBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> lst = [const TeacherDashboard(), const AttendanceCamera()];
    final provider = context.watch<BottomNavViewModel>();
    return Scaffold(
        body: lst[provider.teacherSelectedValue],
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color.fromARGB(255, 248, 72, 181),
                  Color.fromARGB(255, 255, 116, 116)
                ]),
          ),
          child: Transform.translate(
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
                        XFile? img = await ImagePicker()
                            .pickImage(source: ImageSource.camera);
                        if (img != null) {
                          provider.setTeacherSelectValue(1);
                        }
                      },
                      child: Opacity(
                          opacity: provider.teacherSelectedValue == 1 ? 1 : 0.5,
                          child: bottomIcon(Icons.file_open)),
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
