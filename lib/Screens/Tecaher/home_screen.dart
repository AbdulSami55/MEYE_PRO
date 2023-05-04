import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:intl/intl.dart';
import 'package:live_streaming/Model/Admin/timetable.dart';
import 'package:live_streaming/Screens/Tecaher/components/card_text.dart';
import 'package:live_streaming/Screens/Tecaher/components/loading_bar.dart';
import 'package:live_streaming/utilities/constants.dart';
import 'package:live_streaming/view_models/Admin/timetable.dart';
import 'package:live_streaming/view_models/signin_view_model.dart';
import 'package:live_streaming/widget/components/errormessage.dart';
import 'package:live_streaming/widget/components/std_teacher_appbar.dart';
import 'package:live_streaming/widget/textcomponents/large_text.dart';
import 'package:live_streaming/widget/textcomponents/medium_text.dart';
import 'package:provider/provider.dart';

class TeacherDashboard extends StatelessWidget {
  const TeacherDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SignInViewModel>();
    return Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(
        slivers: [
          stdteacherappbar(context, isteacher: true),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: text_medium(
                          DateFormat('EEEE').format(DateTime.now()),
                          font: 30),
                    ),
                  ],
                ),
                ChangeNotifierProvider(
                  create: ((context) =>
                      TimetableViewModel(provider.user.name.toString())),
                  child: Consumer<TimetableViewModel>(
                      builder: (context, provider, child) {
                    if (provider.loading) {
                      return loadingBar(context);
                    } else if (provider.userError != null) {
                      return ErrorMessage(
                          provider.userError!.message.toString());
                    }
                    return mainPage(provider, context);
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column mainPage(
    TimetableViewModel provider,
    BuildContext context,
  ) {
    return Column(
      children: [
        provider.lsttimetable
                .where((element) =>
                    element.day == DateFormat('EEEE').format(DateTime.now()))
                .toList()
                .isEmpty
            ? Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                  ),
                  large_text("No Session Today"),
                ],
              )
            : ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: provider.lsttimetable
                    .where((element) =>
                        element.day ==
                        DateFormat('EEEE').format(DateTime.now()))
                    .toList()
                    .length,
                itemBuilder: ((context, index) {
                  // DateFormat('EEEE').format(DateTime.now())
                  TimeTable timeTable = provider.lsttimetable
                      .where((element) =>
                          element.day ==
                          DateFormat('EEEE').format(DateTime.now()))
                      .toList()[index];

                  if (int.parse(timeTable.starttime.split(':')[0]) < 7) {
                    timeTable.starttime = "${timeTable.starttime} PM";
                  } else {
                    timeTable.starttime = "${timeTable.starttime} AM";
                  }

                  if (int.parse(timeTable.endtime.split(':')[0]) < 7) {
                    timeTable.endtime = "${timeTable.endtime} PM";
                  } else {
                    timeTable.endtime = "${timeTable.endtime} AM";
                  }
                  DateTime stime = DateFormat.jm().parse(timeTable.starttime);
                  DateTime etime = DateFormat.jm().parse(timeTable.endtime);
                  String tempTime = DateTime.now().toString().split(' ')[1];
                  DateTime time = DateTime.parse("1970-01-01 $tempTime");

                  DateTime stimer = DateTime.parse(
                      "${DateTime.now().toString().split(' ')[0]} ${stime.toString().split(' ')[1]}");

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
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
                          color: stime.compareTo(time) < 0 &&
                                  etime.compareTo(time) > 0
                              ? containerCardColor
                              : stime.compareTo(time) > 0
                                  ? teacherCardColor1
                                  : teacherCardColor2),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                stime.compareTo(time) > 0
                                    ? Row(
                                        children: [
                                          text_medium("Start in: ",
                                              color: containerColor),
                                          CountdownTimer(
                                            endTime:
                                                stimer.millisecondsSinceEpoch,
                                            widgetBuilder: (context, time) {
                                              if (time == null) {
                                                return text_medium("");
                                              } else {
                                                return text_medium(
                                                    'hours: ${time.hours ?? 0} min: ${time.min ?? 0} sec: ${time.sec ?? 0}',
                                                    font: 15);
                                              }
                                            },
                                          ),
                                        ],
                                      )
                                    : text_medium(
                                        stime.compareTo(time) < 0 &&
                                                etime.compareTo(time) > 0
                                            ? "Runing"
                                            : "Held",
                                        color: containerColor)
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Divider(
                                color: containerColor,
                              ),
                            ),
                            cardText('Venue: ', timeTable.venue),
                            const SizedBox(
                              height: 10,
                            ),
                            cardText('Course: ', timeTable.courseName),
                            const SizedBox(
                              height: 10,
                            ),
                            cardText('Discipline: ', timeTable.discipline),
                          ],
                        ),
                      ),
                    ),
                  );
                }))
      ],
    );
  }
}
