// ignore_for_file: must_be_immutable, non_constant_identifier_names, unused_local_variable, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:live_streaming/Model/Admin/schedule.dart';
import 'package:live_streaming/Model/Admin/timetable.dart';
import 'package:live_streaming/Model/Admin/user.dart';
import 'package:live_streaming/Model/Admin/venue.dart';
import 'package:live_streaming/Screens/Admin/Schedule/teacher_schedule_select.dart';
import 'package:live_streaming/utilities/constants.dart';
import 'package:live_streaming/view_models/Admin/reschedule_view_model.dart';
import 'package:live_streaming/view_models/Admin/venue_view_model.dart';
import 'package:live_streaming/widget/components/appbar.dart';
import 'package:live_streaming/widget/components/apploading.dart';
import 'package:live_streaming/widget/components/errormessage.dart';
import 'package:live_streaming/widget/mybutton.dart';
import 'package:live_streaming/widget/progress_indicator.dart';
import 'package:live_streaming/widget/snack_bar.dart';
import 'package:live_streaming/widget/textcomponents/medium_text.dart';
import 'package:provider/provider.dart';

class FreeSlotView extends StatelessWidget {
  FreeSlotView(
      {super.key,
      required this.userValue,
      required this.discipline,
      required this.startdate,
      required this.enddate,
      required this.type});
  String userValue;
  String discipline;
  String startdate;
  String enddate;
  String type;

  @override
  Widget build(BuildContext context) {
    final venueViewModel = context.watch<VenueViewModel>();
    User user = User.fromJson(jsonDecode(userValue));
    final startDate = DateTime(int.parse(startdate.split('-')[0]),
        int.parse(startdate.split('-')[1]), int.parse(startdate.split('-')[2]));
    final endDate = DateTime(int.parse(enddate.split('-')[0]),
        int.parse(enddate.split('-')[1]), int.parse(enddate.split('-')[2]));
    List<Map<String, dynamic>> dayNamesAndDate =
        getDayNamesAndDate(startDate, endDate);
    return Scaffold(
      backgroundColor: backgroundColorLight,
      body: CustomScrollView(
        slivers: [
          appbar("Free Slot", bgColor: primaryColor, isGreen: true),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    topbar(context, user, discipline),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                        color: backgroundColorLight,
                        child: Consumer<ReScheduleViewModel>(
                          builder: (context, provider, child) => ScheduleTable(
                              context,
                              provider,
                              venueViewModel,
                              discipline,
                              user,
                              dayNamesAndDate,
                              type),
                        )),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Padding topbar(BuildContext context, User user, String discipline) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.15,
        child: Row(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: user.image == null
                  ? const CircleAvatar(
                      radius: 33,
                      backgroundImage:
                          AssetImage("assets/avaters/Avatar Default.jpg"))
                  : CircleAvatar(
                      radius: 33,
                      backgroundImage: NetworkImage(
                          "$getuserimage${user.role}/${user.image}")),
            ),
            const SizedBox(
              width: 5,
              height: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                text_medium(user.name.toString(), color: shadowColorLight),
                const SizedBox(
                  height: 5,
                ),
                text_medium(discipline, color: shadowColorLight),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget ScheduleTable(
      BuildContext context,
      ReScheduleViewModel rescheduleviewmodel,
      VenueViewModel venueViewModel,
      String discipline,
      User user,
      List<Map<String, dynamic>> dayNamesAndDate,
      String type) {
    List<String> daysHeader = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'];

    List<Map<String, dynamic>> timeTable = [
      {'start': '08:30', 'end': '10:00'},
      {'start': '10:00', 'end': '11:30'},
      {'start': '11:30', 'end': '01:00'},
      {'start': '01:30', 'end': '03:00'},
      {'start': '03:00', 'end': '04:30'}
    ];

    List<Map<String, dynamic>> timeTable1 = [
      {'start': '08:30:00', 'end': '10:00:00'},
      {'start': '10:00:00', 'end': '11:30:00'},
      {'start': '11:30:00', 'end': '01:00:00'},
      {'start': '01:30:00', 'end': '03:00:00'},
      {'start': '03:00:00', 'end': '04:30:00'}
    ];
    if (rescheduleviewmodel.loading || venueViewModel.loading) {
      return apploading(context);
    } else if (rescheduleviewmodel.userError != null ||
        venueViewModel.userError != null) {
      return ErrorMessage(rescheduleviewmodel.userError == null
          ? venueViewModel.userError!.message.toString()
          : rescheduleviewmodel.userError!.message.toString());
    } else if (venueViewModel.lstvenue.isEmpty) {
      return ErrorMessage("Venue Empty");
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.13,
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
                        children:
                            daysHeader.map((e) => scheduleColumn(e)).toList(),
                      ),
                    ],
                  ),
                  Column(
                    children: timeTable
                        .map((e) => ScheduleConditions(
                            rescheduleviewmodel,
                            venueViewModel,
                            e['start'],
                            daysHeader,
                            dayNamesAndDate,
                            timeTable1))
                        .toList(),
                  )
                ],
              ),
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: mybutton(() {
              if (rescheduleviewmodel.selectedvalue != null) {
                if (type == 'Reschedule') {
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
                                            teacherSlotId: context
                                                .read<ReScheduleViewModel>()
                                                .teacherSlotId,
                                            venueName: rescheduleviewmodel
                                                .selectedvalue!.name,
                                            starttime: rescheduleviewmodel
                                                .Daytime.split(',')[1],
                                            endtime: rescheduleviewmodel.Daytime
                                                .split(',')[2],
                                            day: rescheduleviewmodel.Daytime
                                                .split(',')[0],
                                            date: rescheduleviewmodel.Daytime
                                                .split(',')[3]);

                                        await provider.insertdata(schedule);

                                        if (provider.userError != null) {
                                          Navigator.pop(context);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snack_bar(
                                                  provider.userError!.message
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
                                                  "Class Rescheduled", true));
                                        }
                                      },
                                      child: const Text("Yes")),
                                ],
                              ))));
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => TeacherScheduleScreen(
                                user: user,
                                venue: rescheduleviewmodel.selectedvalue!,
                                daytime: rescheduleviewmodel.Daytime,
                                discipline: discipline,
                              ))));
                }
              } else {
                ScaffoldMessenger.of(context)
                    .showSnackBar(snack_bar("Select any Slot", false));
              }
            }, "Okay", Icons.done))
      ],
    );
  }

  Row ScheduleConditions(
      ReScheduleViewModel rescheduleviewmodel,
      VenueViewModel venueViewModel,
      String time,
      List<String> days,
      List<Map<String, dynamic>> dayNamesAndDate,
      List<Map<String, dynamic>> timeTable) {
    List<String> monlst = [];
    List<String> tuelst = [];
    List<String> wedlst = [];
    List<String> thulst = [];
    List<String> frilst = [];
    List<Venue> vmonlst = [];
    List<Venue> vtuelst = [];
    List<Venue> vwedlst = [];
    List<Venue> vthulst = [];
    List<Venue> vfrilst = [];

    String v = "";
    monlst.add(v);
    tuelst.add(v);
    wedlst.add(v);
    thulst.add(v);
    frilst.add(v);

    for (Venue v in venueViewModel.lstvenue) {
      monlst.add(v.name.toString());
      tuelst.add(v.name.toString());
      wedlst.add(v.name.toString());
      thulst.add(v.name.toString());
      frilst.add(v.name.toString());
      vmonlst.add(v);
      vtuelst.add(v);
      vwedlst.add(v);
      vthulst.add(v);
      vfrilst.add(v);
    }

    for (TimeTable t in rescheduleviewmodel.lsttimetable) {
      if (t.starttime.toString() == time) {
        if (t.day == "Monday"&& monlst.isNotEmpty) {
          if (t.discipline == discipline) {
            monlst = [];
            vmonlst = [];
          } else {
            Venue v = vmonlst.where((element) => element.name == t.venue).first;
            monlst.remove(v.name);
          }
        } else if (t.day == "Tuesday"&& tuelst.isNotEmpty) {
          if (t.discipline == discipline) {
            tuelst = [];
            vtuelst = [];
          } else {
            Venue v = vtuelst.where((element) => element.name == t.venue).first;
            tuelst.remove(v.name);
          }
        } else if (t.day == "Wednesday"&& wedlst.isNotEmpty) {
          if (t.discipline == discipline) {
            wedlst = [];
            vwedlst = [];
          } else {
            Venue v = vwedlst.where((element) => element.name == t.venue).first;
            wedlst.remove(v.name);
          }
        } else if (t.day == "Thursday"&& thulst.isNotEmpty) {
          if (t.discipline == discipline) {
            thulst = [];
            vthulst = [];
          } else {
            Venue v = vthulst.where((element) => element.name == t.venue).first;
            thulst.remove(v.name);
          }
        } else if (t.day == "Friday"&& frilst.isNotEmpty) {
          if (t.discipline == discipline) {
            frilst = [];
            vfrilst = [];
          } else {
            Venue v = vfrilst.where((element) => element.name == t.venue).first;
            frilst.remove(v.name);
          }
        }
      }
    }

    rescheduleviewmodel.dayNamesAndDate = dayNamesAndDate;

    if (!dayNamesAndDate
            .where((element) => element['name'] == "Monday")
            .isNotEmpty ||
        monlst.length == 1) {
      monlst = [];
      vmonlst = [];
    }
    if (!dayNamesAndDate
            .where((element) => element['name'] == "Tuesday")
            .isNotEmpty ||
        tuelst.length == 1) {
      tuelst = [];
      vtuelst = [];
    }
    if (!dayNamesAndDate
            .where((element) => element['name'] == "Wednesday")
            .isNotEmpty ||
        wedlst.length == 1) {
      wedlst = [];
      vwedlst = [];
    }
    if (!dayNamesAndDate
            .where((element) => element['name'] == "Thursday")
            .isNotEmpty ||
        thulst.length == 1) {
      thulst = [];
      vthulst = [];
    }
    if (!dayNamesAndDate
            .where((element) => element['name'] == "Friday")
            .isNotEmpty ||
        frilst.length == 1) {
      frilst = [];
      vfrilst = [];
    }

    // return rowSchedule(monlst, tuelst, wedlst, thulst, frilst, time,
    //     rescheduleviewmodel, venueViewModel);

    return Row(
      children: [
        const SizedBox(
          width: 20,
        ),
        Row(
          children: days
              .map((e) => rowData(
                  e == "Mon"
                      ? monlst
                      : e == "Tue"
                          ? tuelst
                          : e == "Wed"
                              ? wedlst
                              : e == days[3]
                                  ? thulst
                                  : frilst,
                  e,
                  time,
                  rescheduleviewmodel,
                  venueViewModel,
                  days,
                  timeTable))
              .toList(),
        ),
      ],
    );
  }

  Column timeSchedule(String time, bool? iswhite, int i) {
    return Column(
      children: [
        SizedBox(
          height: i == 0 ? 40 : 25,
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

  Widget rowData(
      List<String> lst,
      String day,
      String time,
      ReScheduleViewModel reScheduleViewModel,
      VenueViewModel venueViewModel,
      List<String> days,
      List<Map<String, dynamic>> timeTable) {
    return Consumer<ReScheduleViewModel>(builder: (context, provider, child) {
      time = "$time:00";

      return Container(
          height: 70,
          width: 55,
          decoration: BoxDecoration(
              color: backgroundColorLight,
              border: Border.all(
                color: backgroundColor2,
              )),
          child: DropdownButton<String>(
            isExpanded: true,
            underline: const SizedBox(),
            value: day == days[0] && time == timeTable[0]['start']
                ? reScheduleViewModel.mon8
                : day == days[1] && time == timeTable[0]['start']
                    ? reScheduleViewModel.tue8
                    : day == days[2] && time == timeTable[0]['start']
                        ? reScheduleViewModel.wed8
                        : day == days[3] && time == timeTable[0]['start']
                            ? reScheduleViewModel.thu8
                            : day == days[4] && time == timeTable[0]['start']
                                ? reScheduleViewModel.fri8
                                : day == days[0] &&
                                        time == timeTable[1]['start']
                                    ? reScheduleViewModel.mon10
                                    : day == days[1] &&
                                            time == timeTable[1]['start']
                                        ? reScheduleViewModel.tue10
                                        : day == days[2] &&
                                                time == timeTable[1]['start']
                                            ? reScheduleViewModel.wed10
                                            : day == days[3] &&
                                                    time ==
                                                        timeTable[1]['start']
                                                ? reScheduleViewModel.thu10
                                                : day == days[4] &&
                                                        time ==
                                                            timeTable[1]
                                                                ['start']
                                                    ? reScheduleViewModel.fri10
                                                    : day == days[0] &&
                                                            time ==
                                                                timeTable[2]
                                                                    ['start']
                                                        ? reScheduleViewModel
                                                            .mon11
                                                        : day == days[1] &&
                                                                time ==
                                                                    timeTable[2]
                                                                        [
                                                                        'start']
                                                            ? reScheduleViewModel
                                                                .tue11
                                                            : day == days[2] &&
                                                                    time ==
                                                                        timeTable[2]
                                                                            [
                                                                            'start']
                                                                ? reScheduleViewModel
                                                                    .wed11
                                                                : day == days[3] &&
                                                                        time ==
                                                                            timeTable[2][
                                                                                'start']
                                                                    ? reScheduleViewModel
                                                                        .thu11
                                                                    : day == days[4] &&
                                                                            time ==
                                                                                timeTable[2][
                                                                                    'start']
                                                                        ? reScheduleViewModel
                                                                            .fri11
                                                                        : day == days[0] &&
                                                                                time == timeTable[3]['start']
                                                                            ? reScheduleViewModel.mon1
                                                                            : day == days[1] && time == timeTable[3]['start']
                                                                                ? reScheduleViewModel.tue1
                                                                                : day == days[2] && time == timeTable[3]['start']
                                                                                    ? reScheduleViewModel.wed1
                                                                                    : day == days[3] && time == timeTable[3]['start']
                                                                                        ? reScheduleViewModel.thu1
                                                                                        : day == days[4] && time == timeTable[3]['start']
                                                                                            ? reScheduleViewModel.fri1
                                                                                            : day == days[0] && time == timeTable[4]['start']
                                                                                                ? reScheduleViewModel.mon3
                                                                                                : day == days[1] && time == timeTable[4]['start']
                                                                                                    ? reScheduleViewModel.tue3
                                                                                                    : day == days[2] && time == timeTable[4]['start']
                                                                                                        ? reScheduleViewModel.wed3
                                                                                                        : day == days[3] && time == timeTable[4]['start']
                                                                                                            ? reScheduleViewModel.thu3
                                                                                                            : reScheduleViewModel.fri3,
            onChanged: reScheduleViewModel.mon8 != ""
                ? day == days[0] && time == timeTable[0]['start']
                    ? ((value) => DropdownOnChanged(value ?? "", day, time,
                        reScheduleViewModel, venueViewModel, days, timeTable))
                    : null
                : reScheduleViewModel.mon10 != ""
                    ? day == days[0] && time == timeTable[1]['start']
                        ? ((value) => DropdownOnChanged(
                            value ?? "",
                            day,
                            time,
                            reScheduleViewModel,
                            venueViewModel,
                            days,
                            timeTable))
                        : null
                    : reScheduleViewModel.mon11 != ""
                        ? day == days[0] && time == timeTable[2]['start']
                            ? ((value) => DropdownOnChanged(
                                value ?? "",
                                day,
                                time,
                                reScheduleViewModel,
                                venueViewModel,
                                days,
                                timeTable))
                            : null
                        : reScheduleViewModel.mon1 != ""
                            ? day == days[0] && time == timeTable[3]['start']
                                ? ((value) => DropdownOnChanged(
                                    value ?? "",
                                    day,
                                    time,
                                    reScheduleViewModel,
                                    venueViewModel,
                                    days,
                                    timeTable))
                                : null
                            : reScheduleViewModel.mon3 != ""
                                ? day == days[0] &&
                                        time == timeTable[4]['start']
                                    ? ((value) => DropdownOnChanged(
                                        value ?? "",
                                        day,
                                        time,
                                        reScheduleViewModel,
                                        venueViewModel,
                                        days,
                                        timeTable))
                                    : null
                                : reScheduleViewModel.tue8 != ""
                                    ? day == days[1] && time == timeTable[0]['start']
                                        ? ((value) => DropdownOnChanged(value ?? "", day, time, reScheduleViewModel, venueViewModel, days, timeTable))
                                        : null
                                    : reScheduleViewModel.tue10 != ""
                                        ? day == days[1] && time == timeTable[1]['start']
                                            ? ((value) => DropdownOnChanged(value ?? "", day, time, reScheduleViewModel, venueViewModel, days, timeTable))
                                            : null
                                        : reScheduleViewModel.tue11 != ""
                                            ? day == days[1] && time == timeTable[2]['start']
                                                ? ((value) => DropdownOnChanged(value ?? "", day, time, reScheduleViewModel, venueViewModel, days, timeTable))
                                                : null
                                            : reScheduleViewModel.tue1 != ""
                                                ? day == days[1] && time == timeTable[3]['start']
                                                    ? ((value) => DropdownOnChanged(value ?? "", day, time, reScheduleViewModel, venueViewModel, days, timeTable))
                                                    : null
                                                : reScheduleViewModel.tue3 != ""
                                                    ? day == days[1] && time == timeTable[4]['start']
                                                        ? ((value) => DropdownOnChanged(value ?? "", day, time, reScheduleViewModel, venueViewModel, days, timeTable))
                                                        : null
                                                    : reScheduleViewModel.wed8 != ""
                                                        ? day == days[2] && time == timeTable[0]['start']
                                                            ? ((value) => DropdownOnChanged(value ?? "", day, time, reScheduleViewModel, venueViewModel, days, timeTable))
                                                            : null
                                                        : reScheduleViewModel.wed10 != ""
                                                            ? day == days[2] && time == timeTable[1]['start']
                                                                ? ((value) => DropdownOnChanged(value ?? "", day, time, reScheduleViewModel, venueViewModel, days, timeTable))
                                                                : null
                                                            : reScheduleViewModel.wed11 != ""
                                                                ? day == days[2] && time == timeTable[2]['start']
                                                                    ? ((value) => DropdownOnChanged(value ?? "", day, time, reScheduleViewModel, venueViewModel, days, timeTable))
                                                                    : null
                                                                : reScheduleViewModel.wed1 != ""
                                                                    ? day == days[2] && time == timeTable[3]['start']
                                                                        ? ((value) => DropdownOnChanged(value ?? "", day, time, reScheduleViewModel, venueViewModel, days, timeTable))
                                                                        : null
                                                                    : reScheduleViewModel.wed3 != ""
                                                                        ? day == days[2] && time == timeTable[4]['start']
                                                                            ? ((value) => DropdownOnChanged(value ?? "", day, time, reScheduleViewModel, venueViewModel, days, timeTable))
                                                                            : null
                                                                        : reScheduleViewModel.thu8 != ""
                                                                            ? day == days[3] && time == timeTable[0]['start']
                                                                                ? ((value) => DropdownOnChanged(value ?? "", day, time, reScheduleViewModel, venueViewModel, days, timeTable))
                                                                                : null
                                                                            : reScheduleViewModel.thu10 != ""
                                                                                ? day == days[3] && time == timeTable[1]['start']
                                                                                    ? ((value) => DropdownOnChanged(value ?? "", day, time, reScheduleViewModel, venueViewModel, days, timeTable))
                                                                                    : null
                                                                                : reScheduleViewModel.thu11 != ""
                                                                                    ? day == days[3] && time == timeTable[2]['start']
                                                                                        ? ((value) => DropdownOnChanged(value ?? "", day, time, reScheduleViewModel, venueViewModel, days, timeTable))
                                                                                        : null
                                                                                    : reScheduleViewModel.thu1 != ""
                                                                                        ? day == days[3] && time == timeTable[3]['start']
                                                                                            ? ((value) => DropdownOnChanged(value ?? "", day, time, reScheduleViewModel, venueViewModel, days, timeTable))
                                                                                            : null
                                                                                        : reScheduleViewModel.thu3 != ""
                                                                                            ? day == days[3] && time == timeTable[4]['start']
                                                                                                ? ((value) => DropdownOnChanged(value ?? "", day, time, reScheduleViewModel, venueViewModel, days, timeTable))
                                                                                                : null
                                                                                            : reScheduleViewModel.fri8 != ""
                                                                                                ? day == days[4] && time == timeTable[0]['start']
                                                                                                    ? ((value) => DropdownOnChanged(value ?? "", day, time, reScheduleViewModel, venueViewModel, days, timeTable))
                                                                                                    : null
                                                                                                : reScheduleViewModel.fri10 != ""
                                                                                                    ? day == days[4] && time == timeTable[1]['start']
                                                                                                        ? ((value) => DropdownOnChanged(value ?? "", day, time, reScheduleViewModel, venueViewModel, days, timeTable))
                                                                                                        : null
                                                                                                    : reScheduleViewModel.fri11 != ""
                                                                                                        ? day == days[4] && time == timeTable[2]['start']
                                                                                                            ? ((value) => DropdownOnChanged(value ?? "", day, time, reScheduleViewModel, venueViewModel, days, timeTable))
                                                                                                            : null
                                                                                                        : reScheduleViewModel.fri1 != ""
                                                                                                            ? day == days[4] && time == timeTable[3]['start']
                                                                                                                ? ((value) => DropdownOnChanged(value ?? "", day, time, reScheduleViewModel, venueViewModel, days, timeTable))
                                                                                                                : null
                                                                                                            : reScheduleViewModel.fri3 != ""
                                                                                                                ? day == days[4] && time == timeTable[4]['start']
                                                                                                                    ? ((value) => DropdownOnChanged(value ?? "", day, time, reScheduleViewModel, venueViewModel, days, timeTable))
                                                                                                                    : null
                                                                                                                : ((value) => DropdownOnChanged(value ?? "", day, time, reScheduleViewModel, venueViewModel, days, timeTable)),
            items: lst
                .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(
                      e,
                      style: const TextStyle(fontSize: 12),
                    )))
                .toList(),
          ));
    });
  }

  void DropdownOnChanged(
      String value,
      String day,
      String time,
      ReScheduleViewModel reScheduleViewModel,
      VenueViewModel venueViewModel,
      List<String> days,
      List<Map<String, dynamic>> timeTable) {
    day == days[0] && time == timeTable[0]['start']
        ? reScheduleViewModel.mon8 = value
        : day == days[1] && time == timeTable[0]['start']
            ? reScheduleViewModel.tue8 = value
            : day == days[2] && time == timeTable[0]['start']
                ? reScheduleViewModel.wed8 = value
                : day == days[3] && time == timeTable[0]['start']
                    ? reScheduleViewModel.thu8 = value
                    : day == days[4] && time == timeTable[0]['start']
                        ? reScheduleViewModel.fri8 = value
                        : day == days[0] && time == timeTable[1]['start']
                            ? reScheduleViewModel.mon10 = value
                            : day == days[1] && time == timeTable[1]['start']
                                ? reScheduleViewModel.tue10 = value
                                : day == days[2] &&
                                        time == timeTable[1]['start']
                                    ? reScheduleViewModel.wed10 = value
                                    : day == days[3] &&
                                            time == timeTable[1]['start']
                                        ? reScheduleViewModel.thu10 = value
                                        : day == days[4] &&
                                                time == timeTable[1]['start']
                                            ? reScheduleViewModel.fri10 = value
                                            : day == days[0] &&
                                                    time ==
                                                        timeTable[2]['start']
                                                ? reScheduleViewModel.mon11 =
                                                    value
                                                : day == days[1] &&
                                                        time ==
                                                            timeTable[2]
                                                                ['start']
                                                    ? reScheduleViewModel.tue11 =
                                                        value
                                                    : day == days[2] &&
                                                            time ==
                                                                timeTable[2]
                                                                    ['start']
                                                        ? reScheduleViewModel
                                                            .wed11 = value
                                                        : day == days[3] &&
                                                                time ==
                                                                    timeTable[2][
                                                                        'start']
                                                            ? reScheduleViewModel
                                                                .thu11 = value
                                                            : day == days[4] &&
                                                                    time ==
                                                                        timeTable[2][
                                                                            'start']
                                                                ? reScheduleViewModel
                                                                        .fri11 =
                                                                    value
                                                                : day == days[0] &&
                                                                        time ==
                                                                            timeTable[3][
                                                                                'start']
                                                                    ? reScheduleViewModel
                                                                            .mon1 =
                                                                        value
                                                                    : day == days[1] &&
                                                                            time == timeTable[3]['start']
                                                                        ? reScheduleViewModel.tue1 = value
                                                                        : day == days[2] && time == timeTable[3]['start']
                                                                            ? reScheduleViewModel.wed1 = value
                                                                            : day == days[3] && time == timeTable[3]['start']
                                                                                ? reScheduleViewModel.thu1 = value
                                                                                : day == days[4] && time == timeTable[3]['start']
                                                                                    ? reScheduleViewModel.fri1 = value
                                                                                    : day == days[0] && time == timeTable[4]['start']
                                                                                        ? reScheduleViewModel.mon3 = value
                                                                                        : day == "Tue" && time == timeTable[4]['start']
                                                                                            ? reScheduleViewModel.tue3 = value
                                                                                            : day == days[2] && time == timeTable[4]['start']
                                                                                                ? reScheduleViewModel.wed3 = value
                                                                                                : day == days[3] && time == timeTable[4]['start']
                                                                                                    ? reScheduleViewModel.thu3 = value
                                                                                                    : reScheduleViewModel.fri3 = value;
    bool status = venueViewModel.lstvenue
        .where((element) => element.name == value)
        .isNotEmpty;

    String tempDay = day == 'Mon'
        ? "Monday"
        : day == 'Tue'
            ? 'Tuesday'
            : day == 'Wed'
                ? 'Wednesday'
                : day == 'Thu'
                    ? 'Thursday'
                    : 'Friday';
    String date = reScheduleViewModel.dayNamesAndDate
            .where((element) => element['name'] == tempDay)
            .isEmpty
        ? ""
        : reScheduleViewModel.dayNamesAndDate
            .where((element) => element['name'] == tempDay)
            .first['date']
            .toString()
            .split(' ')[0];

    for (var element in timeTable) {
      if (time == element['start']) {
        reScheduleViewModel.Daytime =
            "$tempDay,${element['start'].split(':')[0]}:${element['start'].split(':')[1]},${element['end'].split(':')[0]}:${element['end'].split(':')[1]},$date";
      }
    }

    if (status) {
      reScheduleViewModel.changeSelectedValue(venueViewModel.lstvenue
          .where((element) => element.name == value)
          .first);
    } else {
      reScheduleViewModel.changeSelectedValue(null);
    }
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

  List<Map<String, dynamic>> getDayNamesAndDate(DateTime start, DateTime end) {
    final dayNamesAndDate = <Map<String, dynamic>>[];
    final dateFormat = DateFormat('EEEE');

    DateTime currentDate = start;

    while (currentDate.isBefore(end) || currentDate.isAtSameMomentAs(end)) {
      final dayName = dateFormat.format(currentDate);
      dayNamesAndDate.add({'name': dayName, 'date': currentDate});
      currentDate = currentDate.add(const Duration(days: 1));
    }

    return dayNamesAndDate;
  }
}
