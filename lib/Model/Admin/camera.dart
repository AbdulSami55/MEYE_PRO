import 'dart:convert';

List<Camera> cameraFromJson(String str) =>
    List<Camera>.from(json.decode(str)["data"].map((x) => Camera.fromJson(x)));

String cameraToJson(List<Camera> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Camera {
  Camera({
    this.id,
    this.dvrID,
    this.venueID,
    this.portNumber,
  });

  int? id;
  int? dvrID;
  int? venueID;
  String? portNumber;

  factory Camera.fromJson(Map<String, dynamic> json) => Camera(
        id: json["id"],
        dvrID: json["dvrID"],
        venueID: json["venueID"],
        portNumber: json["portNumber"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "dvrID": dvrID,
        "venueID": venueID,
        "portNumber": portNumber,
      };
}
