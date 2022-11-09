// ignore_for_file: file_names

class DVR {
  final String ip;
  final String host;
  final String channel;
  final String password;

  DVR(
      {required this.ip,
      required this.channel,
      required this.host,
      required this.password});

  factory DVR.fromjson(Map<String, dynamic> json) {
    return DVR(
        ip: json["ip"],
        channel: json["channel"],
        password: json['password'],
        host: json['host']);
  }

  Map tomap() {
    Map m = {};
    m['ip'] = ip;
    m['channel'] = channel;
    m['host'] = host;
    m['password'] = password;
    return m;
  }
}
