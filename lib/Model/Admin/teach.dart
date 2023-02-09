import 'dart:convert';

List<Teach> teachFromJson(String str) =>
    List<Teach>.from(json.decode(str)["data"].map((x) => Teach.fromJson(x)));

String teachToJson(List<Teach> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Teach {
  Teach({
    this.id,
    this.timeTableID,
    this.teacherID,
  });

  int? id;
  int? timeTableID;
  int? teacherID;

  factory Teach.fromJson(Map<String, dynamic> json) => Teach(
        id: json["id"],
        timeTableID: json["timeTableID"],
        teacherID: json["teacherID"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "timeTableID": timeTableID,
        "teacherID": teacherID,
      };
}
