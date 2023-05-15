// ignore_for_file: must_be_immutable, non_constant_identifier_names, unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:live_streaming/Model/Admin/timetable.dart';
import 'package:live_streaming/Model/Admin/user.dart';
import 'package:live_streaming/Model/Admin/venue.dart';
import 'package:live_streaming/Screens/Admin/Schedule/teacher_schedule_select.dart';
import 'package:live_streaming/view_models/Admin/venue_view_model.dart';
import 'package:live_streaming/widget/components/appbar.dart';
import 'package:live_streaming/widget/mybutton.dart';
import 'package:live_streaming/widget/snack_bar.dart';
import 'package:live_streaming/widget/textcomponents/medium_text.dart';
import 'package:provider/provider.dart';
import '../../../utilities/constants.dart';
import '../../../view_models/Admin/reschedule_view_model.dart';
import '../../../widget/components/apploading.dart';
import '../../../widget/components/errormessage.dart';

class FreeSlotView extends StatelessWidget {
  FreeSlotView(
      {super.key,
      required this.userValue,
      required this.discipline,
      required this.startdate,
      required this.enddate});
  String userValue;
  String discipline;
  String startdate;
  String enddate;

  @override
  Widget build(BuildContext context) {
    final venueViewModel = context.watch<VenueViewModel>();
    User user = User.fromJson(jsonDecode(userValue));
    final startDate = DateTime(int.parse(startdate.split('-')[0]),
        int.parse(startdate.split('-')[1]), int.parse(startdate.split('-')[2]));
    final endDate = DateTime(int.parse(enddate.split('-')[0]),
        int.parse(enddate.split('-')[1]), int.parse(enddate.split('-')[2]));
    List<String> dayNames = getDayNames(startDate, endDate);
    return Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(
        slivers: [
          appbar("Free Slot"),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                topbar(context, user, discipline),
                const SizedBox(
                  height: 30,
                ),
                Container(
                    color: backgroundColor,
                    child: Consumer<ReScheduleViewModel>(
                      builder: (context, provider, child) => ScheduleTable(
                          context,
                          provider,
                          venueViewModel,
                          discipline,
                          user,
                          dayNames),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }

  Padding topbar(BuildContext context, User user, String discipline) {
    return Padding(
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
      List<String> dayNames) {
    List<String> daysHeader = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'];

    List<Map<String, dynamic>> timeTable = [
      {'start': '08:30', 'end': '10:00'},
      {'start': '10:00', 'end': '11:30'},
      {'start': '11:30', 'end': '01:00'},
      {'start': '01:30', 'end': '03:00'},
      {'start': '03:00', 'end': '04:30'}
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
                        .map((e) => ScheduleConditions(rescheduleviewmodel,
                            venueViewModel, e['start'], daysHeader, dayNames))
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => TeacherScheduleScreen(
                              user: user,
                              venue: rescheduleviewmodel.selectedvalue!,
                              daytime: rescheduleviewmodel.Daytime,
                              discipline: discipline,
                            ))));
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
      List<String> dayNames) {
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
        if (t.day == "Monday") {
          Venue v = vmonlst.where((element) => element.name == t.venue).first;
          monlst.remove(v.name);
          v = vmonlst.where((element) => element.name == t.venue).first;
          monlst.remove(v.name);
        } else if (t.day == "Tuesday") {
          Venue v = vtuelst.where((element) => element.name == t.venue).first;
          tuelst.remove(v.name);
        } else if (t.day == "Wednesday") {
          Venue v = vwedlst.where((element) => element.name == t.venue).first;
          wedlst.remove(v.name);
        } else if (t.day == "Thursday") {
          Venue v = vthulst.where((element) => element.name == t.venue).first;
          thulst.remove(v.name);
        } else if (t.day == "Friday") {
          Venue v = vfrilst.where((element) => element.name == t.venue).first;
          frilst.remove(v.name);
        }
      }
    }

    if (!dayNames.contains("Monday") || monlst.length==1) {
      monlst = [];
      vmonlst = [];
    }
    if (!dayNames.contains("Tuesday")|| tuelst.length==1) {
      tuelst = [];
      vtuelst = [];
    }
    if (!dayNames.contains("Wednesday")|| wedlst.length==1) {
      wedlst = [];
      vwedlst = [];
    }
    if (!dayNames.contains("Thursday")|| thulst.length==1) {
      thulst = [];
      vthulst = [];
    }
    if (!dayNames.contains("Friday")|| frilst.length==1) {
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
                              : e == "Thu"
                                  ? thulst
                                  : frilst,
                  e,
                  time,
                  rescheduleviewmodel,
                  venueViewModel))
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

  Widget rowData(List<String> lst, String day, String time,
      ReScheduleViewModel reScheduleViewModel, VenueViewModel venueViewModel) {
    return Consumer<ReScheduleViewModel>(builder: (context, provider, child) {
      time = "$time:00";
      return Container(
          height: 70,
          width: 55,
          decoration: BoxDecoration(
              color: backgroundColor,
              border: Border.all(
                color: backgroundColor2,
              )),
          child: DropdownButton<String>(
            isExpanded: true,
            underline: const SizedBox(),
            value: day == "Mon" && time == "08:30:00"
                ? reScheduleViewModel.mon8
                : day == "Tue" && time == "08:30:00"
                    ? reScheduleViewModel.tue8
                    : day == "Wed" && time == "08:30:00"
                        ? reScheduleViewModel.wed8
                        : day == "Thu" && time == "08:30:00"
                            ? reScheduleViewModel.thu8
                            : day == "Fri" && time == "08:30:00"
                                ? reScheduleViewModel.fri8
                                : day == "Mon" && time == "10:00:00"
                                    ? reScheduleViewModel.mon10
                                    : day == "Tue" && time == "10:00:00"
                                        ? reScheduleViewModel.tue10
                                        : day == "Wed" && time == "10:00:00"
                                            ? reScheduleViewModel.wed10
                                            : day == "Thu" && time == "10:00:00"
                                                ? reScheduleViewModel.thu10
                                                : day == "Fri" &&
                                                        time == "10:00:00"
                                                    ? reScheduleViewModel.fri10
                                                    : day == "Mon" &&
                                                            time == "11:30:00"
                                                        ? reScheduleViewModel
                                                            .mon11
                                                        : day == "Tue" &&
                                                                time ==
                                                                    "11:30:00"
                                                            ? reScheduleViewModel
                                                                .tue11
                                                            : day == "Wed" &&
                                                                    time ==
                                                                        "11:30:00"
                                                                ? reScheduleViewModel
                                                                    .wed11
                                                                : day == "Thu" &&
                                                                        time ==
                                                                            "11:30:00"
                                                                    ? reScheduleViewModel
                                                                        .thu11
                                                                    : day == "Fri" &&
                                                                            time ==
                                                                                "11:30:00"
                                                                        ? reScheduleViewModel
                                                                            .fri11
                                                                        : day == "Mon" &&
                                                                                time == "01:30:00"
                                                                            ? reScheduleViewModel.mon1
                                                                            : day == "Tue" && time == "01:30:00"
                                                                                ? reScheduleViewModel.tue1
                                                                                : day == "Wed" && time == "01:30:00"
                                                                                    ? reScheduleViewModel.wed1
                                                                                    : day == "Thu" && time == "01:30:00"
                                                                                        ? reScheduleViewModel.thu1
                                                                                        : day == "Fri" && time == "01:30:00"
                                                                                            ? reScheduleViewModel.fri1
                                                                                            : day == "Mon" && time == "03:00:00"
                                                                                                ? reScheduleViewModel.mon3
                                                                                                : day == "Tue" && time == "03:00:00"
                                                                                                    ? reScheduleViewModel.tue3
                                                                                                    : day == "Wed" && time == "03:00:00"
                                                                                                        ? reScheduleViewModel.wed3
                                                                                                        : day == "Thu" && time == "03:00:00"
                                                                                                            ? reScheduleViewModel.thu3
                                                                                                            : reScheduleViewModel.fri3,
            onChanged: reScheduleViewModel.mon8 != ""
                ? day == "Mon" && time == "08:30:00"
                    ? ((value) => DropdownOnChanged(value ?? "", day, time,
                        reScheduleViewModel, venueViewModel))
                    : null
                : reScheduleViewModel.mon10 != ""
                    ? day == "Mon" && time == "10:00:00"
                        ? ((value) => DropdownOnChanged(value ?? "", day, time,
                            reScheduleViewModel, venueViewModel))
                        : null
                    : reScheduleViewModel.mon11 != ""
                        ? day == "Mon" && time == "11:30:00"
                            ? ((value) => DropdownOnChanged(value ?? "", day,
                                time, reScheduleViewModel, venueViewModel))
                            : null
                        : reScheduleViewModel.mon1 != ""
                            ? day == "Mon" && time == "01:30:00"
                                ? ((value) => DropdownOnChanged(
                                    value ?? "",
                                    day,
                                    time,
                                    reScheduleViewModel,
                                    venueViewModel))
                                : null
                            : reScheduleViewModel.mon3 != ""
                                ? day == "Mon" && time == "03:00:00"
                                    ? ((value) => DropdownOnChanged(
                                        value ?? "",
                                        day,
                                        time,
                                        reScheduleViewModel,
                                        venueViewModel))
                                    : null
                                : reScheduleViewModel.tue8 != ""
                                    ? day == "Tue" && time == "08:30:00"
                                        ? ((value) => DropdownOnChanged(
                                            value ?? "",
                                            day,
                                            time,
                                            reScheduleViewModel,
                                            venueViewModel))
                                        : null
                                    : reScheduleViewModel.tue10 != ""
                                        ? day == "Tue" && time == "10:00:00"
                                            ? ((value) => DropdownOnChanged(
                                                value ?? "",
                                                day,
                                                time,
                                                reScheduleViewModel,
                                                venueViewModel))
                                            : null
                                        : reScheduleViewModel.tue11 != ""
                                            ? day == "Tue" && time == "11:30:00"
                                                ? ((value) => DropdownOnChanged(
                                                    value ?? "",
                                                    day,
                                                    time,
                                                    reScheduleViewModel,
                                                    venueViewModel))
                                                : null
                                            : reScheduleViewModel.tue1 != ""
                                                ? day == "Tue" &&
                                                        time == "01:30:00"
                                                    ? ((value) =>
                                                        DropdownOnChanged(value ?? "", day, time, reScheduleViewModel, venueViewModel))
                                                    : null
                                                : reScheduleViewModel.tue3 != ""
                                                    ? day == "Tue" && time == "03:00:00"
                                                        ? ((value) => DropdownOnChanged(value ?? "", day, time, reScheduleViewModel, venueViewModel))
                                                        : null
                                                    : reScheduleViewModel.wed8 != ""
                                                        ? day == "Wed" && time == "08:30:00"
                                                            ? ((value) => DropdownOnChanged(value ?? "", day, time, reScheduleViewModel, venueViewModel))
                                                            : null
                                                        : reScheduleViewModel.wed10 != ""
                                                            ? day == "Wed" && time == "10:00:00"
                                                                ? ((value) => DropdownOnChanged(value ?? "", day, time, reScheduleViewModel, venueViewModel))
                                                                : null
                                                            : reScheduleViewModel.wed11 != ""
                                                                ? day == "Wed" && time == "11:30:00"
                                                                    ? ((value) => DropdownOnChanged(value ?? "", day, time, reScheduleViewModel, venueViewModel))
                                                                    : null
                                                                : reScheduleViewModel.wed1 != ""
                                                                    ? day == "Wed" && time == "01:30:00"
                                                                        ? ((value) => DropdownOnChanged(value ?? "", day, time, reScheduleViewModel, venueViewModel))
                                                                        : null
                                                                    : reScheduleViewModel.wed3 != ""
                                                                        ? day == "Wed" && time == "03:00:00"
                                                                            ? ((value) => DropdownOnChanged(value ?? "", day, time, reScheduleViewModel, venueViewModel))
                                                                            : null
                                                                        : reScheduleViewModel.thu8 != ""
                                                                            ? day == "Thu" && time == "08:30:00"
                                                                                ? ((value) => DropdownOnChanged(value ?? "", day, time, reScheduleViewModel, venueViewModel))
                                                                                : null
                                                                            : reScheduleViewModel.thu10 != ""
                                                                                ? day == "Thu" && time == "10:00:00"
                                                                                    ? ((value) => DropdownOnChanged(value ?? "", day, time, reScheduleViewModel, venueViewModel))
                                                                                    : null
                                                                                : reScheduleViewModel.thu11 != ""
                                                                                    ? day == "Thu" && time == "11:30:00"
                                                                                        ? ((value) => DropdownOnChanged(value ?? "", day, time, reScheduleViewModel, venueViewModel))
                                                                                        : null
                                                                                    : reScheduleViewModel.thu1 != ""
                                                                                        ? day == "Thu" && time == "01:30:00"
                                                                                            ? ((value) => DropdownOnChanged(value ?? "", day, time, reScheduleViewModel, venueViewModel))
                                                                                            : null
                                                                                        : reScheduleViewModel.thu3 != ""
                                                                                            ? day == "Thu" && time == "03:00:00"
                                                                                                ? ((value) => DropdownOnChanged(value ?? "", day, time, reScheduleViewModel, venueViewModel))
                                                                                                : null
                                                                                            : reScheduleViewModel.fri8 != ""
                                                                                                ? day == "Fri" && time == "08:30:00"
                                                                                                    ? ((value) => DropdownOnChanged(value ?? "", day, time, reScheduleViewModel, venueViewModel))
                                                                                                    : null
                                                                                                : reScheduleViewModel.fri10 != ""
                                                                                                    ? day == "Fri" && time == "10:00:00"
                                                                                                        ? ((value) => DropdownOnChanged(value ?? "", day, time, reScheduleViewModel, venueViewModel))
                                                                                                        : null
                                                                                                    : reScheduleViewModel.fri11 != ""
                                                                                                        ? day == "Fri" && time == "11:30:00"
                                                                                                            ? ((value) => DropdownOnChanged(value ?? "", day, time, reScheduleViewModel, venueViewModel))
                                                                                                            : null
                                                                                                        : reScheduleViewModel.fri1 != ""
                                                                                                            ? day == "Fri" && time == "01:30:00"
                                                                                                                ? ((value) => DropdownOnChanged(value ?? "", day, time, reScheduleViewModel, venueViewModel))
                                                                                                                : null
                                                                                                            : reScheduleViewModel.fri3 != ""
                                                                                                                ? day == "Fri" && time == "03:00:00"
                                                                                                                    ? ((value) => DropdownOnChanged(value ?? "", day, time, reScheduleViewModel, venueViewModel))
                                                                                                                    : null
                                                                                                                : ((value) => DropdownOnChanged(value ?? "", day, time, reScheduleViewModel, venueViewModel)),
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

  void DropdownOnChanged(String value, String day, String time,
      ReScheduleViewModel reScheduleViewModel, VenueViewModel venueViewModel) {
    day == "Mon" && time == "08:30:00"
        ? reScheduleViewModel.mon8 = value
        : day == "Tue" && time == "08:30:00"
            ? reScheduleViewModel.tue8 = value
            : day == "Wed" && time == "08:30:00"
                ? reScheduleViewModel.wed8 = value
                : day == "Thu" && time == "08:30:00"
                    ? reScheduleViewModel.thu8 = value
                    : day == "Fri" && time == "08:30:00"
                        ? reScheduleViewModel.fri8 = value
                        : day == "Mon" && time == "10:00:00"
                            ? reScheduleViewModel.mon10 = value
                            : day == "Tue" && time == "10:00:00"
                                ? reScheduleViewModel.tue10 = value
                                : day == "Wed" && time == "10:00:00"
                                    ? reScheduleViewModel.wed10 = value
                                    : day == "Thu" && time == "10:00:00"
                                        ? reScheduleViewModel.thu10 = value
                                        : day == "Fri" && time == "10:00:00"
                                            ? reScheduleViewModel.fri10 = value
                                            : day == "Mon" && time == "11:30:00"
                                                ? reScheduleViewModel.mon11 =
                                                    value
                                                : day == "Tue" &&
                                                        time == "11:30:00"
                                                    ? reScheduleViewModel.tue11 =
                                                        value
                                                    : day == "Wed" &&
                                                            time == "11:30:00"
                                                        ? reScheduleViewModel
                                                            .wed11 = value
                                                        : day == "Thu" &&
                                                                time ==
                                                                    "11:30:00"
                                                            ? reScheduleViewModel
                                                                .thu11 = value
                                                            : day == "Fri" &&
                                                                    time ==
                                                                        "11:30:00"
                                                                ? reScheduleViewModel
                                                                        .fri11 =
                                                                    value
                                                                : day == "Mon" &&
                                                                        time ==
                                                                            "01:30:00"
                                                                    ? reScheduleViewModel
                                                                            .mon1 =
                                                                        value
                                                                    : day == "Tue" &&
                                                                            time ==
                                                                                "01:30:00"
                                                                        ? reScheduleViewModel.tue1 =
                                                                            value
                                                                        : day == "Wed" &&
                                                                                time == "01:30:00"
                                                                            ? reScheduleViewModel.wed1 = value
                                                                            : day == "Thu" && time == "01:30:00"
                                                                                ? reScheduleViewModel.thu1 = value
                                                                                : day == "Fri" && time == "01:30:00"
                                                                                    ? reScheduleViewModel.fri1 = value
                                                                                    : day == "Mon" && time == "03:00:00"
                                                                                        ? reScheduleViewModel.mon3 = value
                                                                                        : day == "Tue" && time == "03:00:00"
                                                                                            ? reScheduleViewModel.tue3 = value
                                                                                            : day == "Wed" && time == "03:00:00"
                                                                                                ? reScheduleViewModel.wed3 = value
                                                                                                : day == "Thu" && time == "03:00:00"
                                                                                                    ? reScheduleViewModel.thu3 = value
                                                                                                    : reScheduleViewModel.fri3 = value;
    bool status = venueViewModel.lstvenue
        .where((element) => element.name == value)
        .isNotEmpty;

    if (time == "08:30:00") {
      reScheduleViewModel.Daytime = "$day,08:30,10:00";
    } else if (time == "10:00:00") {
      reScheduleViewModel.Daytime = "$day,10:00,11:30";
    } else if (time == "11:30:00") {
      reScheduleViewModel.Daytime = "$day,11:30,01:00";
    } else if (time == "01:30:00") {
      reScheduleViewModel.Daytime = "$day,01:00,03:00";
    } else if (time == "03:00:00") {
      reScheduleViewModel.Daytime = "$day,03:00,04:30";
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

  List<String> getDayNames(DateTime start, DateTime end) {
    final dayNames = <String>[];
    final dateFormat = DateFormat('EEEE');

    DateTime currentDate = start;

    while (currentDate.isBefore(end) || currentDate.isAtSameMomentAs(end)) {
      final dayName = dateFormat.format(currentDate);
      dayNames.add(dayName);
      currentDate = currentDate.add(const Duration(days: 1));
    }

    return dayNames;
  }
}
