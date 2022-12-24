// ignore_for_file: file_names

class DVR {
  int? id;
  String? ip, name, channel, host, password;

  DVR(
      {required this.id,
      required this.ip,
      required this.name,
      required this.channel,
      required this.host,
      required this.password});

  factory DVR.fromJson(dynamic json) {
    return DVR(
      id: json["id"],
      ip: json["ip"],
      name: json["name"],
      channel: json["channel"],
      host: json["host"],
      password: json["password"],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["id"] = id;
    data["ip"] = ip;
    data["name"] = name;
    data["channel"] = channel;
    data["host"] = host;
    data["password"] = password;
    return data;
  }
}
