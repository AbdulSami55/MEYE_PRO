import 'dart:convert';

TimeTable timeTableFromJson(Map<String, dynamic> mp) => TimeTable.fromJson(mp);
List<TimeTable> lsttimetableFromJson(String str) => List<TimeTable>.from(
    json.decode(str)["data"].map((x) => TimeTable.fromJson(x)));

String timeTableToJson(TimeTable data) => json.encode(data.toJson());

List<TimeTable> rlsttimetableFromJson(List lst) {
  List<TimeTable> templst = [];
  for (var i in lst) {
    templst.add(TimeTable.fromJson(i));
  }
  return templst;
}

class TimeTable {
  TimeTable({
    this.id,
    this.secId,
    this.starttime,
    this.endtime,
    this.day,
    this.courseID,
    this.venueID,
  });

  int? id;
  int? secId;
  String? starttime;
  String? endtime;
  String? day;
  int? courseID;
  int? venueID;

  factory TimeTable.fromJson(Map<String, dynamic> json) => TimeTable(
        id: json["id"],
        secId: json["sectionID"],
        starttime: json["starttime"],
        endtime: json["endtime"],
        day: json["day"],
        courseID: json["courseID"],
        venueID: json["venueID"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sectionID": secId,
        "starttime": starttime,
        "endtime": endtime,
        "day": day,
        "courseID": courseID,
        "venueID": venueID,
      };
}
