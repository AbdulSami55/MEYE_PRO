// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:live_streaming/Model/Admin/preschedule.dart';
import 'package:live_streaming/Model/Admin/rules_timeTable.dart';
import 'package:live_streaming/Model/Admin/schedule.dart';
import 'package:live_streaming/Model/Admin/timetable.dart';
import 'package:live_streaming/utilities/constants.dart';
import 'package:live_streaming/view_models/Admin/preschedule_view_model.dart';
import 'package:live_streaming/view_models/Admin/reschedule_view_model.dart';
import 'package:live_streaming/view_models/Admin/timetable.dart';
import 'package:live_streaming/widget/components/apploading.dart';
import 'package:live_streaming/widget/components/errormessage.dart';
import 'package:live_streaming/widget/progress_indicator.dart';
import 'package:live_streaming/widget/snack_bar.dart';
import 'package:live_streaming/widget/textcomponents/large_text.dart';
import 'package:live_streaming/widget/textcomponents/medium_text.dart';
import 'package:provider/provider.dart';

Widget selectScheduleTable(
    BuildContext context, TimetableViewModel timetableViewModel,
    {bool? isRule, String? discipline, String? venue, String? daytime}) {
  timetableViewModel.emptylst();
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
  } else if (timetableViewModel.lstrulestimetable.isEmpty) {
    return large_text("No Schedule Set");
  }
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
    child: Column(
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
                  children: timeTable
                      .asMap()
                      .map((i, e) => MapEntry(i,
                          timeSchedule("${e['start']}-\n${e['end']}", null, i)))
                      .values
                      .toList()),
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
                      Row(
                          children: daysHeader
                              .map((e) => scheduleColumn(e))
                              .toList()),
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        children: timeTable
                            .map((e) => timetableViewModel.lstrulestimetable
                                        .where((element) =>
                                            element.starttime.toString() ==
                                            e['start'])
                                        .isNotEmpty &&
                                    timetableViewModel.lstrulestimetable
                                        .where((element) =>
                                            element.endtime.toString() ==
                                            e['end'])
                                        .isNotEmpty
                                ? ScheduleConditions(
                                    timetableViewModel.lstrulestimetable
                                        .where((element) =>
                                            element.starttime.toString() ==
                                            e['start'])
                                        .toList(),
                                    context,
                                    isRule,
                                    discipline ?? "",
                                    venue ?? "",
                                    daytime ?? "")
                                : rowSchedule(
                                    "",
                                    "",
                                    "",
                                    "",
                                    "",
                                    [],
                                    context,
                                    discipline,
                                    isRule,
                                    venue ?? "",
                                    daytime ?? ""))
                            .toList(),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ],
    ),
  );
}

Widget ScheduleConditions(List<RulesTimeTable> timeTable, BuildContext context,
    bool? isRule, String discipline, String venue, String daytime) {
  String getScheduleText(String day) {
    final matchingTimetable = timeTable.where((e) => e.day == day);

    if (discipline != "") {
      return matchingTimetable
              .where((e) => e.discipline == discipline)
              .isNotEmpty
          ? "${matchingTimetable.first.discipline}\n${matchingTimetable.first.courseName}\n${matchingTimetable.first.venue}"
          : "";
    } else {
      return matchingTimetable.isNotEmpty
          ? "${matchingTimetable.first.discipline}\n${matchingTimetable.first.courseName}\n${matchingTimetable.first.venue}"
          : "";
    }
  }

  return rowSchedule(
    getScheduleText("Monday"),
    getScheduleText("Tuesday"),
    getScheduleText("Wednesday"),
    getScheduleText("Thursday"),
    getScheduleText("Friday"),
    timeTable,
    context,
    discipline,
    isRule,
    venue,
    daytime,
  );
}

Column timeSchedule(String time, bool? iswhite, int i) {
  return Column(
    children: [
      SizedBox(
        height: i < 1 ? 40 : 35,
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

Row rowSchedule(
    String mondata,
    String tueData,
    String wedData,
    String thuData,
    String friData,
    List<RulesTimeTable> timeTable,
    BuildContext context,
    String? discipline,
    bool? isRule,
    String venue,
    String daytime) {
  List<String> days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];
  List data = [mondata, tueData, wedData, thuData, friData];
  if (isRule == true) {
    return Row(
      children: [
        const SizedBox(
          width: 20,
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: days
                .asMap()
                .map((key, value) => MapEntry(
                    key,
                    rowData(
                        data[key],
                        timeTable
                                .where((element) => element.day == value)
                                .isNotEmpty
                            ? timeTable
                                .where((element) => element.day == value)
                                .first
                            : null,
                        context,
                        isRule,
                        discipline ?? "",
                        venue,
                        daytime)))
                .values
                .toList()),
      ],
    );
  } else {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: days
            .asMap()
            .map((key, value) => MapEntry(
                key,
                discipline == data[key].split('\n')[0]
                    ? rowData(
                        data[key],
                        timeTable
                                .where((element) => element.day == value)
                                .isNotEmpty
                            ? timeTable
                                .where((element) => element.day == value)
                                .first
                            : null,
                        context,
                        isRule,
                        discipline ?? "",
                        venue,
                        daytime)
                    : rowData("", null, context, isRule, discipline ?? "",
                        venue, daytime)))
            .values
            .toList());
  }
}

Widget rowData(String data, RulesTimeTable? timeTable, BuildContext context,
    bool? isRule, String discipline, String venue, String daytime) {
  return Consumer<TimetableViewModel>(
    builder: (context, provider, child) {
      timeTable != null ? provider.setListTempTimeTable(timeTable) : null;
      return InkWell(
          onTap: () {
            if (data != "") {
              isRule == null
                  ? showDialog(
                      context: context,
                      builder: ((context) => ChangeNotifierProvider(
                            create: (_) => PreScheduleViewModel(),
                            child: Consumer<PreScheduleViewModel>(
                                builder: (context, provider, child) =>
                                    AlertDialog(
                                      content: text_medium("Are You Sure?"),
                                      title: text_medium("Warning!",
                                          color: shadowColorDark, font: 14),
                                      actions: [
                                        OutlinedButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text("No")),
                                        ElevatedButton(
                                            onPressed: () async {
                                              showLoaderDialog(
                                                  context, "Loading..");

                                              PreSchedule schedule =
                                                  PreSchedule(
                                                      id: 0,
                                                      status: false,
                                                      timeTableId:
                                                          timeTable!.id,
                                                      venueName: venue,
                                                      starttime:
                                                          daytime.split(',')[1],
                                                      endtime:
                                                          daytime.split(',')[2],
                                                      day:
                                                          daytime.split(',')[0],
                                                      date: daytime
                                                          .split(',')[3]);

                                              await provider
                                                  .insertdata(schedule);

                                              if (provider.userError != null) {
                                                Navigator.pop(context);
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snack_bar(
                                                        provider
                                                            .userError!.message
                                                            .toString(),
                                                        false));
                                                Navigator.pop(context);
                                              } else {
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snack_bar(
                                                        "Class PreScheduled",
                                                        true));
                                              }
                                            },
                                            child: const Text("Yes")),
                                      ],
                                    )),
                          )))
                  : provider.updateValue(timeTable!);
            }
          },
          child: Container(
              height: 80,
              width: 55,
              decoration: BoxDecoration(
                  color: data == ""
                      ? backgroundColorLight
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
