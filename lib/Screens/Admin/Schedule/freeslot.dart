// ignore_for_file: must_be_immutable, non_constant_identifier_names, unused_local_variable

import 'package:flutter/material.dart';
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
  FreeSlotView({super.key, required this.user,required this.discipline});
  User user;
  String discipline;

  @override
  Widget build(BuildContext context) {
    final venueViewModel = context.watch<VenueViewModel>();
    String startdate = "";
    String enddate = "";

    return Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(
        slivers: [
          appbar("Free Slot"),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                topbar(context),
                const SizedBox(
                  height: 30,
                ),
                Container(
                    color: backgroundColor,
                    child: ChangeNotifierProvider(
                      create: (context) => ReScheduleViewModel(),
                      child: Consumer<ReScheduleViewModel>(
                        builder: (context, provider, child) =>
                            ScheduleTable(context, provider, venueViewModel,discipline),
                      ),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }

  Padding topbar(BuildContext context) {
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
              child: CircleAvatar(
                  radius: 33,
                  backgroundImage:
                      NetworkImage("$getuserimage${user.role}/${user.image}")),
            ),
            const SizedBox(
              width: 5,
              height: 20,
            ),
            text_medium(user.name.toString())
          ],
        ),
      ),
    );
  }

  Widget ScheduleTable(BuildContext context,
      ReScheduleViewModel rescheduleviewmodel, VenueViewModel venueViewModel,String discipline) {
    if (rescheduleviewmodel.loading || venueViewModel.loading) {
      return apploading();
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
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  timeSchedule("08:30-\n10:00"),
                  const SizedBox(
                    height: 20,
                  ),
                  timeSchedule("10:00-\n11:30"),
                  const SizedBox(
                    height: 25,
                  ),
                  timeSchedule("11:30-\n01:00"),
                  const SizedBox(
                    height: 20,
                  ),
                  timeSchedule("01:30-\n03:00"),
                  const SizedBox(
                    height: 20,
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
                  ScheduleConditions(
                      rescheduleviewmodel, venueViewModel, "08:30"),
                  ScheduleConditions(
                      rescheduleviewmodel, venueViewModel, "10:00"),
                  ScheduleConditions(
                      rescheduleviewmodel, venueViewModel, "11:30"),
                  ScheduleConditions(
                      rescheduleviewmodel, venueViewModel, "01:30"),
                  ScheduleConditions(
                      rescheduleviewmodel, venueViewModel, "03:00"),
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

  Row ScheduleConditions(ReScheduleViewModel rescheduleviewmodel,
      VenueViewModel venueViewModel, String time) {
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

    return rowSchedule(monlst, tuelst, wedlst, thulst, frilst, time,
        rescheduleviewmodel, venueViewModel);
  }

  Padding timeSchedule(String time) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(time),
    );
  }

  Row rowSchedule(
      List<String> mondata,
      List<String> tueData,
      List<String> wedData,
      List<String> thuData,
      List<String> friData,
      String time,
      ReScheduleViewModel reScheduleViewModel,
      VenueViewModel venueViewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          width: 20,
        ),
        rowData(mondata, "Mon", time, reScheduleViewModel, venueViewModel),
        rowData(tueData, "Tue", time, reScheduleViewModel, venueViewModel),
        rowData(wedData, "Wed", time, reScheduleViewModel, venueViewModel),
        rowData(thuData, "Thu", time, reScheduleViewModel, venueViewModel),
        rowData(friData, "Fri", time, reScheduleViewModel, venueViewModel),
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
}
