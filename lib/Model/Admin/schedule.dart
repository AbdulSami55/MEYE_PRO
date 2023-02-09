import 'dart:convert';

Schedule scheduleFromJson(String str) => Schedule.fromJson(json.decode(str));

String scheduleToJson(Schedule data) => json.encode(data.toJson());

class Schedule {
  Schedule(
      {this.id,
      this.teachID,
      this.venueID,
      this.starttime,
      this.endtime,
      this.day,
      this.status});

  int? id;
  int? teachID;
  int? venueID;
  String? starttime;
  String? endtime;
  String? day;
  bool? status;

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
      id: json["id"],
      teachID: json["teachID"],
      venueID: json["venueID"],
      starttime: json["starttime"],
      endtime: json["endtime"],
      day: json["day"],
      status: json["status"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "teachID": teachID,
        "venueID": venueID,
        "starttime": starttime,
        "endtime": endtime,
        "day": day,
        "status": status
      };
}
