import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:live_streaming/Screens/Director/SwitchMode/activity_table.dart';
import 'package:live_streaming/Screens/Director/SwitchMode/table.dart';
import 'package:live_streaming/Screens/Teacher/components/card_text.dart';
import 'package:live_streaming/Screens/Teacher/components/loading_bar.dart';
import 'package:live_streaming/utilities/constants.dart';
import 'package:live_streaming/view_models/Teacher/teacher_chr.dart';
import 'package:live_streaming/view_models/signin_view_model.dart';
import 'package:live_streaming/widget/components/errormessage.dart';
import 'package:live_streaming/widget/components/std_teacher_appbar.dart';
import 'package:live_streaming/widget/textcomponents/large_text.dart';
import 'package:live_streaming/widget/textcomponents/medium_text.dart';
import 'package:provider/provider.dart';

class TeacherCHRScreen extends StatelessWidget {
  const TeacherCHRScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SignInViewModel>();
    TeacherCHRViewModel teacherCHRViewModel =
        TeacherCHRViewModel('', isDirector: true);
    return Scaffold(
        backgroundColor: backgroundColorLight,
        body: CustomScrollView(
          slivers: [
            stdteacherappbar(context, isteacher: true),
            SliverToBoxAdapter(
              child: ChangeNotifierProvider(
                  create: (_) =>
                      TeacherCHRViewModel(provider.user.name.toString()),
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
          child: Consumer<TeacherCHRViewModel>(
              builder: (context, provider, child) {
            return FloatingActionButton(
              onPressed: () {
                tablebottomSheet(context, teacherCHRViewModel);
              },
              child: const Icon(Icons.swap_horiz),
            );
          }),
        ));
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
        : provider.isTeacherTableSwitch == 'Chr'
            ? chrTable(context, provider)
            : provider.isTeacherTableSwitch == 'activity'
                ? activityTable(context, provider)
                : ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: provider.lstTeacherChr.length,
                    itemBuilder: ((context, index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              provider.selectedIndex = index;
                              reportbottomSheet(context, provider);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: [
                                    BoxShadow(
                                        offset: const Offset(0, 7),
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 3,
                                        blurRadius: 7)
                                  ],
                                  color: containerColor),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        text_medium(
                                            provider
                                                .lstTeacherChr[index].status,
                                            color: provider.lstTeacherChr[index]
                                                        .status ==
                                                    'Not Held'
                                                ? Colors.red
                                                : shadowColorDark)
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Divider(
                                        color: provider.lstTeacherChr[index]
                                                    .status ==
                                                'Not Held'
                                            ? Colors.red
                                            : shadowColorDark,
                                      ),
                                    ),
                                    cardText('Date: ',
                                        provider.lstTeacherChr[index].date),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    cardText(
                                        'Course: ',
                                        provider
                                            .lstTeacherChr[index].courseName),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    cardText(
                                        'Discipline: ',
                                        provider
                                            .lstTeacherChr[index].discipline),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )));
  }

  Future<dynamic> reportbottomSheet(
      BuildContext context, TeacherCHRViewModel provider) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Wrap(
            children: [
              Padding(
                  padding: const EdgeInsets.only(
                      top: 12.0, bottom: 12.0, left: 16.0),
                  child: large_text("Report")),
              InkWell(
                onTap: () {
                  provider.setIsTeacherChr(true);
                  context.push(routesTeacherChrDetailsScreen, extra: provider);
                },
                child: ListTile(
                    leading: const Icon(Icons.file_copy),
                    title: text_medium("Class Held")),
              ),
              const Divider(),
              InkWell(
                onTap: () {
                  provider.setIsTeacherChr(false);
                  context.push(routesTeacherChrDetailsScreen, extra: provider);
                },
                child: ListTile(
                  leading: const Icon(Icons.file_present),
                  title: text_medium('Activity'),
                ),
              ),
            ],
          );
        });
  }

  Future<dynamic> tablebottomSheet(
      BuildContext context, TeacherCHRViewModel provider) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Wrap(
            children: [
              Padding(
                  padding: const EdgeInsets.only(
                      top: 12.0, bottom: 12.0, left: 16.0),
                  child: large_text("Table")),
              InkWell(
                onTap: () {
                  provider.setIsTeacherTableSwitch("Chr");
                },
                child: ListTile(
                    leading: const Icon(Icons.file_copy),
                    title: text_medium("Class Held")),
              ),
              const Divider(),
              InkWell(
                onTap: () {
                  provider.setIsTeacherTableSwitch("activity");
                },
                child: ListTile(
                  leading: const Icon(Icons.file_present),
                  title: text_medium('Activity'),
                ),
              ),
              provider.isTeacherTableSwitch != ""
                  ? Column(
                      children: [
                        const Divider(),
                        InkWell(
                          onTap: () {
                            provider.setIsTeacherTableSwitch("");
                          },
                          child: ListTile(
                            leading: const Icon(Icons.file_present),
                            title: text_medium('Move Back From Table'),
                          ),
                        ),
                      ],
                    )
                  : const Padding(padding: EdgeInsets.zero)
            ],
          );
        });
  }
}
