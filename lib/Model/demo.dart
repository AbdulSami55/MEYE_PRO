import 'dart:convert';

List<Demo> demoFromJson(String str) =>
    List<Demo>.from(json.decode(str).map((x) => Demo.fromJson(x)));

String demoToJson(List<Demo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Demo {
  String file;
  String thumbnail;

  Demo({
    required this.file,
    required this.thumbnail,
  });

  factory Demo.fromJson(Map<String, dynamic> json) => Demo(
        file: json["file"],
        thumbnail: json["thumbnail"],
      );

  Map<String, dynamic> toJson() => {
        "file": file,
        "thumbnail": thumbnail,
      };
}

DemoDetails demoDetailsFromJson(String str) =>
    DemoDetails.fromJson(json.decode(str));

String demoDetailsToJson(DemoDetails data) => json.encode(data.toJson());

class DemoDetails {
  String totalTimeIn;
  String totalTimeOut;
  double sit;
  double stand;
  String sitMin;
  String standMin;

  DemoDetails({
    required this.totalTimeIn,
    required this.totalTimeOut,
    required this.sit,
    required this.stand,
    required this.sitMin,
    required this.standMin,
  });

  factory DemoDetails.fromJson(Map<String, dynamic> json) => DemoDetails(
        totalTimeIn: json["totalTimeIn"],
        totalTimeOut: json["totalTimeOut"],
        sit: json["sit"]?.toDouble(),
        stand: json["stand"]?.toDouble(),
        sitMin: json["sitMin"],
        standMin: json["standMin"],
      );

  Map<String, dynamic> toJson() => {
        "totalTimeIn": totalTimeIn,
        "totalTimeOut": totalTimeOut,
        "sit": sit,
        "stand": stand,
        "sitMin": sitMin,
        "standMin": standMin,
      };
}
