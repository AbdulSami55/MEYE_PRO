// ignore_for_file: file_names

import 'dart:convert';

List<RulesTimeTable> rulestimeTableFromJson(List data) =>
    List<RulesTimeTable>.from(data.map((x) => RulesTimeTable.fromJson(x)));

String timeTableToJson(List<RulesTimeTable> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RulesData {
  List<RulesTimeTable> rulesTimeTable;
  bool startRecord;
  bool midRecord;
  bool endRecord;
  bool fullRecord;

  RulesData(
      {required this.endRecord,
      required this.fullRecord,
      required this.midRecord,
      required this.rulesTimeTable,
      required this.startRecord});
  factory RulesData.fromJson(Map<String, dynamic> json) => RulesData(
      endRecord: json['endRecord'],
      fullRecord: json['fullRecord'],
      midRecord: json['midRecord'],
      rulesTimeTable: rulestimeTableFromJson(json['data']),
      startRecord: json['startRecord']);
}

class RulesTimeTable {
  RulesTimeTable({
    required this.id,
    required this.discipline,
    required this.starttime,
    required this.endtime,
    required this.day,
    required this.courseCode,
    required this.courseName,
    required this.venue,
    required this.teacherName,
    required this.sessionId,
    required this.sessionName,
    required this.isSelected,
  });

  int id;
  String discipline;
  String starttime;
  String endtime;
  String day;
  String courseCode;
  String courseName;
  String venue;
  String teacherName;
  String sessionId;
  String sessionName;
  bool isSelected = false;

  factory RulesTimeTable.fromJson(Map<String, dynamic> json) => RulesTimeTable(
        id: json["id"],
        discipline: json["discipline"],
        starttime: json["starttime"],
        endtime: json["endtime"],
        day: json["day"],
        courseCode: json["courseCode"],
        courseName: json["courseName"],
        venue: json["venue"],
        teacherName: json["teacherName"],
        sessionId: json["sessionId"],
        sessionName: json["sessionName"] ?? '',
        isSelected: json['isSelected'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "discipline": discipline,
        "starttime": starttime,
        "endtime": endtime,
        "day": day,
        "courseCode": courseCode,
        "courseName": courseName,
        "venue": venue,
        "teacherName": teacherName,
        "sessionId": sessionId,
        "sessionName": sessionName,
      };
}
