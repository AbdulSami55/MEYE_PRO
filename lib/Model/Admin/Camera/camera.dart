class Camera {
  int? id;
  int? did;
  int? vid;
  String? no;

  Camera(this.id, this.did, this.vid, this.no);

  Camera.fromJson(dynamic json) {
    id = json["id"];
    did = json["did"];
    vid = json["vid"];
    no = json["no"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = id;
    data["did"] = did;
    data["vid"] = vid;
    data["no"] = no;
    return data;
  }
}
