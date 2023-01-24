import 'dart:convert';

Section sectionFromJson(Map<String, dynamic> mp) => Section.fromJson(mp);
List<Section> lstsectionFromJson(String str) =>
    List<Section>.from(json.decode(str).map((x) => Section.fromJson(x)));

String sectionToJson(Section data) => json.encode(data.toJson());

List<Section> rlstsectionFromJson(List lst) {
  List<Section> templst = [];
  for (var i in lst) {
    templst.add(Section.fromJson(i));
  }
  return templst;
}

class Section {
  Section({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory Section.fromJson(Map<String, dynamic> json) => Section(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
