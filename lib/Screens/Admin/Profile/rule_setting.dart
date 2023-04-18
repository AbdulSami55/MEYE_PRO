// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:live_streaming/Model/Admin/user.dart';
import 'package:live_streaming/utilities/constants.dart';
import 'package:live_streaming/view_models/Admin/Profile/rule_setting_view_model.dart';
import 'package:live_streaming/view_models/Admin/timetable.dart';
import 'package:live_streaming/widget/components/appbar.dart';
import 'package:live_streaming/widget/components/select_schedule.dart';
import 'package:live_streaming/widget/mybutton.dart';
import 'package:live_streaming/widget/teachertopbar.dart';
import 'package:live_streaming/widget/textcomponents/medium_text.dart';
import 'package:provider/provider.dart';

class RuleSetting extends StatelessWidget {
  RuleSetting({super.key, required this.user});
  User user;
  @override
  Widget build(BuildContext context) {
    final ruleSetting = context.watch<RuleSettingViewModel>();
    return Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(
        slivers: [
          appbar(
            "Rule Setting",
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Teachertopcard(
                    context,
                    user.image == null
                        ? ""
                        : "$getuserimage${user.role}/${user.image}",
                    user.name.toString(),
                    false,
                    () {}),
                const SizedBox(
                  height: 20,
                ),
                ChangeNotifierProvider(
                  create: ((context) => TimetableViewModel(user.name!)),
                  child: Container(
                    color: backgroundColor,
                    child: Consumer<TimetableViewModel>(
                        builder: (context, provider, child) {
                      return selectScheduleTable(context, provider,
                          isRule: true);
                    }),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ruleCheckBox(ruleSetting, "First 10 minute", 0),
                ruleCheckBox(ruleSetting, "Last 10 minute", 1),
                ruleCheckBox(ruleSetting, "Full Session", 2),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: mybutton(() {}, "Save", Icons.done))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Builder ruleCheckBox(
      RuleSettingViewModel ruleSetting, String title, int index) {
    return Builder(builder: (context) {
      return CheckboxListTile(
          title: text_medium(title),
          value: index == 0
              ? ruleSetting.first
              : index == 1
                  ? ruleSetting.last
                  : ruleSetting.full,
          onChanged: (val) {
            index == 0
                ? ruleSetting.setFirst(val!)
                : index == 1
                    ? ruleSetting.setLast(val!)
                    : ruleSetting.setFull(val!);
          });
    });
  }
}
