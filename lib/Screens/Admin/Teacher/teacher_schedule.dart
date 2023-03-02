// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:live_streaming/Model/Admin/user.dart';
import 'package:live_streaming/view_models/Admin/timetable.dart';
import 'package:live_streaming/widget/components/appbar.dart';
import 'package:live_streaming/widget/components/schedule.dart';
import 'package:live_streaming/widget/teachertopbar.dart';
import 'package:provider/provider.dart';
import '../../../utilities/constants.dart';

class TeacherScheduleView extends StatelessWidget {
  TeacherScheduleView({super.key, required this.user});
  User user;

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
                Teachertopcard(
                    context,
                    "$getuserimage${user.role}/${user.image}",
                    user.name.toString(),
                    false,
                    () {}),
                const SizedBox(
                  height: 30,
                ),
                ChangeNotifierProvider(
                  create: ((context) => TimetableViewModel(user.name!)),
                  child: Container(
                    color: backgroundColor,
                    child: Consumer<TimetableViewModel>(
                        builder: (context, provider, child) {
                      return ScheduleTable(context, provider);
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
