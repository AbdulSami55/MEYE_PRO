import 'package:flutter/material.dart';
import 'package:live_streaming/Model/Teacher/teacher_chr.dart';
import 'package:live_streaming/utilities/constants.dart';
import 'package:live_streaming/view_models/Teacher/teacher_chr.dart';
import 'package:live_streaming/widget/textcomponents/medium_text.dart';
import 'package:live_streaming/widget/textcomponents/small_text.dart';

Widget activityTable(BuildContext context, TeacherCHRViewModel provider,
    {bool? isShortReport}) {
  return Container(
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
            DataColumn(label: text_medium('Teacher', color: containerColor)),
            DataColumn(label: text_medium('Course', color: containerColor)),
            DataColumn(label: text_medium('Date', color: containerColor)),
            DataColumn(label: text_medium('Sit', color: containerColor)),
            DataColumn(label: text_medium('Stand', color: containerColor)),
            DataColumn(label: text_medium('Mobile', color: containerColor)),
            DataColumn(label: text_medium('Status', color: containerColor))
          ],
          rows: isShortReport == true
              ? provider.lstTeacherChr
                  .where((element) => element.status == 'Not Held')
                  .toList()
                  .asMap()
                  .map((k, v) => MapEntry(k, rowData(v, k)))
                  .values
                  .toList()
              : provider.lstTeacherChr
                  .asMap()
                  .map((k, v) => MapEntry(k, rowData(v, k)))
                  .values
                  .toList()),
    ),
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
