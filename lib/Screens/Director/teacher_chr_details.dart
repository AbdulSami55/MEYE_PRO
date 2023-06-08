// ignore_for_file: must_be_immutable, use_build_context_synchronously
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:live_streaming/Model/Teacher/teacher_chr.dart';
import 'package:live_streaming/Screens/Student/components/text.dart';
import 'package:live_streaming/Screens/Teacher/components/card_text.dart';
import 'package:live_streaming/utilities/constants.dart';
import 'package:live_streaming/view_models/Teacher/teacher_chr.dart';
import 'package:live_streaming/widget/components/std_teacher_appbar.dart';
import 'package:live_streaming/widget/mybutton.dart';
import 'package:live_streaming/widget/progress_indicator.dart';
import 'package:live_streaming/widget/snack_bar.dart';
import 'package:live_streaming/widget/textcomponents/medium_text.dart';
import 'package:screenshot/screenshot.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class TeacherCHRDetails extends StatelessWidget {
  TeacherCHRDetails({super.key, required this.provider});
  TeacherCHRViewModel provider;

  @override
  Widget build(BuildContext context) {
    TeacherChr teacherChr = provider.lstTeacherChr[provider.selectedIndex];

    return Scaffold(
      backgroundColor: backgroundColorLight,
      body: CustomScrollView(slivers: [
        stdteacherappbar(context,
            isteacher: true, isback: true, appBarColor: primaryColor),
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
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, top: 8.0, bottom: 8.0, right: 8.0),
                    child: student_text(
                        context,
                        provider.isChr
                            ? "Class Held Report"
                            : "Activity Report",
                        30),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, top: 32.0, bottom: 8.0, right: 8.0),
                    child: Screenshot(
                      controller: provider.screenshotController,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: containerColor,
                        ),
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    text_medium(teacherChr.teacherName),
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: teacherChr.image == ''
                                              ? const CircleAvatar(
                                                  radius: 33,
                                                  backgroundImage: AssetImage(
                                                      "assets/avaters/Avatar Default.jpg"))
                                              : CircleAvatar(
                                                  radius: 33,
                                                  backgroundImage: NetworkImage(
                                                      "${getuserimage}Teacher/${teacherChr.image}")),
                                        ),
                                        text_medium(teacherChr.status,
                                            color: teacherChr.status == 'Held'
                                                ? primaryColor
                                                : teacherChr.status ==
                                                        'Not Held'
                                                    ? Colors.red
                                                    : Colors.redAccent)
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: Divider(
                                  color: shadowColorDark,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      cardRow('Discipline: ',
                                          teacherChr.discipline),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      cardRow(
                                          'Course: ', teacherChr.courseName),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      cardRow(
                                        'Time: ',
                                        "${teacherChr.startTime.split(".")[0]}-${teacherChr.endTime.split('.')[0]}",
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      provider.isChr
                                          ? cardRow('Time In: ',
                                              "${teacherChr.totalTimeIn} Min")
                                          : cardRow(
                                              'Sit: ', "${teacherChr.sit} Min"),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      provider.isChr
                                          ? cardRow('Time Out: ',
                                              teacherChr.totalTimeOut)
                                          : cardRow(
                                              'Stand: ', teacherChr.stand),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      cardRow('Date: ', teacherChr.date),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      cardRow('Day: ', teacherChr.day),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      cardRow('Venue: ', teacherChr.venue),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              // const Padding(
                              //   padding: EdgeInsets.symmetric(vertical: 8.0),
                              //   child: Divider(
                              //     color: shadowColorDark,
                              //   ),
                              // ),
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceEvenly,
                              //   children: [
                              //     text_medium("TimeIn"),
                              //     const SizedBox(
                              //       width: 5,
                              //     ),
                              //     text_medium("TimeOut"),
                              //     // text_medium("Sit"),
                              //     // text_medium("Stand"),
                              //     // text_medium("Mobile")
                              //   ],
                              // ),
                              // const Padding(
                              //   padding: EdgeInsets.only(top: 8.0, bottom: 6.0),
                              //   child: Divider(
                              //     color: shadowColorDark,
                              //   ),
                              // ),
                              // ListView.builder(
                              //     padding: EdgeInsets.zero,
                              //     itemCount: teacherChr
                              //         .teacherChrActivityDetails.length,
                              //     shrinkWrap: true,
                              //     itemBuilder: ((context, index) {
                              //       TeacherChrActivityDetail
                              //           teacherChrActivityDetail = teacherChr
                              //               .teacherChrActivityDetails[index];
                              //       return teacherChrActivityDetail.sit == null
                              //           ? const Padding(
                              //               padding: EdgeInsets.zero)
                              //           : Column(
                              //               children: [
                              //                 Row(
                              //                   mainAxisAlignment:
                              //                       MainAxisAlignment
                              //                           .spaceEvenly,
                              //                   children: [
                              //                     const SizedBox(
                              //                       width: 20,
                              //                     ),
                              //                     SizedBox(
                              //                       width: 80,
                              //                       child: textSmall(
                              //                           teacherChrActivityDetail
                              //                               .timein
                              //                               .toString()
                              //                               .split('.')[0]
                              //                               .split(' ')[1]),
                              //                     ),
                              //                     const SizedBox(
                              //                       width: 55,
                              //                     ),
                              //                     SizedBox(
                              //                       width: 80,
                              //                       child: textSmall(
                              //                           teacherChrActivityDetail
                              //                               .timeout
                              //                               .toString()
                              //                               .split('.')[0]
                              //                               .split(' ')[1]),
                              //                     ),
                              //                     const SizedBox(
                              //                       width: 5,
                              //                     ),
                              //                     // textSmall(teacherChrActivityDetail.sit
                              //                     //     .toString()),
                              //                     // const SizedBox(
                              //                     //   width: 35,
                              //                     // ),
                              //                     // textSmall(teacherChrActivityDetail.stand
                              //                     //     .toString()),
                              //                     // const SizedBox(
                              //                     //   width: 50,
                              //                     // ),
                              //                     // textSmall(teacherChrActivityDetail.mobile
                              //                     //     .toString())
                              //                   ],
                              //                 ),
                              //                 const Padding(
                              //                     padding: EdgeInsets.only(
                              //                         top: 16.0))
                              //               ],
                              //             );
                              //     })),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: mybutton(() async {
                showLoaderDialog(context, "Generating..");
                await provider.screenshotController
                    .capture(delay: const Duration(milliseconds: 10))
                    .then((capturedImage) async {
                  await getPdf(context, capturedImage, provider);
                }).catchError((onError) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(snack_bar("Something went wrong.", false));
                });
                Navigator.pop(context);
              }, "Generate PDF", Icons.picture_as_pdf)),
        )
      ]),
    );
  }

  Future getPdf(BuildContext context, Uint8List? screenShot,
      TeacherCHRViewModel provider) async {
    if (screenShot != null) {
      pw.Document pdf = pw.Document();
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (context) {
            return pw.Expanded(
              child:
                  pw.Image(pw.MemoryImage(screenShot), fit: pw.BoxFit.contain),
            );
          },
        ),
      );
      List<int> bytes = await pdf.save();
      final path = (await getExternalStorageDirectory())!.path;
      DateTime dateTime = DateTime.now();
      File pdfFile = File(
          "$path/${provider.lstTeacherChr[provider.selectedIndex].date} ${dateTime.toString()}.pdf");

      await pdfFile.writeAsBytes(bytes, flush: true);
      await OpenFile.open(
          "$path/${provider.lstTeacherChr[provider.selectedIndex].date} ${dateTime.toString()}.pdf");
      ScaffoldMessenger.of(context)
          .showSnackBar(snack_bar("PDF Generated", true));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(snack_bar("Something went wrong", false));
    }
  }

  Row cardRow(String title1, String subtitle1) {
    return cardText(title1, subtitle1);
  }
}
