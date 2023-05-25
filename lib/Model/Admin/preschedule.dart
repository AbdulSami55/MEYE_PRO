import 'dart:convert';

PreSchedule preScheduleFromJson(String str) =>
    PreSchedule.fromJson(json.decode(str));

String preScheduleToJson(PreSchedule data) => json.encode(data.toJson());

class PreSchedule {
  PreSchedule(
      {this.id,
      this.timeTableId,
      this.venueName,
      this.starttime,
      this.endtime,
      this.day,
      this.status,
      this.date});

  int? id;
  int? timeTableId;
  String? venueName;
  String? starttime;
  String? endtime;
  String? day;
  bool? status;
  String? date;

  factory PreSchedule.fromJson(Map<String, dynamic> json) => PreSchedule(
      id: json["id"],
      timeTableId: json["timeTableId"],
      venueName: json["venueName"],
      starttime: json["starttime"],
      endtime: json["endtime"],
      day: json["day"],
      status: json["status"],
      date: json['date']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "timeTableId": timeTableId,
        "venueName": venueName,
        "starttime": starttime,
        "endtime": endtime,
        "day": day,
        "status": status,
        "date": date
      };
}
