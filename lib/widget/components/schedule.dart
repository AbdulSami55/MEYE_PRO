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
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.10,
        ),
        appShimmer(MediaQuery.of(context).size.width * 0.80,
            MediaQuery.of(context).size.height * 0.60),
      ],
    );
  } else if (timetableViewModel.userError != null) {
    return ErrorMessage(timetableViewModel.userError!.message.toString());
  } else if (timetableViewModel.lsttimetable.isEmpty) {
    return large_text("No Schedule Set");
  }

  List<String> days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];
  List<String> daysHeader = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'];

  List<Map<String, dynamic>> timeTable = [
    {'start': '08:30', 'end': '10:00'},
    {'start': '10:00', 'end': '11:30'},
    {'start': '11:30', 'end': '01:00'},
    {'start': '01:30', 'end': '03:00'},
    {'start': '03:00', 'end': '04:30'}
  ];

  return Container(
    color: backgroundColorLight,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.12,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: timeTable
                  .asMap()
                  .map((i, e) => MapEntry(i,
                      timeSchedule("${e['start']}-\n${e['end']}", iswhite, i)))
                  .values
                  .toList()),
        ),
        Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                      children:
                          daysHeader.map((e) => scheduleColumn(e)).toList()),
                  Column(
                      children: timeTable
                          .map((e) => timetableViewModel.lsttimetable
                                      .where((element) =>
                                          element.starttime.toString() ==
                                          e['start'])
                                      .isNotEmpty &&
                                  timetableViewModel.lsttimetable
                                      .where((element) =>
                                          element.endtime.toString() ==
                                          e['end'])
                                      .isNotEmpty
                              ? ScheduleConditions(
                                  timetableViewModel.lsttimetable
                                      .where((element) =>
                                          element.starttime.toString() ==
                                          e['start'])
                                      .toList(),
                                  days)
                              : Row(
                                  children:
                                      days.map((e) => rowData("")).toList(),
                                ))
                          .toList())
                ],
              ),
            ),
          ],
        )
      ],
    ),
  );
}

Row ScheduleConditions(List<TimeTable> timeTable, List<String> days) {
  return Row(
      children: days
          .map((d) => timeTable.where((element) => element.day == d).isEmpty
              ? rowData("")
              : rowData(
                  "${timeTable.where((e) => e.day == d).first.discipline}\n${timeTable.where((e) => e.day == d).first.courseName}\n${timeTable.where((e) => e.day == d).first.venue}"))
          .toList());
}

Column timeSchedule(String time, bool? iswhite, int i) {
  return Column(
    children: [
      SizedBox(
        height: i < 2 ? 40 : 30,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Text(
          time,
          style:
              TextStyle(color: iswhite != null ? Colors.white : Colors.black),
        ),
      ),
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
