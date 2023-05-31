// ignore_for_file: use_build_context_synchronously, implementation_imports

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:live_streaming/Model/Teacher/teacher_chr.dart';
import 'package:live_streaming/Screens/Director/GeneratePdf/activity_table.dart';
import 'package:live_streaming/Screens/Director/GeneratePdf/chr_table.dart';
import 'package:live_streaming/utilities/constants.dart';
import 'package:live_streaming/view_models/Teacher/teacher_chr.dart';
import 'package:live_streaming/widget/mybutton.dart';
import 'package:live_streaming/widget/progress_indicator.dart';
import 'package:live_streaming/widget/snack_bar.dart';
import 'package:live_streaming/widget/textcomponents/medium_text.dart';
import 'package:live_streaming/widget/textcomponents/small_text.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/src/widgets/document.dart';

Widget activityTable(BuildContext context, TeacherCHRViewModel provider,
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
                DataColumn(label: text_medium('Sit', color: containerColor)),
                DataColumn(label: text_medium('Stand', color: containerColor)),
                DataColumn(label: text_medium('Mobile', color: containerColor)),
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
              await getPdf(context, capturedImage, provider);
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
        DataCell(textSmall(v.sit.toString())),
        DataCell(textSmall(v.stand.toString())),
        DataCell(textSmall(v.mobile.toString())),
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

Future getPdf(
    BuildContext context, Uint8List? screenShot, TeacherCHRViewModel provider,
    {bool? isChr}) async {
  Document pdf;
  if (isChr == null) {
    pdf = generatePdfFromTable(provider);
  } else {
    pdf = generatePdfFromChrTable(provider);
  }

  DateTime dateTime = DateTime.now();
  List<int> bytes = await pdf.save();
  final path = (await getExternalStorageDirectory())!.path;
  File pdfFile = File("$path/${dateTime.toString()}.pdf");

  await pdfFile.writeAsBytes(bytes, flush: true);
  await OpenFile.open("$path/${dateTime.toString()}.pdf");
  ScaffoldMessenger.of(context).showSnackBar(snack_bar("PDF Generated", true));
}
