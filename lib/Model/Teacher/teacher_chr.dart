import 'dart:convert';

List<TeacherChr> teacherChrFromJson(String str) =>
    List<TeacherChr>.from(json.decode(str).map((x) => TeacherChr.fromMap(x)));

String teacherChrToJson(List<TeacherChr> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class TeacherChr {
  TeacherChr(
      {required this.courseName,
      required this.day,
      required this.discipline,
      required this.startTime,
      required this.endTime,
      required this.totalTimeIn,
      required this.totalTimeOut,
      required this.timein,
      required this.timeout,
      required this.sit,
      required this.stand,
      required this.mobile,
      required this.status});

  String courseName;
  String day;
  String discipline;
  String startTime;
  String endTime;
  String totalTimeIn;
  String totalTimeOut;
  String status;
  DateTime timein;
  DateTime timeout;
  int sit;
  int stand;
  int mobile;

  factory TeacherChr.fromMap(Map<String, dynamic> json) => TeacherChr(
      courseName: json["courseName"],
      day: json["day"],
      discipline: json["discipline"],
      startTime: json["startTime"],
      endTime: json["endTime"],
      totalTimeIn: json["totalTimeIn"],
      totalTimeOut: json["totalTimeOut"],
      timein: DateTime.parse(json["timein"]),
      timeout: DateTime.parse(json["timeout"]),
      sit: json["sit"],
      stand: json["stand"],
      mobile: json["mobile"],
      status: json['status']);

  Map<String, dynamic> toMap() => {
        "courseName": courseName,
        "day": day,
        "discipline": discipline,
        "startTime": startTime,
        "endTime": endTime,
        "totalTimeIn": totalTimeIn,
        "totalTimeOut": totalTimeOut,
        "timein": timein.toIso8601String(),
        "timeout": timeout.toIso8601String(),
        "sit": sit,
        "stand": stand,
        "mobile": mobile,
        "status": status
      };
}
