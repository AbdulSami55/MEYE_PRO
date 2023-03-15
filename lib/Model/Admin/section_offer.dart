import 'dart:convert';

List<SectionOffer> sectionOfferFromJson(String str) => List<SectionOffer>.from(
    json.decode(str).map((x) => SectionOffer.fromJson(x)));

String sectionOfferToJson(List<SectionOffer> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SectionOffer {
  SectionOffer(
      {required this.courseName,
      required this.courseCode,
      required this.discipline,
      required this.isSelected,
      required this.id});

  String courseName;
  String courseCode;
  String discipline;
  bool isSelected;
  int id;

  factory SectionOffer.fromJson(Map<String, dynamic> json) => SectionOffer(
      courseName: json["courseName"],
      courseCode: json["courseCode"],
      discipline: json["discipline"],
      isSelected: false,
      id: json["id"]);

  Map<String, dynamic> toJson() => {
        "courseName": courseName,
        "courseCode": courseCode,
        "discipline": discipline,
        "id": id
      };
}
