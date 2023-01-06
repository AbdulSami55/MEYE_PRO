import 'dart:convert';

Schedule scheduleFromJson(String str) => Schedule.fromJson(json.decode(str));

String scheduleToJson(Schedule data) => json.encode(data.toJson());

class Schedule {
  Schedule(
      {this.id,
      this.thid,
      this.vid,
      this.starttime,
      this.endtime,
      this.day,
      this.status});

  int? id;
  int? thid;
  int? vid;
  String? starttime;
  String? endtime;
  String? day;
  bool? status;

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
      id: json["id"],
      thid: json["thid"],
      vid: json["vid"],
      starttime: json["starttime"],
      endtime: json["endtime"],
      day: json["day"],
      status: json["status"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "thid": thid,
        "vid": vid,
        "starttime": starttime,
        "endtime": endtime,
        "day": day,
        "status": status
      };
}
