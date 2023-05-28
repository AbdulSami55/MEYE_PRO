// ignore_for_file: must_be_immutable, non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:live_streaming/Model/Admin/user.dart';
import 'package:live_streaming/view_models/Admin/timetable.dart';
import 'package:live_streaming/widget/components/appbar.dart';
import 'package:live_streaming/widget/components/select_schedule.dart';
import 'package:live_streaming/widget/components/select_schedule_rules.dart';
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
      backgroundColor: backgroundColorLight,
      body: CustomScrollView(
        slivers: [
          appbar("Teacher Schedule", bgColor: primaryColor, isGreen: true),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: user.image == null
                                ? const CircleAvatar(
                                    radius: 33,
                                    backgroundImage: AssetImage(
                                        "assets/avaters/Avatar Default.jpg"))
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              text_medium(user.name.toString(),
                                  color: shadowColorLight),
                              const SizedBox(
                                height: 5,
                              ),
                              text_medium(discipline, color: shadowColorLight),
                              const SizedBox(
                                height: 5,
                              ),
                              text_medium(venue.name.toString(),
                                  color: shadowColorLight),
                              const SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ],
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
                              discipline: discipline,
                              venue: venue.name,
                              daytime: daytime);
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
