import 'dart:convert';

Recordings recordingsFromJson(String str) =>
    Recordings.fromJson(json.decode(str));
List<Recordings> listrecordingsFromJson(String str) =>
    List<Recordings>.from(json.decode(str).map((x) => Recordings.fromJson(x)));
String recordingsToJson(Recordings data) => json.encode(data.toJson());

List<Recordings> rlistrecordingsFromJson(List lst) {
  List<Recordings> templst = [];
  for (var i in lst) {
    templst.add(Recordings.fromJson(i));
  }
  return templst;
}

class Recordings {
  Recordings({
    required this.id,
    required this.tsid,
    required this.filename,
    required this.date,
  });

  int id;
  int tsid;
  String filename;
  DateTime date;

  factory Recordings.fromJson(Map<String, dynamic> json) => Recordings(
        id: json["id"],
        tsid: json["tsid"],
        filename: json["filename"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tsid": tsid,
        "filename": filename,
        "date": date.toIso8601String(),
      };
}
