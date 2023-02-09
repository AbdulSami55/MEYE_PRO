// ignore_for_file: must_be_immutable, non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:live_streaming/Model/Admin/fulltimetable.dart';
import 'package:live_streaming/Model/Admin/schedule.dart';
import 'package:live_streaming/Model/Admin/user.dart';
import 'package:live_streaming/view_models/reschedule_view_model.dart';
import 'package:live_streaming/view_models/teach_view_model.dart';
import 'package:live_streaming/view_models/timetable.dart';
import 'package:live_streaming/widget/components/appbar.dart';
import 'package:live_streaming/widget/progress_indicator.dart';
import 'package:live_streaming/widget/snack_bar.dart';
import 'package:live_streaming/widget/textcomponents/large_text.dart';
import 'package:live_streaming/widget/textcomponents/medium_text.dart';
import 'package:provider/provider.dart';
import '../../../Model/Admin/teach.dart';
import '../../../Model/Admin/venue.dart';
import '../../../utilities/constants.dart';
import '../../../widget/components/apploading.dart';
import '../../../widget/components/errormessage.dart';

class TeacherScheduleScreen extends StatelessWidget {
  TeacherScheduleScreen(
      {super.key,
      required this.user,
      required this.venue,
      required this.daytime});
  User user;
  Venue venue;
  String daytime;
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
                    height: MediaQuery.of(context).size.height * 0.15,
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                              radius: 33,
                              backgroundImage: NetworkImage(
                                  "$getuserimage${user.role}/${user.image}")),
                        ),
                        const SizedBox(
                          width: 5,
                          height: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                text_medium("Name="),
                                text_medium(user.name.toString(),
                                    color: shadowColorLight)
                              ],
                            ),
                            Row(
                              children: [
                                text_medium("Venue="),
                                text_medium(venue.name.toString(),
                                    color: shadowColorLight)
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
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
                          .first,
                      teachViewModel,
                      context)
                  : rowSchedule("", "", "", "", "", null, context),
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
                          .first,
                      teachViewModel,
                      context)
                  : rowSchedule("", "", "", "", "", null, context),
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
                          .first,
                      teachViewModel,
                      context)
                  : rowSchedule("", "", "", "", "", null, context),
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
                          .first,
                      teachViewModel,
                      context)
                  : rowSchedule("", "", "", "", "", null, context),
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
                          .first,
                      teachViewModel,
                      context)
                  : rowSchedule("", "", "", "", "", null, context),
            ],
          ),
        )
      ],
    );
  }

  Row ScheduleConditions(
      TimetableViewModel timetableViewModel,
      FullTimeTable fullTimeTable,
      TeachViewModel teachViewModel,
      BuildContext context) {
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
        teachViewModel.lstteach
            .where((element) =>
                element.teacherID == user.id &&
                element.timeTableID == fullTimeTable.timeTable!.id)
            .first,
        context);
  }

  Padding timeSchedule(String time) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(time),
    );
  }

  Row rowSchedule(String mondata, String tueData, String wedData,
      String thuData, String friData, Teach? teach, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          width: 20,
        ),
        rowData(mondata, teach, context),
        rowData(tueData, teach, context),
        rowData(wedData, teach, context),
        rowData(thuData, teach, context),
        rowData(friData, teach, context),
      ],
    );
  }

  InkWell rowData(String data, Teach? teach, BuildContext context) {
    return InkWell(
      onTap: () {
        if (data != "") {
          showDialog(
              context: context,
              builder: ((context) => Consumer<ReScheduleViewModel>(
                    builder: (context, provider, child) => AlertDialog(
                      content: text_medium("Are You Sure?"),
                      title: text_medium("Warning!",
                          color: shadowColorDark, font: 14),
                      actions: [
                        OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("No")),
                        ElevatedButton(
                            onPressed: () async {
                              showLoaderDialog(context, "Loading..");
                              Schedule schedule = Schedule(
                                  id: 0,
                                  status: false,
                                  teachID: teach!.id,
                                  venueID: venue.id,
                                  starttime: daytime.split(',')[1],
                                  endtime: daytime.split(',')[2],
                                  day: daytime.split(',')[0]);

                              await provider.insertdata(schedule);

                              if (provider.userError != null) {
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    snack_bar(
                                        provider.userError!.message.toString(),
                                        false));
                                Navigator.pop(context);
                              } else {
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    snack_bar("Class Rescheduled", true));
                              }
                            },
                            child: const Text("Yes")),
                      ],
                    ),
                  )));
        }
      },
      child: Container(
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
          ))),
    );
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
