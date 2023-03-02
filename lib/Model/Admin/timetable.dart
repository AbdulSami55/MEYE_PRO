import 'dart:convert';

List<TimeTable> timeTableFromJson(String str) =>
    List<TimeTable>.from(json.decode(str).map((x) => TimeTable.fromJson(x)));

String timeTableToJson(List<TimeTable> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TimeTable {
  TimeTable({
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

  factory TimeTable.fromJson(Map<String, dynamic> json) => TimeTable(
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
