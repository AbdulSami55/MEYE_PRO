// ignore_for_file: file_names, non_constant_identifier_names

import 'dart:convert';

List<DVR> dvrFromJson(String str) =>
    List<DVR>.from(json.decode(str).map((x) => DVR.fromJson(x)));

String DVRToJson(List<DVR> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DVR {
  int? id;
  String? ip, name, channel, host, password;

  DVR({this.id, this.ip, this.name, this.channel, this.host, this.password});

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
