// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:live_streaming/Model/Admin/rules.dart';
import 'package:live_streaming/Model/Admin/user.dart';
import 'package:live_streaming/repo/Admin/rules_services.dart';
import 'package:live_streaming/repo/api_status.dart';
import 'package:live_streaming/utilities/constants.dart';
import 'package:live_streaming/view_models/Admin/Profile/rule_setting_view_model.dart';
import 'package:live_streaming/view_models/Admin/timetable.dart';
import 'package:live_streaming/widget/components/appbar.dart';
import 'package:live_streaming/widget/components/select_schedule.dart';
import 'package:live_streaming/widget/mybutton.dart';
import 'package:live_streaming/widget/progress_indicator.dart';
import 'package:live_streaming/widget/snack_bar.dart';
import 'package:live_streaming/widget/textcomponents/medium_text.dart';
import 'package:live_streaming/widget/topbar.dart';
import 'package:provider/provider.dart';

class RuleSetting extends StatelessWidget {
  RuleSetting({super.key, required this.user});
  User user;
  @override
  Widget build(BuildContext context) {
    final ruleSetting = context.watch<RuleSettingViewModel>();
    TimetableViewModel timetableViewModel =
        TimetableViewModel(user.name.toString());
    List<String> lstRules = [
      'First 10 minute',
      'Mid 10 minute',
      'Last 10 minute',
      'Full Session'
    ];
    return Scaffold(
      backgroundColor: backgroundColorLight,
      body: CustomScrollView(
        slivers: [
          appbar("Rule Setting", bgColor: primaryColor, isGreen: true),
          SliverToBoxAdapter(
            child: Container(
              color: primaryColor,
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
                        create: ((context) => TimetableViewModel(user.name!,
                            isRule: true, ruleSettingViewModel: ruleSetting)),
                        child: Container(
                          color: backgroundColor,
                          child: Consumer<TimetableViewModel>(
                              builder: (context, provider, child) {
                            timetableViewModel = provider;
                            return selectScheduleTable(context, provider,
                                isRule: true);
                          }),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                          children: lstRules
                              .asMap()
                              .map((key, value) => MapEntry(
                                  key, ruleCheckBox(ruleSetting, value, key)))
                              .values
                              .toList()),
                      ChangeNotifierProvider.value(
                          value: timetableViewModel,
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: mybutton(() async {
                                showLoaderDialog(context, "Saving...");
                                List<Map<String, dynamic>> lst = [];
                                for (var element in timetableViewModel
                                    .lstSelectedTimeTable) {
                                  Rules rules = Rules(
                                      id: 0,
                                      timeTableId: element.id,
                                      startRecord: ruleSetting.first ? 1 : 0,
                                      midRecord: ruleSetting.mid ? 1 : 0,
                                      endRecord: ruleSetting.last ? 1 : 0,
                                      fullRecord: ruleSetting.full ? 1 : 0);
                                  lst.add(rules.toJson());
                                }

                                var response = await RulesServices.addRules(
                                    lst, user.name!);
                                Navigator.pop(context);
                                if (response is Success) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      snack_bar("Rule Setting Saved..", true));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      snack_bar("Something went wrong", false));
                                }
                              }, "Save", Icons.done)))
                    ],
                  ),
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
                  ? ruleSetting.mid
                  : index == 2
                      ? ruleSetting.last
                      : ruleSetting.full,
          onChanged: (val) {
            index == 0
                ? ruleSetting.setFirst(val!)
                : index == 1
                    ? ruleSetting.setMid(val!)
                    : index == 2
                        ? ruleSetting.setLast(val!)
                        : ruleSetting.setFull(val!);
          });
    });
  }
}
