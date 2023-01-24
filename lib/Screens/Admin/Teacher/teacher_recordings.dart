// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:live_streaming/Model/Admin/teacherrecordings.dart';
import 'package:live_streaming/Model/Admin/user.dart';
import 'package:live_streaming/Screens/Admin/recordings.dart';
import 'package:live_streaming/view_models/teacherrecordings_view_model.dart';
import 'package:live_streaming/widget/components/appbar.dart';
import 'package:live_streaming/widget/snack_bar.dart';
import 'package:live_streaming/widget/textcomponents/large_text.dart';
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
                    false,
                    () {}),
                const SizedBox(
                  height: 30,
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
    } else if (teacherRecordingsViewModel.teacherrecordings.recordings !=
        null) {
      if (teacherRecordingsViewModel.teacherrecordings.recordings!.isEmpty) {
        return Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
            ),
            ErrorMessage("NO Data"),
          ],
        );
      }
    }
    return Column(
      children: [
        searchbar(context),
        ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: teacherRecordingsViewModel
                .tempteacherrecordings!.recordings!.length,
            itemBuilder: ((context, index) {
              TeacherRecordings teacherRecordings =
                  teacherRecordingsViewModel.tempteacherrecordings!;
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
                          "${teacherRecordings.recordings![index].date.toString().split(' ')[0]}\n${teacherRecordings.recordings![index].filename.split(',')[2]}"),
                      subtitle: Text(
                          "Course Name: ${teacherRecordings.course![index].name}\nSection : ${teacherRecordings.section![index].name}"),
                    ),
                  ),
                  const Divider()
                ],
              );
            })),
      ],
    );
  }

  Padding searchbar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.82,
            child: CupertinoSearchTextField(
              style: const TextStyle(
                color: Colors.black,
              ),
              onChanged: (value) {
                Provider.of<TeacherRecordingsViewModel>(context, listen: false)
                    .setFilter(value);
              },
              decoration: BoxDecoration(
                color: backgroundColorLight,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          InkWell(
              onTap: () {
                showGeneralDialog(
                  context: context,
                  barrierLabel: "Barrier",
                  barrierDismissible: true,
                  barrierColor: Colors.black.withOpacity(0.5),
                  transitionDuration: const Duration(milliseconds: 400),
                  pageBuilder: (_, __, ___) {
                    return Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.45,
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        padding: const EdgeInsets.symmetric(
                            vertical: 32, horizontal: 24),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.95),
                          borderRadius: BorderRadius.circular(40),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              offset: const Offset(0, 30),
                              blurRadius: 60,
                            ),
                            const BoxShadow(
                              color: Colors.black45,
                              offset: Offset(0, 30),
                              blurRadius: 60,
                            ),
                          ],
                        ),
                        child: Scaffold(
                          backgroundColor: Colors.transparent,
                          body: ListView(
                            padding: EdgeInsets.zero,
                            children: [
                              large_text("Filter Out By"),
                              const SizedBox(
                                height: 15,
                              ),
                              Center(
                                  child: InkWell(
                                      onTap: () {
                                        Provider.of<TeacherRecordingsViewModel>(
                                                context,
                                                listen: false)
                                            .filter = "Date";
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snack_bar(
                                                "${Provider.of<TeacherRecordingsViewModel>(context, listen: false).filter} Selected",
                                                true));
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          text_medium("Date"),
                                        ],
                                      ))),
                              const Divider(),
                              Center(
                                  child: InkWell(
                                      onTap: () {
                                        Provider.of<TeacherRecordingsViewModel>(
                                                context,
                                                listen: false)
                                            .filter = "Course";
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snack_bar(
                                                "${Provider.of<TeacherRecordingsViewModel>(context, listen: false).filter} Selected",
                                                true));
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          text_medium("Course"),
                                        ],
                                      ))),
                              const Divider(),
                              Center(
                                  child: InkWell(
                                      onTap: () {
                                        Provider.of<TeacherRecordingsViewModel>(
                                                context,
                                                listen: false)
                                            .filter = "Section";
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snack_bar(
                                                "${Provider.of<TeacherRecordingsViewModel>(context, listen: false).filter} Selected",
                                                true));
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          text_medium("Section"),
                                        ],
                                      ))),
                              const Divider(),
                              Center(
                                  child: InkWell(
                                      onTap: () {
                                        Provider.of<TeacherRecordingsViewModel>(
                                                context,
                                                listen: false)
                                            .filter = "Type";
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snack_bar(
                                                "Recording ${Provider.of<TeacherRecordingsViewModel>(context, listen: false).filter} Selected",
                                                true));
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          text_medium("Recording Type"),
                                        ],
                                      ))),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  transitionBuilder: (_, anim, __, child) {
                    Tween<Offset> tween;

                    tween = Tween(begin: const Offset(0, -1), end: Offset.zero);

                    return SlideTransition(
                      position: tween.animate(
                        CurvedAnimation(parent: anim, curve: Curves.easeInOut),
                      ),
                      child: child,
                    );
                  },
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                    decoration: BoxDecoration(
                        color: backgroundColor2,
                        borderRadius: BorderRadius.circular(99.0)),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.sort,
                        color: containerColor,
                      ),
                    )),
              ))
        ],
      ),
    );
  }
}
