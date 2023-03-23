// ignore_for_file: must_be_immutable, non_constant_identifier_names, unused_local_variable

import 'package:flutter/material.dart';
import 'package:live_streaming/Model/Admin/user.dart';
import 'package:live_streaming/Screens/Admin/Schedule/freeslot.dart';
import 'package:live_streaming/view_models/Admin/timetable.dart';
import 'package:live_streaming/view_models/Admin/venue_view_model.dart';
import 'package:live_streaming/widget/components/appbar.dart';
import 'package:live_streaming/widget/mybutton.dart';
import 'package:live_streaming/widget/snack_bar.dart';
import 'package:live_streaming/widget/textcomponents/medium_text.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../../utilities/constants.dart';

class DateRangeView extends StatelessWidget {
  DateRangeView({super.key, required this.user});
  User user;

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
            child: ChangeNotifierProvider<TimetableViewModel>(
              create: (context) => TimetableViewModel(user.name!),
              child: Consumer<TimetableViewModel>(
                  builder: (context, provider, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    topbar(context, provider),
                    const SizedBox(
                      height: 30,
                    ),
                    SfDateRangePicker(
                      onSelectionChanged: ((args) {
                        startdate =
                            args.value.toString().split(',')[0].split(' ')[1];
                        enddate =
                            args.value.toString().split(',')[1].split(' ')[2];
                      }),
                      selectionMode: DateRangePickerSelectionMode.range,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
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
                            final DateTime date1 =
                                DateTime(year, month, day, 0, 0, 0);
                            final DateTime date2 = DateTime(
                                selectyear, selectmonth, selectday, 0, 0, 0);
                            final Duration durdef = date2.difference(date1);

                            if (enddate == "null)") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  snack_bar("Select End Date", false));
                            } else if (durdef.inDays < 0) {
                              ScaffoldMessenger.of(context).showSnackBar(snack_bar(
                                  "Start Date Must be Greater than Current Date",
                                  false));
                            } else {
                             
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => FreeSlotView(
                                          user: user,
                                          discipline:
                                              provider.selectedDiscipline ??
                                                  ""))));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                snack_bar("Select Date First", false));
                          }
                        }, "Okay", Icons.done))
                  ],
                );
              }),
            ),
          )
        ],
      ),
    );
  }

  Padding topbar(BuildContext context, TimetableViewModel provider) {
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
            text_medium(user.name.toString()),
            const SizedBox(
              width: 80,
            ),
            Consumer<TimetableViewModel>(
                builder: (context, provider, child) => provider.loading
                    ? Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          width: 48.0,
                          height: 48.0,
                          color: Colors.white,
                        ),
                      )
                    : DropdownButton<String>(
                        value: provider.selectedDiscipline,
                        items: provider.getTeacherDiscipline(),
                        onChanged: (val) {
                          provider.setSelectedDiscipline(val!);
                        }))
          ],
        ),
      ),
    );
  }
}
