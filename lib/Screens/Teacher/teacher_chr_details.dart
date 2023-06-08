// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:live_streaming/Model/Teacher/teacher_chr.dart';
import 'package:live_streaming/Screens/Student/components/text.dart';
import 'package:live_streaming/Screens/Teacher/components/card_text.dart';
import 'package:live_streaming/utilities/constants.dart';
import 'package:live_streaming/view_models/Teacher/teacher_chr.dart';
import 'package:live_streaming/widget/components/std_teacher_appbar.dart';
import 'package:screenshot/screenshot.dart';

class TeacherCHRDetailsScreen extends StatelessWidget {
  TeacherCHRDetailsScreen({super.key, required this.provider});
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
                        provider.isTeacherChr
                            ? "Class Held Report"
                            : "Activity Report",
                        30),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, top: 8.0, bottom: 8.0, right: 8.0),
                    child: Screenshot(
                      controller: provider.screenshotController,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: containerColor,
                        ),
                        width: MediaQuery.of(context).size.width * 0.95,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
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
                                      provider.isTeacherChr
                                          ? cardRow('Time In: ',
                                              "${teacherChr.totalTimeIn} Min")
                                          : cardRow(
                                              'Sit: ', "${teacherChr.sit} Min"),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      provider.isTeacherChr
                                          ? cardRow('Time Out: ',
                                              "${teacherChr.totalTimeOut} Min")
                                          : cardRow('Stand: ',
                                              "${teacherChr.stand} Min"),
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
                                      cardRow(
                                        'Status: ',
                                        teacherChr.status,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      provider.isTeacherChr
                                          ? cardRow(
                                              '',
                                              "",
                                            )
                                          : cardRow(
                                              ' ',
                                              "",
                                            )
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
                              //  Row(
                              // mainAxisAlignment:
                              //     MainAxisAlignment.spaceEvenly,
                              // children: [
                              //   text_medium("TimeIn"),
                              //   const SizedBox(
                              //     width: 5,
                              //   ),
                              //   text_medium("TimeOut"),
                              // text_medium("Sit"),
                              // text_medium("Stand"),
                              // text_medium("Mobile")
                              //    ],
                              //  ),
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
                              //       return Column(
                              //         children: [
                              //           Row(
                              //             mainAxisAlignment:
                              //                 MainAxisAlignment.spaceEvenly,
                              //             children: [
                              //               const SizedBox(
                              //                 width: 20,
                              //               ),
                              //               SizedBox(
                              //                 width: 80,
                              //                 child: textSmall(
                              //                     teacherChrActivityDetail
                              //                         .timein
                              //                         .toString()
                              //                         .split('.')[0]
                              //                         .split(' ')[1]),
                              //               ),
                              //               const SizedBox(
                              //                 width: 55,
                              //               ),
                              //               SizedBox(
                              //                 width: 80,
                              //                 child: textSmall(
                              //                     teacherChrActivityDetail
                              //                         .timeout
                              //                         .toString()
                              //                         .split('.')[0]
                              //                         .split(' ')[1]),
                              //               ),
                              //               const SizedBox(
                              //                 width: 5,
                              //               ),
                              //               // textSmall(teacherChrActivityDetail.sit
                              //               //     .toString()),
                              //               // const SizedBox(
                              //               //   width: 35,
                              //               // ),
                              //               // textSmall(teacherChrActivityDetail.stand
                              //               //     .toString()),
                              //               // const SizedBox(
                              //               //   width: 50,
                              //               // ),
                              //               // textSmall(teacherChrActivityDetail.mobile
                              //               //     .toString())
                              //             ],
                              //           ),
                              //           const Padding(
                              //               padding: EdgeInsets.only(top: 16.0))
                              //         ],
                              //       );
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
        // SliverToBoxAdapter(
        //   child: Padding(
        //       padding: const EdgeInsets.symmetric(horizontal: 8.0),
        //       child: mybutton(() async {
        //         showLoaderDialog(context, "Generating..");
        //         await provider.screenshotController
        //             .capture(delay: const Duration(milliseconds: 10))
        //             .then((capturedImage) async {
        //           await getPdf(context, capturedImage, provider);
        //         }).catchError((onError) {
        //           ScaffoldMessenger.of(context)
        //               .showSnackBar(snack_bar("Something went wrong.", false));
        //         });
        //         Navigator.pop(context);
        //       }, "Generate PDF", Icons.picture_as_pdf)),
        // )
      ]),
    );
  }

  // Future getPdf(BuildContext context, Uint8List? screenShot,
  //     TeacherCHRViewModel provider) async {
  //   if (screenShot != null) {
  //     pw.Document pdf = pw.Document();
  //     pdf.addPage(
  //       pw.Page(
  //         pageFormat: PdfPageFormat.a4,
  //         build: (context) {
  //           return pw.Expanded(
  //             child:
  //                 pw.Image(pw.MemoryImage(screenShot), fit: pw.BoxFit.contain),
  //           );
  //         },
  //       ),
  //     );
  //     List<int> bytes = await pdf.save();
  //     final path = (await getExternalStorageDirectory())!.path;
  //     File pdfFile = File(
  //         "$path/${provider.lstTeacherChr[provider.selectedIndex].date} ${context.read<SignInViewModel>().user.name} ${provider.lstTeacherChr[provider.selectedIndex].status} ${provider.lstTeacherChr[provider.selectedIndex].discipline}.pdf");

  //     await pdfFile.writeAsBytes(bytes, flush: true);
  //     await OpenFile.open(
  //         "$path/${provider.lstTeacherChr[provider.selectedIndex].date} ${context.read<SignInViewModel>().user.name} ${provider.lstTeacherChr[provider.selectedIndex].status} ${provider.lstTeacherChr[provider.selectedIndex].discipline}.pdf");
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(snack_bar("PDF Generated", true));
  //   } else {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(snack_bar("Something went wrong", false));
  //   }
  // }

  Row cardRow(String title1, String subtitle1) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        cardText(title1, subtitle1),
      ],
    );
  }
}
