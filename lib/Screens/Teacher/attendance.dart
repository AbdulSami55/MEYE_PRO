// ignore_for_file: use_build_context_synchronously, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:live_streaming/utilities/constants.dart';
import 'package:live_streaming/view_models/Teacher/attendance.dart';
import 'package:live_streaming/view_models/handle_bottom_nav.dart';
import 'package:live_streaming/widget/components/apploading.dart';
import 'package:live_streaming/widget/components/errormessage.dart';
import 'package:live_streaming/widget/mybutton.dart';
import 'package:live_streaming/widget/progress_indicator.dart';
import 'package:live_streaming/widget/snack_bar.dart';
import 'package:live_streaming/widget/textcomponents/medium_text.dart';
import 'package:provider/provider.dart';
import '../../widget/components/std_teacher_appbar.dart';
import 'components/glass_container.dart';

class AttendanceCamera extends StatelessWidget {
  const AttendanceCamera({super.key});

  @override
  Widget build(BuildContext context) {
    final providerAttendance = context.watch<AttendanceViewModel>();
    return Scaffold(
      backgroundColor: backgroundColorLight,
      body: CustomScrollView(
        slivers: [
          stdteacherappbar(context,
              isteacher: true, isback: true, appBarColor: primaryColor),
          SliverToBoxAdapter(child: Builder(builder: (context) {
            return _ui(providerAttendance, context);
          }))
        ],
      ),
    );
  }

  Widget _ui(AttendanceViewModel attendanceViewModel, BuildContext context) {
    if (attendanceViewModel.isloading) {
      return apploading(context);
    } else if (attendanceViewModel.userError != null) {
      return ErrorMessage(attendanceViewModel.userError!.message.toString());
    }

    return Container(
      color: primaryColor,
      child: Container(
        height: MediaQuery.of(context).size.height * 1,
        decoration: const BoxDecoration(
            color: backgroundColorLight,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32.0),
                topRight: Radius.circular(32.0))),
        child: ListView(
          padding: EdgeInsets.zero,
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          children: [
            const SizedBox(
              height: 20,
            ),
            glassContainer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: attendanceViewModel.lstAttendance.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      text_medium(
                          attendanceViewModel.lstAttendance[index].name),
                      Builder(builder: (context) {
                        return InkWell(
                          onTap: () {
                            attendanceViewModel.lstAttendance[index].status =
                                !attendanceViewModel
                                    .lstAttendance[index].status;
                            attendanceViewModel.updateListAttendance(
                                attendanceViewModel.lstAttendance);
                          },
                          child: text_medium(
                              attendanceViewModel.lstAttendance[index].status
                                  ? 'P'
                                  : 'A'),
                        );
                      })
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: mybutton(() async {
                showLoaderDialog(context, "Uploading..");
                String response = await attendanceViewModel
                    .addAttendance(attendanceViewModel.lstAttendance);
                Navigator.pop(context);
                if (response == "Attendance Marked") {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(snack_bar(response, true));
                  context.read<BottomNavViewModel>().setTeacherSelectValue(0);
                  context.pushReplacement(routesTeacherBottomNavBar);
                } else {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(snack_bar(response, false));
                }
              }, "Save", Icons.done),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
            )
          ],
        ),
      ),
    );
  }
}
