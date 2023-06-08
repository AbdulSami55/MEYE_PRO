// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:live_streaming/Model/Teacher/teacher_chr.dart';
import 'package:live_streaming/Screens/Director/SwitchMode/activity_table.dart';
import 'package:live_streaming/utilities/constants.dart';
import 'package:live_streaming/view_models/Teacher/teacher_chr.dart';
import 'package:live_streaming/widget/mybutton.dart';
import 'package:live_streaming/widget/progress_indicator.dart';
import 'package:live_streaming/widget/snack_bar.dart';
import 'package:live_streaming/widget/textcomponents/medium_text.dart';
import 'package:live_streaming/widget/textcomponents/small_text.dart';

Widget chrTable(BuildContext context, TeacherCHRViewModel provider,
    {bool? isShortReport}) {
  return Column(
    children: [
      Container(
        width: MediaQuery.of(context).size.width * 1,
        decoration: myBoxDecoration,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
              headingRowColor:
                  MaterialStateColor.resolveWith((states) => primaryColor),
              dataRowHeight: 50,
              columnSpacing: 20,
              columns: [
                DataColumn(
                  label: text_medium('Sr. No', color: containerColor),
                ),
                DataColumn(
                    label: text_medium('Teacher', color: containerColor)),
                DataColumn(label: text_medium('Course', color: containerColor)),
                DataColumn(
                    label: text_medium('Discipline', color: containerColor)),
                DataColumn(label: text_medium('Venue', color: containerColor)),
                DataColumn(label: text_medium('Date', color: containerColor)),
                DataColumn(label: text_medium('TimeIn', color: containerColor)),
                DataColumn(
                    label: text_medium('TimeOut', color: containerColor)),
                DataColumn(label: text_medium('Status', color: containerColor))
              ],
              rows: isShortReport == true
                  ? provider.lstTempTeacherChr
                      .where((element) => element.status == 'Not Held')
                      .toList()
                      .asMap()
                      .map((k, v) => MapEntry(k, rowData(v, k)))
                      .values
                      .toList()
                  : provider.lstTempTeacherChr
                      .asMap()
                      .map((k, v) => MapEntry(k, rowData(v, k)))
                      .values
                      .toList()),
        ),
      ),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: mybutton(() async {
            showLoaderDialog(context, "Generating..");
            await provider.screenshotController
                .capture(delay: const Duration(milliseconds: 10))
                .then((capturedImage) async {
              await getPdf(context, capturedImage, provider, isChr: true);
            }).catchError((onError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(snack_bar("Something went wrong.", false));
            });
            Navigator.pop(context);
          }, "Generate PDF", Icons.picture_as_pdf))
    ],
  );
}

DataRow rowData(TeacherChr v, int k) {
  return DataRow(
      color: v.status == 'Not Held'
          ? MaterialStateProperty.all(Colors.redAccent)
          : MaterialStateProperty.all(containerColor),
      cells: [
        DataCell(textSmall("${k + 1}")),
        DataCell(textSmall(v.teacherName.toString())),
        DataCell(textSmall(v.courseName.toString())),
        DataCell(textSmall(v.discipline.toString())),
        DataCell(textSmall(v.venue.toString())),
        DataCell(textSmall(v.date.toString())),
        DataCell(textSmall(v.totalTimeIn.toString())),
        DataCell(textSmall(v.totalTimeOut.toString())),
        DataCell(textSmall(v.status.toString()))
      ]);
}

BoxDecoration myBoxDecoration = BoxDecoration(
  border: Border.all(
    color: Colors.grey,
    width: 1.0,
  ),
  color: Colors.white,
);
