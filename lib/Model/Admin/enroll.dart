import 'dart:convert';

List<Enroll> enrollFromJson(String str) =>
    List<Enroll>.from(json.decode(str).map((x) => Enroll.fromJson(x)));

String enrollToJson(List<Enroll> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Enroll {
  Enroll(
      {required this.id,
      required this.sectionOfferId,
      required this.studentId,
      required this.discipline});

  int id;
  List<int> sectionOfferId;
  String studentId;
  String discipline;

  factory Enroll.fromJson(Map<String, dynamic> json) => Enroll(
      id: json["id"],
      sectionOfferId: json["sectionOfferId"],
      studentId: json["studentID"],
      discipline: json['discipline']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "sectionOfferId": sectionOfferId,
        "studentID": studentId,
        "discipline": discipline
      };
}
