import 'dart:convert';

Schedule scheduleFromJson(String str) => Schedule.fromJson(json.decode(str));

String scheduleToJson(Schedule data) => json.encode(data.toJson());

class Schedule {
  Schedule(
      {this.id,
      this.teacherSlotId,
      this.venueName,
      this.starttime,
      this.endtime,
      this.day,
      this.status});

  int? id;
  int? teacherSlotId;
  String? venueName;
  String? starttime;
  String? endtime;
  String? day;
  bool? status;

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
      id: json["id"],
      teacherSlotId: json["teacherSlotId"],
      venueName: json["venueName"],
      starttime: json["starttime"],
      endtime: json["endtime"],
      day: json["day"],
      status: json["status"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "teacherSlotId": teacherSlotId,
        "venueName": venueName,
        "starttime": starttime,
        "endtime": endtime,
        "day": day,
        "status": status
      };
}
