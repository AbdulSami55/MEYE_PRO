import 'dart:convert';

Section sectionFromJson(Map<String, dynamic> mp) => Section.fromJson(mp);

String sectionToJson(Section data) => json.encode(data.toJson());

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
