// ignore_for_file: must_be_immutable, non_constant_identifier_names, unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:live_streaming/Model/Admin/user.dart';
import 'package:live_streaming/utilities/constants.dart';
import 'package:live_streaming/view_models/Admin/reschedule_view_model.dart';
import 'package:live_streaming/view_models/Admin/timetable.dart';
import 'package:live_streaming/view_models/Admin/venue_view_model.dart';
import 'package:live_streaming/widget/components/appbar.dart';
import 'package:live_streaming/widget/mybutton.dart';
import 'package:live_streaming/widget/snack_bar.dart';
import 'package:live_streaming/widget/textcomponents/medium_text.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DateRangeView extends StatelessWidget {
  DateRangeView({super.key, required this.user, required this.type});
  User user;
  String type;

  @override
  Widget build(BuildContext context) {
    final venueViewModel = context.watch<VenueViewModel>();
    String startdate = "";
    String enddate = "";

    return Scaffold(
      backgroundColor: backgroundColorLight,
      body: CustomScrollView(
        slivers: [
          appbar("Select Date", bgColor: primaryColor, isGreen: true),
          SliverToBoxAdapter(
            child: ChangeNotifierProvider<TimetableViewModel>(
              create: (context) => TimetableViewModel(user.name!),
              child: Consumer<TimetableViewModel>(
                  builder: (context, provider, child) {
                return Container(
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
                        topbar(context, provider, type),
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Divider(
                            thickness: 3,
                          ),
                        ),
                        SfDateRangePicker(
                          onSelectionChanged: ((args) {
                            startdate = args.value
                                .toString()
                                .split(',')[0]
                                .split(' ')[1];
                            enddate = args.value
                                .toString()
                                .split(',')[1]
                                .split(' ')[2];
                          }),
                          selectionMode: DateRangePickerSelectionMode.range,
                        ),
                        Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: mybutton(() {
                              if (startdate != "") {
                                int year = int.parse(DateTime.now()
                                    .toString()
                                    .split(' ')[0]
                                    .split('-')[0]
                                    .toString());
                                int month = int.parse(DateTime.now()
                                    .toString()
                                    .split(' ')[0]
                                    .split('-')[1]
                                    .toString());
                                int day = int.parse(DateTime.now()
                                    .toString()
                                    .split(' ')[0]
                                    .split('-')[2]
                                    .toString());

                                int selectyear = int.parse(startdate
                                    .split(' ')[0]
                                    .split('-')[0]
                                    .toString());
                                int selectmonth = int.parse(startdate
                                    .split(' ')[0]
                                    .split('-')[1]
                                    .toString());
                                int selectday = int.parse(startdate
                                    .split(' ')[0]
                                    .split('-')[2]
                                    .toString());

                                if (enddate == "null)") {
                                  enddate = startdate;
                                }
                                int selectendyear = int.parse(enddate
                                    .split(' ')[0]
                                    .split('-')[0]
                                    .toString());
                                int selectendmonth = int.parse(enddate
                                    .split(' ')[0]
                                    .split('-')[1]
                                    .toString());
                                int selectendday = int.parse(enddate
                                    .split(' ')[0]
                                    .split('-')[2]
                                    .toString());
                                final DateTime date1 =
                                    DateTime(year, month, day, 0, 0, 0);
                                final DateTime date2 = DateTime(selectyear,
                                    selectmonth, selectday, 0, 0, 0);
                                final DateTime date3 = DateTime(selectendyear,
                                    selectendmonth, selectendday, 0, 0, 0);
                                final Duration durdef = date2.difference(date1);
                                final int durdays =
                                    date3.difference(date2).inDays;
                                if (enddate == "null)") {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      snack_bar("Select End Date", false));
                                } else if (durdef.inDays < 0) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      snack_bar(
                                          "Start Date Must be Greater than Current Date",
                                          false));
                                } else if (durdays > 6 || durdef.inDays > 6) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      snack_bar(
                                          "Duration must be less than 7 days",
                                          false));
                                } else {
                                  context.read<ReScheduleViewModel>().getdata(
                                      startdate,
                                      enddate,
                                      provider.selectedDiscipline ?? "");
                                  context
                                      .read<ReScheduleViewModel>()
                                      .setEmptyDropDownValue();
                                  context
                                      .pushNamed(routesFreeSlotView, params: {
                                    'user': jsonEncode(user),
                                    'discipline':
                                        provider.selectedDiscipline ?? "",
                                    'startdate': startdate,
                                    'enddate': enddate,
                                    'type': type
                                  });
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    snack_bar("Select Date First", false));
                              }
                            }, "Okay", Icons.done))
                      ],
                    ),
                  ),
                );
              }),
            ),
          )
        ],
      ),
    );
  }

  Padding topbar(
      BuildContext context, TimetableViewModel provider, String type) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.17,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
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
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: text_medium(user.name.toString()),
                ),
              ],
            ),
            type == 'Reschdule'
                ? Consumer<ReScheduleViewModel>(
                    builder: (context, provider, child) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButton<String>(
                              value: provider.selectedDiscipline,
                              items: provider.getTeacherDiscipline(),
                              onChanged: (val) {
                                provider.setSelectedDiscipline(val!);
                              }),
                        ))
                : Consumer<TimetableViewModel>(
                    builder: (context, provider, child) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButton<String>(
                              value: provider.selectedDiscipline,
                              items: provider.getTeacherDiscipline(),
                              onChanged: (val) {
                                provider.setSelectedDiscipline(val!);
                              }),
                        ))
          ],
        ),
      ),
    );
  }
}
