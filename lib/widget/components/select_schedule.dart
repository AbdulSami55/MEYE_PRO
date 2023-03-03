// ignore_for_file: non_constant_identifier_names

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
    BuildContext context, TimetableViewModel timetableViewModel,
    {bool? isRule}) {
  timetableViewModel.emptylst();
  if (timetableViewModel.loading) {
    return apploading();
  } else if (timetableViewModel.userError != null) {
    return ErrorMessage(timetableViewModel.userError!.message.toString());
  } else if (timetableViewModel.lsttimetable.isEmpty) {
    return large_text("No Schedule Set");
  }

  return Column(
    children: [
      isRule != null
          ? Builder(builder: (context) {
              return CheckboxListTile(
                  title: text_medium("Select All"),
                  value: timetableViewModel.selectAll,
                  onChanged: (val) {
                    timetableViewModel.setSelectAll(val!);
                  });
            })
          : const Padding(padding: EdgeInsets.zero),
      isRule != null
          ? const SizedBox(
              height: 10,
            )
          : const Padding(padding: EdgeInsets.zero),
      Row(
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
                            .where((element) =>
                                element.endtime.toString() == "10:00")
                            .isNotEmpty
                    ? ScheduleConditions(
                        timetableViewModel.lsttimetable
                            .where((element) =>
                                element.starttime.toString() == "08:30")
                            .toList(),
                        context,
                        isRule)
                    : rowSchedule("", "", "", "", "", [], context, isRule),
                timetableViewModel.lsttimetable
                            .where((element) =>
                                element.starttime.toString() == "10:00")
                            .isNotEmpty &&
                        timetableViewModel.lsttimetable
                            .where((element) =>
                                element.endtime.toString() == "11:30")
                            .isNotEmpty
                    ? ScheduleConditions(
                        timetableViewModel.lsttimetable
                            .where((element) =>
                                element.starttime.toString() == "10:00")
                            .toList(),
                        context,
                        isRule)
                    : rowSchedule("", "", "", "", "", [], context, isRule),
                timetableViewModel.lsttimetable
                            .where((element) =>
                                element.starttime.toString() == "11:30")
                            .isNotEmpty &&
                        timetableViewModel.lsttimetable
                            .where((element) =>
                                element.endtime.toString() == "01:00")
                            .isNotEmpty
                    ? ScheduleConditions(
                        timetableViewModel.lsttimetable
                            .where((element) =>
                                element.starttime.toString() == "11:30")
                            .toList(),
                        context,
                        isRule)
                    : rowSchedule("", "", "", "", "", [], context, isRule),
                timetableViewModel.lsttimetable
                            .where((element) =>
                                element.starttime.toString() == "01:30")
                            .isNotEmpty &&
                        timetableViewModel.lsttimetable
                            .where((element) =>
                                element.endtime.toString() == "03:00")
                            .isNotEmpty
                    ? ScheduleConditions(
                        timetableViewModel.lsttimetable
                            .where((element) =>
                                element.starttime.toString() == "01:30")
                            .toList(),
                        context,
                        isRule)
                    : rowSchedule("", "", "", "", "", [], context, isRule),
                timetableViewModel.lsttimetable
                            .where((element) =>
                                element.starttime.toString() == "03:00")
                            .isNotEmpty &&
                        timetableViewModel.lsttimetable
                            .where((element) =>
                                element.endtime.toString() == "04:30")
                            .isNotEmpty
                    ? ScheduleConditions(
                        timetableViewModel.lsttimetable
                            .where((element) =>
                                element.starttime.toString() == "03:00")
                            .toList(),
                        context,
                        isRule)
                    : rowSchedule("", "", "", "", "", [], context, isRule),
              ],
            ),
          )
        ],
      ),
    ],
  );
}

Row ScheduleConditions(
    List<TimeTable> timeTable, BuildContext context, bool? isRule) {
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
      context,
      isRule);
}

Padding timeSchedule(String time) {
  return Padding(
    padding: const EdgeInsets.only(left: 8.0),
    child: Text(time),
  );
}

Row rowSchedule(
    String mondata,
    String tueData,
    String wedData,
    String thuData,
    String friData,
    List<TimeTable> timeTable,
    BuildContext context,
    bool? isRule) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      const SizedBox(
        width: 20,
      ),
      rowData(
          mondata,
          timeTable.where((element) => element.day == "Monday").isNotEmpty
              ? timeTable.where((element) => element.day == "Monday").first
              : null,
          context,
          isRule),
      rowData(
          tueData,
          timeTable.where((element) => element.day == "Tuesday").isNotEmpty
              ? timeTable.where((element) => element.day == "Tuesday").first
              : null,
          context,
          isRule),
      rowData(
          wedData,
          timeTable.where((element) => element.day == "Wednesday").isNotEmpty
              ? timeTable.where((element) => element.day == "Wednesday").first
              : null,
          context,
          isRule),
      rowData(
          thuData,
          timeTable.where((element) => element.day == "Thursday").isNotEmpty
              ? timeTable.where((element) => element.day == "Thursday").first
              : null,
          context,
          isRule),
      rowData(
          friData,
          timeTable.where((element) => element.day == "Friday").isNotEmpty
              ? timeTable.where((element) => element.day == "Friday").first
              : null,
          context,
          isRule),
    ],
  );
}

Widget rowData(
    String data, TimeTable? timeTable, BuildContext context, bool? isRule) {
  return Consumer<TimetableViewModel>(
    builder: (context, provider, child) {
      timeTable != null ? provider.setListTempTimeTable(timeTable) : null;
      return InkWell(
          onTap: () {
            if (data != "") {
              isRule == null
                  ? showDialog(
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
                              ))))
                  : provider.updateValue(timeTable!);
            }
          },
          child: Container(
              height: 80,
              width: 55,
              decoration: BoxDecoration(
                  color: data == ""
                      ? backgroundColor
                      : timeTable!.isSelected
                          ? primaryColor
                          : shadowColorLight,
                  border: Border.all(
                    color: backgroundColor2,
                  )),
              child: Center(
                  child: Text(
                data,
                style: TextStyle(
                    color:
                        data == "" ? shadowColorLight : backgroundColorLight),
              ))));
    },
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
