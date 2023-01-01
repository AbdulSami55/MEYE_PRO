import 'dart:convert';

List<Teach> teachFromJson(String str) =>
    List<Teach>.from(json.decode(str)["data"].map((x) => Teach.fromJson(x)));

String teachToJson(List<Teach> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Teach {
  Teach({
    this.id,
    this.tmid,
    this.tid,
  });

  int? id;
  int? tmid;
  int? tid;

  factory Teach.fromJson(Map<String, dynamic> json) => Teach(
        id: json["id"],
        tmid: json["tmid"],
        tid: json["tid"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tmid": tmid,
        "tid": tid,
      };
}
