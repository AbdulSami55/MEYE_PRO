// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:live_streaming/Model/Admin/course.dart';
import 'package:live_streaming/Model/Admin/fulltimetable.dart';
import 'package:live_streaming/Model/Admin/section.dart';
import 'package:live_streaming/Model/Admin/timetable.dart';
import 'package:live_streaming/Model/Admin/user.dart';
import 'package:live_streaming/Model/Admin/venue.dart';
import 'package:live_streaming/view_models/teach_view_model.dart';
import 'package:live_streaming/view_models/timetable.dart';
import 'package:live_streaming/widget/components/appbar.dart';
import 'package:live_streaming/widget/textcomponents/large_text.dart';
import 'package:live_streaming/widget/textcomponents/medium_text.dart';
import 'package:provider/provider.dart';

import '../../../utilities/constants.dart';
import '../../../widget/components/apploading.dart';
import '../../../widget/components/errormessage.dart';

class TeacherScheduleView extends StatelessWidget {
  TeacherScheduleView({super.key, required this.user});
  User user;

  @override
  Widget build(BuildContext context) {
    final timetableViewModel = context.watch<TimetableViewModel>();
    return Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(
        slivers: [
          appbar("Teacher Schedule"),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: backgroundColorLight,
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 3,
                              blurRadius: 7,
                              offset: const Offset(0, 7),
                              color: Colors.grey.withOpacity(0.5))
                        ]),
                    child: Row(),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ChangeNotifierProvider(
                  create: ((context) => TeachViewModel(user.id!, context)),
                  child: Container(
                    color: backgroundColor,
                    child: Consumer<TeachViewModel>(
                        builder: (context, provider, child) {
                      return ScheduleTable(
                          context, provider, timetableViewModel);
                    }),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget ScheduleTable(BuildContext context, TeachViewModel teachViewModel,
      TimetableViewModel timetableViewModel) {
    if (timetableViewModel.loading || teachViewModel.loading) {
      return apploading();
    } else if (teachViewModel.userError != null ||
        timetableViewModel.userError != null) {
      return ErrorMessage(teachViewModel.userError == null
          ? timetableViewModel.userError!.message.toString()
          : teachViewModel.userError!.message.toString());
    } else if (timetableViewModel.lsttimetable.isEmpty) {
      return large_text("No Schedule Set");
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.23,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 60,
              ),
              timeSchedule("08:30-10:00"),
              const SizedBox(
                height: 70,
              ),
              timeSchedule("10:00-11:30"),
              const SizedBox(
                height: 60,
              ),
              timeSchedule("11:30-01:00"),
              const SizedBox(
                height: 60,
              ),
              timeSchedule("01:30-03:00"),
              const SizedBox(
                height: 70,
              ),
              timeSchedule("03:00-04:30"),
            ],
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.75,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  scheduleColumn("Mon"),
                  scheduleColumn("Tue"),
                  scheduleColumn("Wed"),
                  scheduleColumn("Thu"),
                  scheduleColumn("Fri"),
                ],
              ),
              timetableViewModel.lstfulltimetable
                          .where((element) =>
                              element.timeTable!.starttime
                                  .toString()
                                  .split('.')[0] ==
                              "08:30:00")
                          .isNotEmpty &&
                      timetableViewModel.lstfulltimetable
                          .where((element) =>
                              element.timeTable!.endtime
                                  .toString()
                                  .split('.')[0] ==
                              "10:00:00")
                          .isNotEmpty
                  ? ScheduleConditions(
                      timetableViewModel,
                      timetableViewModel.lstfulltimetable
                          .where((element) =>
                              element.timeTable!.starttime
                                  .toString()
                                  .split('.')[0] ==
                              "08:30:00")
                          .first)
                  : rowSchedule("", "", "", "", ""),
              timetableViewModel.lstfulltimetable
                          .where((element) =>
                              element.timeTable!.starttime
                                  .toString()
                                  .split('.')[0] ==
                              "10:00:00")
                          .isNotEmpty &&
                      timetableViewModel.lstfulltimetable
                          .where((element) =>
                              element.timeTable!.endtime
                                  .toString()
                                  .split('.')[0] ==
                              "11:30:00")
                          .isNotEmpty
                  ? ScheduleConditions(
                      timetableViewModel,
                      timetableViewModel.lstfulltimetable
                          .where((element) =>
                              element.timeTable!.starttime
                                  .toString()
                                  .split('.')[0] ==
                              "10:00:00")
                          .first)
                  : rowSchedule("", "", "", "", ""),
              timetableViewModel.lstfulltimetable
                          .where((element) =>
                              element.timeTable!.starttime
                                  .toString()
                                  .split('.')[0] ==
                              "11:30:00")
                          .isNotEmpty &&
                      timetableViewModel.lstfulltimetable
                          .where((element) =>
                              element.timeTable!.endtime
                                  .toString()
                                  .split('.')[0] ==
                              "01:00:00")
                          .isNotEmpty
                  ? ScheduleConditions(
                      timetableViewModel,
                      timetableViewModel.lstfulltimetable
                          .where((element) =>
                              element.timeTable!.starttime
                                  .toString()
                                  .split('.')[0] ==
                              "11:30:00")
                          .first)
                  : rowSchedule("", "", "", "", ""),
              timetableViewModel.lstfulltimetable
                          .where((element) =>
                              element.timeTable!.starttime
                                  .toString()
                                  .split('.')[0] ==
                              "01:30:00")
                          .isNotEmpty &&
                      timetableViewModel.lstfulltimetable
                          .where((element) =>
                              element.timeTable!.endtime
                                  .toString()
                                  .split('.')[0] ==
                              "03:00:00")
                          .isNotEmpty
                  ? ScheduleConditions(
                      timetableViewModel,
                      timetableViewModel.lstfulltimetable
                          .where((element) =>
                              element.timeTable!.starttime
                                  .toString()
                                  .split('.')[0] ==
                              "01:30:00")
                          .first)
                  : rowSchedule("", "", "", "", ""),
              timetableViewModel.lstfulltimetable
                          .where((element) =>
                              element.timeTable!.starttime
                                  .toString()
                                  .split('.')[0] ==
                              "03:00:00")
                          .isNotEmpty &&
                      timetableViewModel.lstfulltimetable
                          .where((element) =>
                              element.timeTable!.endtime
                                  .toString()
                                  .split('.')[0] ==
                              "04:30:00")
                          .isNotEmpty
                  ? ScheduleConditions(
                      timetableViewModel,
                      timetableViewModel.lstfulltimetable
                          .where((element) =>
                              element.timeTable!.starttime
                                  .toString()
                                  .split('.')[0] ==
                              "03:00:00")
                          .first)
                  : rowSchedule("", "", "", "", ""),
            ],
          ),
        )
      ],
    );
  }

  Row ScheduleConditions(
      TimetableViewModel timetableViewModel, FullTimeTable fullTimeTable) {
    return rowSchedule(
      fullTimeTable.timeTable!.day == "Mon"
          ? "${fullTimeTable.section!.name}\n${fullTimeTable.course!.name}\n${fullTimeTable.venue!.name}"
          : "",
      fullTimeTable.timeTable!.day == "Tue"
          ? "${fullTimeTable.section!.name}\n${fullTimeTable.course!.name}\n${fullTimeTable.venue!.name}"
          : "",
      fullTimeTable.timeTable!.day == "Wed"
          ? "${fullTimeTable.section!.name}\n${fullTimeTable.course!.name}\n${fullTimeTable.venue!.name}"
          : "",
      fullTimeTable.timeTable!.day == "Thu"
          ? "${fullTimeTable.section!.name}\n${fullTimeTable.course!.name}\n${fullTimeTable.venue!.name}"
          : "",
      fullTimeTable.timeTable!.day == "Fri"
          ? "${fullTimeTable.section!.name}\n${fullTimeTable.course!.name}\n${fullTimeTable.venue!.name}"
          : "",
    );
  }

  Padding timeSchedule(String time) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(time),
    );
  }

  Row rowSchedule(String mondata, String tueData, String wedData,
      String thuData, String friData) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          width: 20,
        ),
        rowData(mondata),
        rowData(tueData),
        rowData(wedData),
        rowData(thuData),
        rowData(friData),
      ],
    );
  }

  Container rowData(String data) {
    return Container(
        height: 80,
        width: 50,
        decoration: BoxDecoration(
            color: data == "" ? backgroundColor : shadowColorLight,
            border: Border.all(
              color: backgroundColor2,
            )),
        child: Center(
            child: Text(
          data,
          style: TextStyle(
              color: data == "" ? shadowColorLight : backgroundColorLight),
        )));
  }

  Container scheduleColumn(String text) {
    return Container(
        height: 30,
        width: 50,
        decoration: BoxDecoration(
          border: Border.all(color: shadowColorLight),
          color: primaryColor,
        ),
        child: Center(child: text_medium(text, color: backgroundColorLight)));
  }
}
