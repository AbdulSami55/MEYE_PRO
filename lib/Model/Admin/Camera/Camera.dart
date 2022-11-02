// ignore_for_file: file_names

class Camera {
  final String ip;
  final String lt;
  final String no;

  Camera({
    required this.ip,
    required this.lt,
    required this.no,
  });

  factory Camera.fromjson(Map<String, dynamic> json) {
    return Camera(
        ip: json["cameraip"], lt: json["cameralt"], no: json['camerano']);
  }

  Map tomap() {
    Map m = {};
    m['ip'] = ip;
    m['lt'] = lt;
    m['no'] = no;
    return m;
  }
}
