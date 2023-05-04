import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:live_streaming/Screens/Director/SwitchMode/date.dart';
import 'package:live_streaming/Screens/Director/SwitchMode/teacher.dart';
import 'package:live_streaming/Screens/Director/components/searchbar.dart';
import 'package:live_streaming/Screens/Director/short_report.dart';
import 'package:live_streaming/Screens/Tecaher/components/loading_bar.dart';
import 'package:live_streaming/utilities/constants.dart';
import 'package:live_streaming/view_models/Teacher/teacher_chr.dart';
import 'package:live_streaming/widget/components/errormessage.dart';
import 'package:live_streaming/widget/components/std_teacher_appbar.dart';
import 'package:live_streaming/widget/textcomponents/large_text.dart';
import 'package:live_streaming/widget/textcomponents/medium_text.dart';
import 'package:provider/provider.dart';

class DirectorDashboardScreen extends StatelessWidget {
  const DirectorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TeacherCHRViewModel teacherCHRViewModel =
        TeacherCHRViewModel('', isDirector: true);
    return Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(
        slivers: [
          stdteacherappbar(context, isteacher: true),
          SliverToBoxAdapter(
            child: ChangeNotifierProvider(
                create: (_) => TeacherCHRViewModel('', isDirector: true),
                child: Consumer<TeacherCHRViewModel>(
                    builder: ((context, value, child) {
                  teacherCHRViewModel = value;
                  return _ui(context, value);
                }))),
          )
        ],
      ),
      floatingActionButton: ChangeNotifierProvider.value(
          value: teacherCHRViewModel,
          child: FloatingActionButton(
            onPressed: () => teacherCHRViewModel.setIsTable(),
            child: const Icon(Icons.swap_vert_circle_sharp),
          )),
    );
  }

  Widget _ui(BuildContext context, TeacherCHRViewModel provider) {
    if (provider.isloading) {
      return loadingBar(context);
    } else if (provider.userError != null) {
      return ErrorMessage(provider.userError!.message.toString());
    }
    return mainPage(context, provider);
  }

  Widget mainPage(BuildContext context, TeacherCHRViewModel provider) {
    return provider.lstTeacherChr.isEmpty
        ? Center(
            child: large_text("No Report"),
          )
        : Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: const BoxDecoration(
                    color: containerColor,
                  ),
                  width: double.infinity,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            provider.setSelectedTab(0);
                            context.push(routesDirectorDashboard,
                                extra: provider);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.42,
                            color: provider.selectedTab == 0
                                ? primaryColor
                                : containerColor,
                            height: 50,
                            child: Center(
                                child: text_medium("Home",
                                    color: provider.selectedTab == 0
                                        ? backgroundColorLight
                                        : shadowColorDark,
                                    font: 20)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            provider.setSelectedTab(1);
                            context.push(routesShortReport, extra: provider);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.42,
                            color: provider.selectedTab == 1
                                ? primaryColor
                                : containerColor,
                            height: 50,
                            child: Center(
                                child: text_medium("Short Report",
                                    font: 20,
                                    color: provider.selectedTab == 1
                                        ? backgroundColorLight
                                        : shadowColorDark)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              searchbar(context),
              provider.selectedTab == 0
                  ? provider.isTable
                      ? Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: date(context, provider),
                        )
                      : allTeacher(provider)
                  : provider.isTable
                      ? Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: date(context, provider),
                        )
                      : allTeacher(provider, isShortReport: true)
            ],
          );
  }
}