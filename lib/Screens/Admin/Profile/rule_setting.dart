// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:live_streaming/Model/Admin/user.dart';
import 'package:live_streaming/utilities/constants.dart';
import 'package:live_streaming/view_models/Admin/timetable.dart';
import 'package:live_streaming/widget/components/appbar.dart';
import 'package:live_streaming/widget/components/select_schedule.dart';
import 'package:provider/provider.dart';

class RuleSetting extends StatelessWidget {
  RuleSetting({super.key, required this.user});
  User user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(
        slivers: [
          appbar(
            "Rule Setting",
          ),
          // ChangeNotifierProvider(
          //   create: ((context) => TimetableViewModel(user.name!)),
          //   child: Container(
          //     color: backgroundColor,
          //     child: Consumer<TimetableViewModel>(
          //         builder: (context, provider, child) {
          //       return selectScheduleTable(context, provider);
          //     }),
          //   ),
          // ),
        ],
      ),
    );
  }
}
