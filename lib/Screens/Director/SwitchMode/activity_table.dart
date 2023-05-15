import 'package:flutter/material.dart';
import 'package:live_streaming/Model/Teacher/teacher_chr.dart';
import 'package:live_streaming/utilities/constants.dart';
import 'package:live_streaming/view_models/Teacher/teacher_chr.dart';
import 'package:live_streaming/widget/textcomponents/medium_text.dart';
import 'package:live_streaming/widget/textcomponents/small_text.dart';

Widget activityTable(BuildContext context, TeacherCHRViewModel provider,
    {bool? isShortReport}) {
  List<int> sit = [];
  List<int> stand = [];
  List<int> mobile = [];
  for (TeacherChr t in provider.lstTeacherChr) {
    int s = 0;
    int st = 0;
    int m = 0;
    for (TeacherChrActivityDetail tad in t.teacherChrActivityDetails) {
      s += tad.sit ?? 0;
      st += tad.stand ?? 0;
      m += tad.mobile ?? 0;
    }
    sit.add(s);
    stand.add(st);
    mobile.add(m);
  }
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
                  .map((k, v) =>
                      MapEntry(k, rowData(v, k, sit[k], stand[k], mobile[k])))
                  .values
                  .toList()
              : provider.lstTeacherChr
                  .asMap()
                  .map((k, v) =>
                      MapEntry(k, rowData(v, k, sit[k], stand[k], mobile[k])))
                  .values
                  .toList()),
    ),
  );
}

DataRow rowData(TeacherChr v, int k, int sit, int stand, int mobile) {
  return DataRow(
      color: v.status == 'Not Held'
          ? MaterialStateProperty.all(Colors.redAccent)
          : MaterialStateProperty.all(containerColor),
      cells: [
        DataCell(textSmall("${k + 1}")),
        DataCell(textSmall(v.teacherName.toString())),
        DataCell(textSmall(v.courseName.toString())),
        DataCell(textSmall(v.date.toString())),
        DataCell(textSmall(sit.toString())),
        DataCell(textSmall(stand.toString())),
        DataCell(textSmall(mobile.toString())),
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
