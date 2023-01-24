import 'dart:convert';

Course courseFromJson(Map<String, dynamic> mp) => Course.fromJson(mp);
List<Course> lstcourseFromJson(String str) =>
    List<Course>.from(json.decode(str).map((x) => Course.fromJson(x)));

String courseToJson(Course data) => json.encode(data.toJson());
List<Course> rlstcourseFromJson(List lst) {
  List<Course> templst = [];
  for (var i in lst) {
    templst.add(Course.fromJson(i));
  }
  return templst;
}

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
