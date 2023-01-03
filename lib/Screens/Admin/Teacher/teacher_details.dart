// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:live_streaming/Model/Admin/user.dart';
import 'package:live_streaming/Screens/Admin/Schedule/freeslot.dart';
import 'package:live_streaming/Screens/Admin/Teacher/teacher_schedule.dart';
import 'package:provider/provider.dart';

import '../../../utilities/constants.dart';
import '../../../view_models/user_view_model.dart';
import '../../../widget/components/apploading.dart';
import '../../../widget/components/errormessage.dart';
import '../../../widget/textcomponents/large_text.dart';
import '../../../widget/textcomponents/medium_text.dart';

class TeacherDetails extends StatelessWidget {
  TeacherDetails({super.key, this.isSchedule});
  bool? isSchedule;
  @override
  Widget build(BuildContext context) {
    UserViewModel userViewModel = context.watch<UserViewModel>();

    return Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(physics: const BouncingScrollPhysics(), slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 16.0),
            child: CupertinoSearchTextField(
              style: const TextStyle(
                color: Colors.black,
              ),
              onChanged: (value) {
                // SearchMutation(value);
              },
              decoration: BoxDecoration(
                color: backgroundColorLight,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: _ui(userViewModel),
        ),
      ]),
    );
  }

  _ui(UserViewModel userViewModel) {
    if (userViewModel.isloading) {
      return apploading();
    }
    if (userViewModel.userError != null) {
      return ErrorMessage(userViewModel.userError!.message.toString());
    }
    return ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: userViewModel.lstuser.length,
        itemBuilder: ((context, index) {
          User user = userViewModel.lstuser[index];
          return InkWell(
            onTap: () => isSchedule == true
                ? Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => FreeSlotView(user: user))))
                : bottomSheet(context, user),
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                      radius: 33,
                      backgroundImage: NetworkImage(
                          "$getuserimage${user.role}/${user.image}")),
                  title: text_medium(user.name.toString()),
                ),
                const Divider()
              ],
            ),
          );
        }));
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
              ListTile(
                leading: const Icon(Icons.video_collection),
                title: text_medium('Recordings'),
              ),
            ],
          );
        });
  }
}
