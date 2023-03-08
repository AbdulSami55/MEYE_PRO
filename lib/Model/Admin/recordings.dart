import 'dart:convert';

List<Recordings> recordingsFromJson(String str) =>
    List<Recordings>.from(json.decode(str).map((x) => Recordings.fromJson(x)));

String recordingsToJson(List<Recordings> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Recordings {
  Recordings({
    required this.courseCode,
    required this.courseName,
    required this.teacherName,
    required this.discipline,
    required this.venue,
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.date,
    required this.status,
    required this.slot,
    required this.fileName,
  });

  String courseCode;
  String courseName;
  String teacherName;
  String discipline;
  String venue;
  String day;
  String startTime;
  String endTime;
  DateTime date;
  String status;
  int slot;
  String fileName;

  factory Recordings.fromJson(Map<String, dynamic> json) => Recordings(
        courseCode: json["courseCode"],
        courseName: json["courseName"],
        teacherName: json["teacherName"],
        discipline: json["discipline"],
        venue: json["venue"],
        day: json["day"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        date: DateTime.parse(json["date"]),
        status: json["status"],
        slot: json["slot"],
        fileName: json["fileName"],
      );

  Map<String, dynamic> toJson() => {
        "courseCode": courseCode,
        "courseName": courseName,
        "teacherName": teacherName,
        "discipline": discipline,
        "venue": venue,
        "day": day,
        "startTime": startTime,
        "endTime": endTime,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "status": status,
        "slot": slot,
        "fileName": fileName,
      };
}
