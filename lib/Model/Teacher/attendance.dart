import 'dart:convert';

List<Attendance> attendanceFromJson(String str) =>
    List<Attendance>.from(json.decode(str).map((x) => Attendance.fromJson(x)));

String attendanceToJson(List<Attendance> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Attendance {
  Attendance({
    required this.id,
    required this.enrollId,
    required this.date,
    required this.status,
    required this.name,
  });

  int id;
  int enrollId;
  DateTime date;
  bool status;
  String name;

  factory Attendance.fromJson(Map<String, dynamic> json) => Attendance(
        id: json["id"],
        enrollId: json["enrollId"],
        date: DateTime.parse(json["date"]),
        status: json["status"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "enrollId": enrollId,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "status": status,
        "name": name,
      };
}
