// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:live_streaming/Model/Admin/teacherrecordings.dart';
import 'package:live_streaming/Model/Admin/user.dart';
import 'package:live_streaming/Screens/Admin/recordings.dart';
import 'package:live_streaming/view_models/teacherrecordings_view_model.dart';
import 'package:live_streaming/widget/components/appbar.dart';
import 'package:live_streaming/widget/textcomponents/medium_text.dart';
import 'package:provider/provider.dart';
import '../../../utilities/constants.dart';
import '../../../widget/components/apploading.dart';
import '../../../widget/components/errormessage.dart';
import '../../../widget/teachertopbar.dart';

class TeacherRecordingView extends StatelessWidget {
  TeacherRecordingView({super.key, required this.user});
  User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(
        slivers: [
          appbar("Teacher Recordings"),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Teachertopcard(
                    context,
                    "$getuserimage${user.role}/${user.image}",
                    user.name.toString(),
                    true),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                ChangeNotifierProvider(
                  create: ((context) => TeacherRecordingsViewModel(user.id!)),
                  child: Container(
                    color: backgroundColor,
                    child: Consumer<TeacherRecordingsViewModel>(
                        builder: (context, provider, child) {
                      return _recordings(
                        context,
                        provider,
                      );
                    }),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _recordings(BuildContext context,
      TeacherRecordingsViewModel teacherRecordingsViewModel) {
    if (teacherRecordingsViewModel.loading) {
      return apploading();
    } else if (teacherRecordingsViewModel.userError != null) {
      return ErrorMessage(
          teacherRecordingsViewModel.userError!.message.toString());
    } else if (teacherRecordingsViewModel
        .teacherrecordings.recordings.isEmpty) {
      return Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.25,
          ),
          ErrorMessage("NO Data"),
        ],
      );
    }
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount:
            teacherRecordingsViewModel.teacherrecordings.recordings.length,
        itemBuilder: ((context, index) {
          TeacherRecordings teacherRecordings =
              teacherRecordingsViewModel.teacherrecordings;
          return Column(
            children: [
              InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => VideoPlay(
                              index: index,
                              user: user,
                              teacherRecordings: teacherRecordings,
                            )))),
                child: ListTile(
                  leading: const Icon(
                    Icons.play_arrow,
                    size: 50,
                  ),
                  title: text_medium(
                      "${teacherRecordings.recordings[index].date.toString().split(' ')[0]}\n${teacherRecordings.recordings[index].filename.split(',')[2]}"),
                  subtitle: Text(
                      "Course Name: ${teacherRecordings.course[index].name}\nSection : ${teacherRecordings.section[index].name}"),
                ),
              ),
              const Divider()
            ],
          );
        }));
  }
}
