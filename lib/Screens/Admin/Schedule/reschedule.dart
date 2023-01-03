import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utilities/constants.dart';
import '../Teacher/teacher_details.dart';

class Reschedule extends StatelessWidget {
  const Reschedule({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: DefaultTabController(
          length: 3,
          child: NestedScrollView(
              physics: const BouncingScrollPhysics(),
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    SliverAppBar(
                      backgroundColor: backgroundColor,
                      bottom: const TabBar(
                        tabs: [
                          Tab(
                            icon: Icon(
                              Icons.schedule_outlined,
                            ),
                            text: "PreSchedule",
                          ),
                          Tab(
                              icon: Icon(Icons.grid_view_sharp),
                              text: "ReSchedule"),
                          Tab(icon: Icon(Icons.swap_horiz), text: "Swapping"),
                        ],
                      ),
                      expandedHeight: 130,
                      automaticallyImplyLeading: false,
                      snap: true,
                      pinned: true,
                      floating: true,
                      title: Row(
                        children: [
                          Text(
                            "Schedule",
                            style: GoogleFonts.poppins(
                                fontSize: 30, color: shadowColorDark),
                          ),
                        ],
                      ),
                      elevation: 0,
                    ),
                  ],
              body: TabBarView(
                children: [
                  TeacherDetails(
                    isSchedule: true,
                  ),
                  TeacherDetails(
                    isSchedule: true,
                  ),
                  TeacherDetails(
                    isSchedule: true,
                  ),
                ],
              ))),
    );
  }

  _ui() {}
}
