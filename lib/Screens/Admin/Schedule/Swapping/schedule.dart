// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously, must_be_immutable

import 'package:flutter/material.dart';
import 'package:live_streaming/Model/Admin/timetable.dart';
import 'package:live_streaming/Model/Admin/user.dart';
import 'package:live_streaming/Screens/Admin/Schedule/Swapping/teacher_details.dart';
import 'package:live_streaming/utilities/constants.dart';
import 'package:live_streaming/view_models/Admin/swapping_view_model.dart';
import 'package:live_streaming/view_models/Admin/timetable.dart';
import 'package:live_streaming/widget/components/appbar.dart';
import 'package:live_streaming/widget/components/apploading.dart';
import 'package:live_streaming/widget/components/errormessage.dart';
import 'package:live_streaming/widget/textcomponents/medium_text.dart';
import 'package:live_streaming/widget/topbar.dart';
import 'package:provider/provider.dart';

class SwappingSchedule extends StatelessWidget {
  SwappingSchedule({super.key, required this.user});
  User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColorLight,
      body: CustomScrollView(
        slivers: [
          appbar("Select Schedule", bgColor: primaryColor, isGreen: true),
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
                    const SizedBox(
                      height: 10,
                    ),
                    topBar(
                        context,
                        user.image == null
                            ? ""
                            : "$getuserimage${user.role}/${user.image}",
                        user.name.toString()),
                    ChangeNotifierProvider(
                      create: ((context) => TimetableViewModel(user.name!)),
                      child: Container(
                        color: backgroundColor,
                        child: Consumer<TimetableViewModel>(
                            builder: (context, provider, child) {
                          return selectSchedule(context, provider);
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget selectSchedule(
    BuildContext context, TimetableViewModel timetableViewModel) {
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
                      const SizedBox(
                        width: 20,
                      ),
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
                                    context,
                                  )
                                : rowSchedule("", "", "", "", "", [], context))
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

Widget ScheduleConditions(List<TimeTable> timeTable, BuildContext context) {
  String getScheduleText(String day) {
    final matchingTimetable = timeTable.where((e) => e.day == day);

    return matchingTimetable.isNotEmpty
        ? "${matchingTimetable.first.discipline}\n${matchingTimetable.first.courseName}\n${matchingTimetable.first.venue}"
        : "";
  }

  return rowSchedule(
      getScheduleText("Monday"),
      getScheduleText("Tuesday"),
      getScheduleText("Wednesday"),
      getScheduleText("Thursday"),
      getScheduleText("Friday"),
      timeTable,
      context);
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

Row rowSchedule(String mondata, String tueData, String wedData, String thuData,
    String friData, List<TimeTable> timeTable, BuildContext context) {
  List<String> days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];
  List data = [mondata, tueData, wedData, thuData, friData];

  return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: days
          .asMap()
          .map((key, value) => MapEntry(
              key,
              rowData(
                  data[key],
                  timeTable.where((element) => element.day == value).isNotEmpty
                      ? timeTable.where((element) => element.day == value).first
                      : null,
                  context)))
          .values
          .toList());
}

Widget rowData(String data, TimeTable? timeTable, BuildContext context) {
  return InkWell(
      onTap: () {
        if (timeTable != null) {
          context.read<SwappingViewModel>().getdata(timeTable.day,
              timeTable.starttime, timeTable.endtime, timeTable.id);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) => SwappingTeacherDetails(
                        day: timeTable.day,
                        endTime: timeTable.endtime,
                        startTime: timeTable.starttime,
                        id: timeTable.id,
                      ))));
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
                color: data == "" ? shadowColorLight : backgroundColorLight),
          ))));
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
