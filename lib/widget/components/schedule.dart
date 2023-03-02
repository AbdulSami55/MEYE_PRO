// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:live_streaming/Model/Admin/timetable.dart';
import '../../utilities/constants.dart';
import '../../view_models/Admin/timetable.dart';
import '../textcomponents/large_text.dart';
import '../textcomponents/medium_text.dart';
import 'apploading.dart';
import 'errormessage.dart';

Widget ScheduleTable(
    BuildContext context, TimetableViewModel timetableViewModel,
    {bool? iswhite}) {
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
            timeSchedule("08:30-\n10:00", iswhite),
            const SizedBox(
              height: 40,
            ),
            timeSchedule("10:00-\n11:30", iswhite),
            const SizedBox(
              height: 35,
            ),
            timeSchedule("11:30-\n01:00", iswhite),
            const SizedBox(
              height: 25,
            ),
            timeSchedule("01:30-\n03:00", iswhite),
            const SizedBox(
              height: 40,
            ),
            timeSchedule("03:00-\n04:30", iswhite),
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
                    timetableViewModel,
                    timetableViewModel.lsttimetable
                        .where((element) =>
                            element.starttime.toString() == "08:30")
                        .toList())
                : rowSchedule("", "", "", "", ""),
            timetableViewModel.lsttimetable
                        .where((element) =>
                            element.starttime.toString() == "10:00")
                        .isNotEmpty &&
                    timetableViewModel.lsttimetable
                        .where(
                            (element) => element.endtime.toString() == "11:30")
                        .isNotEmpty
                ? ScheduleConditions(
                    timetableViewModel,
                    timetableViewModel.lsttimetable
                        .where((element) =>
                            element.starttime.toString() == "10:00")
                        .toList())
                : rowSchedule("", "", "", "", ""),
            timetableViewModel.lsttimetable
                        .where((element) =>
                            element.starttime.toString() == "11:30")
                        .isNotEmpty &&
                    timetableViewModel.lsttimetable
                        .where(
                            (element) => element.endtime.toString() == "01:00")
                        .isNotEmpty
                ? ScheduleConditions(
                    timetableViewModel,
                    timetableViewModel.lsttimetable
                        .where((element) =>
                            element.starttime.toString() == "11:30")
                        .toList())
                : rowSchedule("", "", "", "", ""),
            timetableViewModel.lsttimetable
                        .where((element) =>
                            element.starttime.toString() == "01:30")
                        .isNotEmpty &&
                    timetableViewModel.lsttimetable
                        .where(
                            (element) => element.endtime.toString() == "03:00")
                        .isNotEmpty
                ? ScheduleConditions(
                    timetableViewModel,
                    timetableViewModel.lsttimetable
                        .where((element) =>
                            element.starttime.toString() == "01:30")
                        .toList())
                : rowSchedule("", "", "", "", ""),
            timetableViewModel.lsttimetable
                        .where((element) =>
                            element.starttime.toString() == "03:00")
                        .isNotEmpty &&
                    timetableViewModel.lsttimetable
                        .where(
                            (element) => element.endtime.toString() == "04:30")
                        .isNotEmpty
                ? ScheduleConditions(
                    timetableViewModel,
                    timetableViewModel.lsttimetable
                        .where((element) =>
                            element.starttime.toString() == "03:00")
                        .toList())
                : rowSchedule("", "", "", "", ""),
          ],
        ),
      )
    ],
  );
}

Row ScheduleConditions(
    TimetableViewModel timetableViewModel, List<TimeTable> timeTable) {
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
  );
}

Padding timeSchedule(String time, bool? iswhite) {
  return Padding(
    padding: const EdgeInsets.only(left: 8.0),
    child: Text(
      time,
      style: TextStyle(color: iswhite != null ? Colors.white : Colors.black),
    ),
  );
}

Row rowSchedule(String mondata, String tueData, String wedData, String thuData,
    String friData) {
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
          color: data == "" ? Colors.transparent : shadowColorLight,
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
