// To parse this JSON data, do
//
//     final teacherChr = teacherChrFromMap(jsonString);

import 'dart:convert';

List<TeacherChr> teacherChrFromMap(String str) =>
    List<TeacherChr>.from(json.decode(str).map((x) => TeacherChr.fromMap(x)));

String teacherChrToMap(List<TeacherChr> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class TeacherChr {
  TeacherChr(
      {required this.id,
      required this.courseName,
      required this.day,
      required this.discipline,
      required this.startTime,
      required this.endTime,
      required this.totalTimeIn,
      required this.totalTimeOut,
      required this.status,
      required this.date,
      required this.teacherChrActivityDetails,
      required this.teacherName,
      required this.image,
      required this.sit,
      required this.stand,
      required this.mobile,
      required this.venue});

  int id;
  String courseName;
  String day;
  String discipline;
  String startTime;
  String endTime;
  String totalTimeIn;
  String totalTimeOut;
  String status;
  String date;
  String teacherName;
  String image;
  String venue;
  int sit;
  int stand;
  int mobile;

  List<TeacherChrActivityDetail> teacherChrActivityDetails;

  factory TeacherChr.fromMap(Map<String, dynamic> json) => TeacherChr(
      id: json["id"],
      courseName: json["courseName"],
      day: json["day"],
      discipline: json["discipline"],
      startTime: json["startTime"],
      endTime: json["endTime"],
      totalTimeIn: json["totalTimeIn"],
      totalTimeOut: json["totalTimeOut"],
      status: json["status"],
      date: json["date"],
      sit: int.parse(json['sit']),
      stand: int.parse(json['stand']),
      mobile: int.parse(json['mobile']),
      teacherChrActivityDetails: List<TeacherChrActivityDetail>.from(
          json["teacherCHRActivityDetails"]
              .map((x) => TeacherChrActivityDetail.fromMap(x))),
      teacherName: json['teacherName'],
      image: json['image'] ?? '',
      venue: json['venue']);

  Map<String, dynamic> toMap() => {
        "id": id,
        "courseName": courseName,
        "day": day,
        "discipline": discipline,
        "startTime": startTime,
        "endTime": endTime,
        "totalTimeIn": totalTimeIn,
        "totalTimeOut": totalTimeOut,
        "status": status,
        "date": date,
        "teacherCHRActivityDetails":
            List<dynamic>.from(teacherChrActivityDetails.map((x) => x.toMap())),
        'teacherName': teacherName,
        'image': image,
        'venue': venue
      };
}

class TeacherChrActivityDetail {
  TeacherChrActivityDetail({
    required this.timein,
    required this.timeout,
    required this.sit,
    required this.stand,
    required this.mobile,
  });

  DateTime? timein;
  DateTime? timeout;
  int? sit;
  int? stand;
  int? mobile;

  factory TeacherChrActivityDetail.fromMap(Map<String, dynamic> json) =>
      TeacherChrActivityDetail(
        timein: json["timein"] == null ? null : DateTime.parse(json["timein"]),
        timeout:
            json["timeout"] == null ? null : DateTime.parse(json["timeout"]),
        sit: json["sit"],
        stand: json["stand"],
        mobile: json["mobile"],
      );

  Map<String, dynamic> toMap() => {
        "timein": timein?.toIso8601String(),
        "timeout": timeout?.toIso8601String(),
        "sit": sit,
        "stand": stand,
        "mobile": mobile,
      };
}
