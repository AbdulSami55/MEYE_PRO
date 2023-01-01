import 'dart:convert';

TimeTable timeTableFromJson(Map<String, dynamic> mp) => TimeTable.fromJson(mp);

String timeTableToJson(TimeTable data) => json.encode(data.toJson());

class TimeTable {
  TimeTable({
    this.id,
    this.secId,
    this.starttime,
    this.endtime,
    this.day,
    this.cid,
    this.vid,
  });

  int? id;
  int? secId;
  String? starttime;
  String? endtime;
  String? day;
  int? cid;
  int? vid;

  factory TimeTable.fromJson(Map<String, dynamic> json) => TimeTable(
        id: json["id"],
        secId: json["sec_id"],
        starttime: json["starttime"],
        endtime: json["endtime"],
        day: json["day"],
        cid: json["cid"],
        vid: json["vid"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sec_id": secId,
        "starttime": starttime,
        "endtime": endtime,
        "day": day,
        "cid": cid,
        "vid": vid,
      };
}
