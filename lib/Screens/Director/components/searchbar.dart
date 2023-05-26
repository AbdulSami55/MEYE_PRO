import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:live_streaming/utilities/constants.dart';
import 'package:live_streaming/widget/snack_bar.dart';
import 'package:live_streaming/widget/textcomponents/large_text.dart';
import 'package:live_streaming/widget/textcomponents/medium_text.dart';
import 'package:provider/provider.dart';

import '../../../view_models/Teacher/teacher_chr.dart';

Padding searchbar(
  BuildContext context,
) {
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
              context.read<TeacherCHRViewModel>().searchChr(value);
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
                                      context
                                          .read<TeacherCHRViewModel>()
                                          .setSelectedFilter(1);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                              snack_bar("Date Selected", true));
                                      Navigator.pop(context);
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
                                      context
                                          .read<TeacherCHRViewModel>()
                                          .setSelectedFilter(2);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snack_bar(
                                              "Course Selected", true));
                                      Navigator.pop(context);
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
                                      context
                                          .read<TeacherCHRViewModel>()
                                          .setSelectedFilter(3);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snack_bar(
                                              "Discipline Selected", true));
                                      Navigator.pop(context);
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        text_medium("Discipline"),
                                      ],
                                    ))),
                            const Divider(),
                            Center(
                                child: InkWell(
                                    onTap: () {
                                      context
                                          .read<TeacherCHRViewModel>()
                                          .setSelectedFilter(4);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snack_bar(
                                              "Teacher Selected", true));
                                      Navigator.pop(context);
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        text_medium("Teacher"),
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
