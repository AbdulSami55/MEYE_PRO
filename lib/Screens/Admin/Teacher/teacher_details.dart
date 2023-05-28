// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:live_streaming/Model/Admin/user.dart';
import 'package:live_streaming/Screens/Admin/Schedule/Swapping/schedule.dart';
import 'package:live_streaming/Screens/Admin/Teacher/teacher_recordings.dart';
import 'package:live_streaming/Screens/Admin/Teacher/teacher_schedule.dart';
import 'package:live_streaming/view_models/Admin/reschedule_view_model.dart';
import 'package:live_streaming/widget/components/appbar.dart';
import 'package:live_streaming/widget/components/search_bar.dart';
import 'package:live_streaming/widget/progress_indicator.dart';
import 'package:provider/provider.dart';
import '../../../utilities/constants.dart';
import '../../../view_models/Admin/User/user_view_model.dart';
import '../../../widget/components/apploading.dart';
import '../../../widget/components/errormessage.dart';
import '../../../widget/textcomponents/large_text.dart';
import '../../../widget/textcomponents/medium_text.dart';
import '../Schedule/daterange.dart';

class TeacherDetails extends StatelessWidget {
  TeacherDetails({super.key, this.isSchedule, this.isRuleSetting});
  bool? isSchedule;
  String? isRuleSetting;
  @override
  Widget build(BuildContext context) {
    UserViewModel userViewModel = context.watch<UserViewModel>();
    return Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(physics: const BouncingScrollPhysics(), slivers: [
        isRuleSetting != null
            ? appbar("Teacher Details", bgColor: backgroundColor)
            : const SliverToBoxAdapter(
                child: Padding(padding: EdgeInsets.zero)),
        searchBar(isTeacher: true, userViewModel: userViewModel),
        SliverToBoxAdapter(
          child: _ui(userViewModel, context),
        ),
      ]),
    );
  }

  _ui(UserViewModel userViewModel, BuildContext context) {
    if (userViewModel.isloading) {
      return apploading(context);
    }
    if (userViewModel.userError != null) {
      return ErrorMessage(userViewModel.userError!.message.toString());
    }
    return ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: userViewModel.lstTempUser.length,
        itemBuilder: (context, index) => InkWell(
              onTap: () => isSchedule == true
                  ? schedulebottomSheet(
                      context, userViewModel.lstTempUser[index])
                  : isRuleSetting != null
                      ? context.push(routesRuleSetting,
                          extra: userViewModel.lstTempUser[index])
                      : bottomSheet(context, userViewModel.lstTempUser[index]),
              child: Column(
                children: [
                  ListTile(
                    leading: userViewModel.lstTempUser[index].image == null
                        ? const CircleAvatar(
                            radius: 33,
                            backgroundImage:
                                AssetImage("assets/avaters/Avatar Default.jpg"),
                          )
                        : CircleAvatar(
                            radius: 33,
                            backgroundImage: NetworkImage(
                                "$getuserimage${userViewModel.lstTempUser[index].role}/${userViewModel.lstTempUser[index].image}")),
                    title: text_medium(
                        userViewModel.lstTempUser[index].name.toString()),
                  ),
                  const Divider()
                ],
              ),
            ));
  }

  Future<dynamic> schedulebottomSheet(BuildContext context, User user) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Wrap(
            children: [
              Padding(
                  padding: const EdgeInsets.only(
                      top: 12.0, bottom: 12.0, left: 16.0),
                  child: large_text("Schedule")),
              InkWell(
                onTap: () async {
                  showLoaderDialog(context, "Loading..");
                  String response = await context
                      .read<ReScheduleViewModel>()
                      .checkTeacherRescheduleClass(user.name.toString());

                  if (response == 'okay') {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => DateRangeView(
                                  user: user,
                                  type: 'Reschedule',
                                ))));
                  } else {
                    Navigator.pop(context);
                    showDialog(
                        context: context,
                        builder: ((context) => AlertDialog(
                              title: text_medium("Error"),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Center(child: text_medium(response)),
                                ],
                              ),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Ok"))
                              ],
                            )));
                  }
                },
                child: ListTile(
                    leading: const Icon(Icons.grid_view_sharp),
                    title: text_medium("Reschdule")),
              ),
              const Divider(),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => DateRangeView(
                                user: user,
                                type: 'Preschedule',
                              ))));
                },
                child: ListTile(
                  leading: const Icon(Icons.schedule),
                  title: text_medium('Preschedule'),
                ),
              ),
              const Divider(),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => SwappingSchedule(
                                user: user,
                              ))));
                },
                child: ListTile(
                  leading: const Icon(Icons.swap_horiz),
                  title: text_medium('Swapping'),
                ),
              ),
            ],
          );
        });
  }

  Future<dynamic> bottomSheet(BuildContext context, User user) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Wrap(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(top: 12.0, bottom: 12.0, left: 16.0),
                child: large_text("View"),
              ),
              InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => TeacherScheduleView(
                              user: user,
                            )))),
                child: ListTile(
                  leading: const Icon(Icons.schedule),
                  title: text_medium('Schedule'),
                ),
              ),
              const Divider(),
              InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => TeacherRecordingView(
                              user: user,
                            )))),
                child: ListTile(
                  leading: const Icon(Icons.video_collection),
                  title: text_medium('Recordings'),
                ),
              ),
            ],
          );
        });
  }
}
