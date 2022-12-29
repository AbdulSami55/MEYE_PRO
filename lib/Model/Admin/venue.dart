import 'dart:convert';

List<Venue> venueFromJson(String str) =>
    List<Venue>.from(json.decode(str)["data"].map((x) => Venue.fromJson(x)));

String venueToJson(List<Venue> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Venue {
  Venue({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory Venue.fromJson(Map<String, dynamic> json) => Venue(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
