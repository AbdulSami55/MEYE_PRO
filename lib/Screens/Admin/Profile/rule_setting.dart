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
import 'package:live_streaming/widget/topbar.dart';
import 'package:provider/provider.dart';

class RuleSetting extends StatelessWidget {
  RuleSetting({super.key, required this.user});
  User user;
  @override
  Widget build(BuildContext context) {
    final ruleSetting = context.watch<RuleSettingViewModel>();
    return Scaffold(
      backgroundColor: backgroundColorLight,
      body: CustomScrollView(
        slivers: [
          appbar("Rule Setting", bgColor: primaryColor, isGreen: true),
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
                  children: [
                    topBar(
                      context,
                      user.image == null
                          ? ""
                          : "$getuserimage${user.role}/${user.image}",
                      user.name.toString(),
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
                    ruleCheckBox(ruleSetting, "Mid 10 minute", 2),
                    ruleCheckBox(ruleSetting, "Full Session", 3),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: mybutton(() {}, "Save", Icons.done))
                  ],
                ),
              ),
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
                  : index == 2
                      ? ruleSetting.mid
                      : ruleSetting.full,
          onChanged: (val) {
            index == 0
                ? ruleSetting.setFirst(val!)
                : index == 1
                    ? ruleSetting.setLast(val!)
                    : index == 2
                        ? ruleSetting.setMid(val!)
                        : ruleSetting.setFull(val!);
          });
    });
  }
}
