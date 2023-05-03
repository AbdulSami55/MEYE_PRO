// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:live_streaming/Model/Admin/user.dart';
import 'package:live_streaming/view_models/Admin/timetable.dart';
import 'package:live_streaming/widget/components/appbar.dart';
import 'package:live_streaming/widget/components/schedule.dart';
import 'package:live_streaming/widget/teachertopbar.dart';
import 'package:live_streaming/widget/textcomponents/medium_text.dart';
import 'package:live_streaming/widget/topbar.dart';
import 'package:provider/provider.dart';
import '../../../utilities/constants.dart';

class TeacherScheduleView extends StatelessWidget {
  TeacherScheduleView({super.key, required this.user});
  User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: CustomScrollView(
        slivers: [
          appbar("Teacher Schedule", isGreen: true),
          SliverToBoxAdapter(
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                  color: backgroundColorLight,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32.0),
                      topRight: Radius.circular(32.0))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  topBar(context, "$getuserimage${user.role}/${user.image}",
                      user.name.toString()),
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
            ),
          )
        ],
      ),
    );
  }
}
