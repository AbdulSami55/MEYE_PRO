// ignore_for_file: prefer_const_constructors

import 'package:live_streaming/view_models/Teacher/teacher_chr.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Document generatePdfFromTable(TeacherCHRViewModel provider,
    {bool? isShortReport}) {
  final pdf = pw.Document();

  final headers = [
    'Sr. No',
    'Teacher',
    'Course',
    'Discipline',
    'Venue',
    'Date',
    'Sit',
    'Stand',
    'Mobile',
    'Status',
  ];

  final data = isShortReport == true
      ? provider.lstTempTeacherChr
          .where((element) => element.status == 'Not Held')
          .toList()
      : provider.lstTempTeacherChr;

  final rows = List<List<String>>.generate(data.length, (index) {
    final rowData = data[index];

    return [
      '${index + 1}',
      rowData.teacherName.toString(),
      rowData.courseName.toString(),
      rowData.discipline.toString(),
      rowData.venue.toString(),
      rowData.date.toString(),
      rowData.sit.toString(),
      rowData.stand.toString(),
      rowData.mobile.toString(),
      rowData.status.toString(),
    ];
  });

  final tableHeaderStyle = pw.TextStyle(
    fontWeight: pw.FontWeight.bold,
    fontSize: 12,
    color: PdfColors.white,
  );
  final tableCellStyle = pw.TextStyle(
    fontSize: 10,
    color: PdfColors.black,
  );
  const headerColor = PdfColors.green;
  final cellPadding = pw.EdgeInsets.all(5);

  final table = pw.Table.fromTextArray(
    headers: headers,
    headerStyle: tableHeaderStyle,
    cellStyle: tableCellStyle,
    data: rows,
    cellAlignment: pw.Alignment.center,
    border: pw.TableBorder.all(
      width: 1,
      color: PdfColors.black,
    ),
    headerDecoration: pw.BoxDecoration(
      color: headerColor,
    ),
    cellPadding: cellPadding,
    rowDecoration: pw.BoxDecoration(
      color: PdfColors.white,
    ),
  );

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Center(
          child: pw.Container(
            decoration: pw.BoxDecoration(
              border: pw.Border.all(
                color: PdfColors.grey,
                width: 1.0,
              ),
              color: PdfColors.white,
            ),
            child: table,
          ),
        );
      },
    ),
  );

  return pdf;
}
