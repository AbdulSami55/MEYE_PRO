// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:live_streaming/Model/Admin/recordings.dart';
import 'package:live_streaming/Model/Admin/user.dart';
import 'package:live_streaming/Screens/Admin/Teacher/recordings.dart';
import 'package:live_streaming/view_models/Admin/User/teacherrecordings_view_model.dart';
import 'package:live_streaming/widget/components/appbar.dart';
import 'package:live_streaming/widget/snack_bar.dart';
import 'package:live_streaming/widget/textcomponents/large_text.dart';
import 'package:live_streaming/widget/textcomponents/medium_text.dart';
import 'package:live_streaming/widget/topbar.dart';
import 'package:provider/provider.dart';
import '../../../utilities/constants.dart';
import '../../../widget/components/apploading.dart';
import '../../../widget/components/errormessage.dart';

class TeacherRecordingView extends StatelessWidget {
  TeacherRecordingView({super.key, required this.user});
  User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColorLight,
      body: CustomScrollView(
        slivers: [
          appbar("Teacher Recordings", isGreen: true),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    topBar(
                      context,
                      "$getuserimage${user.role}/${user.image}",
                      user.name.toString(),
                    ),
                    ChangeNotifierProvider(
                      create: ((context) =>
                          TeacherRecordingsViewModel(user.name!)),
                      child: Container(
                        color: backgroundColorLight,
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
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _recordings(BuildContext context,
      TeacherRecordingsViewModel teacherRecordingsViewModel) {
    if (teacherRecordingsViewModel.loading) {
      return SizedBox(
        child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (con, ind) => Container(
            color: backgroundColorLight,
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.10,
                ),
                appShimmer(MediaQuery.of(context).size.width * 0.80,
                    MediaQuery.of(context).size.height * 0.10),
              ],
            ),
          ),
          itemCount: 10,
          separatorBuilder: (BuildContext context, int index) {
            return const Divider();
          },
        ),
      );
    } else if (teacherRecordingsViewModel.userError != null) {
      return ErrorMessage(
          teacherRecordingsViewModel.userError!.message.toString());
    } else if (teacherRecordingsViewModel.teacherrecordings.isEmpty) {
      return Container(
        color: backgroundColorLight,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
            ),
            ErrorMessage("NO Data"),
          ],
        ),
      );
    }
    return Container(
      color: backgroundColorLight,
      child: Column(
        children: [
          searchbar(context),
          ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount:
                  teacherRecordingsViewModel.tempTeacherRecordings.length,
              itemBuilder: ((context, index) {
                Recordings teacherRecordings =
                    teacherRecordingsViewModel.tempTeacherRecordings[index];
                return Column(
                  children: [
                    InkWell(
                      onTap: () {
                        teacherRecordingsViewModel.setPlayer(
                            '$getvideo${teacherRecordings.fileName}');
                        teacherRecordingsViewModel
                            .setSelectedVideo(teacherRecordings);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => VideoPlay(
                                      teacherRecordingsViewModel:
                                          teacherRecordingsViewModel,
                                    ))));
                      },
                      child: ListTile(
                        leading: const Icon(
                          Icons.play_arrow,
                          color: primaryColor,
                          size: 50,
                        ),
                        title: text_medium(
                            "${teacherRecordings.date.toString().split(' ')[0]}\n${teacherRecordings.fileName.split(',')[2]}"),
                        subtitle: Text(
                            "Course Name: ${teacherRecordings.courseName}\nSection : ${teacherRecordings.discipline}"),
                      ),
                    ),
                    const Divider()
                  ],
                );
              })),
        ],
      ),
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
                color: backgroundColor,
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
