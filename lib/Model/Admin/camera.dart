import 'dart:convert';

List<Camera> cameraFromJson(String str) =>
    List<Camera>.from(json.decode(str).map((x) => Camera.fromJson(x)));

String cameraToJson(List<Camera> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Camera {
  Camera({
    this.id,
    this.did,
    this.vid,
    this.no,
  });

  int? id;
  int? did;
  int? vid;
  String? no;

  factory Camera.fromJson(Map<String, dynamic> json) => Camera(
        id: json["id"],
        did: json["did"],
        vid: json["vid"],
        no: json["no"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "did": did,
        "vid": vid,
        "no": no,
      };
}
