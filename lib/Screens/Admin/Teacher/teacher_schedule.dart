// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:live_streaming/Model/Admin/fulltimetable.dart';
import 'package:live_streaming/Model/Admin/user.dart';
import 'package:live_streaming/view_models/teach_view_model.dart';
import 'package:live_streaming/view_models/timetable.dart';
import 'package:live_streaming/widget/components/appbar.dart';
import 'package:live_streaming/widget/teachertopbar.dart';
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
                Teachertopcard(
                    context,
                    "$getuserimage${user.role}/${user.image}",
                    user.name.toString(),
                    false),
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
    } else if (timetableViewModel.lstfulltimetable.isEmpty) {
      return large_text("No Schedule Set");
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.12,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              timeSchedule("08:30-\n10:00"),
              const SizedBox(
                height: 40,
              ),
              timeSchedule("10:00-\n11:30"),
              const SizedBox(
                height: 35,
              ),
              timeSchedule("11:30-\n01:00"),
              const SizedBox(
                height: 25,
              ),
              timeSchedule("01:30-\n03:00"),
              const SizedBox(
                height: 40,
              ),
              timeSchedule("03:00-\n04:30"),
            ],
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.85,
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
                              "08:30")
                          .isNotEmpty &&
                      timetableViewModel.lstfulltimetable
                          .where((element) =>
                              element.timeTable!.endtime
                                  .toString()
                                  .split('.')[0] ==
                              "10:00")
                          .isNotEmpty
                  ? ScheduleConditions(
                      timetableViewModel,
                      timetableViewModel.lstfulltimetable
                          .where((element) =>
                              element.timeTable!.starttime
                                  .toString()
                                  .split('.')[0] ==
                              "08:30")
                          .first)
                  : rowSchedule("", "", "", "", ""),
              timetableViewModel.lstfulltimetable
                          .where((element) =>
                              element.timeTable!.starttime
                                  .toString()
                                  .split('.')[0] ==
                              "10:00")
                          .isNotEmpty &&
                      timetableViewModel.lstfulltimetable
                          .where((element) =>
                              element.timeTable!.endtime
                                  .toString()
                                  .split('.')[0] ==
                              "11:30")
                          .isNotEmpty
                  ? ScheduleConditions(
                      timetableViewModel,
                      timetableViewModel.lstfulltimetable
                          .where((element) =>
                              element.timeTable!.starttime
                                  .toString()
                                  .split('.')[0] ==
                              "10:00")
                          .first)
                  : rowSchedule("", "", "", "", ""),
              timetableViewModel.lstfulltimetable
                          .where((element) =>
                              element.timeTable!.starttime
                                  .toString()
                                  .split('.')[0] ==
                              "11:30")
                          .isNotEmpty &&
                      timetableViewModel.lstfulltimetable
                          .where((element) =>
                              element.timeTable!.endtime
                                  .toString()
                                  .split('.')[0] ==
                              "01:00")
                          .isNotEmpty
                  ? ScheduleConditions(
                      timetableViewModel,
                      timetableViewModel.lstfulltimetable
                          .where((element) =>
                              element.timeTable!.starttime
                                  .toString()
                                  .split('.')[0] ==
                              "11:30")
                          .first)
                  : rowSchedule("", "", "", "", ""),
              timetableViewModel.lstfulltimetable
                          .where((element) =>
                              element.timeTable!.starttime
                                  .toString()
                                  .split('.')[0] ==
                              "01:30")
                          .isNotEmpty &&
                      timetableViewModel.lstfulltimetable
                          .where((element) =>
                              element.timeTable!.endtime
                                  .toString()
                                  .split('.')[0] ==
                              "03:00")
                          .isNotEmpty
                  ? ScheduleConditions(
                      timetableViewModel,
                      timetableViewModel.lstfulltimetable
                          .where((element) =>
                              element.timeTable!.starttime
                                  .toString()
                                  .split('.')[0] ==
                              "01:30")
                          .first)
                  : rowSchedule("", "", "", "", ""),
              timetableViewModel.lstfulltimetable
                          .where((element) =>
                              element.timeTable!.starttime
                                  .toString()
                                  .split('.')[0] ==
                              "03:00")
                          .isNotEmpty &&
                      timetableViewModel.lstfulltimetable
                          .where((element) =>
                              element.timeTable!.endtime
                                  .toString()
                                  .split('.')[0] ==
                              "04:30")
                          .isNotEmpty
                  ? ScheduleConditions(
                      timetableViewModel,
                      timetableViewModel.lstfulltimetable
                          .where((element) =>
                              element.timeTable!.starttime
                                  .toString()
                                  .split('.')[0] ==
                              "03:00")
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
        width: 55,
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
        width: 55,
        decoration: BoxDecoration(
          border: Border.all(color: shadowColorLight),
          color: primaryColor,
        ),
        child: Center(child: text_medium(text, color: backgroundColorLight)));
  }
}
