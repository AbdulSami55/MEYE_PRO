// ignore_for_file: must_be_immutable, non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:live_streaming/Model/Admin/user.dart';
import 'package:live_streaming/view_models/Admin/timetable.dart';
import 'package:live_streaming/widget/components/appbar.dart';
import 'package:live_streaming/widget/components/select_schedule.dart';
import 'package:live_streaming/widget/textcomponents/medium_text.dart';
import 'package:provider/provider.dart';
import '../../../Model/Admin/venue.dart';
import '../../../utilities/constants.dart';

class TeacherScheduleScreen extends StatelessWidget {
  TeacherScheduleScreen(
      {super.key,
      required this.user,
      required this.venue,
      required this.daytime,
      required this.discipline});
  User user;
  Venue venue;
  String daytime;
  String discipline;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(
        slivers: [
          appbar("Teacher Schedule"),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                              radius: 33,
                              backgroundImage: NetworkImage(
                                  "$getuserimage${user.role}/${user.image}")),
                        ),
                        const SizedBox(
                          width: 5,
                          height: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            text_medium(user.name.toString(),
                                color: shadowColorLight),
                            text_medium(venue.name.toString(),
                                color: shadowColorLight),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ChangeNotifierProvider(
                  create: ((context) => TimetableViewModel(user.name!)),
                  child: Container(
                    color: backgroundColor,
                    child: Consumer<TimetableViewModel>(
                        builder: (context, provider, child) {
                      return selectScheduleTable(context, provider,
                          discipline: discipline);
                    }),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
