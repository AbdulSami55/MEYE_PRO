import 'package:flutter/material.dart';
import 'package:live_streaming/Model/Admin/timetable.dart';
import 'package:live_streaming/utilities/constants.dart';
import 'package:live_streaming/view_models/Admin/reschedule_view_model.dart';
import 'package:live_streaming/view_models/Admin/timetable.dart';
import 'package:live_streaming/widget/components/apploading.dart';
import 'package:live_streaming/widget/components/errormessage.dart';
import 'package:live_streaming/widget/textcomponents/large_text.dart';
import 'package:live_streaming/widget/textcomponents/medium_text.dart';
import 'package:provider/provider.dart';

Widget selectScheduleTable(
    BuildContext context, TimetableViewModel timetableViewModel) {
  if (timetableViewModel.loading) {
    return apploading();
  } else if (timetableViewModel.userError != null) {
    return ErrorMessage(timetableViewModel.userError!.message.toString());
  } else if (timetableViewModel.lsttimetable.isEmpty) {
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
            timetableViewModel.lsttimetable
                        .where((element) =>
                            element.starttime.toString() == "08:30")
                        .isNotEmpty &&
                    timetableViewModel.lsttimetable
                        .where(
                            (element) => element.endtime.toString() == "10:00")
                        .isNotEmpty
                ? ScheduleConditions(
                    timetableViewModel.lsttimetable
                        .where((element) =>
                            element.starttime.toString() == "08:30")
                        .toList(),
                    context)
                : rowSchedule("", "", "", "", "", null, context),
            timetableViewModel.lsttimetable
                        .where((element) =>
                            element.starttime.toString() == "10:00")
                        .isNotEmpty &&
                    timetableViewModel.lsttimetable
                        .where(
                            (element) => element.endtime.toString() == "11:30")
                        .isNotEmpty
                ? ScheduleConditions(
                    timetableViewModel.lsttimetable
                        .where((element) =>
                            element.starttime.toString() == "10:00")
                        .toList(),
                    context)
                : rowSchedule("", "", "", "", "", null, context),
            timetableViewModel.lsttimetable
                        .where((element) =>
                            element.starttime.toString() == "11:30")
                        .isNotEmpty &&
                    timetableViewModel.lsttimetable
                        .where(
                            (element) => element.endtime.toString() == "01:00")
                        .isNotEmpty
                ? ScheduleConditions(
                    timetableViewModel.lsttimetable
                        .where((element) =>
                            element.starttime.toString() == "11:30")
                        .toList(),
                    context)
                : rowSchedule("", "", "", "", "", null, context),
            timetableViewModel.lsttimetable
                        .where((element) =>
                            element.starttime.toString() == "01:30")
                        .isNotEmpty &&
                    timetableViewModel.lsttimetable
                        .where(
                            (element) => element.endtime.toString() == "03:00")
                        .isNotEmpty
                ? ScheduleConditions(
                    timetableViewModel.lsttimetable
                        .where((element) =>
                            element.starttime.toString() == "01:30")
                        .toList(),
                    context)
                : rowSchedule("", "", "", "", "", null, context),
            timetableViewModel.lsttimetable
                        .where((element) =>
                            element.starttime.toString() == "03:00")
                        .isNotEmpty &&
                    timetableViewModel.lsttimetable
                        .where(
                            (element) => element.endtime.toString() == "04:30")
                        .isNotEmpty
                ? ScheduleConditions(
                    timetableViewModel.lsttimetable
                        .where((element) =>
                            element.starttime.toString() == "03:00")
                        .toList(),
                    context)
                : rowSchedule("", "", "", "", "", null, context),
          ],
        ),
      )
    ],
  );
}

Row ScheduleConditions(List<TimeTable> timeTable, BuildContext context) {
  return rowSchedule(
      timeTable.where((e) => e.day == "Monday").isNotEmpty
          ? "${timeTable.where((e) => e.day == "Monday").first.discipline}\n${timeTable.where((e) => e.day == "Monday").first.courseName}\n${timeTable.where((e) => e.day == "Monday").first.venue}"
          : "",
      timeTable.where((e) => e.day == "Tuesday").isNotEmpty
          ? "${timeTable.where((e) => e.day == "Tuesday").first.discipline}\n${timeTable.where((e) => e.day == "Tuesday").first.courseName}\n${timeTable.where((e) => e.day == "Tuesday").first.venue}"
          : "",
      timeTable.where((e) => e.day == "Wednesday").isNotEmpty
          ? "${timeTable.where((e) => e.day == "Wednesday").first.discipline}\n${timeTable.where((e) => e.day == "Wednesday").first.courseName}\n${timeTable.where((e) => e.day == "Wednesday").first.venue}"
          : "",
      timeTable.where((e) => e.day == "Thursday").isNotEmpty
          ? "${timeTable.where((e) => e.day == "Thursday").first.discipline}\n${timeTable.where((e) => e.day == "Thursday").first.courseName}\n${timeTable.where((e) => e.day == "Thursday").first.venue}"
          : "",
      timeTable.where((e) => e.day == "Friday").isNotEmpty
          ? "${timeTable.where((e) => e.day == "Friday").first.discipline}\n${timeTable.where((e) => e.day == "Friday").first.courseName}\n${timeTable.where((e) => e.day == "Friday").first.venue}"
          : "",
      timeTable,
      context);
}

Padding timeSchedule(String time) {
  return Padding(
    padding: const EdgeInsets.only(left: 8.0),
    child: Text(time),
  );
}

Row rowSchedule(String mondata, String tueData, String wedData, String thuData,
    String friData, List<TimeTable>? timeTable, BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      const SizedBox(
        width: 20,
      ),
      rowData(mondata, timeTable, context),
      rowData(tueData, timeTable, context),
      rowData(wedData, timeTable, context),
      rowData(thuData, timeTable, context),
      rowData(friData, timeTable, context),
    ],
  );
}

InkWell rowData(String data, List<TimeTable>? timeTable, BuildContext context) {
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
                            // showLoaderDialog(context, "Loading..");
                            // Schedule schedule = Schedule(
                            //     id: 0,
                            //     status: false,
                            //     teachID: teach!.id,
                            //     venueID: venue.id,
                            //     starttime: daytime.split(',')[1],
                            //     endtime: daytime.split(',')[2],
                            //     day: daytime.split(',')[0]);

                            // await provider.insertdata(schedule);

                            // if (provider.userError != null) {
                            //   Navigator.pop(context);
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //       snack_bar(
                            //           provider.userError!.message.toString(),
                            //           false));
                            //   Navigator.pop(context);
                            // } else {
                            //   Navigator.pop(context);
                            //   Navigator.pop(context);
                            //   Navigator.pop(context);
                            //   Navigator.pop(context);
                            //   Navigator.pop(context);
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //       snack_bar("Class Rescheduled", true));
                            // }
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
