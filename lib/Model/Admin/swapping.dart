import 'dart:convert';

List<SwappingUser> swappingUserFromJson(String str) => List<SwappingUser>.from(
    json.decode(str).map((x) => SwappingUser.fromJson(x)));

String swappingUserToJson(List<SwappingUser> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SwappingUser {
  SwappingUser(
      {this.id,
      this.userID,
      this.name,
      this.image,
      this.password,
      this.role,
      this.timeTableId,
      this.venue,
      this.discipline});

  int? id, timeTableId;
  String? userID, name, image, password, role, discipline, venue;

  factory SwappingUser.fromJson(Map<String, dynamic> json) => SwappingUser(
      id: json["id"],
      userID: json['userID'],
      name: json["name"],
      image: json['image'],
      password: json['password'],
      role: json['role'],
      timeTableId: json['timeTableId'],
      discipline: json['discipline'],
      venue: json['venue']);

  Map<String, dynamic> toJson() => {
        "id": id,
        'userID': userID,
        "name": name,
        'image': image,
        'password': password,
        'role': role,
        'timeTableId': timeTableId,
        'discipline': discipline,
        'venue': venue
      };
}

class Swapping {
  Swapping(
      {this.id,
      this.timeTableIdFrom,
      this.timeTableIdTo,
      this.starttime,
      this.endtime,
      this.day,
      this.status,
      this.date});

  int? id;
  int? timeTableIdFrom;
  int? timeTableIdTo;
  String? starttime;
  String? endtime;
  String? day;
  bool? status;
  String? date;

  factory Swapping.fromJson(Map<String, dynamic> json) => Swapping(
      id: json["id"],
      timeTableIdFrom: json["timeTableIdFrom"],
      timeTableIdTo: json["timeTableIdTo"],
      starttime: json["startTime"],
      endtime: json["endTime"],
      day: json["day"],
      status: json["status"],
      date: json['date']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "timeTableIdFrom": timeTableIdFrom,
        "timeTableIdTo": timeTableIdTo,
        "date": date,
        "day": day,
        "startTime": starttime,
        "endTime": endtime,
        "status": status,
      };
}
