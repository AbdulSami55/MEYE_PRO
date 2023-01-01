import 'dart:convert';

Course courseFromJson(Map<String, dynamic> mp) => Course.fromJson(mp);

String courseToJson(Course data) => json.encode(data.toJson());

class Course {
  Course({
    this.id,
    this.cid,
    this.crHr,
    this.name,
  });

  int? id;
  String? cid;
  int? crHr;
  String? name;

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        id: json["id"],
        cid: json["cid"],
        crHr: json["cr_hr"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cid": cid,
        "cr_hr": crHr,
        "name": name,
      };
}
