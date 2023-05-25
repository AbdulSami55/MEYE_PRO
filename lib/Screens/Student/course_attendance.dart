import 'package:flutter/material.dart';
import 'package:live_streaming/Model/Student/course_attendance.dart';
import 'package:live_streaming/utilities/constants.dart';
import 'package:live_streaming/view_models/Student/courses_view_model.dart';
import 'package:live_streaming/view_models/signin_view_model.dart';
import 'package:live_streaming/widget/components/appbar.dart';
import 'package:live_streaming/widget/components/apploading.dart';
import 'package:live_streaming/widget/components/errormessage.dart';
import 'package:live_streaming/widget/components/std_teacher_appbar.dart';
import 'package:live_streaming/widget/teachertopbar.dart';
import 'package:live_streaming/widget/textcomponents/large_text.dart';
import 'package:live_streaming/widget/textcomponents/medium_text.dart';
import 'package:live_streaming/widget/textcomponents/small_text.dart';
import 'package:live_streaming/widget/topbar.dart';
import 'package:provider/provider.dart';

class CourseAttendanceScreen extends StatelessWidget {
  const CourseAttendanceScreen({super.key, required this.provider});
  final CourseViewModel provider;

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<SignInViewModel>();
    return Scaffold(
      backgroundColor: backgroundColorLight,
      body: CustomScrollView(
        slivers: [
          appbar(userProvider.user.name.toString(), isGreen: true),
          SliverToBoxAdapter(
            child: Container(
              color: primaryColor,
              child: Container(
                decoration: const BoxDecoration(
                    color: backgroundColorLight,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32.0),
                        topRight: Radius.circular(32.0))),
                child: Column(
                  children: [
                    topBar(
                        context,
                        provider.lstcourses[provider.selectedIndex].image == ""
                            ? ""
                            : "${getuserimage}Teacher/${provider.lstcourses[provider.selectedIndex].image}",
                        provider
                            .lstcourses[provider.selectedIndex].teacherName),
                    ChangeNotifierProvider<CourseViewModel>.value(
                      value: provider,
                      child: Consumer<CourseViewModel>(
                          builder: ((context, provider, child) =>
                              _ui(context, provider))),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _ui(BuildContext context, CourseViewModel courseProvider) {
    if (courseProvider.isloading) {
      return apploading(context);
    } else if (courseProvider.userError != null) {
      return ErrorMessage(courseProvider.userError!.message.toString());
    }
    return courseProvider.lstCourseAttendance.isEmpty
        ? Center(child: large_text("No Class Held"))
        : Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: SingleChildScrollView(
                child: DataTable(
                    headingRowColor: MaterialStateColor.resolveWith(
                        (states) => primaryColor),
                    dataRowHeight: 50,
                    columnSpacing: 70,
                    columns: [
                      DataColumn(
                        label: text_medium('Sr. No', color: containerColor),
                      ),
                      DataColumn(
                          label: text_medium('Date', color: containerColor)),
                      DataColumn(
                          label: text_medium('Status', color: containerColor)),
                    ],
                    rows: provider.lstCourseAttendance
                        .asMap()
                        .map((k, v) => MapEntry(k, rowData(v, k)))
                        .values
                        .toList())));
  }

  DataRow rowData(CourseAttendance v, int k) {
    return DataRow(
        color: v.status == false
            ? MaterialStateProperty.all(Colors.redAccent)
            : MaterialStateProperty.all(containerColor),
        cells: [
          DataCell(textSmall("${k + 1}")),
          DataCell(textSmall(v.date.toString())),
          DataCell(textSmall(v.status ? 'P' : 'A')),
        ]);
  }
}
